<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>

<!DOCTYPE html>
<html>
<head>
<title>Google Map</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript"  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAvGvJ4jMUUi4Vfq-CAnm8CtITTq2Lr6wk&callback=initMap"></script>
</head>

<body>

    <script language="javascript">
    <!--
        function click() { 
            if((event.ctrlKey) || (event.shiftKey)) { 
                alert('키를 사용할 수 없습니다.'); 
            } 
        } 
        document.onmousedown=click; 
        document.onkeydown=click; 
    -->
    </script>

    <%
        seq = request("h_code")
        info_cd = request("info_cd")
        
        OpenF5_DB objConn '데이타베이스 오픈
    %>
    <% if seq="" or info_cd="" then %>
        <script language="javascript">
            alert("지도정보가 없습니다.");
        </script>
    <% end if %>
    <%
        Select Case info_cd 
            Case "01" 
                tbl = "TB_ti310"
                bg_img = "호텔 위치"
            Case "02" 
                tbl = "TB_ti320"
                bg_img = "관광지 위치"
            Case "07" 
                tbl = "TB_ti370"
                bg_img = "골프장 위치"
            Case else 
                tbl = "TB_ti320"
                bg_img = "관광지 위치"
        End Select
    %>

    <%
        sql = " select t.nm_kor, t.nm_eng,t.nat_cd,t.city_cd,t.seq ,t.point1,t.point2,t.detail,"
        sql = sql & " img_path=(SELECT  top 1   img_path  FROM  TB_PH020  p  where t.seq=p.seq and p.INFO_CD = '"& info_cd &"' and  p.DEL_YN = 'N') "
        sql = sql & " from "&tbl&" t "
        sql = sql & " where seq   = '"& seq &"' "
     	
        set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql,objConn,3
    
        If not rs.EOF Then
            seq = trim(Rs("seq"))
            nat_cd = trim(Rs("nat_cd"))
            city_cd = trim(Rs("city_cd"))
            nm_kor = trim(Rs("nm_kor"))
            nm_eng = trim(Rs("nm_eng"))
            img_path = trim(Rs("img_path"))
            
            if img_path <> "" and not isNull("img_path") then
                img_path = ""&GLOBAL_URL&"/images/area_img/"& nat_cd &"/"& city_cd &"/"& img_path	
            else
                img_path = ""&GLOBAL_URL&"/admin/google_map/images/no_img.jpg"
            end if
            
            point1   = trim(Rs("point1"))
            point2   = trim(Rs("point2")) 
        End if
        
        Rs.close
        set Rs = nothing
    %>

    <script type="text/javascript">
        function initialize() {
            var mapLocation = new google.maps.LatLng('<%=point1%>', '<%=point2%>'); // 지도에서 가운데로 위치할 위도와 경도
            var markLocation = new google.maps.LatLng('<%=point1%>', '<%=point2%>'); // 마커가 위치할 위도와 경도
              
            var mapOptions = {
                center: mapLocation, // 지도에서 가운데로 위치할 위도와 경도(변수)
                zoom: 14, // 지도 zoom단계
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            
            var map = new google.maps.Map(document.getElementById("mapContainer"), mapOptions);
             
            var size_x = 60; // 마커로 사용할 이미지의 가로 크기
            var size_y = 60; // 마커로 사용할 이미지의 세로 크기
             
            // 마커로 사용할 이미지 주소
            var image = new google.maps.MarkerImage('<%=global_url%>/home/google_map/images/<%=png%>',
                new google.maps.Size(size_x, size_y),
                '',
                '',
                new google.maps.Size(size_x, size_y));
            var marker;
                marker = new google.maps.Marker({
                position: markLocation, // 마커가 위치할 위도와 경도(변수)
                map: map,
                icon: image, // 마커로 사용할 이미지(변수)
                title: '<%=nm_kor%>' // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
            });
             
          //  var content = "8888"; // 말풍선 안에 들어갈 내용
           
          var contentString =
          "<div id='content'>" +
          "    <div id='siteNotice'></div>" +
          "    <div style='font-weight:500;padding:0 0 5px 0;'><%=nm_kor%></div>" +
          "    <div id='bodyContent'><img src='<%=img_path%>' width='180'></div>" +
          "</div>";
               
            var infowindow = new google.maps.InfoWindow({ content: contentString});
     
               google.maps.event.addListener(marker, "click", function() {
                infowindow.open(map,marker);
                
            });
          }
      
         google.maps.event.addDomListener(window, 'load', initialize);
    </script>

    <div id="mapContainer" style="width: 100%; height: 630px;border:1px solid #D2D2D2;"></div>

</body>
</html>

<%
    CloseF5_DB objConn
%>
