<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/conf/before_url.asp"--> 
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/home/inc/URLTools.asp"-->

<%
    Response.Expires = -1
   ' Session.codepage=65001
    Response.CharSet = "utf-8" 
    'Response.CharSet = "euc-kr" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

   If memid = "" Or pwd = "" Or memnum = ""  Then
        response.write "<script language='javascript'>  "
        Response.write " alert('로그인하세요..'); "
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

</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">
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
            <div style="width:100%;height:350px;background:url('/board/upload/main_img/<%=e_img(0)%>') fixed;background-size:100%;">
                <div align="center">
                    <table width="100%" height="350" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
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
             
            <div id="contBody">
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

                <div class="cont_body"><%=con_tents%></div>
 
                <div class="pt40"></div>
                    <% 
                    mem_nm = Trim(Request("mem_nm"))
                
                    res_phone1  = Trim(Request("res_phone1"))
                    res_phone2  = Trim(Request("res_phone2"))
                    res_phone3  = Trim(Request("res_phone3"))
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
                <div style="border:1px solid #DDD; padding:25px 30px;">	
                    <div class="point_title"><i class="xi-cc-visa xi-x"></i> 인도네시아 전자도착비자(e-VOA)</div>
                    <div class="e-voa_txt">
                        ◦전자도착비자(e-VOA)를 소지한 외국인은 자카르타수카르노하타 국제공항과 발리 응우라이 공항만 입국 가능 (기존 도착비자(VOA)로도 입국 가능)<br>
                        ◦여권 유효기간이 6개월 이상 남아 있는 여권정보<br>
                        ◦전자 도착비자를 통해 발급받은 비자는 체류기간 30일을 부여받게 됩니다.<br>
                        ◦전자 도착비자는 1회에 한하여 연장(30일) 신청이 가능합니다.<br>
                        ◦연장 신청은 체류지 인근 이민청 사무소에서 할 수 있습니다.
                    </div>
                    <div class="pt20"></div>
                    <div style="background: #F3F3F3;padding:30px 30px;">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="*" style="font-size:14px; font-weight:500;line-height:1.7em;">
                                    * 우리 국민이 인도네시아로 입국하는 경우 전자도착비자(e-VOA) 신청이 가능 합니다.<br>
                                    * 전자도착비자 서류를 XLSX, XLS, DOCX, HWP, PDF 파일로 올려주시기 바랍니다.
                                </td>
                                <% if pdf_yn = "1" then%>
                                <td width="250"><div class="e-voa_view"><a href="/upload/res_excel/<%=FileName%>" target="_blank"><i class="xi-calendar-list xi-x"></i> <strong>전자도착비자(e-VOA) 첨부서류 보기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></a></div></td>
                                <% else %>
                                <td width="265"><div class="e-voa_view"><a href="/home/2024/" target="_blank"><i class="xi-calendar-list xi-x"></i> <strong> 전자도착비자(e-VOA) 서류 다운로드&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></a></div></td>
                                <% end if %>
                                <td width="235"><div class="e-voa_pop"><a href="javascript:fn_evoa('<%=Base64_Encode(tot_hp)%>');"><i class="xi-calendar-list xi-x"></i> <strong>전자도착비자(e-VOA) 서류 올리기</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></div></td>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <div class="pt80"></div>
 
                 <% CloseF5_DB objConn %>
            </div> 

        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

<div id="chain_evoa_pop" title="인도네시아 전자도착비자(e-VOA)"></div>
<script language="javascript"> 
<!--
    function fn_evoa(r){
        var _url7yy = "/home/mypage/view_pdf_up.asp?tot_hp="+r;
        $("#chain_evoa_pop").html('<iframe id="modalIframeId27yy" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId27yy").attr("src",_url7yy);
    }
    $(document).ready(function(){
        $("#chain_evoa_pop").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 400
        });
    });
//-->
</script> 

<script language="javascript" type="text/javascript">
    $(function(){
        var ifm = $(".cont_body iframe");
        ifm.each(function() {
            $(this).css("width","100%");
            $(this).css("height","700");
        });
    });

    $(function(){
        var img = $(".cont_body img");
        img.each(function() {
            $(this).css("width","100%");
            $(this).css("height","auto");
        });
    });
</script>