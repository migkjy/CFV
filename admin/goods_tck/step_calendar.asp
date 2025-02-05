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

    tbl ="w_tck_day"

    mkk    ="&nbsp;"
    
    good_cd = request("good_cd")
    opt_seq = request("opt_seq")

    s_year   = Request("ss_yy")
    s_month  = Request("ss_mm")
    s_month  = right("0"&s_month,2)

    Select case s_month
        case "01","02" : ss_mm ="01"
        case "03","04" : ss_mm ="03"
        case "05","06" : ss_mm ="05"
        case "07","08" : ss_mm ="07"
        case "09","10" : ss_mm ="09"
        case "11","12" : ss_mm ="11"
    End select

    
  '  start_day_sec = s_year&"-"&ss_mm&"-"&"01"
  
    start_day_sec = "2024-11-01"

    next_year  = DATEADD("m",1,start_day_sec) 
    n_year  = left(next_year,4)
    n_month = mid(next_year,6,2)

    next_year2  = DATEADD("m",2,start_day_sec) 
    n_year2  = left(next_year2,4)
    n_month2 = mid(next_year2,6,2)

    n0_weekday = weekday(start_day_sec)
    n1_weekday = weekday(next_year)
    n2_weekday = weekday(next_year2)
 
    no_maxday = m_ed_num(ss_mm,s_year)
    n1_maxday = m_ed_num(n_month,n_year)
    n2_maxday = m_ed_num(n_month2,n_year2)
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>

