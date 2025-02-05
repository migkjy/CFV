<!--#include virtual="/home/conf/config.asp" --> 
<!--#include virtual="/home/inc/support.asp"-->

<%
    Response.Expires = -1
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    tbl  = "trip_gtck"
    num  = Request("num")
    g_kind = Lcase(Request("g_kind")) 
    
    OpenF5_DB objConn  
    
    sql = " Select g.num,  g.event_tp, g.g_kind, g.s_area , g.title , g.eng_title, g.emp_nm, g.emp_email, g.good_tip, g.remark1, g.remark2, g.remark3, g.remark4 "
    sql = sql &" ,(SELECT TOP (1) price FROM trip_gtck_opt o WHERE o.good_cd= g.num  order by price asc ) AS min_price "
    sql = sql &"  from "&tbl&" g where num="&num

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3

    If not rs.EOF Then

        title     = Rs("title")
        good_tip  = Rs("good_tip")
        eng_title = Rs("eng_title")
        emp_nm = Rs("emp_nm")
        emp_email = Rs("emp_email")

        r_g_kind  = Ucase(Rs("g_kind"))
        r_s_area  = Rs("s_area")

        remark1 = Rs("remark1")
        remark2 = Rs("remark2")
        remark3 = Rs("remark3")
        remark4 = Rs("remark4")
    End if
   
    Rs.close :      Set Rs=nothing
    CloseF5_DB objConn
%>

<!DOCTYPE html>
<span id="contents0"> 
<html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link type="text/css" rel="stylesheet" href="<%=global_url%>/css/style.css" />
<script type="text/javascript" src="<%=global_url%>/home/js/jquery-3.4.1.min.js"></script>
 <link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
</head>

<body style="padding:0px;" >

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <colgroup>
            <col width="285px">
            <col width="*">
        </colgroup>
        <tbody>
            <tr>
                <td><img src="<%=global_url%>/images/logo/title_logo.png" border="0" height="50"></td>
                <td><div style="font-family:Noto Sans KR; font-size:13px; text-align:right;"><%=GLOBAL_JU%><br><%=GLOBAL_TEL%>，<%=GLOBAL_FAX%>，<%=GLOBAL_MAIL%></div></td>
            </tr>
        </tbody>
    </table>
    
    <div style="padding-top:10px;"></div>
    <div style="border-bottom:2px solid #000;"></div>
    <div style="padding-top:28px;"></div>
    <div style="font-family:Noto Sans KR;  font-size:30px;font-weight:700;letter-spacing:-0.03em;"><%=title%></div>
    <div style="padding-top:15px;"></div>

    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
    	    <colgroup>
    	        <col width="15%">
    	        <col width="*">
    	    </colgroup>
    	    <tbody>  
    	        <tr>
    	            <td style="padding:7px 0px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #D9D9D9; border-right:1px solid #D9D9D9; border-top:1px solid #D9D9D9;border-bottom:1px solid #D9D9D9; background:#F1F1F1; font-weight:700;">정원</td>
    	            <td style="padding:7px 15px; font-family:Noto Sans KR; border-right:1px solid #D9D9D9; border-top:1px solid #D9D9D9; border-bottom:1px solid #D9D9D9;"><%=emp_email%></td>
    	        </tr>
    	        <tr>
    	            <td style="padding:4px 0px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #D9D9D9; border-right:1px solid #D9D9D9; border-bottom:1px solid #D9D9D9; background:#F1F1F1; font-weight:700;">최소출발</td>
    	            <td style="padding:7px 15px; font-family:Noto Sans KR; border-right:1px solid #D9D9D9; border-bottom:1px solid #D9D9D9;"><%=emp_nm%>명</td>
    	        </tr>
    	        <tr>
    	            <td style="padding:4px 0px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #D9D9D9; border-right:1px solid #D9D9D9; border-bottom:1px solid #D9D9D9; background:#F1F1F1; font-weight:700;">투어시간</td>
    	            <td style="padding:7px 15px;font-family:Noto Sans KR;  border-right:1px solid #D9D9D9; border-bottom:1px solid #D9D9D9;"><%=eng_title%></td>
    	        </tr>
    	        <tr>
    	            <td style="padding:4px 0px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #D9D9D9; border-right:1px solid #D9D9D9; border-bottom:1px solid #D9D9D9; background:#F1F1F1; font-weight:700;">출발요일</td>
    	            <td style="padding:7px 15px; font-family:Noto Sans KR; border-right:1px solid #D9D9D9; border-bottom:1px solid #D9D9D9;"><%=good_tip%></td>
    	        </tr>
    	    </tbody>
    	</table> 

    <% If remark1<>"" then %>
        <div style="padding:20px 0 0 0;"></div>
        <div style="border:1px solid #D9D9D9; padding:20px 20px;">
            <div style="font-family:Noto Sans KR;font-size:21px; font-weight:900; padding:0 0 10px 0;">상품소개</div>
            <div style="font-family:Noto Sans KR;font-size: 15px;"><%=remark1%></div>
        </div>
    <% End if %>
            
    <% If remark2<>"" then %>
        <div style="padding:20px 0 0 0;"></div>
        <div style="border:1px solid #D9D9D9; padding:20px 20px;">
            <div style="font-family:Noto Sans KR;font-size:21px; font-weight:900; padding:0 0 10px 0;">여행스토리</div>
            <div style="font-family:Noto Sans KR;font-size: 15px;"><%=remark2%></div>
        </div>
    <% End if %>

    <% If remark3<>"" then %>
        <div style="padding:20px 0 0 0;"></div>
        <div style="border:1px solid #D9D9D9; padding:20px 20px;">
            <div style="font-family:Noto Sans KR;font-size:21px; font-weight:900; padding:0 0 10px 0;">준비물</div>
            <div style="font-family:Noto Sans KR;font-size: 15px;"><%=remark3%></div>
        </div>
    <% End if %>

    <% If remark4<>"" then %>
        <div style="padding:20px 0 0 0;"></div>
        <div style="border:1px solid #D9D9D9; padding:20px 20px;">
            <div style="font-family:Noto Sans KR;font-size:21px; font-weight:900; padding:0 0 10px 0;">유의사항</div>
            <div style="font-family:Noto Sans KR;font-size: 15px;"><%=remark4%></div>
        </div>
    <% End if %>

    <div style="padding-top:30px;"></div>
    <div align="center">
        <span style="font-family:Noto Sans KR; font-size:18px; font-weight:500; color:#FFF; background-color:#F4C41F;padding:12px 40px; line-height:40px; border-radius:3px;"><a href="<%=global_url%>/home/good_tck/ticket_view.asp?num=<%=num%>&g_kind=<%=r_g_kind%>&s_area=<%=r_s_area%>" target="_blank" style="text-decoration:none;"><span style="color:#FFF;">홈페이지 보기</span></a></span>
    </div>
    <div style="padding-top:30px;"></div>

</span>
</body>
</html>



<script language="javascript" type="text/javascript">
    $(function(){
 
     var img = $(".detail_txt img");
     img.each(function() {
         
       $(this).css("width","100%");
    
     });
 
    
    });
</script> 
