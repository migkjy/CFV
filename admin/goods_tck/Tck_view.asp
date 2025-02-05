<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    OpenF5_DB objConn
    
    tbl = "trip_gtck"
    
    g_kind    = Request("g_kind")
    Select Case Ucase(g_kind)
        Case "10" : g_kind_nm = "프로그램 상품관리" : g_txt_1 = "투어시간" : g_txt_2 = "최소출발"
        Case "20" : g_kind_nm = "할인티켓 상품관리" : g_txt_1 = "이용시간" : g_txt_2 = "상품 TIP"
    End select


    num = Request("num")

    gotopage  = Request("gotopage")
    s_cont = Request("s_cont")
    cont = Request("cont")
 
   
    If num <> "" then

        sql = " Select num,  event_tp,  g_kind , s_area,  title , eng_title , good_tip , tot_day, exchange , remark1 , remark2 , remark3 , remark4, emp_nm ,  emp_email ,ins_dt  "
        sql = sql & " ,(SELECT title FROM trip_gtck_city c WHERE c.idx = a.s_area  )  AS sub_area_nm "
        sql = sql & "  from "&tbl&" a where num="&num
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql,objConn ,3

        if Rs.eof or Rs.bof then
            Response.write "<script language='javascript'>"
            Response.write " alert('주요인자전송에러!!...'); "
            Response.write " history.back();"
            Response.write " </script>	 "
            Response.end
        else
            r_g_kind  = Rs("g_kind")
            if g_kind="" then
                g_kind= r_g_kind
            end if

            title = Rs("title")
   	  
            event_tp  = Rs("event_tp")
            Select Case Ucase(event_tp)
                Case "A" : event_nm ="NO"  
                Case "B" : event_nm ="추천"
                Case "C" : event_nm ="특가"
            End select 

            good_tip  = Rs("good_tip") 
            s_area = Rs("s_area")

            sub_area_nm  = Rs("sub_area_nm")

            tot_day = Rs("tot_day")
            d_day0 = Left(tot_day,1)
            d_day1 = Mid(tot_day,2,1)
            d_day2 = Mid(tot_day,3,1)
            d_day3 = Mid(tot_day,4,1)
            d_day4 = Mid(tot_day,5,1)
            d_day5 = Mid(tot_day,6,1)
            d_day6 = Mid(tot_day,7,1)

            exchange  = Rs("exchange")
            Select Case Ucase(exchange)
                Case "10" : exchange_nm = "KRW" : site_symbol = "CP"                               
                Case "20" : exchange_nm = "AUD" : site_symbol = "$"
                Case "30" : exchange_nm = "NZD" : site_symbol = "$"
            End select

            remark1 = Rs("remark1")
            remark2 = Rs("remark2")
            remark3 = Rs("remark3")
            remark4 = Rs("remark4")


            eng_title = Rs("eng_title")
            emp_nm = Rs("emp_nm")
            emp_email = Rs("emp_email")
        end if
   
        Rs.close :      Set Rs=nothing

   End if
%>

