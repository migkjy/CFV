<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/home/inc/partset.asp"-->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/home/inc/URLTools.asp"-->

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
<html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sm_logo.png">
	
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">

<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script src="/home/js/jquery.fancybox.pack.js?v=2.1.4"></script>
<link rel="stylesheet" type="text/css" href="/home/js/jquery.fancybox.css?v=2.1.4" />  

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>
</head>

<body>

    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">
        	
            <div id="contBody">

                <div class="pt10"></div>
                <div class="infor_title">예약하기</div>
                <div style="border-bottom:2px solid #000;"></div>
                
                <% 
                    OpenF5_DB objConn  
                    
                    good_num = Request("good_num")
                    tmp_day = Request("tmp_day")
                    tmp_day2 = Replace(tmp_day,"-","")
                    
                    s_ymd =  Request("tmp_day")
                    s_ymd2 = Replace(s_ymd,"-","")
                    
                    
                    If  memid <> ""  then
                        m_sql = " SELECT  memid,birthday, kname,  htel,  gender, point  FROM TB_member where memid= '"&memid&"' "
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open m_sql , objConn , 3
                        
                        if Rs.eof then 
                        else
                            email_h = Rs("memid")
                            kname = Rs("kname")
                            birthday = Rs("birthday")
                            point = Rs("point")
                            gender = Rs("gender")
                            htel   = Rs("htel")
                            if InStr(htel,"-")>0 then
                                htel = split(htel,"-")
                                htel_1 = htel(0)
                                htel_2 = htel(1)
                                htel_3 = htel(2)
                            else
                                htel_1 = ""
                                htel_2 = ""
                                htel_3 = ""
                            end if
                        end if
                        Rs.close : Set Rs=nothing
                
                        tot_htel   = htel_1&"-"&htel_2&"-"&htel_3
                    
                    
                        sql2 = "select sum(use_money) from TB_save_money where tot_htel = '"&tot_htel&"' and  can_yn='N'"
                        Set Rs2 = Server.CreateObject("ADODB.RecordSet")
                        Rs2.open sql2,objConn,3
                        if Rs2.eof or Rs2.bof then
                        else
                            pay_point = Rs2(0)
                            if isNull(pay_point) then pay_point = 0 end if
                        end if
                        CloseRs Rs2 
                        total_point = int(point) - int(pay_point)
                    End if
                      
                        
                    good_data = Request("all_good_data")
                    f_opt_seq = Request("tot_opt_seq")
                    opt_data = Request("all_opt_data")
                  
                    If good_data="" or isnull(good_data) then
                        Response.write "<script language='javascript'>"
                        Response.write " alert('주요인자 오류...'); "
                        Response.write " history.back();"
                        Response.write " </script>	 "
                        Response.end
                    End if
                 
                    arr_good_data = split(good_data,"|")
                
                    good_num = arr_good_data(0)
                    good_ad_cnt = arr_good_data(1)
                    good_ch_cnt = arr_good_data(2)
                    good_ba_cnt = arr_good_data(3)
                
                    sql = " Select g.num, g.title ,g.exchange from trip_gtck g where num="&good_num
                    'response.write sql
                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                    Rs.open sql,objConn ,3
                
                    If Rs.eof or Rs.bof then
                        Response.write "<script language='javascript'>"
                        Response.write " alert('주요인자 전송에러!!...'); "
                        Response.write " history.back();"
                        Response.write " </script>	 "
                        Response.end
                    Else
                        g_title = Rs("title")
                    End if
                  
                    Rs.close  : Set Rs = nothing
                
                 
                    arr_opt_data = Split(opt_data,",")
                    opt_cnt = UBound(arr_opt_data)
                
                    Dim sub_sel_opt ,sub_sel_opt_ad_cnt,sub_sel_opt_ch_cnt,sub_sel_opt_ba_cnt
                    ReDim sub_sel_opt(cnt) ,sub_sel_opt_ad_cnt(cnt), sub_sel_opt_ch_cnt(cnt) ,sub_sel_opt_ba_cnt(cnt)
                %>
                
                    
                <div align="center" style="padding:40px 0 0 0">
                    <table  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td align="center"><div class="re_step1"><div style="padding:0 0 0 0;"><i class="xi-file-text-o xi-2x"></i><div><div></td>
                            <td width="66"><i class="xi-angle-right-thin xi-2x"></i></td>
                            <td align="center"><div class="re_step2"><div style="padding:0 0 0 0;"><i class="xi-calendar-check xi-2x"></i><div><div></td>
                        </tr>
                        <tr>
                            <td class="re_txt1">1. 정보입력 및 약관동의</td>
                            <td></td>
                            <td class="re_txt2">2. 예약완료</td>
                        </tr>
                    </table>
                </div>
                    
                <form name="res_form" method="post" style="display:inline; margin:0px;" >
                <input type="hidden" name="good_num" id="good_num" value="<%=good_num%>" >
                <input type="hidden" name="g_kind" value="<%=g_kind%>">
                <input type="hidden" name="sub_time" value="<%=sub_time%>"> 
                <input type="hidden" name="s_day" id="s_day"    value="<%=tmp_day%>" >
                <input type="hidden" name="opt_seq" id="opt_seq"  value="<%=f_opt_seq%>" >
                <input type="hidden" name="good_data" id="good_data" value="<%=good_data%>" >
                <input type="hidden" name="opt_data" id="opt_data"  value="<%=opt_data%>" >
                <input type="hidden" name="tmp_day" id="tmp_day"  value="<%=tmp_day%>" >
                <input type="hidden" name="d_gender" id="d_gender"  value="<%=gender%>" >
                <input type="hidden" name="d_birth" id="d_birth"  value="<%=birthday%>" >
                
                    <div class="re_gubun">프로그램 정보</div> 
                    <div style="border-top:1px solid #000;"></div>
                    <div class="book_list"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="15%">
                                <col width="*">
                            </colgroup>
                            <tbody>  
                                <tr>
                                    <td class="typd1">프로그램명</td>
                                    <td class="typd2"><%=g_title%></td>
                                </tr>
                                <tr>
                                    <td class="typd3">선택사항</td>
                                    <td class="typd4">
                                        <%
                                            f_sql = " SELECT d.seq, d.room_seq, d.good_cd, d.price_1, d.day, d.magam ,o.nm_c  from w_tck_day d left outer join  trip_gtck_opt o  on d.room_seq= o.seq "
                                            f_sql = f_sql&"  where d.room_seq="&f_opt_seq&" and d.day ='"&tmp_day2&"'  "
                                        
                                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                                            Rs.open f_sql,objConn,3
                                        
                                            If Rs.eof or Rs.bof then
                                                f_price_1 = 0
                                                f_price_2 = 0
                                                f_price_3 = 0
                                            Else
                                                magam = Rs("magam")
                                                f_price_1 = Rs("price_1")
                                                f_nm_c = Rs("nm_c")
                                                nm_c_k = left(f_nm_c,5)
                                                nm_c_h = right(f_nm_c,5)
                                                
                                                
                                                if magam ="Y" then
                                                    f_price_1 = 0
                                                else
                                                    f_price_1 = f_price_1
                                                end if
                                            End if
                                        
                                            
                                           sql =" SELECT  res_nm, tot_htel "  
                                           sql = sql &" FROM  w_res_tckopt "
                                           sql = sql &" WHERE res_nm ='"&cu_nm_kor&"' and opt_day ='"&s_ymd&"'  and  tot_htel ='"&cu_htel&"'" 
                                           sql = sql &" AND ( '"&nm_c_k&"' BETWEEN SUBSTRING(opt_nm, 1, 5) AND SUBSTRING(opt_nm, 7, 5)  OR '"&nm_c_h&"' BETWEEN SUBSTRING(opt_nm, 1, 5) AND SUBSTRING(opt_nm, 7, 5) or  (SUBSTRING(opt_nm, 1, 5) BETWEEN '"&nm_c_k&"' AND '"&nm_c_h&"' OR SUBSTRING(opt_nm, 7, 5) BETWEEN '"&nm_c_k&"'AND '"&nm_c_h&"'))  AND (opt_cancd='N')"
                                           
                                           
                                            ' response.write sql  &"<br>"
                                            ' response.end
                                          
                                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                                            Rs.open sql,objConn ,3
                                          
                                            If not Rs.eof or not Rs.bof then
                                                Response.write "<script type='text/javascript'>"
                                                Response.write " alert(' 동일시간대 중복예약이 있습니다.'); "
                                                Response.write " history.back();"
                                                Response.write " </script>	 "
                                                Response.end
                                            End if
                                            Rs.close   : Set Rs=nothing
                                       
                                       
                                            sql = "SELECT  total_man   FROM w_tck_day WHERE (good_cd = '"&good_num&"')  and (day ='"&s_ymd2&"') and room_seq ='"&f_opt_seq&"' "
                                            'response.write sql &"<br>"
                                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                                            Rs.open sql,objConn,3
                                       
                                            If Rs.eof then
                                                op_total_man =0
                                            Else
                                                op_total_man = Rs("total_man")
                                                if op_total_man="" or isnull(op_total_man) then
                                                    op_total_man=0    
                                                end if
                                            
                                                sql77 = "select  count(1) as op_seq_cnt  from  w_res_tckopt where opt_seq = '"&f_opt_seq&"' and opt_day= '"&s_ymd&"' AND (opt_cancd='N')"
                                                'response.write sql77 &"<br>"
                                                Set rs77 = objConn.Execute(sql77)
                                                op_seq_cnt = Trim(rs77("op_seq_cnt"))
                                                CloseRs Rs77
                                                curRestCnt = Int(op_total_man) - Int(op_seq_cnt)
                                        
                                                if int(curRestCnt) <= 0 then                               
                                                    Response.write "<script language='javascript'>"
                                                    Response.write " alert('블럭인원이 초과 되었습니다.'); "
                                                    Response.write " history.back();"
                                                    Response.write " </script>	 "
                                                    Response.end
                                                end if	
                                            End if  
                                            
                                            
                                            f_opt_amt_1 =  Cdbl(f_price_1) * Cdbl(good_ad_cnt)
                                            f_opt_amt   = Cdbl(f_opt_amt_1)
                                            
                                            If total_point < f_opt_amt then
                                                Response.write "<script language='javascript'>"
                                                Response.write " alert('포인트가 적습니다.예약이 불가합니다.'); "
                                                Response.write " history.back();"
                                                Response.write " </script>	 "
                                                Response.end
                                            End if
                                          
                                            res_amt = Cdbl(f_opt_amt) 
                                        %>
                                        <div style="padding:0 0 7px 0;">① <strong><%=tmp_day%></strong>&nbsp;&nbsp;(<%=f_nm_c%>)</div>
                                        <div style="padding:0 0 7px 0;">② <% if f_pricgood_ad_cnte_1 <> "0" then  %>성인 :&nbsp;&nbsp;<%=good_ad_cnt%>명<% end if %></div>
                                        <div>③ <span style="font-weight:700; color:#000; "><%=formatnumber(f_opt_amt,0)%> CP</span></div>
                                    </td>
                                </tr>                            
                                 <tr>
                                    <td class="typd3">보유 포인트</td>
                                    <td class="typd4"><span style="font-size:17px; font-weight:700;color:#1C55E6;"><%=FormatNumber(total_point,0)%>&nbsp;CP</span></td>
                                </tr>
                                <tr>
                                    <td class="typd3">결제 포인트</td>
                                    <td class="typd4"><span style="font-size:17px; font-weight:700;color:#FF5001;"><%=FormatNumber(res_amt,0)%>&nbsp;CP</span></td>
                                </tr>
                            </tbody>
                        </table> 
                    </div> 
                
                    <div class="pt30"></div>
                    <div class="re_title">예약자 정보</div> 
                    <div style="border-top:1px solid #DDD;"></div>
                    <div class="book_list"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="17%">
                                <col width="*">
                            </colgroup>
                            <tbody>  
                                <tr>
                                    <td class="typd1"><font color="#FF0000">*</font> 한글명</td>
                                    <td class="typd2"><input type="text" name="res_nm" value="<%=cu_nm_kor%>" style="width:22%;"  maxlength="40"  placeholder="한글명"></td>
                                </tr>
                                <tr>
                                    <td class="typd3"><font color="#FF0000">*</font> 이메일</td>
                                    <td class="typd4"><input type="text" name="tot_email" value="<%=email_h%>"  style="width:50%;" maxlength="25" class="onlyeng"  onKeyUp="LowerCase(this)"></td>
                                </tr>
                                      <input type="hidden" name="res_hp1" id="res_hp1" value="<%=htel_1%>" maxlength="3">
                                      <input type="hidden" name="res_hp2" id="res_hp2" value="<%=htel_2%>" maxlength="4">
                                      <input type="hidden" name="res_hp3" id="res_hp3" value="<%=htel_3%>" maxlength="4">
                                      <input type="hidden" name="res_hotel" id="res_hotel">
                            </tbody>
                        </table>   
                        <div class="small_txt">* 표시는 필수 입력사항입니다.</div> 
                    </div>
                
                    <div class="pt15"></div>
                    <div class="re_title">추가 요청사항</div> 
                    <div><textarea name="res_remark" style="width:100%; height:150px;border:1px solid #DDD;"><%=res_remark%></textarea></div>
                
                    <div class="pt15"></div>
                    <div class="re_title">약관동의</div> 
                
                    <div style="border:1px solid #DDD;padding:20px 30px 30px 30px;">
                        <div>
                            <ul>
                                <li class="dropdown1">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="*" class="terms_title">[필수] 개인정보 수집 및 이용안내</td>
                                            <td width="120px" class="terms_title"><label for="chk_11" style="cursor:pointer;">동의합니다.</label>&nbsp;&nbsp;&nbsp;<input type="radio" name="chk_ok1" id="chk_11" value="Y" style="outline:none; width: 18px; height: 18px; cursor:pointer; border:1px solid #DDD;"></td>
                                            <td width="200px" class="terms_title"><label for="chk_12" style="cursor:pointer;">동의하지 않습니다.</label>&nbsp;&nbsp;&nbsp;<input type="radio" name="chk_ok1" id="chk_12" value="N" style="outline:none; width: 18px; height: 18px; cursor:pointer; border:1px solid #DDD;"></td>
                                            <td width="22px"><a href="#" data-toggle="dropdown1"><span class="icon-arrow"><img src="/images/goods/b_open.png" height="15"></span></a></td>
                                        </tr>
                                    </table>
                                    <ul class="dropdown1-menu">
                                        <li>
                                            <div style="border-left:1px solid #EEE;border-right:1px solid #EEE;border-top:1px solid #EEE; padding:20px; border-radius:5px;">
                                                <div style="width:100%;OVERFLOW-Y:auto;height:145px">
                                                    <!--#include virtual="/home/reserve_tck/Agree_1.asp"-->
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                            
                        <div style="border-top:1px solid #EEE;"></div>
                        <div>
                            <ul>
                                <li class="dropdown1">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="*" class="terms_title">[필수] 고유식별정보 수집 및 이용안내</td>
                                            <td width="120px" class="terms_title"><label for="chk_21" style="cursor:pointer;">동의합니다.</label>&nbsp;&nbsp;&nbsp;<input type="radio"  name="chk_ok2" id="chk_21" value="Y" style="outline:none; width: 18px; height: 18px; cursor:pointer; border:1px solid #DDD;"></td>
                                            <td width="200px" class="terms_title"><label for="chk_22" style="cursor:pointer;">동의하지 않습니다.</label>&nbsp;&nbsp;&nbsp;<input type="radio" name="chk_ok2" id="chk_22" value="N" style="outline:none; width: 18px; height: 18px; cursor:pointer; border:1px solid #DDD;"></td>
                                            <td width="22px"><a href="#" data-toggle="dropdown1"><span class="icon-arrow"><img src="/images/goods/b_open.png" height="15"></span></a></td>
                                        </tr>
                                    </table>
                                    <ul class="dropdown1-menu">
                                        <li>
                                            <div style="border-left:1px solid #EEE;border-right:1px solid #EEE;border-top:1px solid #EEE; padding:20px; border-radius:5px;">
                                                <div style="width:100%;OVERFLOW-Y:auto;height:145px">
                                                    <!--#include virtual="/home/reserve_tck/Agree_2.asp"-->
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>       
                        
                        <div style="border-top:1px solid #EEE;"></div>
                        <div>
                            <ul>
                                <li class="dropdown1">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="*" class="terms_title">[필수] 개인정보 제3자 제공 및 공유안내</td>
                                            <td width="120px" class="terms_title"><label for="chk_31" style="cursor:pointer;">동의합니다.</label>&nbsp;&nbsp;&nbsp;<input type="radio"  name="chk_ok3" id="chk_31" value="Y" style="outline:none; width: 18px; height: 18px; cursor:pointer; border:1px solid #DDD;"></td>
                                            <td width="200px" class="terms_title"><label for="chk_32" style="cursor:pointer;">동의하지 않습니다.</label>&nbsp;&nbsp;&nbsp;<input type="radio" name="chk_ok3" id="chk_32" value="N" style="outline:none; width: 18px; height: 18px; cursor:pointer; border:1px solid #DDD;"></td>
                                            <td width="22px"><a href="#" data-toggle="dropdown1"><span class="icon-arrow"><img src="/images/goods/b_open.png" height="15"></span></a></td>
                                        </tr>
                                    </table>
                                    <ul class="dropdown1-menu">
                                        <li>
                                            <div style="border-left:1px solid #EEE;border-right:1px solid #EEE;border-top:1px solid #EEE; padding:20px; border-radius:5px;">
                                                <div style="width:100%;OVERFLOW-Y:auto;height:145px">
                                                    <!--#include virtual="/home/reserve_tck/Agree_3.asp"-->
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div> 
                        
                        <div style="border-top:1px solid #EEE;"></div>
                        <div>
                            <ul>
                                <li class="dropdown1">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="*" class="terms_title">[선택] 개인정보 활용 동의안내</td>
                                            <td width="120px" class="terms_title"><label for="chk_41" style="cursor:pointer;">동의합니다.</label>&nbsp;&nbsp;&nbsp;<input type="radio"  name="chk_ok4" id="chk_41" value="Y" style="outline:none; width: 18px; height: 18px; cursor:pointer; border:1px solid #DDD;"></td>
                                            <td width="200px" class="terms_title"><label for="chk_42" style="cursor:pointer;">동의하지 않습니다.</label>&nbsp;&nbsp;&nbsp;<input type="radio" name="chk_ok4" id="chk_42" value="N" style="outline:none; width: 18px; height: 18px; cursor:pointer; border:1px solid #DDD;"></td>
                                            <td width="22px"><a href="#" data-toggle="dropdown1"><span class="icon-arrow"><img src="/images/goods/b_open.png" height="15"></span></a></td>
                                        </tr>
                                    </table>
                                    <ul class="dropdown1-menu">
                                        <li>
                                            <div class="mgt20"></div>
                                            <div style="border-left:1px solid #EEE;border-right:1px solid #EEE;border-top:1px solid #EEE; padding:20px; border-radius:5px;">
                                                <div style="width:100%;OVERFLOW-Y:auto;height:145px">
                                                    <!--#include virtual="/home/reserve_tck/Agree_4.asp"-->
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div> 
                        
                        <div style="border-top:1px solid #EEE;"></div>
                        <div class="pt30"></div>
                        <div><span class="checks"><input type="checkbox" name="all_agree" id="all_agree" value="Y"><label for="all_agree"><span style="font-size:17px;font-weight: 700;">전체 약관에 동의합니다.</span></label></span></div>
                    </div>
                </form> 

                <div class="board_btn_w">
                    <ul class="btn_r">
                        <li><a href="/home/good_tck/ticket_view.asp?num=<%=good_num%>&g_kind=<%=g_kind%>&s_area=<%=s_area%>">목록</a></li>		
                        <li class="color"><a onclick="sendit();return false;" style="cursor:pointer;">예약</a></li>
                    </ul>
                </div>

                <div class="pt50"></div> 
                
                <% CloseF5_DB objConn %>
                
            </div>
            
        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>


