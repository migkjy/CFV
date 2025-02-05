<!--#include virtual="/home/conf/config.asp" -->
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
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
        <div style="width:100%;height:200px;background:url('/board/upload/main_img/<%=e_img(2)%>') no-repeat;background-position:top center;background-size:cover;">
            <div align="center">
                <table width="100%" height="200" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
                    <tr>
                        <td>
                            <div align="center">
                                <div class="sub_top_en"><%=e_title(2)%></div>
                                <div class="sub_top_ko"><%=e_remark(2)%></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>  
             
        <div class="best_main4">
            <%
                tbl = "trip_notice"  
                num = 10
            
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
     
            <% CloseF5_DB objConn %>
        </div> 

        <!--#include virtual="/mobile/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>