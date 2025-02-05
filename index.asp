<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/conf/before_url.asp" -->  
<!--include virtual="/home/inc/cookies2.asp" -->
<!--#include virtual="/home/inc/support.asp" -->


<%
    '  If memid <> "" Or cu_htel <> ""   Then
            response.write "<script language='javascript'>  "
            response.write "  window.location.href='/home/main.asp';"
            response.write "</script>                             " 
            response.end
      '  end if
%>

<%
    Function HttpLogMobileDetect()
        Dim i, TempAgent
        Dim IsMobile : IsMobile = False
        Dim AgentList : AgentList = Split("iphone/ipod/ios/blackberry/android/windows ce/lg/mot/samsung/sonyericsson/nokia", "/")
        Dim UserAgent : UserAgent = LCase(Request.ServerVariables("HTTP_USER_AGENT"))
        For i=0 To Ubound(AgentList)
            TempAgent = AgentList(i)
            If(InStr(UserAgent, TempAgent)) <> 0 Then
                IsMobile = True
                Exit For
            End If
        Next
        HttpLogMobileDetect = IsMobile
    End Function 
    
    Dim HttpLogQs, HttpLogDs, HttpLogUrl
    If HttpLogMobileDetect() = True Then
        HttpLogUrl = "https://www.cfvacation.com/mobile/"
    End If   
    
    If HttpLogUrl <> "" Then
        If InStr(1, HttpLogUrl, "?") > 0 Then
            HttpLogDs = "&"
        Else
            HttpLogDs = "?"
        End If
            HttpLogQs = Request.ServerVariables("QUERY_STRING")
        if HttpLogQs <> "" then
            HttpLogQs = HttpLogDs & HttpLogQs
        end If
        Response.Redirect HttpLogUrl & HttpLogQs
        Response.End
    End If




dy_url =request.servervariables("HTTP_HOST")
 
' response.write dy_url
 
   if InStr(dy_url ,"www.") > 0 then
   else

   	response.redirect "https://www.cfvacation.com"
   	
   End if    
   
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
<meta property="og:description" content="<%=GLOBAL_NM%>">
<meta name="description" content="<%=GLOBAL_NM%>">
<meta name='keywords' content="<%=GLOBAL_NM%>">

<link rel="stylesheet" type="text/css" href="/css/style.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">

<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/home/js/jquery.bxslider.min.js"></script>
<link type="text/css" href="/home/js/jquery.bxslider.min.css" />

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />
</head>

<body style="overflow-y: hidden">

    <div style="width:100%; z-index:100; margin:0; padding:50px 0px 0px 0px; position:absolute; ">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="50%" style="padding:0px 0px 0px 50px;text-align: left;"><a href="javascript:goUrl0(1)" class="top_link"><img src="/images/logo/title_logo.png" alt="<%=GLOBAL_SIN%>" /></td>
                <td width="*%">
                    <div style="padding:0px 50px 0px 0px;text-align: right;">
                        <% if Request.Cookies("memid") = "" or Request.Cookies("pwd") = "" or Request.Cookies("memkind") = "" then %>
                            <span class="txt_new"><a onclick="fn_pass('/home/member/login.asp?num=<%=num%>&f_ts=qna_view');return false;" style="cursor:pointer;"><i class="xi-lock-o xi-x"></i> 로그인</a></span>
                        <% else %>
                            <span class="txt_new"><a href="/home/member/logout.asp"><i class="xi-unlock-o xi-x"></i> 로그아웃</a></span>
                        <% end if %>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    
    <div id="wrap">
        <div id="container">
        	
        	   <!--슬라이드-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
            <div class="bx_wrap">
                <ul class="bxslider">
                    <%  
                        OpenF5_DB objConn
                        
                        sli_sql ="SELECT  count(num) from main_new_img where g_kind='10' and sub_kind='P' and use_yn='Y'"
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open sli_sql , objConn , 3
                        ss_cnt = Rs(0)
                        rs.close : Set rs=nothing

                        ReDim m_img(ss_cnt), m_url(ss_cnt), m_title(ss_cnt), m_remark(ss_cnt)
                            
                        sql =" select  i_img, i_url, title, remark  from  main_new_img WHERE  (g_kind = 10) and sub_kind='P' and use_yn='Y' order by num asc"
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open sql,objConn,3
                        
                        If rs.EOF Then
                        Else
                            ii =0
                            Do until Rs.eof
                    
                                r_img    = Rs("i_img")
                                r_url    = Rs("i_url")
                                r_title  = Rs("title")
                                r_remark = Rs("remark")
                            
                                m_img(ii) = r_img
                                m_url(ii) = r_url

                                m_title(ii) = r_title
                                m_remark(ii) = r_remark
                                if not isnull(m_remark(ii)) or m_remark(ii) <> "" then   
                                    m_remark(ii) = replace(m_remark(ii),chr(13)&chr(10),"<br>")
                                end if


                                Rs.movenext
                                ii = ii +1
                    
                            Loop
                        End if
                    
                        Rs.close : Set Rs=nothing
                    %>
                    <% For ii=0 to ss_cnt-1 %> 
                        <li><img src="/board/upload/main_img/<%=m_img(ii)%>" width="100%" /></li>
                    <% Next %>
                </ul>    
                <!--    	
                <div class="bx_direction">
                    <span class="slider_prev"></span>
                    <span class="slider_next"></span>
                </div>
                -->
                <div class="pager_01"></div>
            </div>
            
        </div>
    </div>
    
    <% CloseF5_DB objConn %>
    
</body>
</html>

<div id="pop_password" title="비밀번호"></div>
<script language="javascript">
    function fn_pass(_url1){
        $("#pop_password").html('<iframe id="modalIframeId1" width="100%" height="240px" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="no" />').dialog("open");
        $("#modalIframeId1").attr("src",_url1);
    }
    $(document).ready(function(){
        $("#pop_password").dialog({
            autoOpen: false,
            modal: true,
            width: 400,
            height: 320
        });
    });
</script>
    
    
<script type="text/javascript">
    $(document).ready(function() {
        //Main Slider
        var slider = $('.bxslider').bxSlider({
            auto: true,
            mode: 'fade',
            nextSelector: '.slider_next',
            prevSelector: '.slider_prev',
            nextText: '<i class="xi-angle-right-thin"></i>',
            prevText: '<i class="xi-angle-left-thin"></i>',
            pagerSelector: '.pager_01',
            touchEnabled : (navigator.maxTouchPoints > 0)
        });
    	
        var swiper = new Swiper('.bx_wrap_m', {
            pagination: {
                el: '.swiper-pagination',
                clickable: true
            } 
        });

        
        $(document).on('click','.slider_next, .slider_prev, .pager_01',function() {
            slider.stopAuto();
            slider.startAuto();
        });
    	
    });  
</script>