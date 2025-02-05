<!-- #include file="Function_Upload.asp" -->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"


    g_code = Request("g_code")					'//상품등록번호 페이지 이동시 필요
    goodsNum = Request("goodsNum")      '//상품등록번호 페이지 이동시 필요
    seq = Request("seq")							    '//이미지 번호
    
    blurValue = Request("blurValue")
        if  blurValue ="-" then
            blurValue = "99"
        end if	
    
    blurNum = Request("blurNum")

    Flag = Request("Flag")

    info = Request("info")						'//테이블 정보
    nat = Request("nat")						    '/나라코드
    city = Request("city")						    '//도시코드
    imgPath = Request("imgPath")
    sub_seq = Request("sub_seq")


    If blurNum = "-" Then blurNum = ""

    OpenCsDB DB
    DB.BeginTrans'//트랜잭션

    Select Case Flag
        Case "goods"
            sql = " UPDATE TB_Ph010 SET "	&_
                     " DISP_OR = '" & blurValue  & "' "	&_
                     " WHERE SEQ = '" & blurNum & "' "	&_
                     " AND g_code = '" & goodsNum & "' "	
			
            url = "g_code="&g_code&"&goodsNum="&goodsNum
			
        Case "area"	
            sql = " UPDATE TB_Ph020 SET "	&_
                     " DISP_OR = '" & blurValue  & "' "	&_
                     " WHERE INFO_CD		= '" & info & "' " &_
                     " AND SEQ = '" & seq & "' " &_
                     " AND IMG_SEQ = '" & blurNum & "' "	
             url =	"seq="&seq&"&info="&info&"&nat="&nat&"&city="&city&"&sub_seq="&sub_seq
    End Select 

    url = "Img_Main.asp?Flag="& Flag &"&" & url 

    DB.Execute(sql)		

    If Err.number = 0 Then
        DB.CommitTrans
        CloseDB DB
        fnGoUrl(url)
    Else 
        DB.RollbackTrans
        CloseDB DB	
        fnGoBack("수정시 오류가 발생하였습니다.\n다시 한번 수정하세요.")
    End if
%>