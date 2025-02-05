<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/support.asp" -->
<!--include virtual="/home/inc/cookies2.asp" -->

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private" 

   ' If memid <> "" Or cu_htel <> ""   Then
        response.write "<script language='javascript'>  "
        response.write "  window.location.href='/mobile/main.asp';"
        response.write "</script>                             "
        response.end
  '  End if
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

<link rel="stylesheet" type="text/css" href="/mobile/css/common.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/style.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/default.css">

<script type="text/javascript" language="javascript" src="/mobile/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/slick.js"></script>

<link rel="stylesheet" type="text/css" href="/mobile/css/banner1.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner2.css">

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">

        <div style="width:100%; z-index:100; margin:0; padding:50px 0px 0px 0px; position:absolute; ">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="40%" style="padding:0px 0px 0px 30px;text-align: left;"><a href="/mobile/index.asp" class="top_link"><img src="/images/logo/title_logo.png" alt="<%=GLOBAL_SIN%>" /></td>
                    <td width="*%">
                        <div style="padding:0px 30px 0px 0px;text-align: right;">
                            <% if Request.Cookies("memid") = "" or Request.Cookies("pwd") = "" or Request.Cookies("memkind") = "" then %>
                                <span class="txt_new"><a onclick="fn_pass('/mobile/member/login.asp?num=<%=num%>&f_ts=qna_view');return false;" style="cursor:pointer;"><i class="xi-lock-o xi-x"></i> 로그인</a></span>
                            <% else %>
                                <span class="txt_new"><a href="/mobile/member/logout.asp"><i class="xi-unlock-o xi-x"></i> 로그아웃</a></span>
                            <% end if %>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div class="m_container">
            <article class="contents">
                <section>
                    <div class="main_cont_box">
                        <ul class="section1">
                            <li class="slide_banners">
                                <div class="main_slick_slider">
                                	<%  
                                      OpenF5_DB objConn
                                      
                                      sli_sql ="SELECT  count(num) from main_new_img where g_kind='10' and sub_kind='M' and use_yn='Y'"
                                      Set Rs = Server.CreateObject("ADODB.RecordSet")
                                      Rs.open sli_sql , objConn , 3
                                      ss_cnt = Rs(0)
                                      rs.close : Set rs=nothing
                                      
                                      ReDim m_img(ss_cnt), m_url(ss_cnt), m_title(ss_cnt), m_remark(ss_cnt)
                                          
                                      sql =" select  i_img, i_url, title, remark  from  main_new_img WHERE  (g_kind = 10) and sub_kind='M' and use_yn='Y' order by num asc"
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
                                          
                                              m_img(ii)   = r_img
                                              m_url(ii)   = r_url
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
                                        <div><% if m_url(ii) <> "" then %><a href="<%=m_url(ii)%>"  target="_self"><% end if %> <img src="/board/upload/main_img/<%=m_img(ii)%>" class="mainimg"></a></div>
                                	<% Next %>
                                	<%
                                	    CloseF5_DB objConn
                                	%> 
                                </div>
                            </li>
                        </ul>
                    </div>
                </section>
            </article>
        </div>

    </div>
    
</body>
</html>




<script type="text/javascript">
    $(function() {

        var openPrivacy = "";
        if(openPrivacy == "T"){
            layerFull('privacy');
        }
	
        $('.main_slick_slider').slick({                    
            arrows : false,
            dots : true,
            infinite : true,
            slidesToShow : 1,
            slidesToScroll : 1,
            autoplay: true,
            autoplaySpeed: 2000
        });
	
        $('.bottom_slick_slider').slick({                    
            arrows : false,
            dots : true,
            infinite : true,
            slidesToShow : 1,
            slidesToScroll : 1,
            autoplay: true,
            autoplaySpeed: 2000,
            dotsClass: 'custom_paging',
            customPaging: function (slider, i) {                       
                return  (i + 1) + '/' + slider.slideCount;
            }
        });
    
    });
</script>

<div id="pop_password" title="비밀번호"></div>
<script language="javascript">
    function fn_pass(_url1){
        $("#pop_password").html('<iframe id="modalIframeId1" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="no" />').dialog("open");
        $("#modalIframeId1").attr("src",_url1);
    }
    $(document).ready(function(){
        $("#pop_password").dialog({
            autoOpen: false,
            modal: true,
            width: 330,
            height: 300
        });
    });
</script>