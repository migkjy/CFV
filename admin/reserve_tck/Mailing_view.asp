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
    
    mode = Request("mode")

    symbol = "￦"

    reserve_code  = Request("reserve_code")
    if reserve_code = "" then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('주요인자 전송에러...'); "
        Response.write " self.close();"
        Response.write " </script>	 "
        Response.end
    end if

    reserve_gubun ="30"


    start_ymd  = Request("start_ymd")
    start_ymd2 = Request("start_ymd2")

    gotopage   = Request("gotopage")
    s_kind = Request("s_kind")
    s_kind1 = Request("s_kind1")
    s_kind2 = Request("s_kind2") 


    sql =" SELECT  r.seq , r.good_num, r.reserve_code, r.g_kind, r.res_nm,  r.res_eng_nm_f, r.res_eng_nm_L , r.res_hp1, r.res_hp2, r.res_hp3, r.res_email ,r.res_hotel ,r.res_pick_place, r.res_pick_time "
    sql = sql &" ,r.res_remark  ,r.res_amt, r.add_amt , r.dc_amt , r.prod_cd, r.v_vaucher_no ,r.del_yn, r.ins_dt , g.title , g.g_kind "
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

        good_num     = Rs("good_num")
        reserve_code = Rs("reserve_code")

        g_kind = Rs("g_kind")
        select case g_kind 
            case "10" : gubun_nm ="프로그램 상품"
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

        res_pick_time= Rs("res_pick_time")

        res_remark   = Rs("res_remark")
        if not isnull(res_remark) or res_remark <> "" then   
            res_remark = Replace(res_remark,chr(13)&chr(10),"<br>")
        end if

        res_amt = Rs("res_amt")
        add_amt = Rs("add_amt")
        dc_amt = Rs("dc_amt")
        
        r_prod_cd = Rs("prod_cd")
        prod_nm = ch_procd_hnm(r_prod_cd)
        
        ins_dt = Left(Rs("ins_dt"),10)

        title = Rs("title")
        v_vaucher_no = Rs("v_vaucher_no")
        
     End if

     Rs.close : Set Rs = nothing
     
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
	
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="40%"><img src="<%=global_url%>/images/logo/title_logo.png" border="0" height="40"></td>
            <td width="*">
                <div style="font-size:12px; font-family:Noto Sans KR; line-height:1.5em; text-align:right;">
                    <%=GLOBAL_JU%><br><%=GLOBAL_TEL%>，<%=GLOBAL_FAX%>，<%=GLOBAL_MAIL%>
                </div>
            </td>
        </tr>
    </table>
    
    <div style="height:10px;"></div>
    <div style="border-bottom:2px solid #000000;"></div>
    <div style="height:20px;"></div>

    <% if mode = "1" then %>
        <div style="font-size:13px; font-family:Noto Sans KR;">
            <%=GLOBAL_NM%>를 이용해주셔서 감사합니다.&nbsp;&nbsp;&nbsp;<font color="#3366FF"><%=res_nm%>님의 <%=gubun_nm%> 예약 요청이 접수되었습니다.  예약이 가능한지 확인하고 있습니다.</font>
        </div>
    <% elseif mode = "3" then %>
        <div style="font-size:13px; font-family:Noto Sans KR;">
            <%=GLOBAL_NM%>를 이용해주셔서 감사합니다.&nbsp;&nbsp;&nbsp;<font color="#3366FF"><%=res_nm%>님의 <%=gubun_nm%> 예약이 확정 완료되었습니다.</font>
        </div>
    <% elseif mode = "4" then %>
        <div style="font-size:13px; font-family:Noto Sans KR;">
            <%=GLOBAL_NM%>를 이용해주셔서 감사합니다.&nbsp;&nbsp;&nbsp;<font color="#FF0024"><%=res_nm%>님의 <%=gubun_nm%> 예약이 취소 처리되었습니다.</font>
        </div>
    <% elseif mode = "5" then %>
        <div style="font-size:13px; font-family:Noto Sans KR;"> 
            <%=GLOBAL_NM%>를 이용해주셔서 감사합니다.&nbsp;&nbsp;&nbsp;<font color="#3366FF"><%=res_nm%>님의 <%=gubun_nm%> 예약이 대기예약 중입니다.</font>
        </div>
    <% end if %>

    <div style="font-size:14px; font-family:Noto Sans KR;font-weight:500; padding:15px 0 5px 0">예약자 정보</div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <colgroup>
           <col width="15%">
           <col width="35%">
           <col width="15%">
           <col width="*%">
        </colgroup>
        <tbody>  
            <tr>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #000; border-right:1px solid #000; border-top:1px solid #000;border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">예약번호</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-top:1px solid #000;border-bottom:1px solid #000;"><%=reserve_code%></td>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-right:1px solid #000; border-top:1px solid #000;border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">예약일</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-top:1px solid #000;border-bottom:1px solid #000;"><%=ins_dt%></td>
            </tr>
            <tr>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #000; border-right:1px solid #000; border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">한글명</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-bottom:1px solid #000;"><%=res_nm%></td>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-right:1px solid #000; border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">휴대전화</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-bottom:1px solid #000;"><%=res_hp1%>-<%=res_hp2%>-<%=res_hp3%></td>
            </tr>
            <tr>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #000; border-right:1px solid #000; border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">이메일</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-bottom:1px solid #000;"><%=res_email%></td>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-right:1px solid #000; border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">진행현황</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-bottom:1px solid #000;"><%=prod_nm%></td>
            </tr>
        </tbody>
    </table>
             
    <%
        m_sql =" SELECT num, reserve_code, opt_seq ,opt_day from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N')  and opt_tp='F'"
        Set Rs = Server.CreateObject("ADODB.RecordSet")
                    
        Rs.open m_sql,objConn ,3
        If Rs.eof or Rs.bof then
            s_day = ""
        Else
            s_day = Rs("opt_day")
        End if
    %>

    <div style="font-size:14px; font-family:Noto Sans KR;font-weight:500; padding:15px 0 5px 0">예약 상세내역</div>

    <table width="100%"  border="0" cellpadding="0" cellspacing="0">
        <colgroup>
            <col width="15%">
            <col width="*%">
        </colgroup>
        <tbody>  
            <tr>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #000; border-right:1px solid #000; border-top:1px solid #000;border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">프로그램명</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-top:1px solid #000;border-bottom:1px solid #000;"><%=title%></td>
            </tr>
            <tr>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #000; border-right:1px solid #000; border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">출발일자</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-bottom:1px solid #000;"><%=s_day%></td>
            </tr>
            <tr>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #000; border-right:1px solid #000; border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">선택사항</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-bottom:1px solid #000;">
                    <%
                        m_sql =" SELECT num, reserve_code, opt_day ,opt_time,  opt_seq, opt_nm,  opt_ad_cnt, opt_ad_price "
                        m_sql = m_sql &" from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N') and opt_tp='F'"
                    
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open m_sql,objConn ,3
                        If Rs.eof or Rs.bof then
                        Else
                            Do until Rs.eof
                    
                                s_num = Rs("num")
                                s_opt_day = Rs("opt_day")
                                s_opt_time = Rs("opt_time")
                                s_opt_seq  = Rs("opt_seq")
                                s_opt_nm = Rs("opt_nm")
                    
                                s_ad_cnt = Rs("opt_ad_cnt")
                                s_ad_price = Rs("opt_ad_price")
                                s_per_ad_amt = Cdbl(s_ad_cnt ) * Cdbl(s_ad_price)
                                s_per_amt  =   Cdbl(s_per_ad_amt ) 
                                
                                If r_prod_cd="4" then
                                    ss_amt   = 0
                                Else
                                    ss_amt   = Cdbl(ss_amt) + Cdbl(s_per_amt)
                                End if
                    %>
                        <div><%=s_opt_nm%></div>
                        <% if s_ad_cnt <> "0" then %>
                            <div>성인 : <%=FormatNumber(s_ad_price,0)%> CP X <%=FormatNumber(s_ad_cnt,0)%>명</div>
                        <% end if %>  
                        <input type="hidden" name="s_num" value="<%=s_num%>"  >                                
                    <%
                             Rs.movenext
                          
                          LOOP
                       End if
                    %>
            </tr>
            <tr>
                <td style="font-size:13px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #000; border-right:1px solid #000; border-bottom:1px solid #000; background:#E8E8E8; font-weight:500;">결제 포인트</td>
                <td style="font-size:13px; font-family:Noto Sans KR; padding:4px 10px; border-right:1px solid #000; border-bottom:1px solid #000;"><%=FormatNumber(ss_amt,0)%> CP</td>
            </tr>
        </tbody>
    </table>

    <div style="font-size:14px; font-family:Noto Sans KR;text-align:center; font-weight:500;padding:20px 0 0 0;"><%=res_nm%>님께서는 취소료 규정에 동의하셨습니다.</div>
    <div style="font-size:13px; font-family:Noto Sans KR;padding:15px 0 5px 0">
        * 자세한 문의사항은 전화 <%=GLOBAL_TEL%>로 연락 주시거나 운영자에게 메일을 보내주시면 친절하고 정성껏 답변드리겠습니다.<br>
        * 소비자피해보상에 관한 소비자피해보상규정을 확인하시기 바랍니다.
    </div>
                
    <style type="text/css" media="print">
        .noprint {
            display: none;
        }
    </style>
                
    <form name="form1" method="post" action="mailing_view_ok.asp" style="display:inline; margin:0px;">
    <input type="hidden" name="mode" value="<%=mode%>">
    <input type="hidden" name="reserve_code" value="<%=reserve_code%>">
        <div class="noprint">
            <div style="height:30px;"></div>

            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <colgroup>
                    <col width="15%">
                    <col width="*%">
                    <col width="15%">
                </colgroup>
                <tbody>  
                    <tr>
                        <td style="color: #FFF; font-size:13px; font-family:Noto Sans KR; text-align:center; border-left:1px solid #000; border-right:1px solid #000; border-top:1px solid #000; border-bottom:1px solid #000; background:#808080; font-weight:500;">받는 메일</td>
                        <td style="padding:7px 15px; border-top:1px solid #000; border-bottom:1px solid #000;"><input type="text" name="email" value="<%=res_email%>" style="width:99%;" class="input_basic"></td>
                        <td style=" text-align:center; border-right:1px solid #000; border-top:1px solid #000; border-bottom:1px solid #000;"><span class="button_a"><a onclick="form1.submit();return false;">메일보내기</a></span></td>
                    </tr>
                    <tr>
                </tbody>
            </table>
        </div>
    
    </form>

    <div class="noprint" align="center" style="padding:25px 0 30px 0;">
        <span class="button_b" style="padding:0px 4px;"><a onClick="window.print();return false;">인쇄</a></span>
        <span class="button_b" style="padding:0px 4px"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
    </div>

</body>  
</html> 

<script language="JavaScript">
<!--
    function closeIframe(){
        parent.$('#chain_mailing').dialog('close');
        return false;
    }
-->
</script>
