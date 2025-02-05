﻿<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

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
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>
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
            
            <div style="width:100%;height:350px;background:url('/board/upload/main_img/<%=e_img(6)%>') fixed;background-size:100%;">
                <div align="center">
                    <table width="100%" height="350" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
                        <tr>
                            <td>
                                <div align="center">
                                    <div class="sub_top_en"><%=e_title(6)%></div>
                                    <div class="sub_top_ko"><%=e_remark(6)%></div>
                                    <div class="sub_top_tx">
                                        2024 크파케이션 IN BALI<br>
                                        여러분들이 경험한 나만 알기 아까운 맛집들을 공유해주세요!<br>
                                        공유하는 즐거움과 함께 일일퀘스트까지 달성하면 맛있는 선물이
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <%
                OpenF5_DB objConn
                
                tbl  = "trip_after"
                tbl2 = "trip_after_dat"
            
                num = Request("num")
            
                pageblock = 10
                pagesize  = Request("pagesize")
            
                gotopage  = Request("gotopage")
                s_cont = Request("s_cont")
                s_cont = Replace(s_cont,"'","") 
                cont = Request("cont")
                cont = Replace(cont,"'","")
            
                if gotopage = "" then gotopage = 1 End if
                if pagesize = "" then pagesize = 15 End if
            
                '검색부분
                if s_cont="" or isnull(s_cont) then
                    s_cont2="title"
                else
                    Select Case Ucase(s_cont)
                        Case "S": s_cont2="title"
                        Case "C": s_cont2="con_tents"
                    End Select
                end if 
            
                ans = " and " & s_cont2 & " like '%" & cont & "%' "
                

                '카운터
                sql = "select count(num) as cnt from "&tbl
                sql = sql & " where del_yn ='N' "

                if cont <> "" then sql = sql & ans
                Set Rs = objConn.Execute(Sql)
            
                RecordCount = Rs(0)
                PageCount = int( (RecordCount - 1) / PageSize ) + 1
            
                if gotopage = "" then 
                   gotopage = 1
                elseif cint(gotopage) > cint(PageCount) then
                   gotopage = PageCount
                end If
            
                if gotopage=0 then gotopage=1 End if
                r_num = recordcount - cint(pagesize) * cint((gotopage-1) )
            
                CloseRs Rs
            %>
            
            <div style="background: #FFF; padding:40px 0px;"> 
                <div align="center">
                    <div class="board_search">
                        <form name="s_frm" method="post" action="food_list.asp" style="display:inline; margin:0px;">
                            <ul>
                                <li>
                                    <select name="s_cont" style="width:120px;border-radius:20px;padding:0 20px;color:#222;font-size:16px; font-weight:500;">
                                        <option value="S" <% if s_cont = "S" then %>selected<% end if %>>제 목</option>
                                        <option value="C" <% if s_cont = "C" then %>selected<% end if %>>내 용</option>
                                    </select>
                                </li>
                                <li><input type="text" name="cont" value=""<%=cont%>" style="width:400px;height:40px;border-radius:20px;padding:0 20px;color:#222;font-size:16px; font-weight:500;" /></li>
                                <li><span class="box_search"><a onclick="chk_frm();"  style="cursor:pointer;"><i class="xi-magnifier xi-x"></i><span style="font-size:16px;padding:0 0 0 2px">검색</span></a></span></li>
                            </ul>
                        </form>
                    </div>
                    <div class="board_btn_n"><a href="food_write.asp"><i class="xi-border-color xi-x"></i><span style="font-size:16px;padding:0 0 0 2px">글쓰기</span></a></div>
                </div> 
            </div> 
            
            <div id="contBody">

                <div style="border-bottom:1px solid #EAEAEA;"></div>
                <div class="pt30"></div>
                <div class="infor_list">
                    <table width="100%">
                        <colgroup>
                            <col width="250">
                            <col width="30">
                            <col width="*">
                        </colgroup>
                        <tbody>
                            <%
                                sql ="SELECT TOP  "&pagesize&"  "
                                sql = sql & " a.num, a.user_nm ,a.title ,a.con_tents , a.img , a.hit ,a.ins_dt "
                                sql = sql & " ,repl_cnt=(select count(*) from "&tbl2&" k where k.del_yn='N' and k.num = a.num )"
                                sql = sql & " from "&tbl&" a "  
                                sql = sql & " where a.num not in "
                                sql = sql & " (select top " & ((gotopage-1) * pagesize) &" a.num " 
                                sql = sql & " from "&tbl&"  a   "
                                sql = sql & " where a.del_yn='N' "
                                if cont <> "" then sql = sql & ans
                                sql = sql & " order by a.num desc)"
                                sql = sql & " and a.del_yn='N' "
                                if cont <> "" then  sql = sql &  ans
                                sql = sql & " order by  a.num desc "
                            
                                Set Rs = objConn.Execute(Sql)
                                If  (Rs.eof or Rs.bof) then
                            %>    
                            <tr>
                                <td colspan="3"><div class="none_list">등록된 자료가 없습니다.</div></td>
                            </tr>
                            <% 
                                Else 
                                    i=1
                                    r_cnt=1
                                    Do until Rs.EOF
                                    
                                        num = Rs("num")
                                        title = Rs("title")
                                        user_nm = Rs("user_nm")
                                    
                                        con_tents = Rs("con_tents")
                                        con_tents2 = Func_ClearTag(con_tents)
                                        con_tents2 = cutStr(con_tents2,400)
                                    
                                        t_img = Rs("img")
                                        ins_dt = Left(Rs("ins_dt"),10)
                                        check_new = datediff("d",left(now,10),ins_dt)
                                    
                                        hit = Rs("hit")
                                        repl_cnt = Rs("repl_cnt")
                            %>
                            <tr>
                            	<% if t_img <> "" then %>
                                <td valign="top"><a href="food_view.asp?num=<%=num%>&gotopage=<%=gotopage%>"><li><p class="photo"><img src="/board/upload/after/<%=t_img%>" border="0" width="100%"></p></li></a></td>
                                <td></td>
                                <td valign="top">
                                <% else %>
                                <td valign="top" colspan="3">
                                <% end if %>  
                                    <a href="food_view.asp?num=<%=num%>&gotopage=<%=gotopage%>">
                                        <table width="100%" border="0">
                                            <tr>
                                                <td width="*"><div class="subject"><%=title%></div></td>
                                                <td width="100" align="right" valign="top" style="padding:3px 20px 0 0;"><i class="xi-face xi-x"></i> <%=user_nm%></td>
                                                <td width="51">
                                                    <table border="0">
                                                        <tr>
                                                            <td width="51" height="33" background="/images/board/reb.png" style="padding:4px 0 0 30px;font-size:13px; color:#ff5000;font-weight:700;" valign="top"><%=repl_cnt%></td>
                                                        </tr>
                                                    </table>                                           
                                                </td>
                                            </tr>
                                        </table>
                                        <div class="txt"><%'=con_tents2%></div>
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
                            
                                CloseRs Rs
                            %>     
                        </tbody>
                    </table>
                </div>
        
                <% if r_cnt=1 then %>
                    <div class="paginate1">
                        <% Call fn_goPage(gotopage,pagecount,pageblock,"food_list.asp?s_cont="&s_cont,"&cont="&cont) %>
                    </div>
                <% End if %>
                </div>
                
            </div>
            
            <% CloseF5_DB objConn %>
            
        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

<script type="text/javascript">
<!--
   function chk_frm(){
     if (document.s_frm.cont.value==""){
       alert("검색어를  입력해 주세요.");
       return false;
     }

     document.s_frm.submit();

   }
//--> 
</script>
