<!--#include virtual="/home/conf/config.asp"-->
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<%
    OpenF5_DB objConn   

    reserve_code  = Request("reserve_code")
    reserve_code = Base64_Decode(reserve_code)

    g_kind  = Request("g_kind")
    reserve_gubun ="30"

    sql =" SELECT  r.seq , r.good_num, r.reserve_code, r.res_nm,  r.res_eng_nm_f, r.res_eng_nm_L , r.res_hp1, r.res_hp2, r.res_hp3, r.res_email ,r.res_hotel,r.res_pick_time ,v_vaucher_no "
    sql = sql &" ,r.res_remark  , r.res_amt, r.add_amt , r.dc_amt , r.prod_cd , r.ins_dt , g.title , g.g_kind "
    sql = sql &" FROM  w_res_tck001 r left outer join trip_gtck g ON r.good_num = g.num   "
    sql = sql &" WHERE r.reserve_code ='"&reserve_code&"'"

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3
    if Rs.eof or Rs.bof then
        Response.write "<script type='text/javascript'>"
        Response.write " alert(' 예약된내용이 없습니다.'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    Else
        r_seq = Rs("seq")
        good_num = Rs("good_num")

        reserve_code = Rs("reserve_code")

        res_nm = Rs("res_nm")
        res_eng_nm_F = Rs("res_eng_nm_F")
        res_eng_nm_L = Rs("res_eng_nm_L")
        
        res_hp1 = Rs("res_hp1")
        res_hp2 = Rs("res_hp2")
        res_hp3 = Rs("res_hp3")
        tot_tel = res_hp1&"-"&res_hp2&"-"&res_hp3

        res_email = Rs("res_email")
        res_hotel = Rs("res_hotel")
        
        pick_time = Rs("res_pick_time")
        v_vaucher_no= Rs("v_vaucher_no")

        res_remark = Rs("res_remark")
        if not isnull(res_remark) or res_remark <> "" then   
            res_remark = Replace(res_remark,chr(13)&chr(10),"<br>")
        end if
        
        res_amt = Rs("res_amt")
        add_amt = Rs("add_amt")
        dc_amt = Rs("dc_amt")

        r_prod_cd = Rs("prod_cd")
        prod_nm = ch_procd_hnm(r_prod_cd)

        ins_dt = Left(Rs("ins_dt"),10)

        good_nm = Rs("title")
        g_kind  = Rs("g_kind")

    End if

    Rs.close : Set Rs = nothing
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link type="text/css" rel="stylesheet" href="<%=global_url%>/css/style.css" />

</head>

<body>
	
    <div style="padding:20px;">
    	
        <div><img src="<%=global_url%>/images/logo/title_logo.png" border="0" height="45"></div>
        <div class="pt15"></div>
        <div style="border-bottom:2px solid #000;"></div>
        <div class="pt30"></div>
        <div class="pp_title">예약자 정보</div>

        <div class="rater_box">
            <table>
                <colgroup>
                    <col width="17%">
                    <col width="33%">
                    <col width="17%">
                    <col width="*%">
                </colgroup>
                <tbody>  
                    <tr>
                        <td class="typ1">예약번호</td>
                        <td class="typ2"><%=reserve_code%></td>
                        <td class="typ1">예약일</td>
                        <td class="typ2"><%=ins_dt%></td>
                    </tr>
                    <tr>
                        <td class="typ3">한글명</td>
                        <td class="typ4"><%=res_nm%></td>
                        <td class="typ3">이메일</td>
                        <td class="typ4"><%=res_email%></td>
                    </tr>
                    <tr>
                        <td class="typ3">진행현황</td>
                        <td class="typ4"><%=prod_nm%></td>
                        <td class="typ3"></td>
                        <td class="typ4"></td>
                    </tr>
                </tbody>
            </table>   
        </div> 
        
        <%
            m_sql =" SELECT num, reserve_code, opt_seq ,opt_day,opt_nm,opt_ad_price from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N')  and opt_tp='F'"
            Set Rs = Server.CreateObject("ADODB.RecordSet")
                            
            Rs.open m_sql,objConn ,3
            If Rs.eof or Rs.bof then
                s_opt_day = ""
            Else
                s_opt_day = Rs("opt_day")
                opt_nm = Rs("opt_nm")
                opt_ad_price=Rs("opt_ad_price")
            End if
        %>
        
        <div class="pt30"></div>
        <div class="pp_title">예약내역</div>
        
        <div class="rater_box">
            <table>
                <colgroup>
                    <col width="17%">
                    <col width="*">
                </colgroup>
                <tbody>  
                    <tr>
                        <td class="typ1">프로그램명</td>
                        <td class="typ2"><%=good_nm%></td>
                    </tr>
                    <tr>
                        <td class="typ3">투어일</td>
                        <td class="typ4"><%=s_opt_day%></td>
                    </tr>
                      <tr>
                        <td class="typ3">시간</td>
                        <td class="typ4"><%=opt_nm%></td>
                    </tr>
                    <tr>
                        <td class="typ3">상품금액</td>
                        <td class="typ4"><strong><%=formatnumber(opt_ad_price,0)%>&nbsp;CP</strong></td>
                    </tr>
                    
                    <tr>
                        <td class="typ3">결제 포인트</td>
                        <td class="typ4"><strong><%=FormatNumber(opt_ad_price,0)%>&nbsp;CP</strong></td>
                    </tr>
                </tbody>
            </table> 
        </div>
        
        <% if res_remark<>"" then %>       
            <div class="pt30"></div>
            <div class="pp_title">추가 요청사항</div>
            <div style="padding:20px; border:1px solid #D9D9D9;">
                <%=res_remark%>
            </div>
        <% end if %>   
        
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
        
    </div>

</body>
</html>

 <% CloseF5_DB objConn %>