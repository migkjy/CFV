<!--#include virtual="/home/conf/config.asp" -->
<!--include virtual="/home/inc/cookies2.asp" -->
<!--#include virtual="/home/inc/support.asp" -->
<%
     '  If memid = "" Or pwd = "" Or memnum = ""  Then
      '      response.write "<script language='javascript'>  "
      '      response.write "  window.location.href='/';"
     '       response.write "</script>                             " 
     '       response.end
      '  end if
%>
<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
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
<script type="text/javascript" src="/home/js/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="/home/js/jquery.bxslider.min.js"></script>
<link type="text/css" href="/home/js/jquery.bxslider.min.css" />

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">

           <%
                OpenF5_DB objConn

                sli_sql ="SELECT top 8 count(num) from main_new_img where g_kind='20' and sub_kind='P' and use_yn='Y'"
               
                Set Rs = Server.CreateObject("ADODB.RecordSet")
                Rs.open sli_sql , objConn , 3
                ss_cnt = Rs(0)
                rs.close : Set rs=nothing
                 
                ReDim e_img(ss_cnt), e_url(ss_cnt), e_title(ss_cnt), e_remark(ss_cnt)
                 
                sql =" select  i_img, title, remark  from  main_new_img WHERE  (g_kind = 20) and sub_kind='P' and use_yn='Y' order by num asc"
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
            
            <div style="width:100%;height:350px;background:url('/board/upload/main_img/<%=e_img(5)%>') fixed;background-size:100%;">
                <div align="center">
                    <table width="100%" height="350" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
                        <tr>
                            <td>
                                <div align="center">
                                    <div class="sub_top_en"><%=e_title(5)%></div>
                                    <div class="sub_top_ko"><%=e_remark(5)%></div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div style="background: #FFF; padding:40px 0px;"> 
                <div align="center">
                    <div class="board_search">
                        <form name="frmSearch" action="" method="post" onSubmit="return fnSearch();" style="display:inline; margin:0px;">
                            <script language="javascript">
                            <!--
                                function fnEnter(){
    		      	                     if(event.keyCode==13){fnSearch()}
                                }
    		      	                 
                                function fnSearch(){
                                    obj = document.frmSearch;
                                    if (obj.stext.value==""){
                                        alert("프로그램명을 입력하세요");
                                        obj.stext.focus();
                                        return;
                                    }
                                    if (obj.stext.value.length<2){
                                        alert("검색어를 2자리 이상 입력하세요");
                                        obj.stext.value = "";
                                        obj.stext.focus();
                                        return;
                                    }
    		      	                 
                                    obj.action = "/home/good_tck/search_list.asp";
                                    obj.submit();
                                }
                            //-->
                            </script>
                            <ul>
                                <li><input type="text" name="stext" value=""<%=stext%>" style="width:400px;height:40px;border-radius:20px;padding:0 20px;color:#222;font-size:16px; font-weight:500;"  onBlur=check_w(this) onFocus=clear_w(this)  onKeyUp="fnEnter();" placeholder="프로그램명을 입력해 주세요."></li>
                                <li><span class="box_search"><a href="javascript:fnSearch();"><i class="xi-magnifier xi-x"></i><span style="font-size:16px;padding:0 0 0 2px">검색</span></a></span></li>
                            </ul>
                        </form>
                    </div>
                </div> 
            </div> 
            
            <div id="contBody">
                <div style="border-bottom:1px solid #EAEAEA;"></div>
                <div class="pt30"></div>
                <% 
                    OpenF5_DB objConn  
                    
                    tbl = "trip_gtck"
                    if g_kind="" or isnull(g_kind) then
                        g_kind = "10"
                    End if
                
                    s_cont = Request("s_cont")
                    s_cont= Replace(s_cont,"'","") 
                    cont = Request("cont")
                    cont = Replace(cont,"'","")
                
                    '######################################검색부분####################################
                    ans = "   and " & s_cont & " like '%" & cont & "%' "
                    '######################################검색부분####################################      
                %>
                
                <script language="JavaScript">
                <!-- 
                   if (navigator.userAgent.match(/iPad/) == null && navigator.userAgent.match(/iPhone|Mobile|UP.Browser|Android|BlackBerry|Windows CE|Nokia|webOS|Opera Mini|SonyEricsson|opera mobi|Windows Phone|IEMobile|POLARIS/) != null){       
                      window.location.href = "<%=GLOBAL_URL%>/mobile/good_tck/ticket_list.asp?g_kind=<%=g_kind%>";
                   } 
                //-->
                </script>
            
                <%
                    OpenF5_DB objConn
                    
                    s_sql ="SELECT  count(idx) from trip_gtck_city WHERE g_kind='"&g_kind&"' and del_yn='N' "

                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                    Rs.open s_sql , objConn , 3
        
                    ss_cnt = Rs(0)
                    rs.close : Set rs=nothing
            
                    Dim    dan_idx , dan_url ,  dan_title 
                    ReDim  dan_idx(ss_cnt), dan_url(ss_cnt), dan_title(ss_cnt) 
            
                    c_sql  =" SELECT idx, g_kind, title  FROM trip_gtck_city WHERE g_kind='"&g_kind&"' and del_yn='N' order by sunseo asc " 
                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                    Rs.open c_sql,objConn,3
            
                    i=0
                    
                    If Rs.eof then
                        rcnt=0
                    Else
                        Do until Rs.eof
            
                            r_idx = Rs("idx")
                            r_title = Rs("title")
        
                            dan_idx(i) = r_idx
                            dan_title(i) = r_title
        
                            Rs.movenext
                            i=i+1
        
                        Loop
                    End if
               
                    Rs.close : Set Rs=nothing
                %>

                <% For ii= 0 to ss_cnt-1 %>
                    <div class="infor_list">
                        <table width="100%">
                            <colgroup>
                                <col width="250">
                                <col width="30">
                                <col width="*">
                            </colgroup>
                            <tbody>
                                <%
                                    s1_day = Replace(dateadd("D", "0", date()),"-","")
                                    s2_day = Replace(dateadd("M", "6", date()),"-","")
                                    min_day = Left(now(),10)
                    
                                    sql ="SELECT  a.num , a.g_kind, a.title, a.s_area, a.event_tp, a.emp_nm ,   ISNULL(a.sunseo, 99) as sunseo ,exchange "
                                    sql = sql & " ,(SELECT TOP (1) file_img  FROM ex_good_photo p WHERE p.g_seq= a.num  order by disp_seq asc ,p_seq asc ) AS img "
                                    'sql = sql & " ,(SELECT TOP (1) price  FROM trip_gtck_opt o WHERE o.good_cd= a.num and o.del_yn='N' and o.use_yn='Y' and o.sub_tp='F' order by price asc  ) AS min_price "
                                    sql = sql & " ,(SELECT TOP (1) price_1  FROM w_tck_day d WHERE d.good_cd= a.num and d.magam='N' and d.day >='"&Replace(min_day,"-","")&"' order by price_1 asc   ) AS min_price "
                                    sql = sql & " from "&tbl&" a  where a.del_yn='N' and (SUBSTRING(re_comd,1,1) = 'Y') and g_kind='"&g_kind&"' "
                                    sql = sql & " and s_area='"&dan_idx(ii)&"'"
                                    sql = sql & "order by a.sunseo asc, a.num desc "
                                    'response.write sql
                           
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open sql , objConn , 3
                    
                          
                                    If Rs.eof then 
                                        rcnt=0
                                        
                                    Else 
                                        rcnt=1
                                        i=1
                                        
                                            Do until Rs.EOF
                                        
                                                r_num = Rs("num")
                                                r_g_kind = Rs("g_kind")
                                                r_s_area = Rs("s_area")
                                                r_title = Rs("title")
                                                r_emp_nm = Rs("emp_nm")
                                        
                                                r_event_tp = Rs("event_tp")
                                                    Select Case Ucase(r_event_tp)
                                                    Case "A" : event_nm ="/images/goods/event_A.png"
                                                    Case "B" : event_nm ="/images/goods/event_B.png"
                                                    Case "C" : event_nm ="/images/goods/event_C.png"
                                                End select 
                                        
                                                r_exchange = Rs("exchange")
                                        
                                                Select Case r_exchange
                                                    Case "10" : exchange_nm ="￦"
                                                    Case "20" : exchange_nm ="AUD $"
                                                    Case "30" : exchange_nm ="NZD $"
                                                End select 
                    
                                                r_min_price = Rs("min_price")
                                                if r_min_price="" or isnull(r_min_price) then
                                                    r_min_price=0
                                                end if
                                        
                                                '환율
                                                e_list = " select  exchange_rate from TB_exchange_rate where  num ="&r_exchange&" "
                                                'RESPONSE.WRITE e_list
                                                Set e_Rs = Server.CreateObject("ADODB.RecordSet")
                                                e_Rs.open e_list,objConn,3
                                        
                                                If e_Rs.EOF Then
                                                    e_rate = 0
                                                Else
                                                    e_rate = e_Rs("exchange_rate")
                                                End if
                                        
                                                e_Rs.close : Set e_Rs = nothing
                                                
                                                min_price = price_up(r_min_price,e_rate)
                                                
                                                r_img = Rs("img")
                                %> 
                                <tr>
                                    <td valign="top">
                                        <a href="ticket_view.asp?num=<%=r_num%>&g_kind=<%=r_g_kind%>&s_area=<%=r_s_area%>">
                                            <div class="TopEvent"><img src="<%=event_nm%>" border="0" height="40"></div>
                                            <li><p class="photo"><img src="/board/upload/tck/<%=r_num%>/<%=r_img%>"  border="0" onError="this.src='/images/goods/No_img_01.jpg'"></p></li>
                                        </a>
                                    </td>
                                    <td></td>
                                    <td valign="top">
                                        <a href="ticket_view.asp?num=<%=r_num%>&g_kind=<%=r_g_kind%>&s_area=<%=r_s_area%>">
                                            <div class="subject"><%=r_title%></div>
                                            <% if r_emp_nm <> "" then %>
                                                <div class="txt"># 최소출발 : <%=r_emp_nm%>명</div>
                                                <div class="pt5"></div>
                                            <% end if %>
                                            <% if min_price  <> 0 then %>
                                                <div class="price"><%=FormatNumber(min_price,0)%> CP</div> 
                                            <% else %>
                                                <div class="tel">별도문의</div>
                                            <% end if %>
                                        </a>
                                     </td>
                                </tr>
                                <tr>
                                    <td colspan="3" height="30"></td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="border-bottom:1px solid #EAEAEA;"></td>
                                </tr>
                                <tr>
                                    <td colspan="3" height="30"></td>
                                </tr>
                                <%
                                    Rs.movenext
                                    i = i + 1
                                    Loop
                                
                                    End if
                                
                                    Rs.close  : Set Rs = nothing
                                %>     
                            </tbody>
                        </table>
                    </div>
                <% 
                    Next
                    
                    CloseF5_DB objConn 
                %>
                
                <div class="pt50"></div>
                
            </div>
            
        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>