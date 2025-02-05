<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/inc/cookies2.asp" -->
<!--#include virtual="/home/inc/support.asp" -->
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

<%
    OpenF5_DB objConn 
    
    g_kind = Lcase(Request("g_kind")) 
    s_area = Lcase(Request("s_area"))
    
    If s_area <> ""  then
        A_sql  =" SELECT title  FROM trip_gtck_city WHERE del_yn='N' and  g_kind='"&g_kind&"' and  idx='"&s_area&"'  " 
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open A_sql,objConn,3

        if Rs.eof then
           Z_ko = ""
        Else
           Z_ko = Rs("title")
        end if

    End If

 
    '###################################################################
    tbl   = "trip_gtck"
    num   = Request("num")   '상품번호
    min_day = Left(now(),10)
    
    '###################################################################
    
    gotopage = Request("gotopage")
    s_cont = Request("s_cont")
      s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
      cont = Replace(cont,"'","")
    
    
    sql = " Select g.num,  g.event_tp, g.g_kind, g.s_area , g.title , g.eng_title , g.good_tip , g.tot_day, g.exchange , g.t_use ,  g.remark1 , g.remark2 , g.remark3 , g.remark4 "
    sql = sql &" ,g.emp_nm , g.emp_email "
    sql = sql &" ,(SELECT TOP (1) price_1 FROM w_tck_day d WHERE d.good_cd= g.num and d.magam='N' and d.day >='"&Replace(min_day,"-","")&"' order by price_1 asc ) AS min_price "
    sql = sql &"  from "&tbl&" g where num="&num
    
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3
    
    If Rs.eof or Rs.bof then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자전송에러!!...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    
    Else
 
        title     = Rs("title")
 
        good_tip  = Rs("good_tip")
        eng_title = Rs("eng_title")
        emp_nm    = Rs("emp_nm")
        emp_email = Rs("emp_email")
 
        event_tp  = Rs("event_tp")
          Select Case Ucase(event_tp)
             Case "A" : event_nm ="/images/goods/event_A.png"
             Case "B" : event_nm ="/images/goods/event_B.png"
             Case "C" : event_nm ="/images/goods/event_C.png"
          End select 
 
        r_g_kind  = Ucase(Rs("g_kind"))
        r_s_area  = Rs("s_area")
 
        no_day =""
        tot_day = Rs("tot_day")
 
        d_day0 = Left(tot_day,1)
        d_day1 = Mid(tot_day,2,1)
        d_day2 = Mid(tot_day,3,1)
        d_day3 = Mid(tot_day,4,1)
        d_day4 = Mid(tot_day,5,1)
        d_day5 = Mid(tot_day,6,1)
        d_day6 = Mid(tot_day,7,1)
 
        
    
        if d_day0="N" then
            no_day =" ( day != 0 ) "
        end if
    
        if d_day1="N" then
            if no_day = "" then
                no_day = no_day &  " ( day != 1 ) "
            else
                no_day = no_day & "&&" & " ( day != 1 ) "
            end if
        end if
    
        if d_day2="N" then
            if no_day = "" then
                no_day = no_day &  " ( day != 2 ) "
            else
                no_day = no_day & "&&" & " ( day != 2 ) "
            end if
        end if
 
        if d_day3="N" then
            if no_day = "" then
                no_day = no_day &  " ( day != 3 ) "
            else
                no_day = no_day & "&&" & " ( day != 3 ) "
            end if
        end if
 
        if d_day4="N" then
            if no_day = "" then
                no_day = no_day &  " ( day != 4 ) "
            else
                no_day = no_day & "&&" & " ( day != 4 ) "
            end if
        end if
 
        if d_day5="N" then
            if no_day = "" then
                no_day = no_day &  " ( day != 5 ) "
            else
                no_day = no_day & "&&" & " ( day != 5 ) "
            end if
        end if
    
        if d_day6="N" then
            if no_day = "" then
                no_day = no_day &  " ( day != 6 ) "
            else
                no_day = no_day & "&&" & " ( day != 6 ) "
            end if
        end if
        
        if tot_day="YYYYYYY" then
          no_day ="1"
        End if
 
 
        t_use = Rs("t_use")
 
        remark1 = Rs("remark1")
        remark2 = Rs("remark2")
        remark3 = Rs("remark3")
        remark4 = Rs("remark4")
        
        min_price = Rs("min_price")
        if min_price="" or isnull(min_price) then
            min_price=0
        end if
 
    End if
 
    Rs.close : Set Rs=nothing
 
 
    img_sql = " select top 4 p_seq, g_seq, tp, file_img, p_remark from ex_good_photo where g_seq='"& num &"' and tp='T'"
    img_sql = img_sql& "	Order By disp_seq asc , p_seq asc 	"
    Set i_Rs = Server.CreateObject("ADODB.RecordSet") 
    i_Rs.open img_sql , objConn , 3
    
    img_cnt =1
    
    If i_Rs.eof then
        imgSmall = "<div class='swiper-slide'><img src='/images/goods/No_img_02.jpg' width=100% border=0></div>"
         img_big=""&GLOBAL_url&"/images/goods/No_img_02.jpg"
    Else
        ik = 1
        Do until i_Rs.EOF
    
            p_seq = i_Rs("p_seq")
            g_seq = i_Rs("g_seq")
            tp = i_Rs("tp")
            
            file_img  = i_Rs("file_img")
            if ik = 1 then
               f_file_img = file_img 
            End if
            
            p_remark  = i_Rs("p_remark")
    
            If p_seq <> "" then
                if img = 1 then
                    imgSmall="<div class='swiper-slide'><img src='/board/upload/tck/"&g_seq&"/"&file_img&"' width='100%' border='0' onError=this.src='/images/goods/No_img_02.png'></div>"
                     img_big=""&GLOBAL_url&"/board/upload/tck/"&g_seq&"/"&file_img&""
                else
                    imgSmall=imgSmall&"<div class='swiper-slide'><img src='/board/upload/tck/"&g_seq&"/"&file_img&"' width='100%' border='0' onError=this.src='/images/goods/No_img_02.png'></div>"
                    img_big=""&GLOBAL_url&"/board/upload/tck/"&g_seq&"/"&file_img&""
                end if
            End if
    
            i_Rs.MoveNext
            img_cnt = img_cnt + 1
            ik= ik+ 1
            
        Loop
    
    End if
    
    i_Rs.close : SET i_Rs=nothing
    
 
    min_price = price_up(min_price,e_rate)
    if min_price=0 then
       min_price="전화문의" 
       dmin_class=""
    else
       min_price =FormatNumber(min_price,0)
       dmin_class ="￦"
    End if
 
 
 
     '마감일채크
    d_sql = " SELECT idx, good_cd, day from trip_gtck_daychk R1 where good_cd="&Trim(num)&" order by day asc"
    Set Rs2 = Server.CreateObject("ADODB.RecordSet")
    Rs2.open d_sql,objConn,3
    mm =0
    IF Rs2.eof then
    Else
    	
        Do until Rs2.eof
 
            idx = Rs2("idx")
            good_cd = Rs2("good_cd")
            d_day   = Rs2("day")
            d_day   = Replace(d_day,"-","")
 
                if Len(d_day)=8 then
 
                    d_dayday_a = Left(d_day,4)
 
                    d_dayday_b = Mid(d_day,5,2)
                    if d_dayday_b > 9 then
                        d_dayday_b = d_dayday_b
                    else
                        d_dayday_b = Replace(Mid(d_day,5,2) ,0,"")
                    End if
 
                    d_dayday_c = Right(d_day,2)
                    if d_dayday_c > 9 then
                        d_dayday_c = d_dayday_c
                    else
                        d_dayday_c = Replace(d_dayday_c ,0,"")
                    End if
                    
                    d_dayday  =d_dayday_a&"-"&d_dayday_b&"-"&d_dayday_c
 
                End if
 
                if mm= 0 then
                    ALL_DAY = ""  &""""&d_dayday&""""
                Else
                    ALL_DAY = ALL_DAY &"," &""""&d_dayday&""""
                end if
 
           Rs2.MoveNext
           i = i +1
           mm = mm+1
 
       Loop
 
    End if
 
    Rs2.close : SET Rs2=nothing
    
     CloseF5_DB objConn 