<body >

    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
        <tr>
            <td>
                <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="bin_pa" width="130" align="center"><font color="#CC0033">오늘 : <strong><%=Date()%></strong></font></td>
                        <td class="bin_pa" width="130" align="center">
                            <select name="s_year" id="s_year" style="width:100%;" class="select_basic"  onchange="fn_loc('<%=good_cd%>',this.value,document.getElementById('s_month').value)">
                                <option value="2024" <% if s_year="2024" then response.write "selected" end if %>>2024년</option>
                                <option value="2025" <% if s_year="2025" then response.write "selected" end if %>>2025년</option>
                                <option value="2026" <% if s_year="2026" then response.write "selected" end if %>>2026년</option>
                                <option value="2027" <% if s_year="2027" then response.write "selected" end if %>>2027년</option>
                                <option value="2028" <% if s_year="2028" then response.write "selected" end if %>>2028년</option>
                                <option value="2029" <% if s_year="2029" then response.write "selected" end if %>>2029년</option>
                                <option value="2030" <% if s_year="2030" then response.write "selected" end if %>>2030년</option>
                                <option value="2031" <% if s_year="2031" then response.write "selected" end if %>>2031년</option>
                                <option value="2032" <% if s_year="2032" then response.write "selected" end if %>>2032년</option>
                                <option value="2033" <% if s_year="2033" then response.write "selected" end if %>>2033년</option>
                                <option value="2034" <% if s_year="2034" then response.write "selected" end if %>>2034년</option>
                            </select>  
                        </td>
                        <td class="bin_pa" width="100" align="center">
                            <select name="s_month" id="s_month" style="width:100%;" class="select_basic" onchange="fn_loc('<%=good_cd%>',document.getElementById('s_year').value,this.value)">
                                <option value="01" <% if ss_mm="01" then response.write "selected" end if %>>1월</option>
                                <option value="03" <% if ss_mm="03" then response.write "selected" end if %>>3월</option>
                                <option value="05" <% if ss_mm="05" then response.write "selected" end if %>>5월</option>
                                <option value="07" <% if ss_mm="07" then response.write "selected" end if %>>7월</option>
                                <option value="09" <% if ss_mm="09" then response.write "selected" end if %>>9월</option>
                                <option value="11" <% if ss_mm="11" then response.write "selected" end if %>>11월 </option>
                            </select>
                        </td>
                        <td class="bin_pa" width="420">
                            <span class="checks" style="padding:0 20px 0 10px;font-weight:500;"><input type="checkbox" name="f_nm" id="checksun"><label for="checksun">일</label></span>
                            <span class="checks" style="padding:0 20px 0 0;font-weight:500;"><input type="checkbox" name="f_nm" id="checkmon"><label for="checkmon">월</label></span>
                            <span class="checks" style="padding:0 20px 0 0;font-weight:500;"><input type="checkbox" name="f_nm" id="checktue"><label for="checktue">화</label></span>
                            <span class="checks" style="padding:0 20px 0 0;font-weight:500;"><input type="checkbox" name="f_nm" id="checkwed"><label for="checkwed">수</label></span>
                            <span class="checks" style="padding:0 20px 0 0;font-weight:500;"><input type="checkbox" name="f_nm" id="checkthu"><label for="checkthu">목</label></span>
                            <span class="checks" style="padding:0 20px 0 0;font-weight:500;"><input type="checkbox" name="f_nm" id="checkfri"><label for="checkfri">금</label></span>
                            <span class="checks" style="padding:0 0 0 0;font-weight:500;"><input type="checkbox" name="f_nm" id="checksat"><label for="checksat">토</label></span>
                        </td>
                        <td class="bin_pa" width="130" align="center"><span class="checks" style="font-weight:500;"><input type="checkbox" name="f_nm" id="checkAll"><label for="checkAll">출발일 전체선택</label></span></td>
                        <td class="bin_pa" width="*"><span class="button_a" style="padding:0px 4px;"><a onClick="fn_day_cost('<%=r_seq%>');">일자별 금액수정</a></span></td>
                    </tr>
                </table> 
            </td>
        </tr>
    </table>

    <div class="pb15"></div>

    <table width="100%"  border="0" cellpadding="0" cellspacing="0">
    	    <tr>
    	        <td width="50%" valign="top">
                <div class="calender_moon"><%=s_year%>년 <%=ss_mm%>월</div>
                
                <div class="table_calender">
                    <table class="line1">
                        <tr height="36">
                            <td width="16%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checksun_1"><label for="checksun_1" style="color:#FF0000;">일</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checkmon_1"><label for="checkmon_1">월</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checktue_1"><label for="checktue_1">화</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checkwed_1"><label for="checkwed_1">수</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checkthu_1"><label for="checkthu_1">목</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checkfri_1"><label for="checkfri_1">금</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checksat_1"><label for="checksat_1" style="color:#0000FF;">토</label></span></td>
                        </tr>
                        <% 
                            jj = 1
                            n_n =0
                        
                            For ii= 1 to no_maxday
                            
                                If jj mod 7 =1 then
                                    response.write "<tr height='80'>"
                                    n_n = n_n + 1
                                End if
                        
                                If ii=1 then
                                    For kk = 1 to n0_weekday-1 
                                        response.write "<td height='80' valign='top' class='line3'>"&mkk
                                        if kk=1 then
                                           response.write "<span class='checks'><input type='checkbox' name='checkedcard22' id='s1_vertical_"&n_n&"'><label for='s1_vertical_"&n_n&"'></label></span>"
                                        end if
                                        response.write "</td>" 
                                        jj= jj +1
                                    Next
                                End if
                        
                                IF ii < 10 then
                                    new_j="0"&ii
                                Else
                                    new_j=ii
                                End if
                        
                                n0_date   = s_year&"-"&ss_mm&"-"&new_j
                                n0_date22 = s_year&ss_mm&new_j
                                n_weekDate= weekDay(n0_date)
                        %>
                            <td height="80" valign="top" class="line3">
                                <% if jj mod 7 =1 then %>
                                <span class="checks"><input type="checkbox" name="checkedcard22" id="s1_vertical_<%=n_n%>"><label for="s1_vertical_<%=n_n%>"></label></span>
                                <% end if %>
                                <span class="checks" style="font-weight:500;"><input type="checkbox" name="checkedcard" value="<%=n0_date%>" id="s1_vertical_<%=n_n%>_<%=ii%>" class="checkbox1_<%=n_weekDate%>"><label for="s1_vertical_<%=n_n%>_<%=ii%>"><%=ii%>일</label></span>
                            
                                <%
                                    html_nm_c =""
                            
                                    s_sql = " SELECT  seq, room_seq,  price_1, total_man , day, magam from w_tck_day r "
                                    s_sql =s_sql &" where good_cd='"&good_cd&"' and day = '"&n0_date22&"' order by room_seq asc"
                                    'response.write s_sql&"<br>"
                            
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open s_sql,objConn,3
                            
                                    If Rs.eof or Rs.bof then
                                    Else
                                        
                                        i=0
                                        do until Rs.eof 
                                        
                                            r_seq = Rs("room_seq")
                            
                                            r_price_1  = Rs("price_1")
                                            r_price_1  =  Replace(r_price_1 , ",","")
                                            if r_price_1="" or isnull(r_price_1) then
                                                r_price_1=0
                                            end if
                               
                                            r_total_man  = Rs("total_man")
                                            r_total_man  =  Replace(r_total_man , ",","")
                                            if r_total_man="" or isnull(r_total_man) then
                                                r_total_man=0
                                            end if
                          
                            
                                            r_day   = Rs("day")
                                            r_magam = Rs("magam")
                                            
                                            if Ucase(r_magam) ="Y" then
                                                html_nm_c =html_nm_c &"<div class='line4'><span class='line6'>"&r_seq&"</span><span style='padding:0 0 0 8px; color:#888;'>마감</span></div>"
                                            else
                                               
                                                html_nm_c =html_nm_c &"<div class='line4'><span class='line5'>"&r_seq&"</span><span style='padding:0 0 0 8px;'>"&formatNumber(r_price_1,0)&"</span>&nbsp;&nbsp;<span style='color:#0000FF'>("&r_total_man&")</span></div>"
                                            end if
                            
                                            rs.movenext
                                            i=i+1
                            
                                        loop
                            
                                    End if
                            
                                    Rs.close : Set Rs=nothing
                                %>
                                <div style="padding:6px 0 0 0;"><%=html_nm_c%></div>
                            </td>
                        <% 
                                If jj mod 7 =0 then
                                    response.write "</tr>"
                                End if
                        
                                jj= jj +1
                            Next             
                        %>
                        </tr>
                    </table>
                </div>
            </td>
            <td width="1%"></td>
    	        <td width="*%" valign="top">
                <div class="calender_moon"><%=n_year%>년 <%=n_month%>월</div>
                
                <div class="table_calender">
                    <table class="line1">
                        <tr height="36">
                            <td width="16%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checksun_2"><label for="checksun_2" style="color:#FF0000;">일</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checkmon_2"><label for="checkmon_2">월</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checktue_2"><label for="checktue_2">화</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checkwed_2"><label for="checkwed_2">수</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checkthu_2"><label for="checkthu_2">목</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checkfri_2"><label for="checkfri_2">금</label></span></td>
                            <td width="14%" class="line2"><span class="checks"><input type="checkbox" name="f_nm" id="checksat_2"><label for="checksat_2" style="color:#0000FF;">토</label></span></td>
                        </tr>
                        <%
                            n1_day =n_year&n_month
                        
                            jj = 1
                            n_n =0
                        
                            For ii= 1 to n1_maxday
                            
                                If jj mod 7 =1 then
                                    response.write "<tr height='80'>"
                                    n_n = n_n + 1
                                End if
                        
                                If ii=1 then
                                    For kk = 1 to n1_weekday-1
                                        response.write "<td height='80' valign='top' class='line3'>"&mkk
                                        
                                        If kk=1 then
                                            response.write "<span class='checks'><input type='checkbox' name='checkedcard22' id='s2_vertical_"&n_n&"'><label for='s2_vertical_"&n_n&"''></label></span>"
                                        End if
                                        response.write "</td>"
                                        jj= jj +1
                                    Next
                                End if
                        
                                If ii < 10 then
                                    new_j="0"&ii
                                Else
                                    new_j=ii
                                End if
                        
                                n1_date   =n_year&"-"&n_month&"-"&new_j
                                n1_date22 =n_year&n_month&new_j
                                n_weekDate= weekDay(n1_date)
                        %>
                            <td height="80" valign="top" class="line3">
                                <% if jj mod 7 =1 then %>
                                <span class="checks"><input type="checkbox" name="checkedcard22" id="s2_vertical_<%=n_n%>"><label for="s2_vertical_<%=n_n%>"></label></span>
                                <% end if %>
                                <span class="checks" style="font-weight:500;"><input type="checkbox" name="checkedcard" value="<%=n1_date%>" id="s2_vertical_<%=n_n%>_<%=ii%>" class="checkbox2_<%=n_weekDate%>"><label for="s2_vertical_<%=n_n%>_<%=ii%>"><%=ii%>일</label></span>
                                	
                                <%
                                    html_nm_d =""
                            
                                    d_sql = " SELECT  seq, room_seq,  price_1, total_man , day, magam from w_tck_day r "
                                    d_sql =d_sql &" where good_cd='"&good_cd&"' and day = '"&n1_date22&"' order by room_seq asc"
                            
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open d_sql,objConn,3
                            
                                    If Rs.eof or Rs.bof then
                                        html_nm_d = "&nbsp;"
                                    Else
                                        i=0
                                        do until Rs.eof 
                            
                                            d_seq     = Rs("room_seq")
                                            d_price_1 = Rs("price_1")
                                            d_price_1 =  Replace(d_price_1 , ",","")
                                            if d_price_1="" or isnull(d_price_1) then
                                                d_price_1=0
                                            end if
                                             
                                            d_total_man = Rs("total_man")
                                            d_total_man =  Replace(d_total_man , ",","")
                                            if d_total_man="" or isnull(d_total_man) then
                                                d_total_man=0
                                            end if
                                             
                                            d_day   = Rs("day")
                                            d_magam = Rs("magam")
                            
                                            if Ucase(d_magam) ="Y" then
                                                html_nm_d =html_nm_d &"<div class='line4'><span class='line6'>"&d_seq&"</span><span style='padding:0 0 0 8px; color:#888;'>마감</span></div>"
                                            else
                                                html_nm_d =html_nm_d &"<div class='line4'><span class='line5'>"&d_seq&"</span><span style='padding:0 0 0 8px;'>"&formatNumber(d_price_1,0)&"</span><span>&nbsp;&nbsp;<span style='color:#0000FF'>("&d_total_man&")</span></span></div>"
                                            end if
                            
                                            rs.movenext
                                            i=i+1
                                        Loop
                            
                                    End if
                            
                                    Rs.close : Set Rs=nothing
                                %>
                                <div style="padding:6px 0 0 0;"><%=html_nm_d%></div>
                            </td>
                        <% 
                                if jj mod 7 =0 then
                                    response.write "</tr>"
                                End if
                        
                                jj= jj +1
                            Next 
                        %>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

