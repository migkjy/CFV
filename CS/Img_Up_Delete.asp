<!-- #include file="Function_Upload.asp" -->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    

    Set UploadForm				= Server.CreateObject("DEXT.FileUpload") 
    PhysicalImgPath				= server.MapPath("/images/")	
    UploadForm.DefaultPath	= PhysicalImgPath
    
    getUrl							     = UploadForm("getUrl")
    seq								     = UploadForm("seq")
    goodsNum					     = UploadForm("goodsNum")
    g_code		   				         = UploadForm("g_code")
    info								    = UploadForm("info")						'//테이블 정보
    nat								   = UploadForm("nat")						'/나라코드
    city								   = UploadForm("city")						'//도시코드
    imgSeq							   = UploadForm("imgSeq")
    imgPath						   = UploadForm("imgPath")
    nat_cd							   = UploadForm("nat_cd")					'/나라코드
    city_cd						       = UploadForm("city_cd")					'//도시코드
    desc_cd						      = UploadForm("desc_cd")				'//도시코드
    sub_seq						      = UploadForm("sub_seq")				'//도시코드
    Flag								 = UploadForm("Flag")
    
    
    OpenCsDB DB
    
    
    DB.BeginTrans'//트랜잭션
    
    Select Case Flag
        Case "goods"	 
    
            if Trim(seq)=""   then
                response.write "<script language='javascript'>               "
                response.write "  alert('주요인자 전송에러!!');"
                response.write "  history.go(-1);                            "
                response.write "</script>                                    " 
                response.end
            end if
    		
            sql = " DELETE FROM TB_ph010 WHERE "	&_
                     " g_code = '"&goodsNum	&"' "	&_
                     " and	seq = "& seq
            url = "g_code="&g_code&"&imgA="&imgA&"&imgB="&imgB&"&goodsNum="&goodsNum
    
        Case "area"
    
            if Trim(imgSeq)=""   then
                response.write "<script language='javascript'>               "
                response.write "  alert('주요인자 전송에러!!');"
                response.write "  history.go(-1);                            "
                response.write "</script>                                    " 
                response.end
            end if
       
            sql = "DELETE FROM TB_ph020 WHERE Info_cd='"&info&"' AND seq="&seq&"  And img_Seq = '"& imgSeq &"'"
            If sub_seq<>"" Then sql = sql & " and sub_seq="&sub_seq
            url = "seq="&seq&"&info="&info&"&nat="&nat&"&city="&city&"&sub_seq="&sub_seq
    End Select
    
    url = "img_up.asp?" & url
    
    DB.Execute(sql)
    
    
    If Err.number = 0 Then'//Commit
        DB.CommitTrans
        CloseDB DB
    
        '== 체크 이미지를 삭제하기 ==================================================================================
        getUrl	= server.mapPath("../")  & getUrl	
        filePath	= getUrl &  imgPath	
    
        Set FSO=CreateObject("Scripting.FilesystemObject") 
    		
        Select Case Flag
            Case "goods"
                NewImgName_A = getUrl & Left(imgPath,14) & "A.jpg" '& Ext	'Large	파일 경로
                NewImgName_B = getUrl & Left(imgPath,14) & "B.jpg" '& Ext	'Medium	파일 경로
                fnFsoDelete(NewImgName_A)
                fnFsoDelete(NewImgName_B)
    			
            Case "area"
                fnFsoDelete(filePath)
        End Select
    		
        Set Fso = Nothing
        Set UploadForm = Nothing
        '== 체크 이미지를 삭제하기 ==================================================================================
    
        fnGoUrl(url)
    Else 
        DB.RollbackTrans'//Rollback
        CloseDB DB
        Set UploadForm = Nothing
    
        fnGoBack("삭제시 오류가 발생하였습니다.\n다시 한번 삭제하세요.")
    End if
%>