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

        <div style="width:100%;height:200px;background:url('/board/upload/main_img/bk_faq.jpg') no-repeat;background-position:top center;background-size:cover;">
            <div align="center">
                <table width="100%" height="200" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
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

        <div class="best_main1">
        	
            <form name="s_frm" method="post" action="faq_list.asp" style="display:inline; margin:0px;">
                <table>
                    <tr>
                        <td width="*%"><input type="text" name="cont" value=""<%=cont%>" style="width:100%;" class="ser_input"></td>
                        <td width="2%"></td>
                        <td width="20%"><div class="ser_btn"><a onclick="chk_frm();"><span style="color:#FFFFFF;"><i class="xi-magnifier xi-x"></i>검색</span></a></div></td>
                    </tr>
                </table>
            </form>

            <div class="pt20"></div>
            
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
                    <div class="none_list">등록된 자료가 없습니다....</div>
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
                    <div style="border-top:1px solid #E7E7E7;"></div>
                <%
                    End if
                     
                    Rs.close : Set Rs = nothing
                %>
                
                <%  CloseF5_DB objConn %>
                
            </div>
        </div>
        
        <!--#include virtual="/mobile/include/foot_ci.asp"-->
    
    </div>
    
</body>
</html>

<script language="javascript" type="text/javascript">
    $(function(){
 
     var img = $(".answer img");
     img.each(function() {
         
       $(this).css("width","100%");
    
     });
 
    
    });
</script> 

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
