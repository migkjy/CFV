<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/conf/before_url.asp" -->  
<!--include virtual="/home/inc/cookies2.asp" -->
<!--#include virtual="/home/inc/support.asp" -->

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

<link rel="stylesheet" type="text/css" href="/mobile/css/banner1.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner2.css">

<script type="text/javascript" language="javascript" src="/mobile/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/slick.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/swiper.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/common.js"></script>

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />
<!--팝업------------------------------------------------------------------------------------------------------------------------------------------------------------>
<script language="JavaScript">

function setCookie1( name, value, expiredays ) { 
    var todayDate = new Date(); 
       todayDate.setDate( todayDate.getDate() + expiredays ); 
       document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
   } 

function closeWin1() { 
    if ( document.notice_form1.chkbox1.checked ){ 
        setCookie1( "maindiv1", "done" , 1 ); 
    } 
    document.all['divpop1'].style.visibility = "hidden";
}
</script>

<div id="divpop1" style="position:absolute;top:100px;z-index:200;visibility:hidden;">
<table style="width:94%; height:auto;" border="0" cellpadding="0" cellspacing="0" align="center">
<tr>
<td>

    <table border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
    <td align=center><img src="/images/popup/20241031.jpg" border="0"></a></td>
    </tr>
    <td align="center" height=30 style="background:#000">	
        <form name="notice_form1">
        <table border="0" cellpadding="0" cellspacing="0">
        <tr>
        <td style="width:70%;padding:10px 10px 10px 10px;"><input type="checkbox" name="chkbox1" value="checkbox" style="width:20px;height:20px;">&nbsp;&nbsp;<span style="color:#FFFFFF; font-size:0.81em;">오늘 하루 이 창을 열지 않음</span></td>
        <td style="width:*%"><a href="javascript:closeWin1();"><img src="/images/Main/pp_close.gif" border="0" style="vertical-align:middle"></a></td>
        </tr>
        </table>
        </form>
    </td>
    </tr>
    </table>
    
</td>
</tr>
</table>
</div>

<script language="Javascript">
cookiedata1 = document.cookie;    
if ( cookiedata1.indexOf("maindiv1=done") < 0 ){      
    document.all['divpop1'].style.visibility = "visible";
  } 
   else {
        document.all['divpop1'].style.visibility = "hidden"; 
}
</script>
</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">
        <!--include virtual="/mobile/include/roommate_matching.asp"-->
        <!--#include virtual="/mobile/include/left_menu.asp"-->
        <!--#include virtual="/mobile/include/top_menu.asp"-->

        <div class="m_container">
            <article class="contents">
                <section>
                    <div class="main_cont_box">
                        <ul class="section1">
                            <li class="slide_banners">
                                <div class="main_slick_slider">
                                	<%  
                                      OpenF5_DB objConn
                                      
                                      sli_sql ="SELECT  count(num) from main_new_img where g_kind='20' and sub_kind='M' and use_yn='Y'"
                                      Set Rs = Server.CreateObject("ADODB.RecordSet")
                                      Rs.open sli_sql , objConn , 3
                                      ss_cnt = Rs(0)
                                      rs.close : Set rs=nothing
                                      
                                      ReDim m_img(ss_cnt), m_url(ss_cnt), m_title(ss_cnt), m_remark(ss_cnt)
                                          
                                      sql =" select  i_img, i_url, title, remark  from  main_new_img WHERE  (g_kind = 20) and sub_kind='M' and use_yn='Y' order by num asc"
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
                                	<% 
                                	    Next 
                                	    
                                	    CloseF5_DB objConn
                                	%> 

                                </div>
                            </li>
                        </ul>
                    </div>
                </section>
            </article>
        </div>

        <div class="best_main1">
<!--
            <div class="com_title">스마일허브 상담/문의</div>
            <div class="com_txt1">◦김현우 (서아투어)</div>
            <div class="com_txt1">◦스마일게이트 엔터테인먼트 협력사 | 차장</div>  
            
            <div style="padding:0px 0 30px 0;"></div>                           

            <div class="com_title">상담센터 상담/문의</div>
            <div class="com_txt1">◦시간 : 10:00~15:00</div>
            <div class="com_txt1">◦점심시간 : 11:30 ~ 12:30</div>
            <div class="com_txt1">◦장소 : 10층 N동 미팅룸2</div>
            <div class="com_txt1">◦기간 : 2024.08.19(월) ~ 2024.08.30(금)</div>
