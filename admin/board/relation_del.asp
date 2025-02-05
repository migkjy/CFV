<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    gotopage = Request("gotopage")
    s_cont = Request("s_cont")
    s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
    cont = Replace(cont,"'","")
    
    num = Request("num") 
    g_kind = Request("g_kind")

    asp_file   = Lcase(Request("asp_file"))
    Select Case asp_file

        Case "notice_list"
            tbl="trip_notice"	
            etc ="&s_cont="&s_cont&"&cont="&cont&"&g_kind="&g_kind
 
        Case "after_list"
            tbl="trip_after"	
            etc ="&s_cont="&s_cont&"&cont="&cont&"&g_kind="&g_kind

        Case "qna_list"
            tbl="trip_qna"	
            etc ="&s_cont="&s_cont&"&cont="&cont&"&g_kind="&g_kind
        Case "spt_news_list"
               tbl="trip_spt"
        Case "faq_list"
            tbl="trip_faq"	
            etc ="&s_cont="&s_cont&"&cont="&cont
            
        Case "order_list"
            tbl="trip_order"
            etc ="&s_cont="&s_cont&"&cont="&cont
            
    End Select


    cartSeq = Split(Request("cartSeq"),",")


    OpenF5_DB objConn 


    For i = 0 to UBound(cartSeq)

        sql =  "	delete  FROM "&tbl&"	 where num="&cartSeq(i)
        objConn.Execute(sql)

        If asp_file="after_list" then
            sql2 =  "	delete  FROM trip_after_dat where num="&cartSeq(i)
            objConn.Execute(sql2)

        Elseif asp_file="qna_list" then
            sql2 =  "	delete  FROM "&tbl&" where ref="&cartSeq(i)
            objConn.Execute(sql2)

        Elseif asp_file="order_list" then
            sql2 =  "	delete  FROM "&tbl&" where ref="&cartSeq(i)
            objConn.Execute(sql2)
        End if

    Next

    CloseF5_DB objConn
%>

<script type="text/javascript">
<!--
   alert("삭제 처리 되었습니다.");
   location.href="<%=asp_file%>.asp?gotopage=<%=gotopage%><%=etc%>";
//-->
</Script>    
 