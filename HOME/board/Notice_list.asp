<!--#include virtual="/home/conf/config.asp" -->
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
<script type="text/javascript" src="/home/js/jquery-ui.min.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.min.css" />

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>
</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--#include virtual="/home/include/right_menu.asp"--> 

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
            <div style="width:100%;height:350px;background:url('/board/upload/main_img/<%=e_img(3)%>') fixed;background-size:100%;">
                <div align="center">
                    <table width="100%" height="350" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
                        <tr>
                            <td>
                                <div align="center">
                                    <div class="sub_top_en"><%=e_title(3)%></div>
                                    <div class="sub_top_ko"><%=e_remark(3)%></div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <%
                tbl  = "trip_notice"
            
                num = Request("num")
                gotopage  = Request("gotopage")
                
                s_cont = Request("s_cont")
                s_cont = Replace(s_cont,"'","") 
                cont = Request("cont")
                cont = Replace(cont,"'","")
                
                pagesize = 15
                pageblock = 10
            
                if s_cont="" or isnull(s_cont) then
                      s_cont2="title"
                else
                    Select Case Ucase(s_cont)
                    Case "S": s_cont2="title"
                    Case "C": s_cont2="con_tents"
                    End Select
                End if 
            
                ans = " and " & s_cont2 & " like '%" & cont & "%' "
            
            
                OpenF5_DB objConn
            
                sql = "select count(num) as cnt from "&tbl
                sql = sql & " where del_yn = 'N' and g_kind=10 and re_comd='N'"
                 if cont <> "" then sql = sql & ans
                Set Rs = objConn.Execute(Sql)
            
                RecordCount = Rs(0)
            
                PageCount = int( (RecordCount - 1) / PageSize ) + 1
            
                if gotopage = "" then 
                   gotopage = 1
                elseif cint(gotopage) > cint(PageCount) then
                   gotopage = PageCount
                end If
            
                if gotopage=0 then gotopage=1 end if
            
                r_num = recordcount - cint(pagesize) * cint((gotopage-1) )
            
                CloseRs Rs
            %>

            <div style="background: #FFF;  padding:40px 0px;"> 
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
                </div> 
            </div> 
            
            <div id="contBody">
                <div class="board_list">
                    <table>
                        <colgroup>
                            <col width="7%">
                            <col width="*">
                            <col width="15%">
                            <col width="8%">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">제목</th>
                                <th scope="col">등록일</th>
                                <th scope="col">조회수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                re_sql ="  SELECT TOP  5  a.num, a.title, a.hit ,a.ins_dt  "
                                re_sql = re_sql & " FROM "  &tbl& " a "  
                                re_sql = re_sql & " where  a.del_yn='N'  and a.re_comd='Y' and a.g_kind = 10"
                                re_sql = re_sql & " order by a.num desc " 
                            
                                Set recom_Rs = objConn.execute(re_sql)
                                
                                IF recom_Rs.eof and recom_Rs.bof then
                                Else	
                                    Do until recom_Rs.eof
                                        re_num = recom_Rs("num")
                                        re_title = recom_Rs("title")
                                        re_hit = recom_Rs("hit") 
                                        re_ins_dt = left(recom_Rs("ins_dt"),10)
                            %>
                            <tr>
                                <td><img src="/images/board/ic_notice.png" border="0"></td>
                                <td class="subject_n"><a href="notice_view.asp?num=<%=re_num%>&gotopage=<%=gotopage%>"><font color="#FF5001"><%=re_title%></font></a></td>
                                <td class="date"><font color="#FF5001"><%=re_ins_dt%></font></td>
                                <td class="date"><font color="#FF5001"><%=re_hit%></font></td>
                            </tr>
                            <%
                                        recom_Rs.movenext
                                    Loop
                
                                CloseRs recom_Rs
                                
                                End if
                            %>
                            
                            <%
                                sql ="SELECT TOP "&pagesize&"  "
                                sql = sql & "  a.num , a.user_id , a.user_nm , a.title , a.hit , a.ins_dt "
                                sql = sql & " from "&tbl&" a "  
                                sql = sql & " where a.num not in "
                                sql = sql & " (select top " & ((gotopage-1) * pagesize) &" a.num " 
                                sql = sql & " from  "&tbl&"   a   "
                                sql = sql & " where a.del_yn = 'N'  and a.g_kind=10  and a.re_comd='N' "
                                
                                if cont <> "" then sql = sql & ans
                                sql = sql & "       order by a.num desc)"
                                sql = sql & " and a.del_yn='N'  and a.g_kind=10  and a.re_comd='N'"
                                if cont <> "" then  sql = sql &  ans
                                sql = sql & "   order by  a.num desc "
                
                                Set Rs = Server.CreateObject("ADODB.RecordSet")
                                Set Rs = objConn.Execute(Sql)
                                
                                If  (Rs.eof or Rs.bof) then
                            %>
                            <tr>
                                <td colspan="4"><div class="none_list">등록된 자료가 없습니다.</div></td>
                            </tr>
                            <%
                                Else
                                	
                                    r_cnt=1
                                    Do until Rs.EOF
                                            	 
                                        num = Rs("num")
                                        title = Rs("title")
                                        hit = Rs("hit")
                                        ins_dt = left(Rs("ins_dt"),10)
                                        check_new = Datediff("d",left(now,10),ins_dt)
                            %>
                            <tr>
                                <td class="date"><%=r_num%></td>
                                <td class="subject">
                                    <a href="notice_view.asp?num=<%=num%>&gotopage=<%=gotopage%>">
                                        <%=title%></a>
                                        <% if check_new=0 then %>
                                            &nbsp;&nbsp;<span style="color:#FF0000"><i class="xi-new"></i></span>
                                        <% End if %>
                                    </a>
                                 </td>
                                <td class="date"><%=ins_dt%></td>
                                <td class="date"><%=hit%></td>
                            </tr>
                            <%
                                            Rs.movenext
                                            i=i+1
                                            
                                        r_num = r_num - 1
                                    Loop
                
                                End if 
                                
                                CloseRs Rs
                            %>
                        </tbody>
                    </table>
                
                    <% If r_cnt=1 then %>
                        <div class="paginate">
                            <% Call fn_goPage(gotopage,pagecount,pageblock,"notice_list.asp?s_cont="&s_cont,"&cont="&cont) %>
                        </div> 
                    <% End if %>
                </div>
            
            </div>
            
            <% CloseF5_DB objConn  %>
            
        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

    
<script language="javascript">
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
    
  