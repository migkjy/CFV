<!--#include virtual="/home/conf/config.asp"-->
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<% 
    OpenF5_DB objConn
    
    
    reserve_code  = Request("reserve_code")
    If reserve_code  = "" then
        response.write " <script language='javascript'>  "
        response.write "  alert('주요인자오류');"
        response.write "  self.close();"
        response.write " </script> " 
        response.end
    End if

    g_kind = Request("g_kind")
    reserve_gubun ="30"

    '###################################################################################
    start_ymd  = Request("start_ymd")
    start_ymd2 = Request("start_ymd2")


    sql =" SELECT  r.seq , r.good_num, r.reserve_code, r.res_nm, r.res_email ,r.res_pick_time , r.v_vaucher_no ,r.v_remark ,r.v_issue_date ,r.v_detail ,r.ins_dt , g.title"
    sql = sql &" FROM  w_res_tck001 r left outer join trip_gtck g ON r.good_num = g.num   "
    sql = sql &" WHERE r.reserve_code ='"&reserve_code&"'"

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3

    r_seq        = Rs("seq")
    good_num     = Rs("good_num")
    reserve_code = Rs("reserve_code")

    res_nm       = Rs("res_nm")
    res_email    = Rs("res_email")
    res_pick_time= Rs("res_pick_time")
    
    v_vaucher_no = Rs("v_vaucher_no")
    
    v_remark     = Rs("v_remark")
        if not isnull(v_remark) or v_remark <> "" then   
            v_remark = Replace(v_remark,chr(13)&chr(10),"<br>")
        end if

    v_issue_date = Rs("v_issue_date")
    v_detail     = Rs("v_detail")
    title        = Rs("title")

    Rs.close : Set Rs = nothing


    m_sql =" SELECT num, reserve_code, opt_seq ,opt_day from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N')  and opt_tp='F'"
    Set Rs = Server.CreateObject("ADODB.RecordSet")
        
    Rs.open m_sql,objConn ,3
    if Rs.eof or Rs.bof then
        s_day = ""
    else
        s_day = Rs("opt_day")
    end if
 
    '################################################################################바우쳐번호
    If Len(v_vaucher_no)< 2 then
        response.write "<script language='javascript'>   "
        response.write "  alert('등록된 바우쳐번호가 없습니다..'); "
        response.write "  self.close(); "
        response.write "</script> "
        response.end
    End if
%>

<!DOCTYPE html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
</head>