%>


<%
    serverName = Request.ServerVariables("server_name")
    urlPath = Request.ServerVariables("path_info")
    urlQuery = Request.ServerVariables("query_string")
    If Len(urlQuery) > 0 THEN
        urlFull = "https://" & serverName & urlPath & "?" & urlQuery
    Else
        urlFull = "https://" & serverName & urlPath
    End If
%>
<meta property="og:image"	content="<%=imgBig%>" />
<meta property="og:title" content="<%=title%>" />
<meta property="og:type" content="<%=GLOBAL_SIN%>" />
<meta property="og:url"	content="<%=urlFull%>" />
<meta property="og:article:author:url"	content="<%=urlFull%>" />

<!DOCTYPE html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="shortcut icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">
<link rel="apple-touch-icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">

<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
<script type="text/javascript" language="javascript" src="/mobile/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/jquery.cookie-1.4.1.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/swiper.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/common.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/navigation.js"></script>

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<style type="text/css">
    .ui-datepicker {font-size:1.25em;font-weight:700;}
</style>
<script>
    $(function() {
      function enableSpecificDates(date) {
        var enabledDates = [
          new Date(2024, 10, 2),
          new Date(2024, 10, 3),
          new Date(2024, 10, 4),
          new Date(2024, 10, 5),
          new Date(2024, 10, 6),
          new Date(2024, 10, 7),
          new Date(2024, 10, 8)
        ];

        var dateString = jQuery.datepicker.formatDate('yy-mm-dd', date);
        for (var i = 0; i < enabledDates.length; i++) {
          if (dateString === jQuery.datepicker.formatDate('yy-mm-dd', enabledDates[i])) {
            return [true, "", "Available"];
          }
        }
        return [false, "", "Unavailable"];
      }

      var firstEnabledDate = new Date(2024, 10, 2); // The first enabled date

      $("#s_ymd").datepicker({
        beforeShowDay: enableSpecificDates,
        defaultDate: firstEnabledDate,
        dateFormat: 'yy-mm-dd'
      });
    });
  </script>
