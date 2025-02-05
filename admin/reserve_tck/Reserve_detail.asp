<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    'Session.codepage = 65001
    Response.CharSet = "utf-8" 
   'Response.CharSet = "euc-kr" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
        OpenF5_DB objConn
    
    reserve_code  = Request("reserve_code")
    if reserve_code = "" then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('주요인자오류'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    end if

    reserve_gubun ="30"
    symbol = "￦"

    '###################################################################################
    start_ymd  = Request("start_ymd")
    start_ymd2 = Request("start_ymd2")

    gotopage   = Request("gotopage")
    s_kind     = Request("s_kind")
    s_kind1    = Request("s_kind1")
    s_kind2    = Request("s_kind2") 
    s_kind3    = Request("s_kind3") 
    '###################################################################################


    sql =" SELECT  r.seq , r.good_num, r.reserve_code, r.g_kind, r.res_nm,  r.res_eng_nm_f, r.res_eng_nm_L , r.res_hp1, r.res_hp2, r.res_hp3, r.res_email ,r.res_hotel , r.res_pick_idx, r.res_pick_time "
    sql = sql &" ,r.res_remark  , r.res_amt, r.add_amt , r.dc_amt , r.prod_cd , r.v_vaucher_no, r.ins_dt , g.title , g.g_kind "
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
        r_seq        = Rs("seq")
        good_num     = Rs("good_num")
        reserve_code = Rs("reserve_code")

        g_kind       = Rs("g_kind")
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
        tot_tel = res_hp1&"-"&res_hp2&"-"&res_hp3

        res_email = Rs("res_email")
        res_hotel = Rs("res_hotel")
        pick_time = Rs("res_pick_time")
        
        res_remark = Rs("res_remark")
            if not isnull(res_remark) or res_remark <> "" then   
                res_remark = Replace(res_remark, chr(13)&chr(10),"<br>")
            end if

 
        res_amt = Rs("res_amt")
        add_amt = Rs("add_amt")
        dc_amt = Rs("dc_amt")
        r_prod_cd = Rs("prod_cd")
        
      '  response.write  r_prod_cd
        
        
        v_vaucher_no = Rs("v_vaucher_no")
        
        ins_dt = Left(Rs("ins_dt"),10)

        title = Rs("title")
        
     End if

     Rs.close : Set Rs = nothing
%>

<!DOCTYPE html>
<html>
<head>
<title><%=gubun_nm%> 예약관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
<style type="text/css">
    .rcls {color:#FF0000;}
    .pcls {color:#0000FF;}
    .bcls {color:#000000;}
    .gcls {color:#767676;} 
</style>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=gubun_nm%> 예약관리</div>

        <form name="res_form1" method="post" style="display:inline; margin:0px;" >
        <input type="hidden" name="g_kind" value="<%=g_kind%>">     
        
            <div class="table_box">
                <table>
                    <tr>
                        <td class="lop1" width="12%">예약번호</td>
                        <td class="lop2" width="38%"><%=reserve_code%> </td>
                        <td class="lop3" width="12%">예약일</td>
                        <td class="lop2" width="*%"><%=ins_dt%></td>
                    </tr>
                    <tr>
                        <td class="lob1">한글명</td>
                        <td class="lob2"><%=res_nm%> </td>
                        <td class="lob3">휴대전화</td>
                        <td class="lob2"><%=tot_tel%></td>
                    </tr>
                    <tr>
                        <td class="lob1">이메일</td>
                        <td class="lob2"><%=res_email%></td>
                        <td class="lob3">진행현황</td>
                        <td class="lob2">
                            <select name="prod_cd" onchange="change_prod();" class="select_basic" style="width:150px;">
                                <option value="0" <% If r_prod_cd = "0" Then %>selected<% End If %>>예약신청</option>
                                <option value="1" <% If r_prod_cd = "1" Then %>selected<% End If %>>예약확인</option>
                                <option value="3" <% If r_prod_cd = "3" Then %>selected<% End If %>>예약완료</option>
                                <option value="4" <% If r_prod_cd = "4" Then %>selected<% End If %>>예약취소</option>
                                <option value="5" <% If r_prod_cd = "5" Then %>selected<% End If %>>대기예약</option>
                            </select>
                            <input type="hidden" name="prod_cd_1" value="<%=r_prod_cd%>">
                        </td>
                    </tr>
                   <!--
                    <tr>
                        <td class="cop1">메일링</td>
                        <td class="cop2" colspan="3">
                            <span class="button_a" style="padding:0px 0px 0px 0px;"><a onclick="fn_mailing('1','<%=reserve_code%>');return false;">예약확인</a></span>
                            <span class="button_a" style="padding:0px 0px  0px 4px;"><a onclick="fn_mailing('3','<%=reserve_code%>');return false;">예약완료</a></span>
                            <span class="button_a" style="padding:0px 0px  0px 4px;"><a onclick="fn_mailing('4','<%=reserve_code%>');return false;">예약취소</a></span>
                            <span class="button_a" style="padding:0px 20px  0px 4px;"><a onclick="fn_mailing('5','<%=reserve_code%>');return false;">대기예약</a></span>
                            <% If r_prod_cd = "3"  Then %>
                                <span id="v_no"><strong>No.<%=v_vaucher_no%></strong></span>
                                <span class="button_e" style="padding:0px 0px 0px 20px;"><a onclick="fn_voucher('<%=g_kind%>','<%=reserve_code%>');">바우처 등록</a></span>
                                <span class="button_e" style="padding:0px 0px  0px 4px;"><a onclick="fn_voucher_mail('1','<%=g_kind%>','<%=reserve_code%>');return false;">바우처 메일 발송</a></span>
                            <% End If %>
                        </td>
                    </tr>-->
                </table>
            </div>
            
            <div class="pt25"></div>   
                
            <div align="center">
                <span class="button_b" style="padding:0px 4px"><a onclick="fn_name();return false;">예약자 수정</a></span>
                <span class="button_b" style="padding:0px 4px"><a href="javascript:fn_print();">인쇄</a></span>
                <span class="button_b" style="padding:0px 4px"><a href="reserve_list.asp?start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>">목록</a></span>
            </div>
            
            <iframe src="about:blank" name="ifm_add2" id="ifm_add2"  width="0" height="0" style="display:none"></iframe>
        </form>

        <div class="pt40"></div>
  
        <form name="res_form2" method="post" action="person_ok.asp" style="display:inline; margin:0px;" >
        <input type="hidden" name="reserve_code" value="<%=reserve_code%>">
        <input type="hidden" name="start_ymd" value="<%=start_ymd%>">
        <input type="hidden" name="start_ymd2" value="<%=start_ymd2%>">
        <input type="hidden" name="gotopage" value="<%=gotopage%>">
        <input type="hidden" name="s_kind" value="<%=s_kind%>">
        <input type="hidden" name="g_kind" value="<%=g_kind%>">
        <input type="hidden" name="s_kind1" value="<%=s_kind1%>">
        <input type="hidden" name="s_kind2" value="<%=s_kind2%>">
        <input type="hidden" name="s_kind3" value="<%=s_kind3%>">
            <%
                m_sql =" SELECT num, reserve_code, opt_seq ,opt_day from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N')  and opt_tp='F'"
                Set Rs = Server.CreateObject("ADODB.RecordSet")
            
                Rs.open m_sql,objConn ,3
                If Rs.eof or Rs.bof then
                    s_day = ""
                else
                    s_day = Rs("opt_day")
                End if
            %>
            <div class="table_tck">
                <table width="100%">
                    <tr height="36">
                        <td width="12%" class="lop1">프로그램명</td>
                        <td width="38%" class="lop2"><%=title%></td>
                        <td width="12%" class="lop1">출발일</td>
                        <td width="*%" class="lop2"><%=s_day%></td>
                    </tr>
                    <%
                        m_sql =" SELECT num, reserve_code, opt_day ,opt_time,  opt_seq, opt_nm,  opt_ad_cnt, opt_ad_price"
                        m_sql = m_sql &" from w_res_tckopt where reserve_code='"&reserve_code&"' and opt_tp='F'  AND (opt_cancd='N') "
                        ' RESPONSE.WRITE m_sql
                    
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
                    
                                s_ad_cnt   = Rs("opt_ad_cnt")
                                s_ad_price = Rs("opt_ad_price")
                               
                                s_per_ad_amt = Cdbl(s_ad_cnt ) * Cdbl(s_ad_price)
                                s_per_amt  =   Cdbl(s_per_ad_amt ) 
                    
                                '#############################################################필수금액 
                                If r_prod_cd="4" then
                                    ss_amt   = 0
                                Else
                                    ss_amt   = Cdbl(ss_amt) + Cdbl(s_per_amt)
                                End if
                                
                                
                               ' response.write  ss_amt
                    %>
                    <tr height="36">
                        <td class="loc1">인원</td>
                        <td class="lop2">성인 <%=s_ad_cnt%>명</td>
                        <td class="loc1">투어시간</td>
                        <td class="lop2"><%=s_opt_nm%></td>
                    </tr>
                    <tr height="36">
                        <td class="loc1">상품금액</td>
                        <td class="lop2"><%=FormatNumber(s_ad_price,0)%> CP</td>
                        <td class="loc1">결제 포인트</td>
                        <td class="lop2"><font color="#0000FF"><strong><%=FormatNumber(ss_amt,0)%> CP</strong></font><input type="hidden" name="s_num" value="<%=s_num%>"  ></td>
                    </tr>
                    <%
                	           Rs.movenext
                	        
                	        LOOP
                	     End if
                    %>
                </table>
            </div>
        </form>

        <div class="pt20"></div> 
            
        <% if res_remark <>"" then %>
             <div class="table_box">
                 <table>
                     <tr>
                         <td class="lop1" width="12%">추가 요청내역</td>
                         <td class="lop2" width="*%"><div style="padding:10px 0;"><%=res_remark%></div></td>
                     </tr>
                 </table>
             </div>
        
             <div class="pt20"></div> 
        <% end if %>
        
         <div class="table_tck">
             <table width="100%">
                 <tr>
                     <td class="lop1" width="12%">상담내역</td>
                     <td class="loz1" width="*%">
        
                        <table width="100%">
                            <%
                                d_sql="select idx ,user_id, user_nm, con_tents ,ins_dt from res_dat where res_tp='T' and res_cd='"&reserve_code&"' and del_yn='N' order by idx asc "
                                Set Rs = Server.CreateObject("ADODB.RecordSet")
                                Rs.open d_sql , objConn , 3
                            
                                If Rs.eof or Rs.bof then
                                Else 
                                    Do until Rs.eof 
                                        r_idx     = Rs("idx")
                                        r_user_nm = Rs("user_nm")
                                        r_content = Rs("con_tents")
                                        r_ins_dt  = Left(Rs("ins_dt"),10)
                            
                            %>
                            <tr height="36" id="dat_<%=r_idx%>">  
                                <td width="10%" class="line_1"><%=r_user_nm%></td>
                                <td width="*%" class="line_2"><%=r_content%></td>
                                <td width="10%" class="line_1"><%=r_ins_dt%></td>
                                <td width="7%" class="line_1"><span class="button_a"><a onclick="dat_memo('<%=r_idx%>','T')" style="cursor:pointer;">수정</a></span></td>
                                <td width="7%" class="line_3"><span class="button_a"><a onclick="dat_del('<%=r_idx%>')" style="cursor:pointer;">삭제</a></span></td>
                            </tr>
                            <%
                                         Rs.movenext
                                    Loop
                                End if
                            
                                Rs.close :Set Rs = nothing
                            %>
                            <tr>  
                                <td colspan="5" class="line_4"><span class="button_a"><a onClick="dat_memo('','T');">상담내역 등록</a></span></td>
                            </tr>
                        </table>
                     </td>
                 </tr>
             </table>
         </div>
         
        <div class="pt25"></div>   
            
        <div align="center">
            <span class="button_b" style="padding:0px 4px"><a href="javascript:fn_print();">인쇄</a></span>
            <span class="button_b" style="padding:0px 4px"><a href="reserve_list.asp?start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>">목록</a></span>
        </div>

    </div> 

</body>
</html>

<div id="chain_mailing" title="메일링"></div>
<div id="chain_vaucher" title="바우처"></div>
<div id="chain_print" title="예약현황"></div>
<div id="chain_memo" title="상담내역"></div>
<div id="chain_name" title="예약자 수정"></div>
<% 
    objConn.close  : Set objConn = Nothing 
%>


<script language="javascript">
<!--
    //메일링
    function fn_mailing(a,b){
        var _url1 = "mailing_view.asp?mode="+a+"&reserve_code="+b;
        $("#chain_mailing").html('<iframe id="modalIframeId1" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId1").attr("src",_url1);
    }
    $(document).ready(function(){
        $("#chain_mailing").dialog({
            autoOpen: false,
            modal: true,
            width: 850,
            height: 770
        });
    });
    

    //바우처
    function fn_voucher(a,b) {
        var _url7 = "voucher_ins.asp?g_kind="+a+"&reserve_code="+b;
        $("#chain_vaucher").html('<iframe id="modalIframeId7" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId7").attr("src",_url7);
    }
    $(document).ready(function(){
        $("#chain_vaucher").dialog({
            autoOpen: false,
            modal: true,
            width: 900,
            height: 770
        });
    });
    
    
    //바우처 메일
    function fn_voucher_mail(a,b,c) {
        var _url8 = "voucher_mail.asp?mode="+a+"&g_kind="+b+"&reserve_code="+c;
        $("#chain_vaucher").html('<iframe id="modalIframeId8" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId8").attr("src",_url8);
    }
    $(document).ready(function(){
        $("#chain_vaucher").dialog({
            autoOpen: false,
            modal: true,
            width: 900,
            height: 770
        });
    });
    

    //인쇄
    function fn_print() {
        var _url14 = "reserve_print.asp?g_kind=<%=g_kind%>&reserve_code=<%=reserve_code%>";
        $("#chain_print").html('<iframe id="modalIframeId14" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId14").attr("src",_url14);
    }
    $(document).ready(function(){
        $("#chain_print").dialog({
            autoOpen: false,
            modal: true,
            width: 850,
            height: 770
        });
    });
  
  
    //상담내역
    function dat_memo(n,t) {
        var _url15= "/admin/reserve_dat/dat_write.asp?res_cd=<%=reserve_code%>&res_tp="+t+"&emp_no=<%=emp_no%>&idx="+n;
        $("#chain_memo").html('<iframe id="modalIframeId15" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId15").attr("src",_url15);
    }
    $(document).ready(function(){
        $("#chain_memo").dialog({
            autoOpen: false,
            modal: true,
            width: 850,
            height: 550
        });
    });
  
    function dat_del(n) {
        var winEditor_memo = null;
        var param ="idx="+n;

        $.ajax({
            type: "POST",
            url: "/admin/reserve_dat/dat_del.asp",
            data: param,
            success: function(data) {
                if (data==0){
                    $('#dat_'+n).remove();
                    alert('삭제 되었습니다.');
                }else{
                    alert('삭제중 오류발생\n다시 시도해 주시기 바랍니다.');
                }
            },
            error : function() {
                alert('데이타 전송이 실패했습니다.\n다시 시도해 주시기 바랍니다.');
            }

        });
    }



    //예약자 수정
    function fn_name() {
        var _url16= "reserve_upd.asp?reserve_code=<%=reserve_code%>";
        $("#chain_name").html('<iframe id="modalIframeId16" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId16").attr("src",_url16);
    }
    $(document).ready(function(){
        $("#chain_name").dialog({
            autoOpen: false,
            modal: true,
            width: 900,
            height: 350
        });
    });

    function change_prod(){

        if(document.res_form1.prod_cd_1.value==document.res_form1.prod_cd.value){
            alert("현재의 진행현황과 수정하시려는 진행현황이 일치해서 수정할 수 없습니다");
            document.res_form1.prod_cd.focus();
            return false;
  
        }else{
  
            if(confirm("진행현황을 '"+document.res_form1.prod_cd.options[document.res_form1.prod_cd.selectedIndex].text+"'(으)로 수정하시겠습니까? ")){
                var t_value1;
                t_value1 =document.res_form1.prod_cd.value;
                document.res_form1.action = "ifm_addprice.asp?reserve_code=<%=reserve_code%>&prod_cd="+t_value1+"&tp=p";
                document.res_form1.target = "ifm_add2";
                document.res_form1.submit();
            }else{
                document.res_form1.reset();
                return;
            }
  
        }
    }


    function send2(){
        document.res_form2.submit();
    }
  
    function send3(){
        document.res_form3.submit();
    }

    function isNum(form1, val){
        var numic = "0123456789.,";
        var i=0;
        for(i=0;i < val.length; i++) {
            var loc = numic.indexOf(val.charAt(i));
            if(loc == -1) {
                alert('숫자만 입력하여주세요');
                form1.value = "";
                form1.focus();
                return false;
            }
        }
        return;
    }

 
    // 숫자에 컴마빼고 다시 계산후 컴마찍기.
    function CheckMoney(obj){
        var a=out_comma(obj.value);
        obj.value=in_comma(a);
    }


    //컴마 빼기
    function out_comma(str){
        comm_str = String(str);
        uncomm_str="";

        for(i=0; i<comm_str.length; i++)
        {
            substr=comm_str.substring(i,i+1);
            if(substr!=",")
            uncomm_str += substr;
        }

        return uncomm_str;
    }


    //컴마 넣기
    function in_comma(str){
        uncomm_str = String(str);
        comm_str = "";

        loop_j = uncomm_str.length - 3;

        for(j=loop_j; j>=1 ; j=j-3)
        {
            comm_str=","+uncomm_str.substring(j,j+3)+comm_str;
        }
        comm_str = uncomm_str.substring(0,j+3)+comm_str;

        return comm_str;
    }


    function pay_del(p,r,g){
        var r_url = "<%=request.ServerVariables("PATH_INFO")%>"

        answer = confirm(" 삭제하시겠습니까? ");
        if(answer==true){
            location.href="/admin/paymoney/pay_del.asp?pay_seq="+p+"&reserve_code="+r+"&r_gubun="+g;
        }
    }


    function ifm_addprice(){
        var f = document.reserveform
        f.action = "ifm_addprice.asp?reserve_code=<%=reserve_code%>";
        f.target = "ifm_add2";
        f.submit();
    }


   
 
 
    function toUpCase(object){
       object.value = object.value.toUpperCase(); 
    }
   
//-->
</script>

 