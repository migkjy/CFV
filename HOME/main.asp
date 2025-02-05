<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/conf/before_url.asp" -->  
<!--include virtual="/home/inc/cookies2.asp" -->
<!--#include virtual="/home/inc/support.asp" -->

<%
 '  If memid = "" Or pwd = "" Or memnum = ""  Then
  '      response.write "<script language='javascript'>  "
   '     Response.write " alert('로그인하세요..'); "
   '     response.write "  window.location.href='/';"
   '     response.write "</script>                             " 
   '     response.end
   ' end if
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
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sns_logo.png">
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
<script src="/home/js/navDock_1.2.min.js" type="text/javascript"></script>

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

<div id="divpop1" style="position:absolute;left:530px;top:166px;z-index:200;visibility:hidden;">
<table width="500" border="0" cellpadding="0" cellspacing="0" align="center">
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
        <td style="padding:10px 10px 10px 10px"><input type="checkbox" name="chkbox1" value="checkbox" style="width:20px;height:20px;">&nbsp;&nbsp;<font color="ffffff">오늘 하루 이 창을 열지 않음</font></td>
        <td><a href="javascript:closeWin1();"><img src="/images/Main/pp_close.gif" border="0" style="vertical-align:top"></a></td>
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
    <!--include virtual="/home/include/roommate_matching.asp"-->
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--include virtual="/home/include/right_menu.asp"--> 

    
    <div id="wrap">
        <div id="container">
        	
        	   <!--슬라이드-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
            <div class="bx_wrap">
                <ul class="bxslider">
                    <%  
                        OpenF5_DB objConn
                        
                        sli_sql ="SELECT top 2 count(num) from main_new_img where g_kind='20' and sub_kind='P' and use_yn='Y'"
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open sli_sql , objConn , 3
                        ss_cnt = Rs(0)
                        rs.close : Set rs=nothing
                        
                        ReDim e_img(ss_cnt), e_url(ss_cnt), e_title(ss_cnt), e_remark(ss_cnt)
                        
                        sql =" select  i_img, i_url, title, remark  from  main_new_img WHERE  (g_kind = 20) and sub_kind='P' and use_yn='Y' order by num asc"
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open sql,objConn,3
                        
                        If rs.EOF Then
                        Else
                            i =0
                            Do until Rs.eof
                        
                                  r_img = Rs("i_img")
                                  r_url = Rs("i_url")
                                  r_title = Rs("title")
                                  r_remark = Rs("remark")
                        
                                  e_img(i) = r_img
                                  e_url(i) = r_url
                                  e_title(i) = r_title
                                  e_remark(i) = r_remark
                                  if not isnull(e_remark(i)) or e_remark(i) <> "" then   
                                      e_remark(i) = replace(e_remark(i),chr(13)&chr(10),"<br>")
                                  end if
                                  
                                  Rs.movenext
                                  i = i +1
                        
                            Loop
                        End if
                        
                        Rs.close : Set Rs=nothing
                    %>
                    <% For i=0 to ss_cnt-1 %> 
                        <li><img src="/board/upload/main_img/<%=e_img(i)%>" width="100%" /></li>
                    <% Next %>
                </ul>    

                <div class="bx_direction">
                    <span class="slider_prev"></span>
                    <span class="slider_next"></span>
                </div>

            </div>
            
            <div style="position: relative;width: 1200px;margin:0 auto;">
                <div align="center" style="padding:80px 0 60px 0;">
                    <table width="1160px" border="0" cellpadding="0" cellspacing="0">
                        <colgroup>
                            <col width="40%">
                            <col width="*">
                        </colgroup>
                        <tbody>
                       <!--
                            <tr>
                                <td valign="top" style="padding:0px;">
                                    <div class="com_title">스마일허브 상담/문의</div>
                                    <div class="com_txt1">◦김현우 (서아투어)</div>
                                    <div class="com_txt1">◦스마일게이트 엔터테인먼트 협력사 | 차장</div>                         
                                </td>
                                <td valign="top" style="padding:0px;">
                                    <div class="com_title">상담센터 상담/문의</div>
                                    <div class="com_txt1">◦시간 : 10:00~15:00</div>
                                    <div class="com_txt1">◦점심시간 : 11:30 ~ 12:30</div>
                                    <div class="com_txt1">◦장소 : 10층 N동 미팅룸2</div>
                                    <div class="com_txt1">◦기간 : 2024.08.19(월) ~ 2024.08.30(금)</div>
                                </td>
                            </tr>-->
                        <tbody>
                    </table>
                </div>

                <div class="weath">
                    <table border="0">
                        <colgroup>
                            <col width="14.29%" />
                            <col width="14.29%" />
                            <col width="14.29%" />
                            <col width="14.29%" />
                            <col width="14.29%" />
                            <col width="14.29%" />
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
                                	<div><strong><%=yoilStr%></strong></div>
                                	<div><%= oDom.AttribValue("time", 0, "day") %></div>
                                	<div><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 0, "var") %>.png" border="0" onError="this.src='/images/inc/Img_weather.gif'"></div>
                                	<div style="padding:7px 0px"><%= oDom.AttribValue("symbol", 0, "name") %></div>
                                	<div>최고 : <%= oDom.AttribValue("temperature", 0, "max") %></div>
                                	<div>최저 : <%= oDom.AttribValue("temperature", 0, "min") %></div> 
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
                                	<div><strong><%=yoilStr%></strong></div>
                                	<div><%= oDom.AttribValue("time", 1, "day") %></div>
                                	<div><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 1, "var") %>.png" border="0" onError="this.src='/images/inc/Img_weather.gif'"></div>
                                	<div style="padding:7px 0px"><%= oDom.AttribValue("symbol", 1, "name") %></div>
                                	<div>최고 : <%= oDom.AttribValue("temperature", 1, "max") %></div>
                                	<div>최저 : <%= oDom.AttribValue("temperature", 1, "min") %></div>  
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
                                	<div><strong><%=yoilStr%></strong></div>
                                	<div><%= oDom.AttribValue("time", 2, "day") %></div>
                                	<div><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 2, "var") %>.png" border="0" onError="this.src='/images/inc/Img_weather.gif'"></div>
                                	<div style="padding:7px 0px"><%= oDom.AttribValue("symbol", 2, "name") %></div>
                                	<div>최고 : <%= oDom.AttribValue("temperature", 2, "max") %></div>
                                	<div>최저 : <%= oDom.AttribValue("temperature", 2, "min") %></div>
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
                                	<div><strong><%=yoilStr%></strong></div>
                                	<div><%= oDom.AttribValue("time", 3, "day") %></div>
                                	<div><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 3, "var") %>.png" border="0" onError="this.src='/images/inc/Img_weather.gif'"></div>
                                	<div style="padding:7px 0px"><%= oDom.AttribValue("symbol", 3, "name") %></div>
                                	<div>최고 : <%= oDom.AttribValue("temperature", 3, "max") %></div>
                                	<div>최저 : <%= oDom.AttribValue("temperature", 3, "min") %></div>
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
                                	<div><strong><%=yoilStr%></strong></div>
                                	<div><%= oDom.AttribValue("time", 4, "day") %></div>
                                	<div><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 4, "var") %>.png" border="0" onError="this.src='/images/inc/Img_weather.gif'"></div>
                                	<div style="padding:7px 0px"><%= oDom.AttribValue("symbol", 4, "name") %></div>
                                	<div>최고 : <%= oDom.AttribValue("temperature", 4, "max") %></div>
                                	<div>최저 : <%= oDom.AttribValue("temperature", 4, "min") %></div>
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
                                	<div><strong><%=yoilStr%></strong></div>
                                	<div><%= oDom.AttribValue("time", 5, "day") %></div>
                                	<div><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 5, "var") %>.png" border="0" onError="this.src='/images/inc/Img_weather.gif'"></div>
                                	<div style="padding:7px 0px"><%= oDom.AttribValue("symbol", 5, "name") %></div>
                                	<div>최고 : <%= oDom.AttribValue("temperature", 5, "max") %></div>
                                	<div>최저 : <%= oDom.AttribValue("temperature", 5, "min") %></div>
                                </td>
                                <td class="typ2" valign="top">
                                	<%
                                	    selDay=  oDom.AttribValue("time", 6, "day")
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
                                	<div><strong><%=yoilStr%></strong></div>
                                	<div><%= oDom.AttribValue("time", 6, "day") %></div>
                                	<div><img src="http://openweathermap.org/img/w/<%= oDom.AttribValue("symbol", 6, "var") %>.png" border="0" onError="this.src='/images/inc/Img_weather.gif'"></div>
                                	<div style="padding:7px 0px"><%= oDom.AttribValue("symbol", 6, "name") %></div>
                                	<div>최고 : <%= oDom.AttribValue("temperature", 6, "max") %></div>
                                	<div>최저 : <%= oDom.AttribValue("temperature", 6, "min") %></div>
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
                    <div style="font-size:13px; color:#666; padding:10px 0 10px 0;text-align:right; ">발리 날씨 (OpenWeather)</div>
                    
                    <div style="padding:0px 0 60px 0;"></div>
                </div>
             </div>
            
        </div>

        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
    <% CloseF5_DB objConn %>
    
</body>
</html>
 
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