<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/conf/before_url.asp"--> 
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
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
    End if
%>

<!DOCTYPE html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />

<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sm_logo.png">
<meta property="og:description" content="<%=GLOBAL_NM%>">
<meta name="description" content="<%=GLOBAL_NM%>">
<meta name='keywords' content="<%=GLOBAL_NM%>">

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="shortcut icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">
<link rel="apple-touch-icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">

<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner1.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner2.css">

<script type="text/javascript" language="javascript" src="/mobile/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/slick.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/swiper.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/common.js"></script>

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script src="/home/js/jquery.fancybox.pack.js?v=2.1.4"></script>
<link rel="stylesheet" type="text/css" href="/home/js/jquery.fancybox.css?v=2.1.4" />  
</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">
    	
        <!--#include virtual="/mobile/include/left_menu.asp"-->
        <!--#include virtual="/mobile/include/top_menu.asp"-->

        <div class="best_main3">

            <div class="infor_title">마이페이지</div>
            <div style="border-bottom:2px solid #000;"></div>
            <div align="center" style="padding:20px 0 20px 0"><img src="/mobile/images/member/step_6.jpg" height="70"></div>

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
            <div class="re_gubun1">예약자 정보</div> 
            <div class="my_list"> 
                <table width="100%">
                    <colgroup>
                        <col width="25%">
                        <col width="*%">
                    </colgroup>
                    <tbody>  
                        <tr>
                            <td class="typ1">예약번호</td>
                            <td class="typ2"><%=reserve_code%></td>
                        </tr>
                        <tr>
                            <td class="typ3">예약일</td>
                            <td class="typ4"><%=ins_dt%></td>
                        </tr>
                        <tr>
                            <td class="typ3">한글명</td>
                            <td class="typ4"><%=res_nm%></td>
                        </tr>
                     
                        <tr>
                            <td class="typ3">이메일</td>
                            <td class="typ4"><%=res_email%></td>
                        </tr>
                        <tr>
                            <td class="typ3">진행현황</td>
                            <td class="typ4"><%=prod_nm%></td>
                        </tr>
                    <tbody>
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

            <div class="re_gubun">예약 내역</div>     
            <div style="border-top:1px solid #DDD;"></div>
            <div class="my_list"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <colgroup>
                        <col width="25%">
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
                            <td class="typ3">투어시간</td>
                            <td class="typ4"><%=opt_nm%></td>
                        </tr>
                        <tr>
                            <td class="typ3">상품금액</td>
                            <td class="typ4"><span style="font-weight:700; color:#2951BD;"><%=formatnumber(opt_ad_price,0)%>&nbsp;CP</span></td>
                        </tr>
                         <tr>
                            <td class="typ3">결제 포인트</td>
                            <td class="typ4"><span style="font-weight:700;color:#FF5001;"><%=FormatNumber(opt_ad_price,0)%>&nbsp;CP</span></td>
                        </tr>     		 
                    </tbody>
                </table>   
            </div>
           
            <% if res_remark<>"" then %>
                <div class="re_gubun">추가 요청사항</div> 
                <div style="padding:25px; border:1px solid #DDD;">
                    <%=replace(res_remark,vbCrLf,"<br>")%>
                </div>
            <% end if %>

            <div class="board_btn_w">
                <ul class="btn_r">
                    <li><a href="my_page.asp">목록</a></li>	
                    	
                    <% if r_prod_cd = "2" or r_prod_cd = "3"  Then ' 예약확정,완료%>
                        <li class="gray"><a onClick="javascript:listView('vaucher_tour.asp?g_kind=<%=g_kind%>&reserve_code=<%=reserve_code%>');" style="cursor:pointer;">바우처</a></li>
                    <% end If %>
                    
                    <% if r_prod_cd <>"4"  Then ' 취소아닐때%>
                        <li class="gray"> <a href="javascript:req_cancel();"><span style="color:#FFF;">예약취소</span></a></li>
                     <% end If %>
                </ul>
            </div>
            
            <% CloseF5_DB objConn %>

        </div>
        
        <!--#include virtual="/mobile/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

<script type="text/javascript">
    function req_cancel(){
        if(confirm("예약을 취소하시겠습니까?")){
            ifmchk_frm.location.href = "cancel.asp?reserve_code=<%=reserve_code%>";
        } 
    } 
        
    $(document).ready(function() {
        $('a#fancybox_list_view').fancybox({
            type: 'iframe',
            width:'900px',
            height : '100%'
        });
        $('a#btn_list_view_click').click(function() {
            listView(g_url);
        });
    });
    
    function listView(g_url) {
        if( g_url == null || g_url == '' ) return ;
        $('a#fancybox_list_view').attr('href',g_url);
        $('a#fancybox_list_view').click();
    }
</script>
<a id="fancybox_list_view" class="iframe" style="display:none;"></a>

<iframe name="ifmchk_frm" id="ifmchk_frm" src="about:blank"  allowTransparency=true width="0" height="0" marginwidth="0" marginheight="0" vspace="0" scrolling="yes" frameborder="0" framespacing="0" frameborder="0"></iframe>
