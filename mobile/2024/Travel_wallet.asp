<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/conf/before_url.asp"--> 
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/home/inc/URLTools.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->  

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private" 
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

</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">
    	
        <!--#include virtual="/mobile/include/left_menu.asp"-->
        <!--#include virtual="/mobile/include/top_menu.asp"-->
       
        <%
            OpenF5_DB objConn

            sli_sql ="SELECT top 8 count(num) from main_new_img where g_kind='40' and sub_kind='P' and use_yn='Y'"
            Set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sli_sql , objConn , 3
            ss_cnt = Rs(0)
            rs.close : Set rs=nothing
             
            ReDim e_img(ss_cnt), e_url(ss_cnt), e_title(ss_cnt), e_remark(ss_cnt)
             
            sql =" select  i_img, title, remark  from  main_new_img WHERE  (g_kind = 40) and sub_kind='P' and use_yn='Y' order by num asc"
            Set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sql,objConn,3
             
            If rs.EOF Then
            Else
                i =0
                Do until Rs.eof
             
                    r_img = Rs("i_img")
                    r_title = Rs("title")
                    r_remark = Rs("remark")
             
                    e_img(i)   = r_img
                    e_title(i) = r_title
                    e_remark(i) = r_remark
                    if not isnull(e_remark(i)) or e_remark(i) <> "" then   
                        e_remark(i) = replace(e_remark(i),chr(13)&chr(10),"<br>")
                    end if
                    
                Rs.movenext
                i = i +1
                Loop
            End if
             
            Rs.close : Set Rs=nothing
            
            CloseF5_DB objConn
        %>
        <div style="width:100%;height:200px;background:url('/board/upload/main_img/<%=e_img(1)%>') no-repeat;background-position:top center;background-size:cover;">
            <div align="center">
                <table width="100%" height="200" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
                    <tr>
                        <td>
                            <div align="center">
                                <div class="sub_top_en"><%=e_title(1)%></div>
                                <div class="sub_top_ko"><%=e_remark(1)%></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>  
  
        <div class="best_main4">
            <%
                tbl = "trip_notice"  
                num = 9
            
                OpenF5_DB objConn
            
                sql="select num, title ,con_tents from "&tbl&" where num="&num&" and g_kind=20 and del_yn='N'   "
                Set Rs = objConn.Execute(Sql)
                If rs.eof or rs.bof then
                    Response.write "<script type='text/javascript'>"
                    Response.write " alert('접근하실수 없습니다.'); "
                    Response.write " history.back(); "
                    Response.write " </script>	 "
                    Response.End
                Else
                   num = Rs("num")
                   title = Rs("title")
                   con_tents = Rs("con_tents")
                End if
            
                CloseRs Rs
            
                sql = " update "&tbl&" Set hit = hit + 1  where num ="&num
                objConn.Execute(sql)
            %> 

            <div class="etc_body"><%=con_tents%></div>
 
 <!--
            <div class="pt40"></div>
            <% 
                mem_nm = Trim(Request("mem_nm"))
                
                res_phone1 = Trim(Request("res_phone1"))
                res_phone2 = Trim(Request("res_phone2"))
                res_phone3 = Trim(Request("res_phone3"))
                tot_hp = res_phone1&"-"&res_phone2&"-"&res_phone3
                
                
                sql = " SELECT  kname,memid,  htel,point ,pdf_yn,FileName,account_number  FROM TB_member where memid= '"&memid&"' "
                Set Rs = objConn.Execute(sql)
                       
                mem_nm  = Trim(Rs("kname"))
                tot_hp  = Trim(Rs("htel"))
                point  = Trim(Rs("point"))
                pdf_yn  = Trim(Rs("pdf_yn"))
                FileName  = Trim(Rs("FileName"))
                account_number  = Trim(Rs("account_number"))
                
                Rs.close  : Set Rs = nothing
            %>
  	          
            <div style="border:1px solid #DDD; padding:20px 15px;">
                <div class="point_title"><i class="xi-wallet xi-x"></i> 트래블월렛(Travelwallet)</div>
                <div class="e-voa_txt">
                   2024 크파케이션 기간 동안 지급되는 식대에 대해 트래블월렛 사용 구성원에게는 현금 지급이 아닌 계좌 입금으로 진행됩니다.<br>
                   사용을 희망하는 구성원은 카드 신청하신 후 입금계좌 등록 해주시기 바랍니다.
                </div>
                
                <div class="pt20"></div>
                
                <div style="background: #F3F3F3;padding:20px 20px 35px 20px;">
                    <div style="font-size:0.81em; font-weight:500;line-height:1.7em;">트래블윌렛 사용 구성원들은 계좌번호를 남겨주시기 바랍니다.</div>
                   <div class="pt15"></div>
                   <% If (Trim(account_number)="" or isnull(Trim(account_number)) )  then  %>
                   <% else %>
                       <div class="wallet_txt"><i class="xi-bank xi-x"></i> <strong><%=account_number%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></div>
                       <div class="pt20"></div>
                   <% end if %>
                   <div class="e-voa_pop"><a href="javascript:fn_wallet('<%=tot_hp%>');"><i class="xi-calendar-list xi-x"></i> <strong>트래블윌렛 은행계좌 등록</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
               </div>
           </div>     
-->
            <% CloseF5_DB objConn %>
            
        </div> 

        <!--#include virtual="/mobile/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

<div id="chain_wallet" title="트래블월렛 은행계좌"></div>
<script language="javascript"> 
<!--
    function fn_wallet(){
        var _url211 = "/mobile/mypage/account.asp";
        $("#chain_wallet").html('<iframe id="modalIframeId211" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId211").attr("src",_url211);
    }
    $(document).ready(function(){
        $("#chain_wallet").dialog({
            autoOpen: false,
            modal: true,
            width: 330,
            height: 250
        });
    });
//-->
</script> 

<script language="javascript" type="text/javascript">
    $(function(){
        var ifm = $(".etc_body iframe");
        ifm.each(function() {
            $(this).css("width","100%");
            $(this).css("height","60vw");
        });
    });

    $(function(){
        var img = $(".etc_body img");
        img.each(function() {
            $(this).css("width","100%");
            $(this).css("height","auto");
        });
    });
</script>