<body>
	
    <div style="padding:15px 5px;">

        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td width="*" style="font-family: Verdana; font-size:1.56em; font-weight:700; letter-spacing:-0.05em;">Voucher</td>
                <td width="180" align="right"><img src="<%=global_url%>/images/logo/title_logo.png" border="0" height="30"></td>
            </tr>
        </table>
        
        <div style="padding:10px;"></div>
        
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:3px solid #000000;">
            <tr>
                <td bgcolor="#FFFFFF">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr height="40">
                            <td colspan="4" style="font-family: Verdana; font-size:0.94em; padding:0 10px; border-bottom:1px solid #A4A4A4; background: #F5F5F5;font-weight:bold;color:#000;">Booking Infor</td>
                        </tr>
                        <tr height="36">
                            <td style="font-family: Verdana; font-size:0.69em; padding:0 10px; border-bottom:1px solid #A4A4A4;font-weight:bold;color:#000;">Voucher no.</td>
                            <td colspan="3" style="font-family: Verdana; font-size:0.69em; border-bottom:1px solid #A4A4A4;color:#000;"><%=v_vaucher_no%></td>
                        </tr>
                        <tr height="36">
                            <td style="font-family: Verdana; font-size:0.69em; padding:0 10px; border-bottom:1px solid #A4A4A4;font-weight:bold;color:#000;">Tour title</td>
                            <td colspan="3" style="font-family: Verdana; font-size:0.69em; border-bottom:1px solid #A4A4A4;color:#000;"><%=title%></td>
                        </tr>
                        <% if res_pick_time <>"" then %>
                        <tr height="36">
                            <td style="font-family: Verdana; font-size:0.69em; padding:0 10px; border-bottom:1px solid #A4A4A4;font-weight:bold;color:#000;">Date</td>
                            <td style="font-family: Verdana; font-size:0.69em;  border-bottom:1px solid #A4A4A4;color:#000;"><%=s_day%></td>
                            <td style="font-family: Verdana; font-size:0.69em; padding:0 10px; border-bottom:1px solid #A4A4A4;font-weight:bold;color:#000;">Time</td>
                            <td style="font-family: Verdana; font-size:0.69em;  border-bottom:1px solid #A4A4A4;color:#000;"><%=res_pick_time%></td>
                        </tr>
                        <% else %>
                        <tr height="36">
                            <td style="font-family: Verdana; font-size:0.69em; padding:0 10px; border-bottom:1px solid #A4A4A4;font-weight:bold;color:#000;">Date</td>
                            <td colspan="3" style="font-family: Verdana; font-size:0.69em;  border-bottom:1px solid #A4A4A4;color:#000;"><%=s_day%></td>
                        </tr>
                        <% end if %>
                        <tr height="36">
                            <td width="20%" style="font-family: Verdana; font-size:0.69em; padding:0 10px; border-bottom:2px solid #000000;color:#000;font-weight:bold;">Issued by</td>
                            <td width="30%" style="font-family: Verdana; font-size:0.69em; border-bottom:2px solid #000000;color:#000;"><%=global_sin%> / <%=global_tel%></td>
                            <td width="20%" style="font-family: Verdana; font-size:0.69em; padding:0 10px; border-bottom:2px solid #000000;color:#000;font-weight:bold;">Issued date</td>
                            <td width="*%" style="font-family: Verdana; font-size:0.69em; border-bottom:2px solid #000000;color:#000;"><%=v_issue_date%></td> 
                        </tr>
                        <tr height="40">
                            <td colspan="4" style="font-family: Verdana; font-size:0.94em; padding:0 10px; border-bottom:1px solid #A4A4A4; background: #F5F5F5;font-weight:bold;color:#000;">Tour Info</td>
                        </tr>
                        <tr height="36">
                            <td style="font-family: Verdana; font-size:0.69em; padding:0 10px; border-bottom:1px solid #A4A4A4;font-weight:bold;color:#000;">Select Info</td>
                            <td colspan="3" style="font-family: Verdana; font-size:0.69em; border-bottom:1px solid #A4A4A4; padding:10px 0px;color:#000; ">
                                <%
                                    m_sql =" SELECT num, reserve_code, opt_day ,opt_time,  opt_seq, opt_nm,  opt_ad_cnt, opt_ad_price  "
                                    m_sql = m_sql &" from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N') and opt_tp='F'"
                                
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open m_sql,objConn ,3
                                    If Rs.eof or Rs.bof then
                                    Else
                                        Do until Rs.eof
                                
                                            s_num      = Rs("num")
                                            s_opt_seq  = Rs("opt_seq")
                                            s_opt_nm   = Rs("opt_nm")
                                
                                            s_ad_cnt   = Rs("opt_ad_cnt")
                                
                                %>
                                    <div><strong>·</strong> <%=s_opt_nm%></div>
                                    <div style="padding:5px 0 0 0;"><strong>·</strong> <% if s_ad_cnt <> "0" then %>Adult <%=FormatNumber(s_ad_cnt,0)%><% end if %></div>
                                    <input type="hidden" name="s_num" value="<%=s_num%>"  >
                                <%
                                         Rs.movenext
                                      
                                      loop
                                   End if
                                %>
                            </td>
                        </tr>
        
                        <tr height="36">
                            <td style="font-family: Verdana; font-size:0.69em; padding:0 10px; border-bottom:2px solid #000000; line-height:1.5em;font-weight:bold;color:#000;">Guest name</td>
                            <td colspan="3" style="font-family: Verdana; font-size:0.69em; border-bottom:2px solid #000000; padding:10px 0px;color:#000;">
                                <%
                                    d_sql = "select idx , d_age, d_gender, d_nm, d_eng_f, d_eng_L, d_birth from w_res_tck002 where reserve_code='"&reserve_code&"' "
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open d_sql,objConn,3
                                    
                                    If Rs.eof then
                                    Else
                                        i=0
                                        Do until Rs.eof
                                    
                                            d_num = Rs("idx")
                                            d_age = Ucase(Rs("d_age"))
                                                Select Case d_age
                                                    Case "A" : age_nm ="Adult"
                                                    Case "C" : age_nm ="Child"
                                                    Case "I" : age_nm ="Infant"
                                                End select
                                                
                                            d_gender   = Ucase(Rs("d_gender"))                                 
                                            d_nm = Rs("d_nm")
                                            d_eng_F  = Rs("d_eng_F")
                                            d_eng_L  = Rs("d_eng_L")
                                            d_birth  = Rs("d_birth")
                                %>
                                <div><%=age_nm%> : <%=d_nm%>&nbsp;<%=d_eng_F%>/<%=d_eng_L%>  (<%=d_gender%>)</div>
                                <%
                                            Rs.MoveNext
                                            i=i+1
                                        Loop
                                
                                    End if
                                %>
                            </td>
                        </tr>
                        <tr height="40">
                            <td colspan="4" style="font-family: Verdana; font-size:0.94em; padding:0 10px; border-bottom:1px solid #A4A4A4; background: #F5F5F5;font-weight:bold;color:#000;">Remark</td>
                        </tr>
                        <tr height="36">
                            <td colspan="4" style="font-family: Verdana; font-size:0.69em; padding:10px; border-bottom:1px solid #A4A4A4; line-height:1.5em;color:#000;"><%=v_remark%></td>
                        </tr>
                        <tr height="40">
                            <td colspan="4" style="font-family: Verdana; font-size:0.94em; padding:0 10px; border-bottom:1px solid #A4A4A4; background: #F5F5F5;font-weight:bold;color:#000;">Detail</td>
                        </tr>
                        <tr height="36">
                            <td colspan="4" style="font-family: Verdana; font-size:0.69em; padding:10px;line-height:1.5em; border-bottom:1px solid #A4A4A4;color:#000;"><%=v_detail%></td>
                        </tr>
                        <tr height="40">
                            <td colspan="4" style="font-family: Verdana; font-size:0.94em; padding:0 10px; border-bottom:1px solid #A4A4A4; background: #F5F5F5;font-weight:bold;color:#000;">주의사항</td>
                        </tr>
                        <tr height="30">
                            <td colspan="4" style="font-family: Verdana; font-size:0.69em; padding:10px; line-height:1.5em;color:#000;">
                                * 요청사항은 상황에 따라 100% 반영되지 않는 경우도 있습니다.<br>
                                * 예약 후 현지에서 어떤 사유로 인해 불참해도 환불되지 않습니다.<br>
                                * 현지에서 직접 변경으로 인한 수수료/불이익은 <%=global_sin%>에서 책임지지 않습니다.<br>
                                * 현지에서 여권의 제시 또는 카피를 요구할 수 있으니 양해바랍니다.<br>
                                * <%=global_sin%> 연락처 [<%=global_tel%>]
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </td>
        
    <style type="text/css" media="print">
        .noprint {
        display: none;
        }
    </style>
    <div class="noprint">
        <div class="board_btn_w">
            <ul class="btn_r">
                <li class="color"><a href="javascript:void(0)" onClick="window.print();">인쇄</a></li>
            </ul>
        </div>
    </div>

</body>
</html>

 <% CloseF5_DB objConn %>