</body> 
</html>

<script type="text/javascript">
<!--
    $(function() {

        $("#checkAll").click(function() { 
            if ($("#checkAll").is(":checked")== true) {
                $( 'input[name="checkedcard"]' ).prop( 'checked', true );
            }else{
                $( 'input[name="checkedcard"]' ).prop( 'checked', false );
            }
        });

        $("#checksun").click(function(){
            if ($("#checksun").is(":checked")== true) {
                $( '.checkbox1_1,.checkbox2_1,.checkbox3_1' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_1,.checkbox2_1,.checkbox3_1' ).prop( 'checked', false );
            }
        });

        $("#checkmon").click(function() { 
            if ($("#checkmon").is(":checked")== true) {
                $( '.checkbox1_2,.checkbox2_2,.checkbox3_2' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_2,.checkbox2_2,.checkbox3_2' ).prop( 'checked', false );
            }
        }); 

        $("#checktue").click(function() { 
            if ($("#checktue").is(":checked")== true) {
                $( '.checkbox1_3,.checkbox2_3,.checkbox3_3' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_3,.checkbox2_3,.checkbox3_3' ).prop( 'checked', false );
            }
        });

        $("#checkwed").click(function() { 
            if ($("#checkwed").is(":checked")== true) {
                $( '.checkbox1_4,.checkbox2_4,.checkbox3_4' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_4,.checkbox2_4,.checkbox3_4' ).prop( 'checked', false );
            }
        }); 
        
        $("#checkthu").click(function() { 
            if ($("#checkthu").is(":checked")== true) {
                $( '.checkbox1_5,.checkbox2_5,.checkbox3_5' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_5,.checkbox2_5,.checkbox3_5' ).prop( 'checked', false );
            }
        }); 
        
        $("#checkfri").click(function() { 
            if ($("#checkfri").is(":checked")== true) {
                $( '.checkbox1_6,.checkbox2_6,.checkbox3_6' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_6,.checkbox2_6,.checkbox3_6' ).prop( 'checked', false );
            }
        }); 

        $("#checksat").click(function() { 
            if ($("#checksat").is(":checked")== true) {
                $( '.checkbox1_7,.checkbox2_7,.checkbox3_7' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_7,.checkbox2_7,.checkbox3_7' ).prop( 'checked', false );
            }
         }); 


         $("#checksun_1").click(function() { 
            if ($("#checksun_1").is(":checked")== true) {
                $( '.checkbox1_1' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_1' ).prop( 'checked', false );
            }
         }); 
      
         $("#checkmon_1").click(function() { 
            if ($("#checkmon_1").is(":checked")== true) {
                $( '.checkbox1_2' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_2' ).prop( 'checked', false );
            }
         }); 
      
         $("#checktue_1").click(function() { 
            if ($("#checktue_1").is(":checked")== true) {
                $( '.checkbox1_3' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_3' ).prop( 'checked', false );
            }
         }); 
         
         $("#checkwed_1").click(function() { 
            if ($("#checkwed_1").is(":checked")== true) {
                $( '.checkbox1_4' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_4' ).prop( 'checked', false );
            }
         }); 
         
         $("#checkthu_1").click(function() { 
            if ($("#checkthu_1").is(":checked")== true) {
                $( '.checkbox1_5' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_5' ).prop( 'checked', false );
            }
         }); 
         
         $("#checkfri_1").click(function() { 
            if ($("#checkfri_1").is(":checked")== true) {
                $( '.checkbox1_6' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_6' ).prop( 'checked', false );
            }
          }); 
      
         $("#checksat_1").click(function() { 
            if ($("#checksat_1").is(":checked")== true) {
                $( '.checkbox1_7' ).prop( 'checked', true );
            }else{
                $( '.checkbox1_7' ).prop( 'checked', false );
            }
         }); 
      
      
         $("#checksun_2").click(function() { 
            if ($("#checksun_2").is(":checked")== true) {
                $( '.checkbox2_1' ).prop( 'checked', true );
            }else{
                $( '.checkbox2_1' ).prop( 'checked', false );
            }
          }); 
      
         $("#checkmon_2").click(function() { 
            if ($("#checkmon_2").is(":checked")== true) {
                $( '.checkbox2_2' ).prop( 'checked', true );
            }else{
                $( '.checkbox2_2' ).prop( 'checked', false );
            }
         }); 
      
         $("#checktue_2").click(function() { 
            if ($("#checktue_2").is(":checked")== true) {
                $( '.checkbox2_3' ).prop( 'checked', true );
            }else{
                $( '.checkbox2_3' ).prop( 'checked', false );
            }
         }); 
         
         $("#checkwed_2").click(function() { 
            if ($("#checkwed_2").is(":checked")== true) {
                $( '.checkbox2_4' ).prop( 'checked', true );
            }else{
                $( '.checkbox2_4' ).prop( 'checked', false );
            }
         }); 
         
         $("#checkthu_2").click(function() { 
            if ($("#checkthu_2").is(":checked")== true) {
                $( '.checkbox2_5' ).prop( 'checked', true );
            }else{
                $( '.checkbox2_5' ).prop( 'checked', false );
            }
         }); 
         
         $("#checkfri_2").click(function() { 
            if ($("#checkfri_2").is(":checked")== true) {
                $( '.checkbox2_6' ).prop( 'checked', true );
            }else{
                $( '.checkbox2_6' ).prop( 'checked', false );
            }
         }); 
      
         $("#checksat_2").click(function() { 
            if ($("#checksat_2").is(":checked")== true) {
                $( '.checkbox2_7' ).prop( 'checked', true );
            }else{
                $( '.checkbox2_7' ).prop( 'checked', false );
            }
         }); 
      
      
         $("#checksun_3").click(function() { 
            if ($("#checksun_3").is(":checked")== true) {
                $( '.checkbox3_1' ).prop( 'checked', true );
            }else{
                $( '.checkbox3_1' ).prop( 'checked', false );
            }
         }); 
      
         $("#checkmon_3").click(function() { 
            if ($("#checkmon_3").is(":checked")== true) {
                $( '.checkbox3_2' ).prop( 'checked', true );
            }else{
                $( '.checkbox3_2' ).prop( 'checked', false );
            }
         }); 
      
         $("#checktue_3").click(function() { 
            if ($("#checktue_3").is(":checked")== true) {
                $( '.checkbox3_3' ).prop( 'checked', true );
            }else{
                $( '.checkbox3_3' ).prop( 'checked', false );
            }
         }); 
         
         $("#checkwed_3").click(function() { 
            if ($("#checkwed_3").is(":checked")== true) {
                $( '.checkbox3_4' ).prop( 'checked', true );
            }else{
                $( '.checkbox3_4' ).prop( 'checked', false );
            }
         }); 
         
         $("#checkthu_3").click(function() { 
            if ($("#checkthu_3").is(":checked")== true) {
                $( '.checkbox3_5' ).prop( 'checked', true );
            }else{
                $( '.checkbox3_5' ).prop( 'checked', false );
            }
         }); 
         
         $("#checkfri_3").click(function() { 
            if ($("#checkfri_3").is(":checked")== true) {
                $( '.checkbox3_6' ).prop( 'checked', true );
            }else{
                $( '.checkbox3_6' ).prop( 'checked', false );
            }
         }); 

         $("#checksat_3").click(function() { 
            if ($("#checksat_3").is(":checked")== true) {
                $( '.checkbox3_7' ).prop( 'checked', true );
            }else{
                $( '.checkbox3_7' ).prop( 'checked', false );
            }
         }); 


         $("#s1_vertical_1").click(function() { 
            if ($("#s1_vertical_1").is(":checked")== true) {
                $("[id^='s1_vertical_1_']").prop( 'checked', true );
            }else{
                $("[id^='s1_vertical_1_']").prop( 'checked', false );
            }
         }); 

         $("#s1_vertical_2").click(function() { 
            if ($("#s1_vertical_2").is(":checked")== true) {
                $("[id^='s1_vertical_2_']").prop( 'checked', true );
            }else{
                $("[id^='s1_vertical_2_']").prop( 'checked', false );
            }
         }); 

         $("#s1_vertical_3").click(function() { 
            if ($("#s1_vertical_3").is(":checked")== true) {
                $("[id^='s1_vertical_3_']").prop( 'checked', true );
            }else{
                $("[id^='s1_vertical_3_']").prop( 'checked', false );
            }
         }); 

         $("#s1_vertical_4").click(function() { 
            if ($("#s1_vertical_4").is(":checked")== true) {
                $("[id^='s1_vertical_4_']").prop( 'checked', true );
            }else{
                $("[id^='s1_vertical_4_']").prop( 'checked', false );
            }
         }); 
      
         $("#s1_vertical_5").click(function() { 
            if ($("#s1_vertical_5").is(":checked")== true) {
                $("[id^='s1_vertical_5_']").prop( 'checked', true );
            }else{
                $("[id^='s1_vertical_5_']").prop( 'checked', false );
            }
         }); 
      
         $("#s1_vertical_6").click(function() { 
            if ($("#s1_vertical_6").is(":checked")== true) {
                $("[id^='s1_vertical_6_']").prop( 'checked', true );
            }else{
                $("[id^='s1_vertical_6_']").prop( 'checked', false );
            }
         }); 
      
      
         $("#s2_vertical_1").click(function() { 
            if ($("#s2_vertical_1").is(":checked")== true) {
                $("[id^='s2_vertical_1_']").prop( 'checked', true );
            }else{
                $("[id^='s2_vertical_1_']").prop( 'checked', false );
            }
          }); 

         $("#s2_vertical_2").click(function() { 
            if ($("#s2_vertical_2").is(":checked")== true) {
                $("[id^='s2_vertical_2_']").prop( 'checked', true );
            }else{
                $("[id^='s2_vertical_2_']").prop( 'checked', false );
            }
         }); 

         $("#s2_vertical_3").click(function() { 
            if ($("#s2_vertical_3").is(":checked")== true) {
                $("[id^='s2_vertical_3_']").prop( 'checked', true );
            }else{
                $("[id^='s2_vertical_3_']").prop( 'checked', false );
            }
         }); 

         $("#s2_vertical_4").click(function() { 
            if ($("#s2_vertical_4").is(":checked")== true) {
                $("[id^='s2_vertical_4_']").prop( 'checked', true );
            }else{
                $("[id^='s2_vertical_4_']").prop( 'checked', false );
            }
         }); 
      
         $("#s2_vertical_5").click(function() { 
            if ($("#s2_vertical_5").is(":checked")== true) {
                $("[id^='s2_vertical_5_']").prop( 'checked', true );
            }else{
                $("[id^='s2_vertical_5_']").prop( 'checked', false );
            }
         }); 

         $("#s2_vertical_6").click(function() { 
            if ($("#s2_vertical_6").is(":checked")== true) {
                $("[id^='s2_vertical_6_']").prop( 'checked', true );
            }else{
                $("[id^='s2_vertical_6_']").prop( 'checked', false );
            }
         }); 

    });
//-->
</script> 

<%
    Function m_ed_num(ss_MM, ss_YY)
    
        selectmonth = ss_MM

        If selectmonth = 4 or selectmonth = 6 or selectmonth = 9 or selectmonth = 11 then
            nummonth = 30
        Elseif selectmonth = 2 then
            if (((ss_YY mod 4 = 0) and (ss_YY mod 100 <> 0)) or (ss_YY mod 400 = 0)) then
                nummonth = 29
            else
                nummonth = 28
            end if
        Else
            nummonth = 31
        End if
        m_ed_num = nummonth

    End Function
%>