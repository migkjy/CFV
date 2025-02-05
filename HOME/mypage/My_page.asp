<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/conf/before_url.asp"--> 
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/home/inc/URLTools.asp"-->

<%
    Response.Expires = -1
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

   If memid = "" Or pwd = "" Or memnum = ""  Then
        response.write "<script language='javascript'>  "
        Response.write " alert('로그인정보없습니다..'); "
        response.write "  window.location.href='/';"
        response.write "</script>                             " 
        response.end
    end if
    
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
    <!--#include virtual="/home/include/right_menu.asp"--> 
    
    <div id="wrap">
        <div id="container">
        	
            <div id="contBody">

                <div class="pt10"></div>
                <div class="infor_title">마이페이지</div>
                <div style="border-bottom:2px solid #000;"></div>

                <div align="center" style="padding:40px 0 0 0">
                    <table  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="150" align="center"><div class="re_step1"><div><i class="xi-file-text-o xi-2x"></i><div><div></td>
                            <td width="66"><i class="xi-angle-right-thin xi-2x"></i></td>
                            <td align="center"><div class="re_step2"><div><i class="xi-calendar-check xi-2x"></i><div><div></td>
                        </tr>
                        <tr>
                            <td class="re_txt1">1. 예약내역</td>
                            <td></td>
                            <td class="re_txt2">2. 예약상세보기</td>
                        </tr>
                    </table>
                </div>
        
                <div class="pt40"></div>

                <% 
                    OpenF5_DB objConn   
                    
                    mem_nm = Trim(Request("mem_nm"))
                
                    res_phone1  = Trim(Request("res_phone1"))
                    res_phone2  = Trim(Request("res_phone2"))
                    res_phone3  = Trim(Request("res_phone3"))
                    tot_hp = res_phone1&"-"&res_phone2&"-"&res_phone3
                
                
                    sql = " SELECT  kname,memid,  htel,point ,pdf_yn,FileName,account_number,air_pdf_yn,air_FileName  FROM TB_member where memid= '"&memid&"' "
                    Set Rs = objConn.Execute(sql)
                           
                    mem_nm  = Trim(Rs("kname"))
                    tot_hp  = Trim(Rs("htel"))
                    point  = Trim(Rs("point"))
                    pdf_yn  = Trim(Rs("pdf_yn"))
                    FileName  = Trim(Rs("FileName"))
                    account_number  = Trim(Rs("account_number"))
                    
                    air_pdf_yn = Rs("air_pdf_yn")
                    air_FileName  = Trim(Rs("air_FileName"))
                    Rs.close  : Set Rs = nothing
                
         
                    sql2 = "select sum(use_money) from TB_save_money where tot_htel = '"&tot_hp&"' and  can_yn='N'"
                    Set Rs2 = Server.CreateObject("ADODB.RecordSet")
                    Rs2.open sql2,objConn,3
                    If Rs2.eof or Rs2.bof then
                    Else
                        pay_point = Rs2(0)
                        if isNull(pay_point) then pay_point = 0 end if
                    End if
                    CloseRs Rs2 
                    
                    total_point = int(point) - int(pay_point)
                %>

                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="49%" style="border:1px solid #DDD; padding:25px 30px;" valign="top">
                            <div class="point_title"><i class="xi-info xi-x"></i> <%=mem_nm%>님 포인트 현황</div>
                	          <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                	              <tr>
                	                  <td width="100"class="point_txt1">◦보유 포인트</td>
                	                  <td width="*" class="point_txt2"><%=FormatNumber(point,0)%>&nbsp;CP</td>
                	              </tr>
                	              <tr>
                	                  <td class="point_txt1">◦사용 포인트</td>
                	                  <td class="point_txt3"><%=FormatNumber(pay_point,0)%>&nbsp;CP</td>
                	              </tr>
                	              <tr>
                	                  <td class="point_txt1">◦잔여 포인트</td>
                	                  <td class="point_txt4"><%=FormatNumber(total_point,0)%>&nbsp;CP</td>
                	              </tr>
                	          </table>
                	          
                	          <div style="padding:10px 0 0 0;"></div> 
                            <div class="e-voa_pop"><a onclick="fn_pwd();return false;" style="cursor:pointer;"><i class="xi-paper xi-x"></i> <strong>비밀번호변경</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div> 
                        </td>

                        <%
                            sql5 = "select num, send_name, send_hp, app_gubn, ins_dt, cu_nm_kor, cu_hp, del_yn from TB_sel_memo where (send_hp = '"&tot_hp&"'  or  cu_hp  = '"&cu_htel&"')  and app_gubn = '1' and del_yn='N'"
                            'RESPONSE.WRITE SQL5
                            Set mRs = Server.CreateObject("ADODB.RecordSet")
                            mRs.open sql5,objConn,3
                            rs_cnt = mRs.RecordCount
                            'response.write rs_cnt
                            
                            If mRs.eof or mRs.bof then
 
                                cntSql = "select count(*) from TB_sel_memo where send_hp = '"&tot_hp&"'  and app_gubn = '0' and del_yn='N'"
                                ' response.write cntSql
                                Set cntRs = Server.CreateObject("ADODB.RecordSet")
                                cntRs.open cntSql,objConn
                                if cntRs.eof or cntRs.bof then
                                    me_Cnt = 0
                                else
                                    me_Cnt = cntRs(0)
                                end if
                                CloseRs cntRs
                                     
                                
                                cntSql = "select count(*) from TB_sel_memo where cu_hp = '"&tot_hp&"'  and app_gubn = '0' and del_yn='N'"
                                ' response.write cntSql
                                Set cntRs = Server.CreateObject("ADODB.RecordSet")
                                cntRs.open cntSql,objConn
                                if cntRs.eof or cntRs.bof then
                                    mek_Cnt = 0
                                else
                                    mek_Cnt = cntRs(0)
                                end if
                                CloseRs cntRs

                            Else

                                my_send_name = Trim(mRs("send_name"))
                                my_send_hp = Trim(mRs("send_hp"))
                                my_cu_nm_kor = Trim(mRs("cu_nm_kor"))
                                my_cu_hp = Trim(mRs("cu_hp"))
                  
                            End if   
                        %>
                        <td width="*%"> </td>
                        <td width="49%" style="border:1px solid #DDD; padding:25px 30px;" valign="top">
                            <div class="point_title"><i class="xi-hotel xi-x"></i> 룸메이트 매칭 현황</div>
                            <%  If rs_cnt <= 0 then %>
                                <div style="padding:0 0 7px 0;"><span class="mat_txt1">◦받은 매칭수 : </span><span class="mat_txt2"><%=me_Cnt%></span>건&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<% if me_Cnt > 0 then %><a onclick="fn_order();return false;" style="cursor:pointer;"><span class="matc_v1">보기</span></a><% end if %></div>
                                <div style="padding:0 0 13px 0;"><span class="mat_txt1">◦보낸 매칭수 : </span><span class="mat_txt3"><%=mek_Cnt%></span>건&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<% if mek_Cnt > 0 then %><a onclick="fn_order_k();return false;" style="cursor:pointer;"><span class="matc_v2">보기</span></a><% end if %></div>
                                <div style="font-size:14px;">◦요청한 상대방이 다른사람과 매칭이 되면 내가 요청한 매칭은 자동으로 사라집니다</div>
                            <% End if %>  
                              
                            <% If cstr(mem_nm) <>cstr(my_cu_nm_kor) then %>
                                <% if my_cu_nm_kor <>"" then%>
                                    <div class="mm_txt4">* <strong>"<%=mem_nm%>"</strong>님은 <strong>"<%=my_cu_nm_kor%>(<%=my_cu_hp%>)"</strong>님과 룸메이트 매칭이 되었습니다.</div>
                                <% end if %>
                            <% Else %>
                                <% if my_send_name <>"" then%>
                                    <div class="mm_txt4">* <strong>"<%=mem_nm%>"</strong>님은 <strong>"<%=my_send_name%>(<%=my_send_hp%>)"</strong>님과 룸메이트 매칭이 되었습니다.</div>
                                <% end if %>
                            <% end if %>     
                        </td>
                    </tr>
                </table>
                