-->
            
            <div style="padding:0px 0 30px 0;"></div>

            <div class="weath">
                <table border="0">
                    <colgroup>
                        <col width="16.67%" />
                        <col width="16.67%" />
                        <col width="16.67%" />
                        <col width="16.67%" />
                        <col width="16.67%" />
                        <col width="*%" />
                    </colgroup>
                    <tbody>
                        <%
                            redim r_city(1),r_city_km(1)
                            r_city(0)  = "Provinsi Bali, ID"   
                            r_city_km(0) ="발리"                       
                        
                            Dim oConn ,ii ,oDom
                            Set oConn = new CXMLConn
                             
                            For ii = 0 to 0
                        
                            oConn.Open "http://api.openweathermap.org/data/2.5/forecast/daily?q="&r_city(ii)&"&mode=xml&units=metric&cnt=7&APPID=d9a448e791904ecf5374127cc12591d5"
                        
                            Set oDom = new CXMLDom
                            oDom.Load oConn.oItem.responseXML.xml
                        %>
                        <tr>
                            <td class="typ1" valign="top">
                            	<%
                            	    selDay=  oDom.AttribValue("time", 0, "day")
                            	    yoilNum = WeekDay(selDay)
                            	    dim selDay,yoilNum,yoilStr
                            	        select case yoilNum
                            	            case 1
                            	                yoilStr = "일요일"
                            	            case 2
                            	                yoilStr = "월요일"
                            	            case 3
                            	                yoilStr = "화요일"
                            	            case 4
                            	                yoilStr = "수요일"
                            	            case 5
                            	                yoilStr = "목요일"
                            	            case 6
                            	                yoilStr = "금요일"
                            	            case 7
                            	                yoilStr = "토요일"
                            	        end select
                            	%>	            	
                            	<div style="font-size:0.75em;"><strong><%=yoilStr%></strong></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("time", 0, "day") %></div>
                            	<div><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 0, "var") %>.png" border="0" width="70%"></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("symbol", 0, "name") %></div>
                            	<div style="font-size:0.56em;">최고 : <%= oDom.AttribValue("temperature", 0, "max") %></div>
                            	<div style="font-size:0.56em;">최저 : <%= oDom.AttribValue("temperature", 0, "min") %></div> 
                            </td>
                            <td class="typ2" valign="top">
                            	<%
                            	    selDay=  oDom.AttribValue("time", 1, "day")
                            	    yoilNum = WeekDay(selDay)
                        
                            	        select case yoilNum
                            	            case 1
                            	                yoilStr = "일요일"
                            	            case 2
                            	                yoilStr = "월요일"
                            	            case 3
                            	                yoilStr = "화요일"
                            	            case 4
                            	                yoilStr = "수요일"
                            	            case 5
                            	                yoilStr = "목요일"
                            	            case 6
                            	                yoilStr = "금요일"
                            	            case 7
                            	                yoilStr = "토요일"
                            	        end select
                            	%>        	
                            	<div style="font-size:0.75em;"><strong><%=yoilStr%></strong></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("time", 1, "day") %></div>
                            	<div style="font-size:0.56em;"><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 1, "var") %>.png" border="0" width="70%"></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("symbol", 1, "name") %></div>
                            	<div style="font-size:0.56em;">최고 : <%= oDom.AttribValue("temperature", 1, "max") %></div>
                            	<div style="font-size:0.56em;">최저 : <%= oDom.AttribValue("temperature", 1, "min") %></div>  
                            </td>
                            <td class="typ2" valign="top">
                            	<%
                            	    selDay=  oDom.AttribValue("time", 2, "day")
                            	    yoilNum = WeekDay(selDay)
                        
                            	        select case yoilNum
                            	            case 1
                            	                yoilStr = "일요일"
                            	            case 2
                            	                yoilStr = "월요일"
                            	            case 3
                            	                yoilStr = "화요일"
                            	            case 4
                            	                yoilStr = "수요일"
                            	            case 5
                            	                yoilStr = "목요일"
                            	            case 6
                            	                yoilStr = "금요일"
                            	            case 7
                            	                yoilStr = "토요일"
                            	        end select
                            	%>         	
                            	<div style="font-size:0.75em;"><strong><%=yoilStr%></strong></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("time", 2, "day") %></div>
                            	<div style="font-size:0.56em;"><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 2, "var") %>.png" border="0" width="70%"></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("symbol", 2, "name") %></div>
                            	<div style="font-size:0.56em;">최고 : <%= oDom.AttribValue("temperature", 2, "max") %></div>
                            	<div style="font-size:0.56em;">최저 : <%= oDom.AttribValue("temperature", 2, "min") %></div>
                            </td>
                            <td class="typ2" valign="top">
                            	<%
                            	    selDay=  oDom.AttribValue("time", 3, "day")
                            	    yoilNum = WeekDay(selDay)
                        
                            	        select case yoilNum
                            	            case 1
                            	                yoilStr = "일요일"
                            	            case 2
                            	                yoilStr = "월요일"
                            	            case 3
                            	                yoilStr = "화요일"
                            	            case 4
                            	                yoilStr = "수요일"
                            	            case 5
                            	                yoilStr = "목요일"
                            	            case 6
                            	                yoilStr = "금요일"
                            	            case 7
                            	                yoilStr = "토요일"
                            	        end select
                            	%>       
                            	<div style="font-size:0.75em;"><strong><%=yoilStr%></strong></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("time", 3, "day") %></div>
                            	<div style="font-size:0.56em;"><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 3, "var") %>.png" border="0" width="70%"></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("symbol", 3, "name") %></div>
                            	<div style="font-size:0.56em;">최고 : <%= oDom.AttribValue("temperature", 3, "max") %></div>
                            	<div style="font-size:0.56em;">최저 : <%= oDom.AttribValue("temperature", 3, "min") %></div>
                            </td>
                            <td class="typ2" valign="top">
                            	<%
                            	    selDay=  oDom.AttribValue("time", 4, "day")
                            	    yoilNum = WeekDay(selDay)
                        
                            	        select case yoilNum
                            	            case 1
                            	                yoilStr = "일요일"
                            	            case 2
                            	                yoilStr = "월요일"
                            	            case 3
                            	                yoilStr = "화요일"
                            	            case 4
                            	                yoilStr = "수요일"
                            	            case 5
                            	                yoilStr = "목요일"
                            	            case 6
                            	                yoilStr = "금요일"
                            	            case 7
                            	                yoilStr = "토요일"
                            	        end select
                            	%>       
                            	<div style="font-size:0.75em;"><strong><%=yoilStr%></strong></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("time", 4, "day") %></div>
                            	<div style="font-size:0.56em;"><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 4, "var") %>.png" border="0" width="70%"></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("symbol", 4, "name") %></div>
                            	<div style="font-size:0.56em;">최고 : <%= oDom.AttribValue("temperature", 4, "max") %></div>
                            	<div style="font-size:0.56em;">최저 : <%= oDom.AttribValue("temperature", 4, "min") %></div>
                            </td>
                            <td class="typ2" valign="top">
                            	<%
                            	    selDay=  oDom.AttribValue("time", 5, "day")
                            	    yoilNum = WeekDay(selDay)
                        
                            	        select case yoilNum
                            	            case 1
                            	                yoilStr = "일요일"
                            	            case 2
                            	                yoilStr = "월요일"
                            	            case 3
                            	                yoilStr = "화요일"
                            	            case 4
                            	                yoilStr = "수요일"
                            	            case 5
                            	                yoilStr = "목요일"
                            	            case 6
                            	                yoilStr = "금요일"
                            	            case 7
                            	                yoilStr = "토요일"
                            	        end select
                            	%>        
                            	<div style="font-size:0.75em;"><strong><%=yoilStr%></strong></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("time", 5, "day") %></div>
                            	<div style="font-size:0.56em;"><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 5, "var") %>.png" border="0" width="70%"></div>
                            	<div style="font-size:0.56em;"><%= oDom.AttribValue("symbol", 5, "name") %></div>
                            	<div style="font-size:0.56em;">최고 : <%= oDom.AttribValue("temperature", 5, "max") %></div>
                            	<div style="font-size:0.56em;">최저 : <%= oDom.AttribValue("temperature", 5, "min") %></div>
                            </td>
                        </tr>
                        <%
                            Next
                        %>
                    <tbody>
                </table>
                
                <%
                    Class CXMLConn 
                        Private m_conn
                    
                        Private Sub Class_Initialize      
                            SET m_conn=Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
                        End Sub
                    
                        Private Sub Class_Terminate     
                            Set m_conn = Nothing   
                        End Sub
                    
                        Public Property Get oItem()
                            Set oItem = m_conn    
                        End Property
                    
                        Public Sub Open(url)
                            m_conn.Open "GET", url, False     
                            m_conn.Send   
                        End Sub  
                    End Class
                
                    Class CXMLDom    
                        Private m_dom
                        Private Sub Class_Initialize()     
                            SET m_dom = Server.CreateObject("Msxml2.DOMDocument.6.0")
                        End Sub
                  
                        Private Sub Class_Terminate()    
                            Set m_dom = Nothing
                        End Sub
                 
                        Public Property Get oItem()  
                            Set oItem = m_dom
                        End Property
                 
                        Public Function AttribValue(tag, idx, attrib)
                            AttribValue = m_dom.getElementsByTagName(tag)(idx).attributes.getNamedItem(attrib).Text
                        End Function
                  
                        Public Sub Load(xml)
                            m_dom.async = False
                            m_dom.loadXML(xml)
                        End Sub
                    End Class
                %>
            </div>
            <div style="font-size:0.75em; color:#666; padding:10px 0 10px 0;text-align:right;">발리 날씨 (OpenWeather)</div>
        </div>

        <!--#include virtual="/mobile/include/foot_ci.asp"-->
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