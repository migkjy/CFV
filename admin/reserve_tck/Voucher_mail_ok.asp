<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    'Response.CharSet = "euc-kr" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
   OpenF5_DB objConn
    
    
    reserve_code  = Request("reserve_code")
   
    If reserve_code  = "" then
        response.write " <script language='javascript'>  "
        response.write "  alert('주요인자오류');"
        response.write "  self.close();"
        response.write " </script> " 
        response.end
    End if
 email  = Request("email")
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


    html = "<html>"
    html = html & "<head>"
    html = html & "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>"
    html = html & "<title></title>"
    html = html & "<link rel='stylesheet' href='"&global_url&"/admin/css/style_pop.css' type='text/css'>"
    html = html & "</head>"
    html = html & "<body leftmargin='0' topmargin='0' marginwidth='0' marginheight='0' style='padding:15px'>"
	  
      

    html = html & "<table width='816'' cellpadding='0' cellspacing='0' border='0'>"
    html = html & "    <tr>"
    html = html & "        <td>"
    
    html = html & "            <table width='816'' cellpadding='0' cellspacing='0' border='0' align='center' style='border-bottom:7px solid #dbd3a9;'>"
    html = html & "                <tr>"
    html = html & "                    <td width='*' style='font-family: Verdana; font-size: 40px; font-weight:700; letter-spacing:-0.05em;'>VOUCHER</td>"
    html = html & "                    <td width='320' style='padding:15px 0px 15px 0px; text-align:right;'><img src='"&global_url&"/images/logo/title_logo.png' border='0' height='45'></td>"
    html = html & "                </tr>"
    html = html & "            </table>"
                           
    html = html & "            <div style='font-family:Noto Sans KR; font-size:17px; font-weight:700; padding:30px 0 7px 0;'>예약자 정보</div>"
                           
    html = html & "            <div style='border-bottom:5px solid #595959;'></div>"
                           
    html = html & "            <table width='816'' border='0' cellpadding='0' cellspacing='0'>"
    html = html & "                <tr height='36'>"
    html = html & "                    <td width='12%' style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;'><strong>이름</strong></td>"
    html = html & "                    <td width='38%' style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; padding:0 10px;'>"
                           
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
                           
    html = html & "                        <div>"&d_nm&"&nbsp;("&d_gender&")</div>"
                           
                                                           Rs.MoveNext
                                                           i=i+1
                                                           Loop
                            
                                                       End if
                           
    html = html & "                    </td> "
    html = html & "                    <td width='12%' style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;;'><strong>인원</strong></td> "
    html = html & "                    <td width='*%' style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; border-right:1px solid #C5BF9E; padding:0 10px;'> "
                           
                                                       m_sql =" SELECT num, reserve_code, opt_day ,opt_time,  opt_seq, opt_nm,  opt_ad_cnt, opt_ad_price  "
                                                       m_sql = m_sql &" from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N') and opt_tp='F'"
                            
                                                       Set Rs = Server.CreateObject("ADODB.RecordSet")
                                                       Rs.open m_sql,objConn ,3
                                                       
                                                       If Rs.eof or Rs.bof then
                                                       Else
                                                           Do until Rs.eof
                            
                                                               s_num = Rs("num")
                                                               s_ad_cnt = Rs("opt_ad_cnt")
                            
    html = html & "                            "&FormatNumber(s_ad_cnt,0)&"명 "
    html = html & "                            <input type='hidden' name='s_num' value='"&s_num&"'> "
                           
                                                           Rs.movenext
                                  
                                                           loop
                                                       End if
                           
    html = html & "                    </td> "
    html = html & "                </tr> "
    html = html & "            </table> "
                           
                           
    html = html & "            <div style='font-family:Noto Sans KR; font-size:17px; font-weight:700; padding:30px 0 7px 0;'>예약 투어 정보</div> "
    html = html & "            <div style='border-bottom:5px solid #595959;'></div> "
                           
    html = html & "            <table width='816'' border='0' cellpadding='0' cellspacing='0'> "
    html = html & "                <tr height='36'> "
    html = html & "                    <td style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;'><strong>투어명</strong></td> "
    html = html & "                    <td style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; padding:0 10px;' colspan='3'>"&title&"</td> "
    html = html & "                </tr> "
    html = html & "                <tr height='36'> "
    html = html & "                    <td width='12%' style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;'><strong>투어일</strong></td> "
    html = html & "                    <td width='38%' style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; padding:0 10px;'>"&s_day&"</td> "
    html = html & "                    <td width='12%' style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;'><strong>선택시간</strong></td> "
    html = html & "                    <td width='*%' style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; border-right:1px solid #C5BF9E; padding:0 10px;'>"&res_pick_time&"</td> "
    html = html & "                </tr> "
    html = html & "                <tr height='36'> "
    html = html & "                    <td style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;'><strong>픽업장소</strong></td> "
    html = html & "                    <td style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; padding:0 10px;'>"&v_vaucher_no&"</td> "
    html = html & "                    <td style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;'><strong>소요시간</strong></td> "
    html = html & "                    <td style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; border-right:1px solid #C5BF9E; padding:0 10px;'>"&v_issue_date&"</td> "
    html = html & "                </tr>  "
    html = html & "                <tr height='36'> "
    html = html & "                    <td style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; background: #D6D0AE; text-align:center;'><strong>REMARK</strong></td> "
    html = html & "                    <td style='font-family:Noto Sans KR; font-size:13px; border-left:1px solid #C5BF9E; border-bottom:1px solid #C5BF9E; border-right:1px solid #C5BF9E; padding:7px 10px;' colspan='3'>"&v_remark&"</td> "
    html = html & "                </tr> "
    html = html & "            </table> "
                           
    html = html & "            <div style='padding:20px 0 0 0;'></div> "
    html = html & "            <div style='font-family:Noto Sans KR; font-size:16px; font-weight:600; padding:7px 0; background: #b4cae4; text-align:center;'>투어 안내사항</div> "
    html = html & "            <div style='font-family:Noto Sans KR; font-size:13px; padding:10px 0;'>"&v_detail&"</div> "
                           
    html = html & "            <div style='padding:10px 0 0 0;'></div> "
    html = html & "            <div style='font-family:Noto Sans KR; font-size:16px; font-weight:600; padding:7px 0; background: #c8d8a8; text-align:center;'>투어 주의사항</div> "
    html = html & "            <div style='font-family:Noto Sans KR; font-size:13px; padding:10px 0;'> "
    html = html & "                * 요청사항은 상황에 따라 100% 반영되지 않는 경우도 있습니다.<br> "
    html = html & "                * 예약 후 현지에서 어떤 사유로 인해 불참해도 환불되지 않습니다.<br> "
    html = html & "                * 현지에서 직접 변경으로 인한 수수료/불이익은 "&global_NM&"에서 책임지지 않습니다.<br> "
    html = html & "                * 현지에서 여권의 제시 또는 카피를 요구할 수 있으니 양해바랍니다.<br> "
    html = html & "                * 현지기상 또는 기타 상황에 따라 일정이 변경되거나 취소 될 수 있습니다.<br> "
    html = html & "                * 우천시에도 진행되며, 투어가 불가능할 정도의 악천후시 저희가 전일 혹은 당일 오전에 취소 안내를 드립니다.<br> "
    html = html & "                * 기상악화로 인해 취소 되는 경우 100% 환불 됩니다. <br> "
    html = html & "                * 가이드의 안전관련 유의사항 안내를 잘 지켜주세요.<br> "
    html = html & "                * 유의사항을 지키지 않아서 발생하는 안전사고 시 당사는 책임지지 않습니다. "
    html = html & "            </div> "
                           
    html = html & "            <div style='padding:10px 0 0 0;'></div> "
    html = html & "            <div style='font-family:Noto Sans KR; font-size:16px; font-weight:600; padding:7px 0; background: #eacfce; text-align:center;'>투어 비상 연락망</div> "
    html = html & "            <div style='font-family:Noto Sans KR; font-size:13px; padding:10px 0 15px 0;'> "
    html = html & "                * "&global_NM&" 연락처 : "&global_tel&"<br> "
    html = html & "                * 연락처는 현지에서 한국어가 가능한 가이드님께서 친절하고 신속하게 도움을 드릴 예정입니다.<br> "
    html = html & "                * 예약투어명 > 예약자 성함 > 긴급문의 순으로 천천히 전달 부탁드립니다.<br> "
    html = html & "                * 평일 영업시간에는 카톡으로 문의주셔도 긴급사항은 빠른 조치 안내를 받으실 수 있습니다.<br> "
    html = html & "                * 미팅포인트에서 가이드/차량을 만나지 못했을때, 투어 중 긴급사정이 생겼을때 연락 부탁드립니다. "
    html = html & "            </div> "
    html = html & "        </td> "
    html = html & "    </tr> "
    html = html & "</table> "

   
    
    html = html & "</body></html>"


 'response.write html
'response.end
'===================================================================sendmail


  Dim iMsg
  Dim iConf
  Dim Flds

	Const cdoSendUsingPickup = 1
	 

	
	set iMsg = server.CreateObject("CDO.Message")
	set iConf = createobject("CDO.Configuration")
	
	
	Set Flds = iConf.Fields
	 With Flds

		.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2

		.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "127.0.0.1" 

		.update

	End With
	
	With iMsg
	Set .Configuration = iConf
	    .To = email
	    .From = GLOBAL_MAIL
	    .Subject = GLOBAL_NM&"에서 발송한 Voucher  입니다."
	    .HTMLBody = html
	    .BodyPart.Charset="utf-8" 
      .HTMLBodyPart.Charset="utf-8" 
	
	
	
	
	  .Send

	End With

	Set iMsg = Nothing
	Set iConf = Nothing
	Set Flds = Nothing	


'=============================================================================
%>

<script language="javascript">
<!--
    alert("'<%=trim(Request("email"))%>'(으)로 메일이 전송되었습니다.");
    parent.$('#chain_vaucher').dialog('close');
//-->
</script>
 