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
        <div style="width:100%;height:200px;background:url('/board/upload/main_img/<%=e_img(0)%>') no-repeat;background-position:top center;background-size:cover;">
            <div align="center">
                <table width="100%" height="200" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
                    <tr>
                        <td>
                            <div align="center">
                                <div class="sub_top_en"><%=e_title(0)%></div>
                                <div class="sub_top_ko"><%=e_remark(0)%></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>  

        <div class="best_main4">
            <%
                tbl = "trip_notice"  
                num = 8
            
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
                <div class="point_title"><i class="xi-cc-visa xi-x"></i> 인도네시아 전자도착비자(e-VOA)</div>
                <div class="e-voa_txt">
                    전자도착비자(e-VOA)를 소지한 외국인은 자카르타수카르노하타 국제공항과 발리 응우라이 공항만 입국 가능 (기존 도착비자(VOA)로도 입국 가능)<br>
                    ◦여권 유효기간이 6개월 이상 남아 있는 여권정보<br>
                    ◦전자 도착비자를 통해 발급받은 비자는 체류기간 30일을 부여.<br>
                    ◦전자 도착비자는 1회에 한하여 연장(30일) 신청이 가능합니다.<br>
                    ◦연장 신청은 체류지 인근 이민청 사무소에서 할 수 있습니다.
                </div>
                
                <div class="pt20"></div>
                
                <div style="background: #F3F3F3;padding:20px 20px 35px 20px;">
                    <div style="font-size:0.81em; font-weight:500;line-height:1.7em;">
                        * 우리 국민이 인도네시아로 입국하는 경우 전자도착비자(e-VOA) 신청이 가능 합니다.<br>
                        * 전자도착비자 서류를 XLSX, XLS, DOCX, HWP, PDF 파일로 올려주시기 바랍니다.
                   </div>
                   <% if pdf_yn = "1" then %>
                       <div class="pt20"></div>
                       <div class="e-voa_view"><a href="/upload/res_excel/<%=FileName%>" target="_blank"><i class="xi-calendar-list xi-x"></i> <strong>전자도착비자(e-VOA) 첨부서류 보기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></a></div>
                       <div class="pt25"></div>
                   <% else %>
                       <div class="pt20"></div>
                       <div class="e-voa_view"><a href="/home/2024/" target="_blank"><i class="xi-calendar-list xi-x"></i> <strong> 전자도착비자(e-VOA) 서류 다운로드&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></a></div>
                       <div class="pt25"></div>
                   <% end if %>
                   <div class="e-voa_pop"><a href="javascript:fn_evoa('<%=Base64_Encode(tot_hp)%>');"><i class="xi-calendar-list xi-x"></i> <strong>전자도착비자(e-VOA) 서류 올리기</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div>
               </div>
           </div>     
      
            <% CloseF5_DB objConn %>
            
        </div> 

        <!--#include virtual="/mobile/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

<div id="chain_evoa_pop" title="인도네시아 전자도착비자(e-VOA)"></div>
<script language="javascript"> 
<!--
    function fn_evoa(r){
        var _url7yy = "/mobile/mypage/view_pdf_up.asp?tot_hp="+r;
        $("#chain_evoa_pop").html('<iframe id="modalIframeId27yy" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId27yy").attr("src",_url7yy);
    }
    $(document).ready(function(){
        $("#chain_evoa_pop").dialog({
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