</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">
    	
        <!--#include virtual="/mobile/include/left_menu.asp"-->
        <!--#include virtual="/mobile/include/top_menu.asp"-->

        <form name="frm_view"  method="post" action="/mobile/reserve_tck/res_step.asp" style="display:inline; margin:0px;">
        <input type="hidden" name="g_kind" value="<%=g_kind%>"> 
        <input type="hidden" name="s_area" value="<%=s_area%>"> 
        <input type="hidden" name="good_num" id="good_num"  value="<%=num%>">
        <input type="hidden" name="tmp_day" id="tmp_day"  value="">
        <input type="hidden" name="tot_opt_seq"   id="tot_opt_seq"  value="">
        <input type="hidden" name="all_good_data" id="all_good_data"  value="<%=num%>|1|0|0">
        <input type="hidden" name="all_opt_data"  id="all_opt_data"  value="">

            <div id="mainVisual">
                <div class="swiper-container swiper1">
                    <div class="TopEvent"><img src="<%=event_nm%>" border="0" width="60"></div>
                    <div class="swiper-wrapper"><%=imgSmall%></div>
                </div>
            </div>

            <div class="container"> 
                
                <div class="product_title"><%=title%></div>
                <div class="mgt20"></div>
                <div style="border-bottom:1px solid #E0E0E0;"></div>
                <div class="day_list">
                    <table>
                        <colgroup>
                    		<col width="28%">
                    		<col width="*">
                        </colgroup>
                        <tbody>
                            <tr>
                                <td class="typ1">① 정원</td>
                                <td class="typ2"><%=emp_email%>명</td>
                            </tr>
                             <tr>
                                <td class="typ1">② 최소출발</td>
                                <td class="typ2"><%=emp_nm%>명</td>
                            </tr>  
                            <tr>
                                <td class="typ1">③ 여행도시</td>
                                <td class="typ2"><%=Z_ko%></td>
                            </tr>
                            <tr>
                                <td class="typ1">④ 투어시간</td>
                                <td class="typ2"><%=eng_title%></td>
                            </tr>
                            <tr>
                                <td class="typ1"> ⑤ 출발요일</td>
                                <td class="typ2"><%=good_tip%></td>
                            </tr>              		
                        </tbody>
                    </table> 
                </div>
                
                <!--
                <div align="right"> 
                    <span style="padding:0 8px 0 0 ;"><a href="javascript:myceo_kakaosend()" title="카카오톡"><i class="xi-kakaotalk" style="border:1px solid #888; padding:8px;border-radius:4px;"></i></a></span>
                    <span style="padding:0 8px 0 0 ;"><a href="javascript:;" class="fb" title="페이스북"><i class="xi-facebook" style="border:1px solid #888; padding:8px;border-radius:4px;"></i></a></span>
                    <span style="padding:0 8px 0 0 ;"><a href="javascript:;" class="tw" title="트위터"><i class="xi-twitter" style="border:1px solid #888; padding:8px;border-radius:4px;"></i></a></span>
                </div>
           
                <%
                    title = replace(title,"'","")
                    title = replace(title,"""","")
                %>
                
                <script type="text/javascript">
                    var title = "<%=title%>";
                    var linkUrl = "<%=urlFull%>";
                    var twCont = "<%'=emp_nm%>";
                
                    /*
                    * SNS 퍼가기 기능 > 페이스 북
                    */
                    jQuery(".fb").click(function(event) {
                        event.preventDefault();
                        var facebookURL = "https://www.facebook.com/sharer.php?u=" + encodeURIComponent(linkUrl) + "&t=" + encodeURIComponent(title);
                        window.open(facebookURL, "FACEBOOK");
                    });
                
                    /*
                    * SNS 퍼가기 기능 > 트위터
                    */
                    jQuery(".tw").click(function(event) {
                        event.preventDefault();
                        var twitterURL = "http://twitter.com/intent/tweet?text=" + encodeURIComponent('[' + title + '] ' + twCont + " " + linkUrl);
                        window.open(twitterURL, "TWITTER");
                    });

                    Kakao.init('<%=KAKAOKEY%>');
                    function myceo_kakaosend() {
                      Kakao.Link.sendDefault({
                        objectType: 'feed',
                        content: {
                          title: '<%=title%>',
                          description: '예약센터 : <%=GLOBAL_COM_TEL%>',
                          imageUrl: '<%=img_big%>',
                    
                          link: {
                            mobileWebUrl: '<%=urlFull%>',
                            webUrl: '<%=urlFull%>'
                          }
                        },
                        
                       
                      });
                    }
                </script>
                <div class="mgt15"></div>
                
                <div class="day_list" style="border:1px solid #EAEAEA;padding:15px 20px;">
                    <table border="0">
                        <tr>
                            <td style="font-size:0.75em;color:#333; ">
                                ※ 제공사에 따라 특별기간동안 추가요금이 발생 할 수 있습니다.<br>
                                ※ 상품예약시 예약이 접수되며, 여행이 확정된 것은 아닙니다.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;담당자와 상담 후 완납시 예약이 진행 됩니다.<br>
                                ※ 최소 모객인원 미달시 투어가 취소될 수 있습니다.<br>
                                ※ 보통 바우처 발행까지 2~3일이 소요 됩니다.
                            </td>
                        </tr>
                    </table>
                </div>
                
                <div class="mgt15"></div>
                -->

                <div style="background: #FFF; border:1px solid #EAEAEA; padding:10px 15px;border-radius:0px;">
                    <table border="0">
                        <tr>
                            <td style="font-size:0.81em;color:#666; ">
                                ※ 제공사 규정에 따라 특별기간동안 추가요금이 발생 할 수 있습니다.<br>
                                ※ 상품예약시 예약이 접수되며, 여행이 확정된 것은 아닙니다.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;담당자와 상담 후 예약이 진행 됩니다.<br>
                                ※ 보통 바우처 발행까지 2~3일이 소요 됩니다.
                            </td>
                        </tr>
                    </table>
                </div>
                
                <div class="mgt20"></div>
                
                <div style="background: #fdfaef; border:1px solid #ecd0a8; padding:15px 15px;border-radius:0px;">	
                    <div align="left">
                        <span style="font-size:0.81em;font-weight:500; padding:0 10px 0 0;"><i class="xi-user xi-x"></i> <%=GLOBAL_SIN%></span>
                        <span style="font-size:0.81em;font-weight:900; padding:0 10px 0 0;"><i class="xi-call xi-x"></i> <%=GLOBAL_COM_TEL%></span>
                        <span style="font-size:0.81em;"><i class="xi-mail xi-x"></i> <%=GLOBAL_MAIL%></span>
                    </div>
                </div>
                
                <div class="mgt30"></div>
                
                <% if remark1<>"" then %>
                    <div class="inf_line">
                        <div class="view_gubun">상품소개</div> 
                        <div class="view_txt"><%=remark1%></div>
                    </div>
                    <div class="pt20"></div>
                <% end if %>
                
                <% if remark2<>"" then %>
                    <div class="inf_line">
                    	 <% if g_kind ="10" then %>
                            <div class="view_gubun">여행스토리</div> 
                        <% end if %>
                        <div class="view_txt"><%=remark2%></div>
                    </div>
                    <div class="pt20"></div>
                <% end if %>
                
                <% if remark3<>"" then %>
                    <div class="inf_line">
                        <div class="view_gubun">준비물</div> 
                        <div class="view_txt"><%=remark3%></div>
                    </div>
                    <div class="pt20"></div>
                <% end if %>
                
                <% if remark4<>"" then %>
                    <div class="view_line">
                        <div class="view_gubun">유의사항</div>
                        <div class="view_txt"><%=remark4%></div>
                    </div>
                    <div class="pt20"></div>
                <% end if %>
                
                <div class="pt20"></div>

                <div style="border-top:5px solid #ff5000; border-bottom:1px solid #EAEAEA;border-left:1px solid #000; border-right:1px solid #000; padding:20px 20px;">
                    <script type="text/javascript">
                    <!--
                        $(document).ready(function(){
                            $("#box_s img").mouseover(function(){ 
                                $("#big_img").attr("src",$(this).attr("src")); 
                            });    
                        });
                    //-->
                    </script>    
                
                    <div class="view_title">날짜선택</div>
                    <div><input type="text" name="s_ymd" id="s_ymd" onclick="all_close();" class="datepicker" style="font-size:1.06em; width:100%;height:42px; padding: 0 10px; border-radius:0; border:1px solid #EAEAEA; background:url('/images/goods/ico_calander.png') no-repeat; background-position:95% center;cursor:pointer;" maxlength="10" readonly></div>
                
                    <div class="pt20"></div>
                
                    <div class="view_title">시간선택</div>	    
                    <select name="cal_step2" id="cal_step2" class="select_ticket" >
                        <option value="" >선택</option>
                        <%
                             sql = " SELECT seq, good_cd, nm_c , price,total_man from trip_gtck_opt s2 where del_yn='N' and s2.use_yn='Y' and s2.good_cd="&num&" and sub_tp='F' order by sunseo asc,seq asc"
                             'response.write sql
                             Set Rs = Server.CreateObject("ADODB.RecordSet")
                             Rs.open sql,objConn,3
                                            
                             If Rs.eof or Rs.bof then
                             Else
                                 ii=1
                                 Do until Rs.eof
                
                                     op_seq = Rs("seq")
                                     op_good_cd= Rs("good_cd")
                                     op_nm_c = Rs("nm_c")
                
                                     op_price1 = Rs("price")
                                     if op_price1="" or isnull(op_price1) then
                                         op_price1=0
                                     end if
                        %>
                        <option value="<%=op_seq%>||<%=op_price1%>||<%=op_nm_c%>"><%=op_nm_c%></option>
                        <%
                                Rs.movenext
                                Loop
                    
                            End if
                        %>
                    </select>
                    
                    <div class="pt10"></div>
                </div>
                
                <div style="border-bottom:1px solid #EAEAEA;border-left:1px solid #000; border-right:1px solid #000; padding:10px 20px; background: #FBFBFB;">
                    <div id="sel_opt_price"></div>
                </div>
                
                <div style="border-bottom:1px solid #EAEAEA;border-left:1px solid #000; border-right:1px solid #000; padding:20px 20px;">  
                    <table style="width:100%;" >
                        <colgroup>
                            <col width="20%" />
                            <col width="*%" />
                        </colgroup>
                        <tbody>
                             <tr>
                                <td>
                                    <div class="re_call">
                                        <table>
                                            <tr>                    
                                               <td><a href="tel:<%=GLOBAL_COM_TEL%>"><li class="subject"><i class="xi-call xi-x"></i></li></a></td>
                                            </tr>
                                        </table>
                                    </div>  
                                </td>
                                <td>
                                    <div class="re_book">
                                        <table>
                                            <tr>                    
                                                <td><a onclick="res_tck()"><li class="subject">예약하기</li></a></td>
                                            </tr>
                                        </table>
                                    </div>      
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="sche_list" style=";border-bottom:1px solid #000;border-left:1px solid #000;border-right:1px solid #000;background-color:#FBFBFB;padding:20px 20px;">
                    <table border="0">
                        <colgroup>
                            <col width="40px">
                            <col width="10px">
                            <col width="*">
                        </colgroup>
                        <tbody>
                            <tr>
                                <td><i class="xi-user xi-2x"></i></td>
                                <td></td>
                                <td class="title">고객센터</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>
                                    <div class="call"><%=GLOBAL_COM_TEL%></div>
                                    <div class="samll"><%=GLOBAL_FAX%><br><%=GLOBAL_MAIL%></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <div style="padding:20px 0 0 0;"></div>
                    <div style="border-bottom:1px solid #E7E8E9;"></div>
                    <div style="padding:20px 0 0 0;"></div>
                    
                    <table border="0">
                        <colgroup>
                            <col width="40px">
                            <col width="10px">
                            <col width="*">
                        </colgroup>
                        <tbody>
                            <tr>
                                <td><i class="xi-alarm-clock xi-2x"></i></td>
                                <td></td>
                                <td class="title">업무시간</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td class="samll">평일 : 09:00 ~ 18:00<br>토,일요일 및 공휴일 휴무</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="board_btn_w">
                    <ul class="btn_r">
                        <li><a href="/mobile/good_tck/ticket_list.asp?g_kind=<%=g_kind%>">목록</a></li>		
                    </ul>
                </div>
            </div>
            
        </form>

    </div>
    
    <!--#include virtual="/mobile/include/foot_ci.asp"-->

</body>
</html>

<script language="JavaScript">
<!--
    $(function(){
        var img = $(".view_txt img");
        img.each(function() {
     
            $(this).css("width","100%");
            $(this).css("height","auto");
        });
    });
//-->
</script>

<%
    If  memid <> ""  then
        m_sql = " SELECT   point  FROM TB_member where memid= '"&memid&"' "
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open m_sql , objConn , 3
        if Rs.eof then 
        else
            point = Rs("point")
        end if
        Rs.close : Set Rs=nothing
    End if
    
    
    sql2 = "select sum(use_money) from TB_save_money where tot_htel = '"&cu_htel&"' and  can_yn='N'"
    Set Rs2 = Server.CreateObject("ADODB.RecordSet")
    Rs2.open sql2,objConn,3
    If Rs2.eof or Rs2.bof then
    Else
        pay_point = Rs2(0)
        if isNull(pay_point) then pay_point = 0 end if
    End if
    		
    CloseRs Rs2 
        
    total_point = int(point) - int(pay_point)
%>
 
<%
    If  memid <> ""  then
        m_sql = " SELECT   point  FROM TB_member where memid= '"&memid&"' "
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open m_sql , objConn , 3
        if Rs.eof then 
        else
            point = Rs("point")
        end if
        Rs.close : Set Rs=nothing
    End if
    
    
    sql2 = "select sum(use_money) from TB_save_money where tot_htel = '"&cu_htel&"' and  can_yn='N'"
    Set Rs2 = Server.CreateObject("ADODB.RecordSet")
    Rs2.open sql2,objConn,3
    If Rs2.eof or Rs2.bof then
    Else
        pay_point = Rs2(0)
        if isNull(pay_point) then pay_point = 0 end if
    End if
    		
    CloseRs Rs2 
        
    total_point = int(point) - int(pay_point)
%>
 
<script type="text/javascript">
<!--
    $(document).ready(function() {

        $("#cal_step2").on('change', function() {

        var s_ymd = $("#s_ymd").val();
        if (s_ymd.length !=10){
            alert("정확한 날짜를 선택해 주시기 바랍니다.");
            $('#cal_step2').find('option:first').attr('selected', 'selected');

        }else{
            // document.getElementById("all_good_data").value="";
            document.getElementById("all_opt_data").value="";
            
            var sel_txt = $("#cal_step2").val();
            var s_value   = sel_txt.split('||');
           
            var data_txt1 = s_value[0];
            var data_txt2 = s_value[1];
            var data_txt3 = s_value[2];
           

            $.ajax({
                type: "POST",
                url: "ticket_price.asp",
                data: "good_num=<%=num%>&s_ymd="+s_ymd+"&room_seq="+data_txt1,
                success: function(data) {

                    var res_data = data.split('|');
                    
                    var ad_price =   fn_comma(res_data[0]);
                    var ch_price = res_data[1];
                    var add_size = document.getElementsByName("qty_ad").length;
                    
                    html =  "<div id='"+ s_ymd + '_'+add_size+ "'>"
                    html += "    <div style='padding:10px 0px;'>"
                    html += "        <table border='0' cellspacing='0' cellpadding='0'>"
                    html += "            <tr>"
                    html += "                <td width='120px;'><span style='font-size:1.06em; font-weight:700;'>① "+ s_ymd + "</span></td>"
                    html += "                <td width='*;'><span onclick=\"all_close();\" style='cursor:pointer;'><i class='xi-close-square xi-x'></i></span></td>"
                    html += "            </tr>"
                    html += "        </table>"
                    html += "        <div style='padding:0 0 5px 0;'></div>"
                    html += "        <div style='padding:5px 0;'><span style='font-size:1.06em; font-weight:700;'>② "+ data_txt3 + "</span></div>"
                    html += "        <div style='padding:5px 0;'><span style='font-size:1.06em; font-weight:700;'>③ <span style='color:#ff5000;'>"+ ch_price +"명</span></span>, 예약가능</div>"
                    html += "        <div style='padding:5px 0;'><span style='font-size:1.06em; font-weight:700;'>④ 보유 포인트 : <span style='color:#ff5000;'><%=FormatNumber(total_point,0)%> CP</span></span></div>"
                    html += "        <div style='padding:0 0 5px 0;'></div>"
                    html += "        <table border='0' cellspacing='0' cellpadding='0'>" 
                    html += "            <tr>"
                    html += "                <td width='50px;'><strong>⑤ 성인</strong></td>"
                    html += "                <td width='30px;'><input name='qty_ad' value='1' style='width:20px;border:1px solid #FBFBFB; background:#FBFBFB;font-size:1.06em; color:#FF5000;font-weight:700; ' readonly/></td>"
                    html += "                <td width='*;' ><span style='font-size:1.06em; font-weight:700;'>" + ad_price  + " CP</span><input type='hidden' name='ad_price' value='"+ ad_price + "'></td> "
                    html += "            </tr>"
                    html += "        </table>"
                    html += "    </div>"
                    html += "    <div id='"+ s_ymd + "_opt"+"'></div>"
                    html += "</div>"
                    document.getElementById("tot_opt_seq").value=data_txt1;
                    $("#sel_opt_price").empty();
                    $("#sel_opt_price").append(html);
                    //$("#s_ymd").val('');
                   // $('#cal_step2').find('option:first').attr('selected', 'selected');
                    document.getElementById("tmp_day").value=s_ymd;
                    }
                });
            }
        });

    });
//-->
</script>

<script language="JavaScript">
<!--
    function add_ad(s) {
        var add_size = document.getElementsByName("qty_ad").length;
     
        for(var i=0;i < parseInt(add_size) ;i++){
            var curr_ad_cnt = document.getElementsByName("qty_ad")[i].value;
   	  	 
            if (curr_ad_cnt >=0) {
                var new_curr_ad_cnt = parseInt(curr_ad_cnt)+ 1;
                document.getElementsByName("qty_ad")[i].value=new_curr_ad_cnt;
            }
        }
        good_amt();
    }

    function del_ad(s) {
        var add_size = document.getElementsByName("qty_ad").length;

        for(var i=0;i < parseInt(add_size) ;i++){
            var curr_ad_cnt = document.getElementsByName("qty_ad")[i].value;
   	  	   	  	 
            if (curr_ad_cnt >0) {
                var new_curr_ad_cnt = parseInt(curr_ad_cnt)- 1;
                document.getElementsByName("qty_ad")[i].value=new_curr_ad_cnt;
            }
        }
        good_amt();
    }

    function stringNumberToInt(stringNumber){
        return parseInt(stringNumber.replace(/,/g , '')); 
    }
    
    function good_amt(){
        var ad_cnt   = 1;
        var ad_price = document.getElementsByName("ad_price")[0].value;
        var ad_price =stringNumberToInt(ad_price);
        
        var good_amt=0;
        good_amt = parseInt(ad_cnt) *parseInt(ad_price) ;
        
        var price_amt =parseInt(good_amt) ;
        
        var price_amt2 =fn_comma(price_amt);
        var insTag = "<div>￦"+price_amt2+"</div>" ;
        
        $("#good_amt").html(insTag);
        
        var good_data="";
        var good_id    = document.getElementById("good_num").value; 
        var qty_ad_val = document.getElementsByName("qty_ad")[0].value
        good_data = good_id+"|"+qty_ad_val;
        
        var data_seq = [];
        var add_opt_size = document.getElementsByName("qty_opt").length;
        var tot_opt_amt =0;

        for(var i=0;i < parseInt(add_opt_size) ;i++){
            var opt_seq = document.getElementsByName("qty_opt_seq")[i].value;
            var opt_cnt = document.getElementsByName("qty_opt")[i].value;
            var opt_price = document.getElementsByName("qty_opt_price")[i].value;
     
            all_opt_data = opt_seq+"|"+opt_cnt;
            data_seq.push(all_opt_data);

            var opt_amt=0;
            opt_amt = parseInt(opt_cnt) *parseInt(opt_price) ;
     
            tot_opt_amt = parseInt(tot_opt_amt) + parseInt(opt_amt) ;
        }

        document.getElementById("all_good_data").value=good_data;
        document.getElementById("all_opt_data").value=data_seq;

        var total_price_amt =0;
        var total_price_amt = parseInt(good_amt) + parseInt(tot_opt_amt) ;
  
        var total_price_amt2 =fn_comma(total_price_amt);

        var tot_amtTag = "<div>￦"+total_price_amt2+"</div>" ;
        $(".sum_amt").html(tot_amtTag);
    }


    function add_opt(s) {
        var curr_cnt = document.getElementById("qty_opt_"+s).value;
    
        if (curr_cnt >=0) {
            var new_curr_cnt = parseInt(curr_cnt)+ 1;
            document.getElementById("qty_opt_"+s).value=new_curr_cnt;
        }
     
        var opt_cnt =  document.getElementById("qty_opt_"+s).value;
        var opt_price = document.getElementById("qty_opt_price_"+s).value;
         
        var opt_amt=0;
        opt_amt = parseInt(opt_cnt) *parseInt(opt_price) ;

        var price_amt =parseInt(opt_amt) ;
        var price_amt2 =fn_comma(price_amt);
        var insTag = "<div  >￦"+price_amt2+"</div>" ;
        $("#opt_amt_"+s).html(insTag);
    
        good_amt();
    }


    function del_opt(s) {
        var curr_cnt = document.getElementById("qty_opt_"+s).value;
    
        if (curr_cnt >=1) {
            var new_curr_cnt = parseInt(curr_cnt)- 1;
            document.getElementById("qty_opt_"+s).value=new_curr_cnt;
        }
     
        var opt_cnt =  document.getElementById("qty_opt_"+s).value;
        var opt_price = document.getElementById("qty_opt_price_"+s).value;
         
        var opt_amt=0;
        opt_amt = parseInt(opt_cnt) *parseInt(opt_price) ;

        var price_amt =parseInt(opt_amt) ;
        var price_amt2 =fn_comma(price_amt);
        var insTag = "<div  >￦"+price_amt2+"</div>" ;
        $("#opt_amt_"+s).html(insTag);

        good_amt();
    }
 
    function all_close() {
        $("#sel_opt_price").empty();
        $('#cal_step2').find('option:first').prop('selected', true);
     
        //document.getElementById("all_good_data").value="";
        document.getElementById("all_opt_data").value="";
        var insTag = "<div style='font-weight:500; text-align:right;color: #FF0000;'>￦0</div>" ;

        $(".sum_amt").html(insTag);
  
       // document.getElementById("all_good_data").value="";
        document.getElementById("all_opt_data").value="";

        good_amt();
        alert("필수선택 삭제 완료");
    }

    function fn_comma(num){
        var len, point, str;

        num = num + "";
        point = num.length % 3 ;
        len = num.length;
        str = num.substring(0, point);

        while (point < len) {
            if (str != "") str += ",";
            str += num.substring(point, point + 3);
            point += 3;
        }
        return str;
    }

    function res_tck(){
       
        if (document.getElementById("cal_step2").value == ""){
                alert("시간을 선택해 주시기 바랍니다.");
                return false;
            }
        if (document.getElementById("tot_opt_seq").value == ""){
            alert("날짜/시간 선택해 주시기 바랍니다.");
            return false;
        }
        document.frm_view.submit();
    }
//-->
</script>


<script type="text/javascript">
    var myVisual = new Swiper('.swiper1', {
        pagination: '.swiper-pagination1',
        paginationClickable: true,
        spaceBetween: 0,
        loop:true,
        grabCursor: true,
        autoplay: 6000,
        autoplayDisableOnInteraction: false,
    
    });
    
    function activeTab (e) {
        var num = e;
    	var activespan = $("#flktab li, #flktab li a");
    	var tabCount = $("#flktab li").length;

    	if (num==0) num = tabCount;
    	else num = e;
    
        activespan.removeClass("active");
    
        if(num) {
    		$("#flktab li:nth-child("+num+") a, #flktab li:nth-child("+num+")").addClass("active");
    }
    
    var mainBoard = $("#mainBoard");
    var swiper2 = $(".swiper2");
        mainBoard.height( $(".tabbox"+num).height() );
        swiper2.animate({
        height: $(".tabbox"+num).height()+16
        }, 200, function() {
    });
    }
</script>

<% CloseF5_DB objConn  %>