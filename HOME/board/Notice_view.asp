<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<% 
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>

<!DOCTYPE html>
<html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sm_logo.png">
	
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">

<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script type="text/javascript" src="/home/js/jquery.fancybox.pack.js?v=2.1.4"></script>
<link type="text/css" href="/home/js/jquery.fancybox.css?v=2.1.4" />

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>
</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--#include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">
        	
            <div id="contBody">
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
                
                <script language="JavaScript">
                <!-- 
                    if (navigator.userAgent.match(/iPad/) == null && navigator.userAgent.match(/iPhone|Mobile|UP.Browser|Android|BlackBerry|Windows CE|Nokia|webOS|Opera Mini|SonyEricsson|opera mobi|Windows Phone|IEMobile|POLARIS/) != null){       
                        window.location.href = "<%=global_url%>/mobile/board/notice_view.asp?num=<%=num%>";
                    }
                //-->
                </script>
                
                <div class="pt10"></div>
                <div class="infor_title"><%=title%></div>
                <div style="border-bottom:2px solid #000;"></div>
                <div class="pt30"></div>
                <div class="infor_content"><%=con_tents%></div>
                <div class="pt30"></div>
                <div style="border-bottom:1px solid #EAEAEA;"></div>
                
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
                            <dd>이전글이 없습니다.</dd>
                        <% Else  %>  
                            <dd><a href="notice_view.asp?num=<%=Rs("prenum")%>&gotopage=<%=gotopage%>"><%=Rs("pre_title")%></a></dd>
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
                            <dd>다음글이 없습니다.</dd>
                        <% Else %>
                            <dd><a href="notice_view.asp?num=<%=Rs("nextnum")%>&gotopage=<%=gotopage%>"><%=Rs("next_title")%></a></dd>
                        <%
                             End if
                            Rs.close : Set Rs = nothing
                        %>
                    </dl>
                </div>
                
                <div class="board_btn_w">
		            <ul class="btn_r">
		            	<li><a href="notice_list.asp?gotopage=<%=gotopage%>">목록</a></li>		
		            </ul>
                </div>
                
                <% CloseF5_DB objConn %>
                
               <div class="pt50"></div> 
    	
            </div>
            
        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
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