<script type="text/javascript">
<!--
    var frm = document.res_form;
    
    function in_comma(str){
        uncomm_str = String(str);
        comm_str = "";
        loop_j = uncomm_str.length - 3;

        for(j=loop_j; j>=1 ; j=j-3){
            comm_str=","+uncomm_str.substring(j,j+3)+comm_str;
        }

        comm_str = uncomm_str.substring(0,j+3)+comm_str;
        return comm_str;
    }


    function sendit(){
        if (document.res_form.res_nm.value=="" ){
             alert("한글명을 입력해 주십시오 ");
             document.res_form.res_nm.focus();
             return false;
         }

     

         if (document.res_form.tot_email.value==""){
             alert("이메일을 입력해 주십시오 ");
             document.res_form.tot_email.focus();
             return false;
         }


         if ($('input:radio[name=chk_ok1]').is(':checked') == false){
             alert ("개인정보 수집 및 이용안내에 동의하셔야 예약이 가능합니다.");
             document.getElementsByName("chk_ok1")[0].focus();
             return false;
         }


         if ( $('input:radio[name=chk_ok2]').is(':checked') == false){
             alert ("고유식별정보 수집 및 이용안내 에 동의하셔야 예약이 가능합니다.");
             document.getElementsByName("chk_ok2")[0].focus();
             return false;
         }

         if ( $('input:radio[name=chk_ok3]').is(':checked') == false){
             alert ("개인정보 제3자 제공 및 공유안내 에 동의하셔야 예약이 가능합니다.");
             document.getElementsByName("chk_ok3")[0].focus();
             return false;
         }

         document.res_form.action="res_step_ok.asp"
         document.res_form.submit();
    }


    function onlyNumber(objtext1){ 
        var inText = objtext1.value; 
        var ret; 
   
        for (var i = 0; i < inText.length; i++) { 
            ret = inText.charCodeAt(i);
            
            if (!((ret > 47) && (ret < 58))){
                objtext1.value = 0;
                objtext1.focus();
                objtext1.value="";
                alert('숫자만 입력해 주십시오');
                return false;
            } 
        } 
        return true;
    }


    function getCommaFormat(n) {
        var reg = /(^[+-]?\d+)(\d{3})/;   
        n = String(n);        
        while (reg.test(n)) {
            n = n.replace(reg, '$1' + ',' + '$2');
        }
        return n;
    }


    $(function(){
        $("#all_agree").click(function(){
            var chk = $(this).is(":checked");//.attr('checked');
            if(chk) {
                $ ("input:radio[name='chk_ok1']:radio[value='Y']").prop("checked",true);
                $ ("input:radio[name='chk_ok2']:radio[value='Y']").prop("checked",true);
                $ ("input:radio[name='chk_ok3']:radio[value='Y']").prop("checked",true);
                $ ("input:radio[name='chk_ok4']:radio[value='Y']").prop("checked",true);
            }else {
                $ ("input:radio[name='chk_ok1']:radio[value='Y']").prop("checked",false);
                $ ("input:radio[name='chk_ok2']:radio[value='Y']").prop("checked",false);
                $ ("input:radio[name='chk_ok3']:radio[value='Y']").prop("checked",false);
                $ ("input:radio[name='chk_ok4']:radio[value='Y']").prop("checked",false);
            }
        });
    });
 
    function fn_chk(){ 
        if (document.res_form.same_chk.checked == true){
            $('#res_nm_kor_0').val(document.res_form.res_nm.value);
            $('#res_nm_eng_h_0').val(document.res_form.res_nm_eng_F.value);
            $('#res_nm_eng_t_0').val(document.res_form.res_nm_eng_L.value);
        }else{
            $('#res_nm_kor_0').val('');
            $('#res_nm_eng_h_0').val('')
            $('#res_nm_eng_t_0').val('')
        }
    } 