<!DOCTYPE html>
<html>
<head>
<title><%=g_kind_nm%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=g_kind_nm%></div>
    
        <div class="table_dan">
            <table width="100%">
                <tr>
                    <td class="lop1">프로그램명</td>
                    <td class="lop2" colspan="3"><%=title%></td>
                </tr>
                <tr>
                    <td width="12%" class="lob1">카테고리</td>
                    <td width="38%" class="lob2"><%=sub_area_nm%></td>
                    <td width="12%" class="lob3">이벤트 타입</td>
                    <td width="*%" class="lob2"><%=event_nm%></td>
                </tr>
                <tr>
                    <td class="lob1">출발요일</td>
                    <td class="lob2">
                        <span class="checks"><input type="checkbox" name="day_0" id="day_0" value="0" <% if d_day0="Y" then response.write "checked" end if %> disabled ><label for="day_0">일</label></span>
                        <span class="prl10"></span>
                        <span class="checks"><input type="checkbox" name="day_1" id="day_1" value="1" <% if d_day1="Y" then response.write "checked" end if %> disabled ><label for="day_1">월</label></span>
                        <span class="prl10"></span>
                        <span class="checks"><input type="checkbox" name="day_2" id="day_2" value="2" <% if d_day2="Y" then response.write "checked" end if %> disabled ><label for="day_2">화</label></span>
                        <span class="prl10"></span>
                        <span class="checks"><input type="checkbox" name="day_3" id="day_3" value="3" <% if d_day3="Y" then response.write "checked" end if %> disabled ><label for="day_3">수</label></span>
                        <span class="prl10"></span>
                        <span class="checks"><input type="checkbox" name="day_4" id="day_4" value="4" <% if d_day4="Y" then response.write "checked" end if %> disabled ><label for="day_4">목</label></span>
                        <span class="prl10"></span>
                        <span class="checks"><input type="checkbox" name="day_5" id="day_5" value="5" <% if d_day5="Y" then response.write "checked" end if %> disabled ><label for="day_5">금</label></span>
                        <span class="prl10"></span>
                        <span class="checks"><input type="checkbox" name="day_6" id="day_6" value="6" <% if d_day6="Y" then response.write "checked" end if %> disabled ><label for="day_6">토</label></span>
                    </td>
                    <td class="lob3">통화</td>
                    <td class="lob2"><%=site_symbol%></td>
                </tr>
                <tr>
                    <td class="lob1">정원</td>
                    <td class="lob2"><%=emp_email%>명</td>
                    <td class="lob3"><%=g_txt_2%></td>
                    <td class="lob2"><%=emp_nm%>명</td>
                </tr>
                <tr>
                    <td class="lob1">출발요일</td>
                    <td class="lob2"><%=good_tip%></td>
                    <td class="lob3"><%=g_txt_1%></td>
                    <td class="lob2"><%=eng_title%></td>
                </tr>
            </table>
        </div> 

        <div class="pt15"></div> 
        
        <div class="table_dan">
            <table width="100%" style="border-top:1px solid #C0C0C0;">
                <tr>
                    <td width="12%" class="loc1">선택사항</td>
                    <td width="*%" class="loc2">
                        <table width="100%">
                            <tr>
                                <td width="7%" class="line_a">No.</td>
                                <td width="*" class="line_a">투어시간</td>
                                <td width="10%" class="line_a">전체 인원</td>
                                <td width="10%" class="line_a">상품금액</td>
                            </tr>
                            <%
                                If num <> "" then
                                    sql = " SELECT seq, good_cd, nm_c , price,  total_man from trip_gtck_opt s2 where  del_yn='N' and s2.good_cd="&num&"  and sub_tp='F' and use_yn='Y' order by sunseo asc ,seq asc "
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open sql,objConn,3
                                
                                    If Rs.eof or Rs.bof then
                                    else
                                        ii=1
                                        Do until Rs.eof
                                           s_seq    = Rs("seq")
                                           s_good_cd= Rs("good_cd")
                                           s_nm_c   = Rs("nm_c")
                                
                                           s_price  = Rs("price")
                                           if s_price="" or isnull(s_price) then
                                           	s_price=0
                                           End if
                                           
                                           s_total_man  = Rs("total_man")
                                            if s_total_man="" or isnull(s_total_man) then
                                           	s_total_man=0
                                           End if
                                           
                                    
                            %>
                            <tr id="price_<%=ii%>">
                                <td class="line_e"><%=ii%></td>
                                <td class="line_c"><%=s_nm_c%></td>
                                <td class="line_e"><%=FormatNumber(s_total_man,0)%>명</td>
                                <td class="line_e"><%=FormatNumber(s_price,0)%>&nbsp;<%=site_symbol%></td>
                                
                            </tr>
                            <%
                                            Rs.movenext
                                            ii = ii+1
                                         Loop
                                
                                     End if
                                     Rs.close : Set Rs = nothing
                                End if
                            %>
                        </table>
                    </td>
                </tr>
            
              
            </table>
        </div>
        
        <div class="pt25"></div> 
        
        <div align="center">
            <span class="button_b" style="padding:0px 4px;"><a onClick="location.href='tck_ins.asp?num=<%=num%>&g_kind=<%=g_kind%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>'">수정</a></span>
            <span class="button_b" style="padding:0px 4px;"><a onClick="location.href='tck_list.asp?g_kind=<%=g_kind%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>'">목록</a></span>
        </div> 
        
        <div class="pt25"></div> 
        
        <div class="table_dan">
            <table width="100%">
                <tr>
                    <td width="12%" class="lop1">상품소개</td>
                    <td width="*%" class="lop3"><%=remark1%></td>
                </tr>
                <tr>
                    <td class="lob1">여행스토리</td>
                    <td class="lob4"><%=remark2%></td>
                </tr>
                <tr>
                    <td class="lob1">준비물</td>
                    <td class="lob4"><%=remark3%></td>
                </tr>
                <tr>
                    <td class="lob1">유의사항</td>
                    <td class="lob4"><%=remark4%></td>
                 </tr>
            </table>
        </div>
        
        <div class="pt25"></div> 
        
        <div align="center">
            <span class="button_b" style="padding:0px 4px;"><a onClick="location.href='tck_ins.asp?num=<%=num%>&g_kind=<%=g_kind%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>'">수정</a></span>
            <span class="button_b" style="padding:0px 4px;"><a onClick="location.href='tck_list.asp?g_kind=<%=g_kind%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>'">목록</a></span>
        </div>
        
    </div>
  
</body>
</html>

<script language="javascript" type="text/javascript">
    $(function(){
        var img = $(".lob4 img");
        img.each(function() {
            $(this).css("width","824px");
        });
    });

    $(function(){
        var ifm = $(".lob4 iframe");
        ifm.each(function() {
            $(this).css("width","824px");
            $(this).css("height","540px");
        });
    });
</script> 