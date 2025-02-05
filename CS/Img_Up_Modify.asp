<!-- #include file="Function_Upload.asp" -->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    

    Set UploadForm				= Server.CreateObject("DEXT.FileUpload") 
    Set objImage					    = Server.CreateObject("DEXT.ImageProc")
    PhysicalImgPath				= server.MapPath("/images/")	
    UploadForm.DefaultPath	= PhysicalImgPath								'//이미지 기본경로 꼭 설정해 줘야 다른 값을 받을 수 있다.
    strContents					    = UploadForm("contents")					'//내용
    g_code						        = UploadForm("g_code")					'//상품등록번호 페이지 이동시 필요
    goodsNum					   = UploadForm("goodsNum")
    getUrl							   = UploadForm("getUrl")						'//경로
    imgFullName				   = UploadForm("imgPath")						'//변경될파일이름
    ImgFileNm					   = UploadForm("ImgFileNm").FileName	'//넘어온 이미지
    strWidth						   = UploadForm("ImgFileNm").ImageWidth
    strHeight						   = UploadForm("ImgFileNm").ImageHeight 
    imgNumMax				   = UploadForm("imgNum")					'//입력될 이미지 번호
    goodType						   = UploadForm("goodType")					'//상품코드
    area								   = UploadForm("area")							'/지역코드
    goodSize						   = UploadForm("goodSizeS")					'//이미지 사이즈	
    seq								   = UploadForm("seq")							'//이미지 번호
    imgA							   = UploadForm("imgA")							'//이미지 사이즈	
    imgB								   = UploadForm("imgB")							'//이미지 사이즈	
    Flag								   = UploadForm("Flag")
    info								   = UploadForm("info")
    imgSeq						   	   = UploadForm("imgSeq")
    nat								   = UploadForm("nat")							'/나라코드
    city								   = UploadForm("city")							'//도시코드
    sub_seq							   = UploadForm("sub_seq")
    strContents					   = UploadForm("contents")				'//내용
    nat_cd							   = UploadForm("nat_cd")					'/나라코드
    city_cd							   = UploadForm("city_cd")					'/나라코드
    desc_cd						       = UploadForm("desc_cd")				'//도시코드
    
    
    strContents = Replace(strContents, "'","''")
    
    
    OpenCsDB DB
    DB.BeginTrans'//트랜잭션
    
    Select Case Flag
        Case "goods"
            Dim imgAA, imgBB
            
            If imgA<>"" Then
                imgAA = Split(imgA,",")
                imgA1 = Cint(imgAA(0))
                imgA2 = Cint(imgAA(1))
            End if
            
            If imgB<>"" Then
                imgBB = Split(imgB,",")
                imgB1 = Cint(imgBB(0))  
                imgB2 = Cint(imgBB(1))  
            End if 
    
            sql = " SELECT seq FROM TB_ph010 "	&_
                     " WHERE SEQ = '" & seq& "' "	&_
                     " AND g_code = '" & goodsNum & "'	"	&_	
                     " AND IMG_PATH = '" & imgFullName & "'"
            url = "g_code="&g_code&"&seq="&seq&"&imgA="&imgA&"&imgB="&imgB&"&goodsNum="&goodsNum
    
        Case "area"
            sql = "select img_seq from TB_ph020 where Info_cd='"&info&"' and seq='"&seq&"' and img_seq="&imgSeq
            If sub_seq<>"" Then sql = sql & " and sub_seq=" & sub_seq	'//상세정보 값 여부
            url = "seq="&seq&"&info="&info&"&nat="&nat&"&city="&city&"&imgSeq="&imgSeq&"&sub_seq="&sub_seq
    
    End Select 
    
    url = "img_up.asp?" & url
    
    
    
    Set Rs=db.execute(sql)
    
    If Not Rs.Eof then
    	
        if UploadForm("ImgFileNm").FileLen>1 Then
            '== 화일변경 ==================================================================================
            '//기본에 파일이 있다면 기존에 있던 파일을 삭제하고 업로드한다음 이미지 크기를 변경하여 올린 다음 원래 이미지는 삭제한다.			
            '//기존에 같은 파일이 존재하면 안되므로 같은 이름이 있으면 삭제하고 업로드 후 다시 삭제 한다.
            Set FSO=CreateObject("Scripting.FilesystemObject")		
            getUrl			= server.mapPath("../")  & getUrl																					'//경로에 맵 경로 추가
            filePath			= getUrl & imgFullName																								'//실제크기 이미지 이름
            old_filePath	= getUrl & "D_" & imgFullName																						'//임의로 저장될 이미지 이름
    
            Select Case Flag
                Case "goods"
                    NewImgName_A = getUrl & Left(imgFullName,14) & "A.jpg"														'//새로저장될 파일 이름
                    NewImgName_B = getUrl & Left(imgFullName,14) & "B.jpg"		
    
                    fnFsoDelete(filePath)
                    fnFsoDelete(NewImgName_A)
                    fnFsoDelete(NewImgName_B)
    	
                    UploadForm("ImgFileNm").SaveAS filePath																			'//파일저장
    
                    if True = objImage.SetSourceFile(filePath) Then
                        a = objImage.SaveasThumbnail(NewImgName_A,imgA1,imgA2, False)								'//이미지 JPG 변경 및 저장
                        b = objImage.SaveasThumbnail(NewImgName_B,imgB1,imgB2, False)
                    end if		
    
    						fnFsoDelete(filePath)																											'//임의 저장 이미지 삭제	
    
                Case "area"
                    '	if info="01" Then 	 '호텔
    						
                    ' fnFsoDelete(filePath)
                    '	UploadForm("ImgFileNm").SaveAS old_filePath																		'//임의의 파일 저장
    
                    '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                    '	if True = objImage.SetSourceFile(old_filePath) Then
                    '		a = objImage.SaveasThumbnail(filePath, "800", "600" , False)												'//이미지 변환 및 저장
                    '	End if		
                    '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                    '	fnFsoDelete(old_filePath)
    
                    ' elseif info="07" Then '골프장
    
                    '	fnFsoDelete(filePath)
                    '	UploadForm("ImgFileNm").SaveAS old_filePath																		'//임의의 파일 저장
    
                    '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                    '	if True = objImage.SetSourceFile(old_filePath) Then
                    '		a = objImage.SaveasThumbnail(filePath, "800", "600" , False)												'//이미지 변환 및 저장
                    '	End if		
                    '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                    '	fnFsoDelete(old_filePath)
    						
                    '	Else '호텔골프장 제외한것들
    					
                    fnFsoDelete(filePath)																													'//이미지 삭제
                    UploadForm("ImgFileNm").SaveAS old_filePath																				'//이미지 등록
                    '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                    'if objImage.SetSourceFile(old_filePath) Then a = objImage.SaveasThumbnail(filePath,strWidth,strHeight, False)
                    if objImage.SetSourceFile(old_filePath) Then a = objImage.SaveasThumbnail(filePath,"1200", "800", False)
                    '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                    fnFsoDelete(old_filePath)
                    'end if
            End Select
    
            Set FSO = Nothing
            Set UploadForm	= Nothing
            Set objImage = Nothing
            '== 화일변경 ==================================================================================
        end if
    
    
        '============= 데이터베이스 값과 일치할 경우 업데이트 ==================================================
        Select Case Flag
            Case "goods"
                sql = " UPDATE TB_Ph010  SET "	&_
                         " GOOD_DESC = '" & strContents & "' " &_
                         " , SIZE_CD = '" & goodSize & "' " &_
                         " WHERE SEQ = '" & seq & "' " &_
                         " AND g_code	= '" & goodsNum	& "' "	&_	
                         " AND IMG_PATH = '" & imgFullName & "' "	
    
            Case "area"
                sql = "	 UPDATE TB_Ph020 SET "	&_
                         " INFO_DESC = N'" & strContents	& "' "	&_
                         "	, SIZE_CD = '" & goodSize & "' " &_
                         " WHERE INFO_CD = '" & info & "' "	&_
                         " AND SEQ = '" & seq & "' "	&_
                         " AND IMG_SEQ = " & imgSeq				
        End Select	
        DB.Execute(sql)	
        '============= 데이터베이스 값과 일치할 경우 업데이트 ==================================================
    		
    Else	'첨부파일 존재 여부
        DB.RollbackTrans
        RS.close : Set RS = Nothing
        CloseDB DB	
        fnGoBack("수정시 오류가 발생하였습니다.\n다시 한번 수정하세요.")
    End if	'첨부파일 존재 여부
    
    If Err.number = 0 Then
        DB.CommitTrans
        RS.close : 	Set RS = Nothing
        CloseDB DB	
        fnGoUrl(url)
    Else 
        DB.RollbackTrans
        RS.close : Set RS = Nothing
        CloseDB DB	
        fnGoBack("수정시 오류가 발생하였습니다.\n다시 한번 수정하세요.")
    End if
%>