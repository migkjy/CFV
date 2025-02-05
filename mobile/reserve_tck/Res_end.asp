<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/home/inc/partset.asp"-->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/home/inc/URLTools.asp"-->
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
    End If

    g_kind = Lcase(Request("g_kind")) 
    s_area = Lcase(Request("s_area")) 
%>
       
<!DOCTYPE html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />
<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sns_logo.png">
<meta property="og:description" content="<%=GLOBAL_NM%>">
<meta name="description" content="<%=GLOBAL_NM%>">
<meta name='keywords' content="<%=GLOBAL_NM%>">

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
</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">
    	
        <!--#include virtual="/mobile/include/left_menu.asp"-->
        <!-- #include virtual="/mobile/include/top_menu.asp"-->

        <% 
            OpenF5_DB objConn
            
            g_kind =  request("g_kind")
        
            res_cd = Request("res_cd")
            If res_cd = "" then
                Response.write "<script type='text/javascript'>"
                Response.write " alert('주요인자오류'); "
                Response.write " history.back();"
                Response.write " </script>	 "
                Response.end
            End if
        
            sql=" SELECT   r.seq, r.good_num, r.reserve_code,   r.res_nm, r.res_eng_nm_F , r.res_eng_nm_L ,r.res_hp1, r.res_hp2, r.res_hp3, r.res_email , res_hotel , res_pick_idx, res_pick_time ,r.res_remark "
            sql=sql&" ,r.res_amt, r.add_amt, r.dc_amt, r.prod_cd, r.ins_dt, g.title  "
            sql=sql&" FROM  w_res_tck001 AS r LEFT OUTER JOIN trip_gtck AS g ON r.good_num = g.num "
            sql=sql&" WHERE r.reserve_code ='"&res_cd&"'"
        
            Set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sql , objConn , 3
            
            If Rs.eof then 
            Else
                r_seq = Rs("seq")
                r_good_num = Rs("good_num")
                r_reserve_code = Rs("reserve_code")
        
                r_res_nm = Rs("res_nm")
                r_res_eng_nm_f = Rs("res_eng_nm_f")
                r_res_eng_nm_L = Rs("res_eng_nm_L")
        
        
                r_res_hp1 = Rs("res_hp1")
                r_res_hp2 = Rs("res_hp2")
                r_res_hp3 = Rs("res_hp3")
                r_tot_tel = r_res_hp1&"-"&r_res_hp2&"-"&r_res_hp3
                
                r_res_email = Rs("res_email")
                r_res_hotel = Rs("res_hotel") 
                
                r_pick_time = Rs("res_pick_time") 
                r_res_remark = Rs("res_remark")
                if not isnull(r_res_remark) or r_res_remark <> "" then   
                    r_res_remark = Replace(r_res_remark,chr(13)&chr(10),"<br>")
                end if
                    
                r_res_amt = Rs("res_amt")
                r_prod_cd = Rs("prod_cd")
                'prod_cd_nm = ch_procd_tnm(r_prod_cd)
        
                ins_dt = left(Rs("ins_dt"),10)
                good_nm = Rs("title")
            End if
        
             Rs.close : Set Rs = nothing
        %>

        <div class="container">
            <div id="title">
                <h3 class="cont_tit">
                    <span style="padding: 0 7px 0 0;">예약하기</span> 
                </h3>
                <div id="location">
                    <a href="/mobile/index.asp"><i class="xi-home "></i></a>
                    <i class="xi-angle-right-thin"></i> 예약하기
                </div>
            </div>
            <div style="border-top:2px solid #000;"></div>

            <div align="center" style="padding:20px 0 20px 0"><img src="/mobile/images/member/step_2.png" height="70"></div>

            <div style="border:1px solid #DDD; padding:20px 15px;">	
                <div class="re_txt3"><i class="xi-info-o xi-x"></i> 선택하신 상품정보를 확인하신 후 정보를 입력하여 예약을 진행해 주세요.</div>
                <div class="re_txt4">
                    * 해당 예약은 담당자가 확인 후 확정되며, 최종 예약 확정이 완료되면 문자 또는 전화로 안내해 드립니다.<br>
                    * 토, 일요일 및 법정공휴일에는 고객센터 휴무로 인해 취소/변경 신청이 불가능합니다.<br>
                    * 고객센터 취소/변경/환불업무 가능시간은 평일 09:00 ~ 18:00입니다. 유의해 주시기 바랍니다.
                </div>
            </div>

            <%
                sql = " Select g.num, g.title  from trip_gtck g where num="&r_good_num
            
                Set Rs = Server.CreateObject("ADODB.RecordSet")
                Rs.open sql,objConn ,3
            
                If Rs.eof or Rs.bof then
                Else
                    title = Rs("title")
                End if
            
                Rs.close : Set Rs=nothing
            %>

            <div class="re_gubun">예약 내역</div> 
            <div style="border-top:1px solid #000;"></div>
            <div class="my_list"> 
                <table>
                    <colgroup>
                        <col width="26%">
                        <col width="*">
                    </colgroup>
                    <tbody>  
                        <tr>
                            <td class="typ1">예약번호</td>
                            <td class="typ2"><%=res_cd%></td>
                        </tr>
                        <tr>
                            <td class="typ3">예약일</td>
                            <td class="typ4"><%=ins_dt%></td>
                        </tr>
                        <tr>
                            <td class="typ3">프로그램명</td>
                            <td class="typ4"><%=title%></td>
                        </tr>
                        <tr>
                            <td class="typ3">필수선택</td>
                            <td class="typ4">
                                <%
                                    op_amt = 0
                                    sql= "select num, reserve_code, opt_day, opt_seq, opt_nm, opt_ad_cnt, opt_ad_price  from w_res_tckopt "
                                    sql= sql&" where reserve_code='"&res_cd&"' and opt_tp='F' and opt_cancd='N' order by num asc"
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open sql , objConn , 3
                                
                                    If Rs.eof then
                                    Else
                                        s_opt_day = Rs("opt_day")
                                        s_opt_seq = Rs("opt_seq")
                                        s_opt_nm = Rs("opt_nm")
                                
                                        s_ad_cnt = Rs("opt_ad_cnt")
                                        s_ad_price = Rs("opt_ad_price")
                                        
                                        ad_amt = Cdbl(s_ad_cnt ) * Cdbl(s_ad_price )
                                        op_amt =   Cdbl(ad_amt )  
                                    End if
                                %>
                                <div style="padding:0 0 7px 0;">① <strong><%=s_opt_day%></strong>&nbsp;&nbsp;(<%=s_opt_nm%>)</div>
                                <div style="padding:0 0 7px 0;">② <% if s_ad_cnt <> "0" then  %>성인 :&nbsp;&nbsp;<%=s_ad_cnt%>명<% end if %></div>
                                <div style="padding:0 0 7px 0;">③ <span style="font-weight:700; color:#000;"><%=formatnumber(op_amt,0)%>&nbsp;CP</span></div>
                            </td>
                        </tr>
                    </tbody>
                 </table>  

                <div class="pt20"></div>
                <div class="re_title">예약자 정보</div> 
                <div style="border-top:1px solid #DDD;"></div>
                <div class="my_list"> 
                    <table>
                    	<colgroup>
                    		<col width="26%">
                    		<col width="*">
                    	</colgroup>
                    	<tbody>  
                            <tr>
                                <td class="typ1">한글명</td>
                                <td class="typ2"><%=r_res_nm%></td>
                            </tr>

                            <tr>
                                <td class="typ3">이메일</td>
                                <td class="typ4"><%=r_res_email%></td>
                            </tr>
                            <% if r_res_hotel<>"" then %>
                            <tr>
                                <td class="typ3">숙박호텔</td>
                                <td class="typ4"><%=r_res_hotel%></td>
                            </tr>
                            <% end if %>
                    	</tbody>
                    </table> 
                </div>

                <% if r_res_remark<>"" then %>
                    <div class="pt20"></div>            
                    <div class="re_title">추가 요청사항</div> 
                    <div style="border:1px solid #EAEAEA; padding:20px 20px;"><%=r_res_remark%></div>
                <% End If %>
                
                <div class="board_btn_w">
                    <ul class="btn_r">
                        <li><a href="/mobile/good_tck/ticket_list.asp?g_kind=<%=g_kind%>">목록</a></li>		
                        <li class="color"><a onclick="fn_mypage();" style="cursor:pointer;">예약확인</a></li>
                    </ul>
                </div>
            </div>

        <div class="pt50"></div>
        
    </div>
    
    <!--#include virtual="/mobile/include/foot_ci.asp"-->

</body>
</html>

<script language="javascript">
<!--
    function fn_mypage(){        	
        location.href="/mobile/mypage/my_page.asp?reserve_code=<%=reserve_code%>";
    }
//-->
</script> 