<!--#include virtual="/home/conf/config.asp" -->
<!--include virtual="/home/inc/cookies2.asp"-->
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

<script src="/home/js/jquery.fancybox.pack.js?v=2.1.4"></script>
<link rel="stylesheet" type="text/css" href="/home/js/jquery.fancybox.css?v=2.1.4" />  

</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">
        	
            <div style="width:100%;height:350px;background:url('/board/upload/main_img/bk_Padma.jpg') fixed;background-size:100%;">
                <div align="center">
                    <table width="100%" height="350" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
                        <tr>
                            <td>
                                <div align="center">
                                    <div class="sub_top_en">Padma Resort Ubud</div>
                                    <div class="sub_top_ko">파드마 리조트 우붓</div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div> 


            <div id="contBody">
                <%
                    tbl = "trip_notice"  
                    num = 13
                
                    OpenF5_DB objConn
                
                    sql="select num, title ,con_tents from "&tbl&" where num="&num&" and g_kind=20 and del_yn='N'   "
                    Set Rs = objConn.Execute(Sql)
                    If rs.eof or rs.bof then
                        Response.write "<script type='text/javascript'>"
                        Response.write " alert('접근하실수 없습니다.'); "
                        Response.write " history.back(); "
                        Response.write " </script>	 "
                        Response.End
                    Else
                       num = Rs("num")
                       title = Rs("title")
                       con_tents = Rs("con_tents")
                    End if
                
                    CloseRs Rs
                
                    sql = " update "&tbl&" Set hit = hit + 1  where num ="&num
                    objConn.Execute(sql)
                %> 

                <div class="cont_body"><%=con_tents%></div>
     
                <div class="pt80"></div>
                
                <% CloseF5_DB objConn %>
            </div> 

        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

<script language="javascript" type="text/javascript">
    $(function(){
        var ifm = $(".cont_body iframe");
        ifm.each(function() {
            $(this).css("width","100%");
            $(this).css("height","700");
        });
    });

    $(function(){
        var img = $(".cont_body img");
        img.each(function() {
            $(this).css("width","100%");
            $(this).css("height","auto");
        });
    });
</script>