//-->
</script>


<%
    FUNCTION fnWriteOption(byVal count)
        for i = 1 to count
            fnWriteOption = fnWriteOption & "<option value="&i&">" & i & "</option>" & vbCrLf
        Next
    END FUNCTION
%>


<script type="text/javascript">
<!--
    $(document).ready(function() {
        $(".onlyeng").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
    });
//-->
</script>

<script type="text/javascript">
    var dropdown1 = document.querySelectorAll('.dropdown1');
    var dropdown1Array = Array.prototype.slice.call(dropdown1,0);
    
    dropdown1Array.forEach(function(el){
        var button = el.querySelector('a[data-toggle="dropdown1"]'),
        menu = el.querySelector('.dropdown1-menu'),
        arrow = button.querySelector('span.icon-arrow');
    
        button.onclick = function(event) {
            if(!menu.hasClass('show')) {
                menu.classList.add('show');
                menu.classList.remove('hide');
                arrow.classList.add('open');
                arrow.classList.remove('close');
                event.preventDefault();
            }
            else {
                menu.classList.remove('show');
                menu.classList.add('hide');
                arrow.classList.remove('open');
                arrow.classList.add('close');
                event.preventDefault();
            }
        };
    })
    
    Element.prototype.hasClass = function(className) {
        return this.className && new RegExp("(^|\\s)" + className + "(\\s|$)").test(this.className);
    };
</script> 
