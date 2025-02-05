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
    s_area = Lcase(Request("s_area"))
    

    print_1= Trim(Request("print_1")) '###상품소개
    print_2= Trim(Request("print_2")) '###여행스토리
    print_3= Trim(Request("print_3")) '###유의사항
    print_4= Trim(Request("print_4")) '###유의사항	
    

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
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link type="text/css" rel="stylesheet" href="/css/style.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/home/js/jquery-3.4.1.min.js"></script>
 <link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
</head>

<body style="padding:20px;" >
 
    <div class="rater_top">
        <table>
            <colgroup>
                <col width="285px">
                <col width="*">
            </colgroup>
            <tbody>
                <tr>
                    <td><img src="<%=global_url%>/images/logo/title_logo.png" border="0" border="0" height="50"></td>
                    <td><div align="right"><%=GLOBAL_JU%><br><%=GLOBAL_TEL%>，<%=GLOBAL_FAX%>，<%=GLOBAL_MAIL%></div></td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <div class="pt10"></div>
    <div style="border-bottom:2px solid #000;"></div>
    <div class="pt30"></div>
    <div class="rater_title"><%=title%></div>
    <div class="pt15"></div>

    <div class="rater_box">
        <table>
            <colgroup>
                <col width="15%">
                <col width="*">
            </colgroup>
            <tbody>  
                <tr>
                	  <td class="typ1">정원</td>
                	  <td class="typ2"><%=emp_email%></td>
                </tr>
                 <tr>
                	  <td class="typ3">최소출발</td>
                	  <td class="typ4"><%=emp_nm%><명/td>
                </tr>
                <tr>
                	  <td class="typ3">투어시간</td>
                	  <td class="typ4"><%=eng_title%></td>
                </tr>
                <tr>
                	  <td class="typ3">출발요일</td>
                	  <td class="typ4"><%=good_tip%></td>
                </tr>
            </tbody>
        </table> 
    </div>


    <% If remark1<>"" then %>
        <div class="pt20"></div>
        <div class="rater_line">
            <div  class="infor1_title">상품소개</div>
            <div class="detail_txt"><%=remark1%></div>
        </div>
    <% End if %>
            
    <% If print_2="Y" then %>
        <div class="pt20"></div>
        <div class="rater_line">
            <div  class="infor1_title">여행스토리</div>
            <div class="detail_txt"><%=remark2%></div>
        </div>
    <% End if %>

    <% If print_3="Y" then %> 
        <div class="pt20"></div>
        <div class="rater_line">
            <div  class="infor1_title">준비물</div>
            <div class="detail_txt"><%=remark3%></div>
        </div>
    <% End if %>

    <% If print_4="Y" then %> 
        <div class="pt20"></div>
        <div class="rater_line">
            <div  class="infor1_title">유의사항</div>
            <div class="detail_txt"><%=remark4%></div>
        </div>
    <% End if %>


    <div class="pt100"></div>

    <style type="text/css" media="print">
        .noprint {
        display: none;
        }
    </style>

    <form name="search_frm" method="post" action="print_ticket.asp">
  	<input type="hidden" name="num" value="<%=num%>">
  	<input type="hidden" name="g_kind" value="<%=g_kind%>">
    <div id="footpanel" class="noprint">
        <ul id="mainpanel">    	
            <li><span class="checks"><input  type="checkbox" name="print_1" value="Y" checked><label for="print_1" style="font-weight:500; padding:0 40px 0 20px;">상품소개</label></span></li>
            <li><span class="checks"><input type="checkbox" name="print_2" id="print_2" value="Y" <% if print_2="Y" then %>checked<% end if %> onclick="go_search();return false;"><label for="print_2" style="font-weight:500; padding:0 40px 0 0px;">여행스토리</label></span></li>
            <li><span class="checks"><input type="checkbox" name="print_3" id="print_3" value="Y" <% if print_3="Y" then %>checked<% end if %> onclick="go_search();return false;"><label for="print_3" style="font-weight:500; padding:0 40px 0 0;">준비물</label></span></li>
            <li><span class="checks"><input type="checkbox" name="print_4" id="print_4" value="Y" <% if print_4="Y" then %>checked<% end if %> onclick="go_search();return false;"><label for="print_4" style="font-weight:500; padding:0 240px 0 0;">유의사항</label></span></li>
            <li><span class="print_ok"><a href="javascript:void(0)" onClick="window.print();">인쇄</a></span></li>
  	     </ul>
  	 </div>
  	 </form>
  
</body>
</html>


<script language="javascript">
<!--
    function go_search(){
        search_frm.submit();
    }
-->
</script>

<script language="javascript" type="text/javascript">
    $(function(){
 
     var img = $(".detail_txt img");
     img.each(function() {
         
       $(this).css("width","100%");
    
     });
 
    
    });
</script> 
