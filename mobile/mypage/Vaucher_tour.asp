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
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link type="text/css" rel="stylesheet" href="<%=global_url%>/css/style.css" />
</head>

<body>
	
    <div style="padding:10px;">

        <table width="100%" cellpadding="0" cellspacing="0" border="0" align="center" style="border-bottom:7px solid #dbd3a9;">
            <tr>
                <td width="*" style="font-family: Verdana; font-size:1.56em; font-weight:700; letter-spacing:-0.05em;">VOUCHER</td>
                <td width="30%" style="padding:15px 0px 15px 0px; text-align:right;"><img src="<%=global_url%>/images/logo/title_logo.png" border="0" height="30"></td>
            </tr>
        </table>

        <div style="font-family:Noto Sans KR; font-size:0.94em; font-weight:700; padding:20px 0 7px 0;">예약자 정보</div>
         
        <div style="border-bottom:5px solid #595959;"></div>
        
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr height="36">
                <td width="15%" style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;"><strong>이름</strong></td>
                <td width="35%" style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; padding:0 10px;">
                    <%
                        d_sql = "select idx , d_age, d_gender, d_nm from w_res_tck002 where reserve_code='"&reserve_code&"' "
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open d_sql,objConn,3
                        
                        If Rs.eof then
                        Else
                            i=0
                            Do until Rs.eof
                        
                                d_num = Rs("idx")
                                d_gender   = Ucase(Rs("d_gender"))                                 
                                d_nm = Rs("d_nm")
                    %>
                    <div><%=d_nm%>&nbsp;(<%=d_gender%>)</div>
                    <%
                                Rs.MoveNext
                                i=i+1
                            Loop
                    
                        End if
                    %>
                </td>
                <td width="15%" style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;;"><strong>인원</strong></td>
                <td width="*%" style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; border-right:1px solid #C5BF9E; padding:0 10px;">
                    <%
                        m_sql =" SELECT num, reserve_code, opt_day ,opt_time,  opt_seq, opt_nm,  opt_ad_cnt, opt_ad_price  "
                        m_sql = m_sql &" from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N') and opt_tp='F'"
                    
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open m_sql,objConn ,3
                        If Rs.eof or Rs.bof then
                        Else
                            Do until Rs.eof
                    
                                s_num = Rs("num")
                                s_ad_cnt = Rs("opt_ad_cnt")
                    
                    %>
                        <% if s_ad_cnt <> "0" then %><%=FormatNumber(s_ad_cnt,0)%>명<% end if %>
                        <input type="hidden" name="s_num" value="<%=s_num%>"  >
                    <%
                             Rs.movenext
                          
                          loop
                       End if
                    %>
                </td>
            </tr>
        </table>
        
        
        <div style="font-family:Noto Sans KR; font-size:0.94em; font-weight:700; padding:20px 0 7px 0;">예약 투어 정보</div>
        <div style="border-bottom:5px solid #595959;"></div>
        
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr height="36">
                <td style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;"><strong>투어명</strong></td>
                <td style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; padding:0 10px;" colspan="3"><%=title%></td>
            </tr>
            <tr height="36">
                <td width="15%" style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;"><strong>투어일</strong></td>
                <td width="35%" style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; padding:0 10px;"><%=s_day%></td>
                <td width="15%" style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;"><strong>선택시간</strong></td>
                <td width="*%" style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; border-right:1px solid #C5BF9E; padding:0 10px;"><%=res_pick_time%></td>
            </tr>
            <tr height="36">
                <td style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;"><strong>픽업장소</strong></td>
                <td style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; padding:0 10px;"><%=v_vaucher_no%></td>
                <td style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;"><strong>소요시간</strong></td>
                <td style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; border-right:1px solid #C5BF9E; padding:0 10px;"><%=v_issue_date%></td>
            </tr> 
            <tr height="36">
                <td style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;"><strong>REMARK</strong></td>
                <td style="font-family:Noto Sans KR; font-size:0.69em; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; border-right:1px solid #C5BF9E; padding:7px 10px;" colspan="3"><%=v_remark%></td>
            </tr>
        </table>
        
        <div style="padding:20px 0 0 0;"></div>
        <div style="font-family:Noto Sans KR; font-size:0.94em; font-weight:600; padding:7px 0; background: #b4cae4; text-align:center;">투어 안내사항</div>
        <div style="font-family:Noto Sans KR; font-size:0.69em; padding:10px 0;"><%=v_detail%></div>
         
        <div style="padding:10px 0 0 0;"></div>
        <div style="font-family:Noto Sans KR; font-size:0.94em; font-weight:600; padding:7px 0; background: #c8d8a8; text-align:center;">투어 주의사항</div>
        <div style="font-family:Noto Sans KR; font-size:0.69em; padding:10px 0;">
            * 요청사항은 상황에 따라 100% 반영되지 않는 경우도 있습니다.<br>
            * 예약 후 현지에서 어떤 사유로 인해 불참해도 환불되지 않습니다.<br>
            * 현지에서 직접 변경으로 인한 수수료/불이익은 <%=global_NM%>에서 책임지지 않습니다.<br>
            * 현지에서 여권의 제시 또는 카피를 요구할 수 있으니 양해바랍니다.<br>
            * 현지기상 또는 기타 상황에 따라 일정이 변경되거나 취소 될 수 있습니다.<br>
            * 우천시에도 진행되며, 투어가 불가능할 정도의 악천후시 저희가 전일 혹은 당일 오전에 취소 안내를 드립니다.<br>
            * 기상악화로 인해 취소 되는 경우 100% 환불 됩니다. <br>
            * 가이드의 안전관련 유의사항 안내를 잘 지켜주세요.<br>
            * 유의사항을 지키지 않아서 발생하는 안전사고 시 당사는 책임지지 않습니다.
        </div>
        
        <div style="padding:10px 0 0 0;"></div>
        <div style="font-family:Noto Sans KR; font-size:0.94em; font-weight:600; padding:7px 0; background: #eacfce; text-align:center;">투어 비상 연락망</div>
        <div style="font-family:Noto Sans KR; font-size:0.69em; padding:10px 0 15px 0;">
            * <%=global_NM%> 연락처 : <%=global_tel%><br>
            * 연락처는 현지에서 한국어가 가능한 가이드님께서 친절하고 신속하게 도움을 드릴 예정입니다.<br>
            * 예약투어명 > 예약자 성함 > 긴급문의 순으로 천천히 전달 부탁드립니다.<br>
            * 평일 영업시간에는 카톡으로 문의주셔도 긴급사항은 빠른 조치 안내를 받으실 수 있습니다.<br>
            * 미팅포인트에서 가이드/차량을 만나지 못했을때, 투어 중 긴급사정이 생겼을때 연락 부탁드립니다.
        </div>
    </div>
        
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