<!--
                 <div class="pt25"></div>
                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="*%" style="border:1px solid #DDD; padding:25px 30px 35px 30px;" valign="top">
                            <div class="point_title"><i class="xi-flight-on xi-x"></i> 항공권</div>
                            <div style="font-size:14px;line-height:1.8em;">e-티켓 확인증은 탑승수속시, 입출국/세관 통과시 제시하도록 요구 될 수 있으므로<br>반드시 전 여행 기간 동안 소지하시기 바랍니다.</div>
                            <div style="padding:20px 0 0 0;">
                                <% if air_pdf_yn = "1" then %>
                                   <div class="e-voa_view"><a href="/upload/acc_excel/<%=air_FileName%>" target="_blank"><i class="xi-paper xi-x"></i> <strong>e-티켓 발행확인서 보기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></a></div>
                                <% else %>
                                    <span class="wallet_txt"><i class="xi-paper xi-x"></i> <strong>e-티켓 발행확인서가 없습니다&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></span>
                                <% end if %>
                            </div>
                        </td>

                        <td width="*%"> </td>
                        <td width="49%" style="border:1px solid #DDD; padding:25px 30px;" valign="top">
                            <div class="point_title"><i class="xi-speaker xi-x"></i> 여권정보</div>
                            <div style="font-size:14px;line-height:1.8em;">
                                ◦이미지를 선택 후 저장하기를 누르시면 게시물의 이미지를 삽입할 수 있습니다,<br>
                                ◦저장되는 이미지 형식은 gif, jpg, png 입니다.
                            </div>
    
                            <div style="padding:20px 0 0 0;">
                                <%
                                    Sql = "SELECT SessionID FROM W_GoodsImageBox where SessionID='"&cu_htel&"' and delok='False'"
                                    Set Rs1 = objConn.Execute(sql) 
                                    
                                    If  not Rs1.EOF or  not Rs1.BOF then
                                %>
                                    <div class="e-voa_view"><a onclick="fn_pass();return false;" style="cursor:pointer;"><i class="xi-paper xi-x"></i> <strong>여권 보기</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div> 
                                <% Else %>
                                    <div class="e-voa_pop"><a onclick="fn_pass();return false;" style="cursor:pointer;"><i class="xi-paper xi-x"></i> <strong>여권 등록</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div> 
                                <%
                                        Rs1.close
                                        Set Rs1 = nothing
                                    End if
                                %>
                            </div>
                        </td>
                    </tr>
                </table>
  -->


                <% 
                    sql="c"
                    u_sql="select res_nm , res_hp     from ("
                    u_sql=u_sql& " SELECT  name AS res_nm ,phone as res_hp , reserve_code AS res_cd FROM TB_reserve_reg "
                    u_sql=u_sql& " union "
                    u_sql=u_sql& " select  res_nm AS res_nm , res_hp1 + '-' + res_hp2 + '-' + res_hp3 AS res_hp , reserve_code AS res_cd FROM w_res_tck001 where del_yn='N'  "               
                    u_sql=u_sql& " ) tbl "
                   ' u_sql=u_sql& " where   res_hp ='"&tot_hp&"' and  res_nm = '"&mem_nm&"' "
                    u_sql=u_sql& " where   res_hp ='"&tot_hp&"' "
                
                    '  response.write u_sql
                    Set Rs_u = Server.CreateObject("ADODB.RecordSet")
                    Rs_u.open u_sql , objConn , 3
                
                    If Rs_u.eof then
                %>
                   <div class="re_gubun">예약현황</div>   

                    <div style="border-top:1px solid #000;"></div>
                    <div class="book_su">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                           <colgroup>
                               <col width="10%">
                               <col width="15%">
                               <col width="*">
                               <col width="10%">
                               <col width="10%">
                               <col width="10%">
                               <col width="10%">
                           </colgroup>
                           <thead>
                               <tr>
                                   <td class="typu1">투어일</td>
                                   <td class="typu1">시간</td>		
                                   <td class="typu1">프로그래 상품명</td>	
                                   <td class="typu1">사용 포인트</td>	
                                   <td class="typu1">예약번호</td>	
                                   <td class="typu1">예약일</td>	
                                   <td class="typu1">진행현황</td>
                               </tr>
                           </thead>
                           <tbody>
                                <tr>
                                    <td colspan="7"><div class="no_list">예약상품이 없습니다.</div></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                <% Else %>
                    <div class="pt50"></div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="50%"><div class="re_gubun2">예약현황</div> </td>
                            <td width="*%" align="right"><div class="box_schedule"><a onClick="javascript:listView('print_schedule.asp');" style="cursor:pointer;"><i class="xi-calendar-list xi-x"></i> 전체 일정 보기</a></div></td>
                        </tr>
                    </table>
                    <div class="pt20"></div>

                    <%
                        subsql = " and (res_hp1 + '-' + res_hp2 + '-' + res_hp3 = '"&tot_hp&"' ) "
                        reserve_gubun ="30"
 
                       sql = " select r.seq , r.good_num, r.reserve_code, r.g_kind, r.res_amt, r.add_amt , r.dc_amt , r.prod_cd ,r.del_yn, r.ins_dt , g.title  "
                       sql = sql & " FROM w_res_tck001 r left outer join trip_gtck g ON r.good_num = g.num "
                       sql = sql & " WHERE r.del_yn='N'  AND r.prod_cd <>'4'"
                       sql = sql & subsql
                       'sql = sql & " ORDER BY r.reserve_code desc "
                       sql = sql & " ORDER BY r.res_pick_place asc, r.res_pick_time asc"
                      ' response.write sql  res_pick_place, res_pick_time
                       Set Rs = Server.CreateObject("ADODB.RecordSet")
                           
                       Rs.open sql , objConn , 3
                       
                       If Rs.eof or Rs.bof then
                       Else
                   %>
                       <div style="border-top:1px solid #000;"></div>
                       <div class="sch_box">
                           <table width="100%" border="0" cellspacing="0" cellpadding="0">
                               <colgroup>
                                   <col width="10%">
                                   <col width="15%">
                                   <col width="*">
                                   <col width="10%">
                                   <col width="10%">
                                   <col width="10%">
                                   <col width="10%">
                               </colgroup>
                               <thead>
                                   <tr>
                                       <td class="typu1">투어일</td>
                                       <td class="typu1">시간</td>		
                                       <td class="typu1">프로그래 상품명</td>	
                                       <td class="typu1">사용 포인트</td>	
                                       <td class="typu1">예약번호</td>	
                                       <td class="typu1">예약일</td>	
                                       <td class="typu1">진행현황</td>
                                   </tr>
                               </thead>
                               <tbody>
                                   <%
                                       Do Until Rs.EOF
                                   
                                           seq = Rs("seq")
                                           good_num  = Rs("good_num")
                                           reserve_code = Rs("reserve_code")
                                   
                                           r_g_kind = Rs("g_kind")
                                   
                                           prod_cd = Rs("prod_cd")
                                           prod_nm = ch_procd_hnm(prod_cd)

                                           if prod_cd<>"4" then
                                               cls1 ="color:#000;"
                                           else
                                               cls1 ="color:#888;"
                                           end if
                                   
                                           ins_dt = Left(Rs("ins_dt"),10)
                                           title = Rs("title")
                                   
                                   
                                           sql2 = " select top 1 opt_day ,opt_nm,opt_ad_price from w_res_tckopt where reserve_code='"&reserve_code&"' and opt_cancd ='N' order by num asc "
                                        ' response.write sql2 &"<br>"
                                           Set Rs2 = Server.CreateObject("ADODB.RecordSet")
                                           Rs2.open sql2 , objConn , 3
                                           if Rs2.eof or Rs2.bof then
                                               opt_day=""
                                           else
                                               opt_day=Rs2("opt_day")
                                               opt_nm=Rs2("opt_nm")
                                               opt_ad_price=Rs2("opt_ad_price")
                                           end if
                                   
                                           Rs2.close   : Set Rs2=nothing    
                                   %>
                                   <tr>
                                       <td class="typu3"><a href="my_page_view.asp?g_kind=<%=r_g_kind%>&reserve_code=<%=Base64_Encode(reserve_code)%>"><span style="<%=cls1%>"><% if prod_cd<>"4" then%><%=opt_day%></span><% else %>0000-00-00<% end if %></span></a></td>
                                       <td class="typu4"><a href="my_page_view.asp?g_kind=<%=r_g_kind%>&reserve_code=<%=Base64_Encode(reserve_code)%>"><span style="<%=cls1%>"><% if prod_cd<>"4" then%><%=opt_nm%><% else %>00:00 - 00:00<% end if %></span></a></td>
                                       <td class="typu5"><a href="my_page_view.asp?g_kind=<%=r_g_kind%>&reserve_code=<%=Base64_Encode(reserve_code)%>"><span style="<%=cls1%>"><%=title%></span></a></td>
                                       <td class="typu4"><a href="my_page_view.asp?g_kind=<%=r_g_kind%>&reserve_code=<%=Base64_Encode(reserve_code)%>"><span style="<%=cls1%>"><%=formatnumber(opt_ad_price,0)%> CP</span></a></td>
                                       <td class="typu4"><a href="my_page_view.asp?g_kind=<%=r_g_kind%>&reserve_code=<%=Base64_Encode(reserve_code)%>"><span style="<%=cls1%>"><%=reserve_code%></span></a></td>
                                       <td class="typu4"><a href="my_page_view.asp?g_kind=<%=r_g_kind%>&reserve_code=<%=Base64_Encode(reserve_code)%>"><span style="<%=cls1%>"><%=ins_dt%></span></a></td>
                                       <td class="typu4"><a href="my_page_view.asp?g_kind=<%=r_g_kind%>&reserve_code=<%=Base64_Encode(reserve_code)%>"><span style="<%=cls1%>"><%=prod_nm%></span></a></td>
                                   </tr>
                                   <%
                                       Rs.movenext
                                       Loop
                                   %>
                               </tbody>
                           </table>
                       </div> 

                   <%
                       End if
                       
                       Rs.close : Set Rs = nothing
   
                    End if
                    CloseRs Rs_u
                %>
                <div class="pt80"></div>

            </div>
            
        </div>
                        
                        
        <%
           CloseF5_DB objConn
        %>                    
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
    
    
</body>
</html>

