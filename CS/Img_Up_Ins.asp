<%
'-------------------------------------------------------------------
'Programed by kim, jongha 
'Date		: 2010-01-08
'Content	: 지역이미지  (덱스트 업로드)
'-------------------------------------------------------------------
%>

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
    UploadForm.DefaultPath  = PhysicalImgPath
    g_code							    = UploadForm("g_code")
    goodsNum					    = UploadForm("goodsNum")
    strContents					    = UploadForm("contents")					'//내용
    getUrl							    = UploadForm("getUrl")						'//경로
    imgFullName					= UploadForm("imgFullName")				'//이미지명
    ImgFileNm						= UploadForm("ImgFileNm").FileName	'//업로드된 이미지	
    strWidth							= UploadForm("ImgFileNm").ImageWidth
    strHeight						    = UploadForm("ImgFileNm").ImageHeight 
    imgNumMax				    = UploadForm("imgNum")					'//입력될 이미지 번호
    area								    = UploadForm("area")							'/지역코드
    goodSize						    = UploadForm("goodSizeS")					'//이미지 사이즈	
    imgA								= UploadForm("imgA")							'//이미지 사이즈	
    imgB								    = UploadForm("imgB")							'//이미지 사이즈	
    Flag								    = UploadForm("Flag")								
    info								    = UploadForm("info")
    seq								    = UploadForm("seq")
    nat								    = UploadForm("nat")				'/나라코드
    city								    = UploadForm("city")				'//도시코드
    sub_seq						        = UploadForm("sub_seq")
    nat_cd							   = UploadForm("nat_cd")					'/나라코드
    city_cd							   = UploadForm("city_cd")					'//도시코드
    desc_cd						       = UploadForm("desc_cd")				'//
    
    
    
    If nat_cd="" Or IsNull(nat_cd) Then nat_cd = nat
    If city_cd="" Or IsNull(city_cd) Then city_cd = city
    
    
    imgPathGood2= server.mapPath("/") &"\images\good_img\"
    imgPathGood = server.mapPath("/") &"\images\good_img\"&goodsNum&"\"
    imgPathArea	= server.mapPath("/") &"\images\area_img\"
    imgPathNat	= server.mapPath("/") &"\images\area_img\"&nat_cd&"\"
    imgPathCity	= server.mapPath("/") &"\images\area_img\"&nat_cd&"\"&city_cd&"\"
    
    strContents = Replace(strContents, "'","''")
    '== 날자세팅 =========================================================================================
    if Len(month(now()))<2 Then strMonth="0"&month(now()) Else strMonth=month(now())
    if Len(day(now()))<2 Then strDay="0"&day(now()) Else strDay	=day(now())
    strDate			= year(now())&strMonth &strDay''오늘날자로 세팅
    '== 날자세팅 =========================================================================================
    
    
    
    OpenCsDB DB
    
    DB.BeginTrans'//트랜잭션
    
    Select Case Flag
        Case "goods" '상품
            Dim imgAA, imgBB
            
            if imgA<>"" Then
                imgAA = Split(imgA,",")
                imgA1 = Cint(imgAA(0))
                imgA2 = Cint(imgAA(1))
            end if
            
            if imgB<>"" Then
                imgBB = Split(imgB,",")
                imgB1 = Cint(imgBB(0))  
                imgB2 = Cint(imgBB(1))  
            end if
    		
    
            sql =			" INSERT INTO TB_Ph010("
            sql = sql & " g_code "
            sql = sql & ", SEQ "
            sql = sql & ", SIZE_CD "
            sql = sql & ", IMG_PATH "
            sql = sql & ", GOOD_DESC "
            sql = sql & ", INS_DT "
            sql = sql & ", DEL_YN		) "
            sql = sql & " VALUES	( "
            sql = sql & " '" & goodsNum & "'"				
            sql = sql & ", "  & imgNumMax	
            sql = sql & ", '" & goodSize & "'"
            sql = sql & ", '" & imgFullName & "'"
            sql = sql & ", '" & strContents & "'"
            sql = sql & ", '" & strDate & "'"
            sql = sql & ", 'N' )"
           ' response.write sql
            'response.end
            DB.Execute(sql)
    
            '게시물 얻기
            sql	=		   " SELECT MAX(SEQ) AS maxSeq "
            sql = sql & " FROM TB_Ph010 "
            sql = sql & " WHERE 1=1 "
            sql = sql & " AND g_code = '" & goodsNum & "'"	
            sql = sql & " AND SEQ = "  & imgNumMax		
            sql = sql & " AND IMG_PATH = '" & imgFullName & "'"
    
            url = "g_code="&g_code&"&Seq="&imgNumMax&"&imgA="&imgA&"&imgB="&imgB&"&goodsNum="&goodsNum
    	
    	
        Case "area" '여행정보
            sql =           " Select max(IMG_SEQ)+1 "
            sql = sql & " From TB_Ph020 "
            sql = sql & " Where Seq='"&CLng(seq)&"' and info_Cd='"&info&"' and Del_Yn='N' "
            if imgSeq<>"" Then sql = sql & " And img_Seq="& imgSeq
            Set Rs = DB.Execute(sql)
    
            If Rs.Eof Then 
                imgNumMax	= 1   
            Else 
                imgNumMax = Rs(0)     
            End If
    
            If IsNull(imgNumMax) Or imgNumMax="" Then imgNumMax=1
    
            Select Case info
                Case "01"
                    tbl = "Ti310"
                    subName = "310"
                Case "02"
                    tbl = "Ti320"
                    subName = "320"
                Case "03"
                    tbl = "Ti330"
                    subName = "330"
                Case "04"
                    tbl = "Ti340"
                    subName = "340"
                Case "05"
                    tbl = "Ti350"
                    subName = "350"
                Case "06"
                    tbl = "Ti360"
                    subName = "360"
                Case "07"
                    tbl = "Ti370"
                    subName = "370"
                Case "08"
                    tbl = "Ti380"
                    subName = "380"
                Case Else
                    tbl = "Ti310"
                    subName = "310"
            End Select
    
            imgName1 = fnImgName(Seq)
            imgName2 = fnImgName(imgNumMax)
            imgFullName = nat_cd & city_cd & subName & imgName1 & "_" & imgName2 & ".jpg"
    
    
            Rs.Close : Set Rs = Nothing
    
            sql =			" INSERT INTO TB_Ph020("
            sql = sql & " INFO_CD "
            sql = sql & ", SEQ "
            sql = sql & ", IMG_SEQ "
            sql = sql & ", SIZE_CD "
            sql = sql & ", IMG_PATH "
            sql = sql & ", INFO_DESC "
            If sub_seq<>"" Then sql = sql & ", sub_seq "
            sql = sql & ", INS_DT "
            sql = sql & ", DEL_YN		) "
            sql = sql & " VALUES	( "
            sql = sql &	" '" & info & "'	"
            sql = sql & ", "  & seq
            sql = sql & ", "  & imgNumMax
            sql = sql & ", '" & goodSize & "'"
            sql = sql & ", '" & imgFullName & "' "
            sql = sql & ", N'" & strContents & "'	"
            If sub_seq<>"" Then sql = sql & ", " & sub_seq		
            sql = sql & ", '" & strDate & "'	"
            sql = sql & ", 'N' )"
    
            DB.Execute(sql)
            'response.write sql
            'response.end
            '게시물 얻기
            sql	=		   " SELECT MAX(IMG_SEQ) AS maxSeq "
            sql = sql & " FROM TB_Ph020 "
            sql = sql & " WHERE 1=1 "
            sql = sql & " AND SEQ = '" & seq & "' "
            sql = sql & " AND IMG_SEQ = '" & imgNumMax & "' "	
            sql = sql & " AND IMG_PATH = '" & imgFullName & "' "
    
            url = "seq="&seq&"&info="&info&"&nat="&nat&"&city="&city&"&imgSeq="&imgNumMax&"&sub_seq="&sub_seq
    		
    End Select
    	
    url = "img_Up.asp?" & url
    
    Set RS = DB.execute(sql)
    
    
    If RS.EOF Then	'게시물 존재 여부
        DB.RollbackTrans
        RS.close : Set RS = Nothing
        CloseDB DB	
        fnGoBack("첨부파일이 존재하지 않습니다.\n다시 등록해주세요. ")		
    Else	'게시물 존재 여부
    
        if UploadForm("ImgFileNm").FileLen>0 Then
            '== 화일첨부 ==================================================================================
            Set FSO = Server.CreateObject("Scripting.FileSystemObject")
            getUrl = server.mapPath("../")  & getUrl '//경로에 맵 경로 추가
            
            '*********** 파일업로드 Start *****************
            If Not FSO.FolderExists(imgPathGood2)   then FSO.CreateFolder(imgPathGood2)
            If Not FSO.FolderExists(imgPathGood)   then FSO.CreateFolder(imgPathGood)
    		    
            filePath = getUrl & imgFullName														'// 삭제될 이미지
            old_filePath = getUrl & Left(imgFullName, 12) & "_DEL.JPG"			'//임의로 파일 저장할 이름
            
            Select Case Flag		
                Case "goods"
                    NewImgName_A = getUrl & Left(imgFullName,14) & "A.jpg"				'//새로저장될 이미지 이름
                    NewImgName_B = getUrl & Left(imgFullName,14) & "B.jpg" 
    		    
                    'response.write NewImgName_A
                    'response.end
                    fnFsoDelete(filePath)																	'//기존에 파일이 있으면 삭제
                    fnFsoDelete(NewImgName_A) 														'//저장될 이미지와 같은 이름이 있으면 삭제
                    fnFsoDelete(NewImgName_B)		
                    '//이미지 등록
            
                    UploadForm("ImgFileNm").SaveAS old_filePath				
    		    
                    if objImage.SetSourceFile(old_filePath) Then 
                        a = objImage.SaveasThumbnail(NewImgName_A,imgA1,imgA2,False)
                        b = objImage.SaveasThumbnail(NewImgName_B,imgB1,imgB2,False)
                    end if
                    fnFsoDelete(old_filePath)		
    		    
            
                Case "area" '지역이미지 사이즈는 아래에
                    If Not FSO.FolderExists(imgPathArea)  then FSO.CreateFolder(imgPathArea)
                    If Not FSO.FolderExists(imgPathNat)   then FSO.CreateFolder(imgPathNat)
                    If Not FSO.FolderExists(imgPathCity)  then FSO.CreateFolder(imgPathCity)
            
                    'if info="01" Then 	'호텔
                        'fnFsoDelete(filePath)																	'//기존파일삭제
                        'UploadForm("ImgFileNm").SaveAS old_filePath								'//임의의 파일 저장
                        '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                        'if objImage.SetSourceFile(old_filePath) Then a = objImage.SaveasThumbnail(filePath,"800", "600", False)
                        '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                        'fnFsoDelete(old_filePath)		
    		    
                    'elseif  info="07" Then 	'골프장
                        'fnFsoDelete(filePath)																	'//기존파일삭제
                        'UploadForm("ImgFileNm").SaveAS old_filePath								'//임의의 파일 저장
                        '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                        'if objImage.SetSourceFile(old_filePath) Then a = objImage.SaveasThumbnail(filePath,"800", "600", False)
                        '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                        'fnFsoDelete(old_filePath)		
    		    
                    'Else '호텔골프장 제외한것들
                        fnFsoDelete(filePath)																													'//이미지 삭제
                        UploadForm("ImgFileNm").SaveAS old_filePath																				'//이미지 등록
                        '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                        'if objImage.SetSourceFile(old_filePath) Then a = objImage.SaveasThumbnail(filePath,strWidth,strHeight, False)
                        if objImage.SetSourceFile(old_filePath) Then a = objImage.SaveasThumbnail(filePath,"1200", "800", False)
                        '=== 이미지 속성을 변경해서 저장한다. jpg===================================================
                        fnFsoDelete(old_filePath)											'//임의로 등록된 이미지 삭제
                    'End if
    		    
            End Select
                
            Set FSO = Nothing
            Set UploadForm	= Nothing
            Set objImage = Nothing

        else
        	
            DB.RollbackTrans
            RS.close : Set RS = Nothing
            CloseDB DB	
            fnGoBack("첨부파일이 존재하지 않습니다.\n다시 등록해주세요.")
        end if
    
    
        if Err.number = 0 Then
            DB.CommitTrans
            RS.close : 	Set RS = Nothing
            CloseDB DB	
            fnGoUrl(url)
        else 
            DB.RollbackTrans
            RS.close : Set RS = Nothing
            CloseDB DB	
            fnGoBack("등록시 오류가 발생하였습니다.\n다시 한번 등록하세요.")
        end if
        
    End if
%> 