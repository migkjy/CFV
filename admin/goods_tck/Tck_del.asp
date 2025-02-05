<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    OpenF5_DB objConn
    
    num = Request("num")
    g_kind = Request("g_kind")
    s_area = Request("s_area")

    '##############################옵션
    sql2 = "	update  trip_gtck_opt set del_yn='Y'  where good_cd="&num
    objConn.Execute(sql2)
    
    '##############################이미지
    sql = " delete from ex_good_photo  where tp='T' and  g_seq="&num
    objConn.Execute(sql)

    '##############################마감일자
    'sql = "	delete from trip_gtck_daychk  where good_cd="&num
    'objConn.Execute(sql)

    '##############################상품삭제
    sql = "	update trip_gtck set del_yn='Y' where num="&num
    objConn.Execute(sql)

    objConn.close   : Set objConn = Nothing
%>

<script language=Javascript> 
<!--
	alert("삭제 처리되었습니다.   ");
	location.href = "tck_list.asp?g_kind=<%=g_kind%>&s_area=<%=s_area%>";
//-->
</script> 