<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    OpenF5_DB objConn

    mkk ="&nbsp;"
    idx = request("idx")
    seq = request("seq")

    today_date = Cdate(date)


    gubun = request("gubun")
    If gubun="" then
        gubun="10"
    End if

    s_year   = Request("s_year")
    s_month  = Request("s_month")

    If s_year="" or isnull(s_year) then
        s_year = Left( Cdate(date),4)
    End if

    If s_month="" or isnull(s_month) then
        s_month = Mid( Cdate(date),6,2)
    Else
        s_month  = right("0"&s_month,2)	
    End if


    '현재
    start_day_sec = s_year&"-"&s_month&"-"&"01"
    n0_weekday = weekday(start_day_sec)
    no_maxday = m_ed_num(s_year,s_month)
 
%>

<!DOCTYPE html>
<html>
<head>
<title>투어/티켓 월별모객</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
</head>

<body>
	
    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 프로그램 월별모객 현황</div>
        	
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
            <tr>
                <td>
                    <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bin_pa" width="100">
                                <select name="s_year" id="s_year" onchange="fn_s_loc(this.value)" class="select_basic" style="width:100%;">
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
                            <td class="bin_pa" width="70">
                                <select name="s_month" id="s_month" onchange="fn_m_loc(this.value)" class="select_basic" style="width:100%;">
                                    <% For jj=1 to 12 %>
                                        <option value="<%=jj%>" <% if Cint(s_month)=Cint(jj) then response.write "selected" end if %>><%=jj%>월</option>
                                    <% Next %>
                                </select>
                            </td>
                            <td class="bin_pb" width="*%">
                               <span><img src="/admin/images/top_list.png" border="0" onClick="location.href='plan_index.asp'" style="cursor:pointer;border-radius:2px;"></span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div class="pb15"></div> 
        
        <div class="pian_title">현재달력 : <%=s_year&"년 "&s_month%>월&nbsp;&nbsp; <font color="#FF0000">(오늘 : <%=date()%>)</font></div>
            
        <table width="100%"  border="0" cellpadding="0" cellspacing="0" style="border-left:1px solid #C0C0C0; border-top:1px solid #C0C0C0;">
            <tr height="36"> 
                <td width="15%" class="pian_moon" style="border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0; color:#FF0000;">일</td>
                <td width="14%" class="pian_moon" style="border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0;">월</td>
                <td width="14%" class="pian_moon" style="border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0;">화</td>
                <td width="14%" class="pian_moon" style="border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0;">수</td>
                <td width="14%" class="pian_moon" style="border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0;">목</td>
                <td width="14%" class="pian_moon" style="border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0;">금</td>         
                <td width="*%" class="pian_moon" style="border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0; color:#0000FF;">토</td>
            </tr>
            <% 
                jj = 1
                 
                For ii= 1 to no_maxday
                
                    If jj mod 7 =1 then
                        response.write "<tr height='80'>"
                    End if
                
                    If ii=1 then
                        For kk = 1 to n0_weekday-1 
                            response.write "<td width='14%' valign='top' bgcolor='#F7F7F7' style='padding:15px; border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0;'>"&mkk&"</td>"
                            jj= jj +1
                        Next
                    End if
                
                    If ii < 10 then
                        new_j="0"&ii
                    Else
                        new_j=ii
                    End if

                    n0_date   = s_year&"-"&s_month&"-"&new_j
                    n0_date22 = s_year&s_month&new_j
            %>
                <td height="80" valign="top" bgcolor="#EFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';" style="padding:15px;border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0;">
                    <div style="font-weight:700;"><%=ii%></div>
                    <%
                        html_nm_c =""

                        s_sql = " SELECT  o.num, o.reserve_code, r.g_kind , r.good_num,r.res_nm from w_res_tckopt o left outer join w_res_tck001 r on o.reserve_code=r.reserve_code  "
                        's_sql = s_sql&" where  opt_day  ='"&n0_date&"' and (r.prod_cd='2' or r.prod_cd='3')  order by o.num desc"
                        s_sql = s_sql&" where  opt_day  ='"&n0_date&"'  order by o.num desc"
                       'response.write s_sql
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                      
                        Rs.open s_sql,objConn,3
                        
                        If Rs.eof or Rs.bof then
                            html_nm_c ="&nbsp;"
                        else
                            i=0
                            do until Rs.eof 
                                r_g_kind = Rs("g_kind")

                                r_res_cd = Rs("reserve_code")
                                r_res_nm = Rs("res_nm")


                                html_nm_c =html_nm_c &"<div style='padding:5px 0px 0px 0px;'><a href='reserve_detail.asp?reserve_code="&r_res_cd&"'>No." &r_res_cd&"&nbsp;&nbsp;"&r_res_nm&" " &"</a></div>"

                                rs.movenext
                                i=i+1
                           Loop
                        
                        End if

                        Rs.close : Set Rs=nothing

                    %>
                    <%=html_nm_c%>
                </td>
            <% 
                    If jj mod 7 =0 then
                        response.write "</tr>"
                    End if
                 
                    jj= jj +1
                Next             
         
         
                 objConn.Close   : Set objConn = Nothing
            %>
            </tr>
        </table>
    </div>
    
</body>
</html>


<script type="text/javascript">
<!--
    function fn_s_loc(y) {
        var curr_year = document.getElementById("s_year").value;
        var curr_month = document.getElementById("s_month").value;
        location.href="plan_index.asp?gubun=<%=gubun%>&s_year="+y+"&s_month="+curr_month;
    }


   function fn_m_loc(m) {
        var curr_year = document.getElementById("s_year").value;
        var curr_month = document.getElementById("s_month").value;
        location.href="plan_index.asp?gubun=<%=gubun%>&s_year="+curr_year+"&s_month="+m;
   }
--> 
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

