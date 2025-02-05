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
<script type="text/javascript" src="/home/js/jquery-ui.min.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.min.css" />

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>
</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--#include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">

            <div style="width:100%;height:350px;background:url('/board/upload/main_img/bk_faq.jpg') fixed;background-size:100%;">
                <div align="center">
                    <table width="100%" height="350" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
                        <tr>
                            <td>
                                <div align="center">
                                    <div class="sub_top_en">Frequently Asked Questions</div>
                                    <div class="sub_top_ko">자주묻는질문</div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <% 
                OpenF5_DB objConn
            
                s_cont = Request("s_cont")
                s_cont = Replace(s_cont,"'","") 
                cont = Request("cont")
                cont = Replace(cont,"'","")
            %>     
            <script type="text/javascript">
            <!--
                $(document).ready(function(){
                    $('.answer').hide();
                    
                    $('#faq_main .title').click(function(){
                      $(this).next('.answer').slideToggle("slow")
                      
                     });
                     
                });
            //-->
            </script>

            <div style="background: #FFF;  padding:40px 0px;"> 
                <div align="center">
                    <div class="board_search">
                        <form name="s_frm" method="post" action="faq_list.asp" style="display:inline; margin:0px;">
                            <ul>
                                <li><input type="text" name="cont" value=""<%=cont%>" style="width:400px;height:40px;border-radius:20px;padding:0 20px;color:#222;font-size:16px; font-weight:500;" /></li>
                                <li><span class="box_search"><a onclick="chk_frm();"  style="cursor:pointer;"><i class="xi-magnifier xi-x"></i><span style="font-size:16px;padding:0 0 0 2px">검색</span></a></span></li>
                            </ul>
                        </form>
                    </div>
                </div> 
            </div> 
            
            <div id="contBody">
                <div class="board_list"> 
                    <% 
                        tbl    = "trip_faq"
                        ans = " and (title like '%" & cont & "%' or con_tents like '%" & cont & "%') "
                
                        sql = " SELECT num, title, con_tents,ins_dt FROM "&tbl
                        sql = sql &" WHERE del_yn='N' "
                        if cont <> "" then sql = sql & ans
                        sql = sql &"  ORDER BY num DESC"
                      
                        Set Rs = objConn.Execute(sql)
                        if Rs.eof and Rs.bof then 
                    %>
                    
                    <div class="none_list">등록된 자료가 없습니다.</div>
                    
                    <% Else %> 
                    <div id="faq_main">
                        <%
                            ii = 1
                            Do until rs.EOF
                                num       = rs("num")
                                title     = rs("title")
                                con_tents = rs("con_tents")
                                if not isnull(con_tents) or con_tents <> "" then
                                    con_tents =  replace(con_tents,chr(13)&chr(10),"")
                                end if	
                        %>
                        <div class="title"><strong><%=ii%>.</strong> <%=title%></div>
                        <div class="answer"><%=con_tents%></div>
                        <%
                             Rs.MoveNext
                             ii = ii + 1 
                             loop
                        %>
                    </div>
                
                    <%
                        End if
                         
                        Rs.close : Set Rs = nothing
                    %>
                </div>
                <div style="border-top:1px solid #E7E7E7;"></div>

            </div>
            
            <div class="pt80"></div>
            
            <% CloseF5_DB objConn  %>
            
        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>
    
<script language="javascript">
<!--
    function chk_frm(){
        if (document.s_frm.cont.value==""){
            alert("검색어를  입력해 주세요.");
            return false;
        }
        document.s_frm.submit();
    }
//--> 
</script> 
    