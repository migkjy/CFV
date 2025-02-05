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
    
    
    reserve_code  = Request("reserve_code")
    if reserve_code = "" then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('주요인자 전송에러...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    end if

    reserve_gubun ="30"
    symbol="￦"
    
    sql =" SELECT  r.seq , r.good_num, r.reserve_code, r.g_kind, r.res_nm,  r.res_eng_nm_f, r.res_eng_nm_L , r.res_hp1, r.res_hp2, r.res_hp3, r.res_email ,r.res_hotel ,r.res_pick_place, r.res_pick_time "
    sql = sql &" ,r.res_remark , r.res_amt, r.add_amt , r.dc_amt , r.prod_cd, r.v_vaucher_no ,r.v_vaucher_no,  r.ins_dt , g.title , g.g_kind "
    sql = sql &" FROM  w_res_tck001 r left outer join trip_gtck g ON r.good_num = g.num   "
    sql = sql &" WHERE r.reserve_code ='"&reserve_code&"'"

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3

    If Rs.eof or Rs.bof then
        Response.write "<script type='text/javascript'>"
        Response.write " alert(' 예약된내용이 없습니다.'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    Else
        r_seq = Rs("seq")
        good_num = Rs("good_num")
        reserve_code = Rs("reserve_code")

        g_kind = Rs("g_kind")
        select case g_kind 
            case "10" : gubun_nm ="프로그램"
            case "20" : gubun_nm ="할인티켓"
            case else : gubun_nm ="기타"
        end select 

        res_nm = Rs("res_nm")
        res_eng_nm_F = Rs("res_eng_nm_F")
        res_eng_nm_L = Rs("res_eng_nm_L")

        res_hp1 = Rs("res_hp1")
        res_hp2 = Rs("res_hp2")
        res_hp3 = Rs("res_hp3")

        res_email = Rs("res_email")
        res_hotel = Rs("res_hotel")
        res_pick_time    = Rs("res_pick_time")
        
        res_remark = Rs("res_remark")
        if not isnull(res_remark) or res_remark <> "" then   
            res_remark = Replace(res_remark,chr(13)&chr(10),"<br>")
        end if
            
        res_amt = Rs("res_amt")
        add_amt = Rs("add_amt")
        dc_amt = Rs("dc_amt")
        r_prod_cd = Rs("prod_cd")
        prod_nm = ch_procd_hnm(r_prod_cd)

        v_vaucher_no = Rs("v_vaucher_no")
        ins_dt = left(Rs("ins_dt"),10)
        title = Rs("title")
        
     End if

     Rs.close : Set Rs = nothing


     m_sql =" SELECT num, reserve_code, opt_seq ,opt_day from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N')  and opt_tp='F'"
     Set Rs = Server.CreateObject("ADODB.RecordSet")
        
     Rs.open m_sql,objConn ,3
     If Rs.eof or Rs.bof then
          s_day = ""
     Else
          s_day = Rs("opt_day")
     End if
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>

<body>
	
    <div class="pt15"></div>    
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="*%"><div class="pop_title" align="center"><%=gubun_nm%> 예약현황</div></td>
            <td width="45%" valign="top"><!--#include virtual="/admin/inc/line_approval.asp"--></td>
        </tr>
    </table>  
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="70" class="pop_txt">예약번호</td>
            <td width="10">:</td>
            <td width="*"><%=reserve_code%></td>
        </tr>
        <tr>
            <td class="pop_txt">예약일</td>
            <td>:</td>
            <td><%=ins_dt%></td>
        </tr>
        <tr>
            <td class="pop_txt">프로그램명</td>
            <td>:</td>
            <td><%=title%></td>
        </tr>
        <tr>
            <td class="pop_txt">출발일</td>
            <td>:</td>
            <td><%=s_day%> </td>
        </tr>
    </table>     

    <div class="print_gubun">예약자 정보</div>   	

    <div class="pop_box">
        <table>
            <tr>
                <td width="13%" class="lop1">한글명</td>
                <td width="37%" class="lop2"><%=res_nm%></td>
                <td width="13%" class="lop3">휴대전화</td>
                <td width="*%" class="lop2"><%=res_hp1%>-<%=res_hp2%>-<%=res_hp3%></td>
            </tr>
            <tr>
                <td class="lob1">이메일</b</td>
                <td class="lob2"><%=res_email%></td>
                <td class="lob3">진행현황</b</td>
                <td class="lob2"><%=prod_nm%></td>
            </tr>
        </table>
    </div> 

    <div class="print_gubun">예약내역</div>
  
    <div class="pop_box">
        <table>
            <colgroup>
                <col width="13%">
                <col width="*%">
            </colgroup>
            <tbody>
                <tr>
                    <td class="lop1">상품명</td>
                    <td class="lop2"><%=title%></td>
                </tr>
                <tr>
                    <td class="lob1">출발일</td>
                    <td class="lob2"><%=s_day%></td>
                </tr>
                <% if res_pick_time <>"" then%>
                <tr>
                    <td class="lob1">선택시간</td>
                    <td class="lob2"><%=res_pick_time%></td>
                </tr>
                <% end if %>
                <tr>
                    <td class="lob1">선택사항</td>
                    <td class="lob2">
                        <%
                            m_sql =" SELECT num, reserve_code, opt_day ,opt_time,  opt_seq, opt_nm,  opt_ad_cnt, opt_ad_price  "
                            m_sql = m_sql &" from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N') and opt_tp='F'"
                        
                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                            Rs.open m_sql,objConn ,3
                            If Rs.eof or Rs.bof then
                            Else
                                Do until Rs.eof
                        
                                    s_num = Rs("num")
                                    s_opt_day  = Rs("opt_day")
                                    s_opt_time = Rs("opt_time")
                                    s_opt_seq  = Rs("opt_seq")
                                    s_opt_nm   = Rs("opt_nm")
                        
                                    s_ad_cnt = Rs("opt_ad_cnt")
                                    s_ad_price = Rs("opt_ad_price")
                                 
                                    s_per_ad_amt = Cdbl(s_ad_cnt ) * Cdbl(s_ad_price)
                                    s_per_amt = Cdbl(s_per_ad_amt )
                        
                                    If r_prod_cd="4" then
                                        ss_amt   = 0
                                    Else
                                        ss_amt = Cdbl(ss_amt) + Cdbl(s_per_amt)
                                    End if
                        %>
                            <div style="padding:5px 0;">
                                <div><%=s_opt_nm%></div>
                                <% if s_ad_cnt <> "0" then %>
                                    <div>성인 : <%=FormatNumber(s_ad_price,0)%> CP X <%=FormatNumber(s_ad_cnt,0)%>명</div>
                                <% end if %>  
                            </div>
                        
                            <input type="hidden" name="s_num" value="<%=s_num%>"  >
                        <%
                                 Rs.movenext
                              
                              LOOP
                           End if
                        %>
                    </td>
                </tr>
                <tr>
                    <td class="lob1">결제 포인트</td>
                    <td class="lob2"><%=FormatNumber(ss_amt,0)%> CP</td>
                </tr>
            </tbody>
        </table>
    </div>

    <% If res_remark <> "" then %>
        <div class="print_gubun">추가 요청사항</div>  

        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="border:1px solid #000;padding:10px;"><%=res_remark%></td>
            </tr>
        </table>
    <% End if %>
 
 
    <style type="text/css" media="print">
        .noprint {
       display: none;
       }       
    </style>

    <div class="noprint" align="center" style="padding:25px 0 30px 0;">
        <span class="button_b" style="padding:0px 4px;"><a onClick="window.print();return false;">인쇄</a></span>
        <span class="button_b" style="padding:0px 4px"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
    </div>

</body>
</html>

<script language="javascript">
<!--
    function closeIframe(){
        parent.$('#chain_print').dialog('close');
        return false;
    }
-->
</script> 