<div id="chain_maching" title="받은 매칭 승인"></div>
<div id="chain_maching1" title="보낸 매칭"></div>
<div id="chain_pass" title="여권정보"></div>
<div id="chain_pwd" title="비밀번호변경"></div>
 
<script language="javascript"> 
<!--
    function fn_pwd(){
        var _urlpwd = "/home/member/Member_password.asp";
        $("#chain_pwd").html('<iframe id="modalIframeIdpwd" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeIdpwd").attr("src",_urlpwd);
    }
    $(document).ready(function(){
        $("#chain_pwd").dialog({
            autoOpen: false,
            modal: true,
            width: 650,
            height: 400
        });
    });


    //여권등록
    function fn_pass(){
        var _urlpass = "/tourgramedit/Html/ScheduleAdd.asp?num=<%=Base64_Encode(cu_htel)%>";
        $("#chain_pass").html('<iframe id="modalIframeIdpass" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeIdpass").attr("src",_urlpass);
    }
    $(document).ready(function(){
        $("#chain_pass").dialog({
            autoOpen: false,
            modal: true,
            width: 650,
            height: 770
        });
    });

    function fn_order(){
        var _url2 = "/home/room_mate/my_matching.asp?send_hp=<%=tot_hp%>";
        $("#chain_maching").html('<iframe id="modalIframeId2" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId2").attr("src",_url2);
    }
    $(document).ready(function(){
        $("#chain_maching").dialog({
            autoOpen: false,
            modal: true,
            width: 800,
            height: 400 
        });
    });
    
    
    function fn_order_k(){
        var _url21 = "/home/room_mate/my_matching_send.asp?send_hp=<%=tot_hp%>";
        $("#chain_maching1").html('<iframe id="modalIframeId21" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId21").attr("src",_url21);
    }
    $(document).ready(function(){
        $("#chain_maching1").dialog({
            autoOpen: false,
            modal: true,
            width: 800,
            height: 400
        });
    });
//-->
</script> 

<script type="text/javascript">
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