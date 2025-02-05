<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->   

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private" 
    
    If memid = "" Or pwd = "" Or memnum = ""  Then
        response.write "<script language='javascript'>  "
        Response.write " alert('로그인정보없습니다..'); "
        response.write "  window.location.href='/';"
        response.write "</script>"
        response.end
    End if
%>    

<!DOCTYPE html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />

<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sm_logo.png">
<meta property="og:description" content="<%=GLOBAL_NM%>">
<meta name="description" content="<%=GLOBAL_NM%>">
<meta name='keywords' content="<%=GLOBAL_NM%>">

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="shortcut icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">
<link rel="apple-touch-icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">

<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner1.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner2.css">

<script type="text/javascript" language="javascript" src="/mobile/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/slick.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/swiper.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/common.js"></script>

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">
    	
        <!--#include virtual="/mobile/include/left_menu.asp"-->
        <!--#include virtual="/mobile/include/top_menu.asp"-->

        <div class="best_main3">

            <%
                tbl  = "trip_notice"  
                num  = Request("num")
            
                gotopage  = Request("gotopage")
                
                s_cont = Request("s_cont")
                s_cont = Replace(s_cont,"'","") 
                cont = Request("cont")
                cont = Replace(cont,"'","")
            
            
                OpenF5_DB objConn
            
                sql="select num ,user_id ,user_nm ,title ,con_tents ,hit ,ins_dt from "&tbl&" where num="&num&" and g_kind=10 and del_yn='N'   "
                Set Rs = objConn.Execute(Sql)
                If rs.eof or rs.bof then
                    Response.write "<script type='text/javascript'>"
                    Response.write " alert('접근하실수 없습니다.'); "
                    Response.write " history.back(); "
                    Response.write " </script>	 "
                    Response.End
                Else
                   num = Rs("num")
                   user_id = Rs("user_id")
                   user_nm = Rs("user_nm")
                   title = Rs("title")
                   con_tents = Rs("con_tents")
                       
                   hit = Rs("hit")
                   ins_dt = left(Rs("ins_dt"),10)
                   
                End if
            
                CloseRs Rs
            
                sql = " update "&tbl&" Set hit = hit + 1  where num ="&num
                objConn.Execute(sql)
            %> 

            <div class="infor_title"><%=title%></div>
            <div style="border-bottom:2px solid #000;"></div>
            <div class="pt20"></div>
            <div class="infor_content"><%=con_tents%></div>
            <div class="pt20"></div>
            <div style="border-bottom:1px solid #E0E0E0;"></div>

            <div class="prev_next">
                <dl class="prev">
                    <dt style="font-weight:500;">이전</dt>
                    <%
                        p_sql = " Select TOP 1 num as prenum,TITLE  as pre_title  from "&tbl &_
                        "	where del_yn='N' and g_kind='10' and (num < "&num&" ) ORDER BY num DESC " 
            
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open p_sql,objConn,3
            
                        If Rs.eof or Rs.bof  then
                    %>
                        <dd><span  style=" padding:0 0 0 10px;">이전글이 없습니다.</span></dd>
                    <% Else  %>  
                        <dd><a href="notice_view.asp?num=<%=Rs("prenum")%>&gotopage=<%=gotopage%>"><span  style=" padding:0 0 0 10px;"><%=Rs("pre_title")%></span></a></dd>
                    <%
                         End if
                          Rs.close :Set Rs = nothing
                    %>
                </dl>
                <dl class="next">
                    <dt style="font-weight:500;">다음</dt>
                    <%
                        n_sql = " Select TOP 1  num as nextnum ,TITLE as next_title   from "&tbl &_
                        "	where del_yn='N' and g_kind='10' and (num > "&num&") ORDER BY NUM asc" 
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open n_sql,objConn,3
            
                        If Rs.eof or Rs.bof  then
                    %>
                        <dd><span  style=" padding:0 0 0 10px;">다음글이 없습니다.</span></dd>
                    <% Else %>
                        <dd><a href="notice_view.asp?num=<%=Rs("nextnum")%>&gotopage=<%=gotopage%>"><span  style=" padding:0 0 0 10px;"><%=Rs("next_title")%></span></a></dd>
                    <%
                         End if
                        Rs.close : Set Rs = nothing
                    %>
                </dl>
            </div>
            
            <div style="padding:7px 0 0 0;"></div>
            <div style="border-bottom:1px solid #E0E0E0;"></div>
                
            <div class="board_btn_w">
		        <ul class="btn_r">
		        	<li><a href="notice_list.asp?gotopage=<%=gotopage%>">목록</a></li>		
		        </ul>
            </div>
            
            <% CloseF5_DB objConn %>

        </div>

        <!--#include virtual="/mobile/include/foot_ci.asp"-->
    
    </div>
    
</body>
</html>

<script language="javascript" type="text/javascript">
    $(function(){
        var img = $(".content img");
        img.each(function() {
     
            $(this).css("width","100%");
            $(this).css("height","auto");
        });
    });
</script>