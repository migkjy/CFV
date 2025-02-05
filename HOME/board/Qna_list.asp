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
            <div style="width:100%;height:350px;background:url('/board/upload/main_img/<%=e_img(2)%>') fixed;background-size:100%;">
                <div align="center">
                    <table width="100%" height="350" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
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

            <%
                tbl = "trip_qna"
                num = Request("num")
                gotopage = Request("gotopage")
            
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
                        Case "C": s_cont2="user_nm"  
                    End Select
                End if 
            
                ans = " and " & s_cont2 & " like '%" & cont & "%' "
            
            
                OpenF5_DB objConn
            
                sql = "select count(num) as cnt from "&tbl
                sql = sql & " where del_yn='N' and re_comd='N' and ref_level='0'"
                if cont <> "" then sql = sql & ans
                Set Rs = objConn.Execute(Sql)
            
                RecordCount = Rs(0)
                PageCount = int( (RecordCount - 1) / PageSize ) + 1
            
                If gotopage = "" then 
                    gotopage = 1
                Elseif cint(gotopage) > cint(PageCount) then
                    gotopage = PageCount
                End If
            
                if gotopage=0 then gotopage=1 end if
            
                r_num = recordcount - cint(pagesize) * cint((gotopage-1) )
            
                CloseRs Rs
            %>

            <div style="background: #FFF; padding:40px 0px;"> 
                <div align="center">
                    <div class="board_search">
                        <form name="s_frm" method="post" action="qna_list.asp" style="display:inline; margin:0px;">
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
                    <div class="board_btn_n"><a href="qna_write.asp"><i class="xi-border-color xi-x"></i><span style="font-size:16px;padding:0 0 0 2px">글쓰기</span></a></div>
                </div> 
            </div> 

            
            <div id="contBody">
                <div class="board_list">
                    <table>
                        <colgroup>
                            <col width="7%">
                            <col width="*">
                            <col width="10%">
                            <col width="14%">
                            <col width="8%">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">제목</th>
                                <th scope="col">작성자</th>
                                <th scope="col">등록일</th>
                                <th scope="col">처리</th>
                            </tr>
                        </thead>
                        <tbody>  
                            <%
                                re_sql =" SELECT TOP 5 a.num, a.title, a.hit ,a.ins_dt  "
                                re_sql = re_sql & " FROM " &tbl& " a "  
                                re_sql = re_sql & " where a.del_yn='N' and a.re_comd='Y' and ref_level='0'  " 
                                re_sql = re_sql & " order by a.num desc " 
                                
                                Set recom_Rs = objConn.execute(re_sql)
                                
                                if recom_Rs.eof and recom_Rs.bof then
                                Else	
                                    h=0
                                    do until recom_Rs.eof
                                        re_num   = recom_Rs("num")
                                        re_title = recom_Rs("title")
                                        re_hit   = recom_Rs("hit") 
                                        re_ins_dt = left(recom_Rs("ins_dt"),10)
                            %>
                            <tr>
                                <td><img src="/images/board/ic_notice.png" border="0"></td>
                                <td class="subject_n"><a href="qna_view.asp?num=<%=re_num%>&gotopage=<%=gotopage%>"><font color="#FF5001"><%=title_cutting(re_title,70)%></a></td>
                                <td class="date"><font color="#FF5001">(주)서아</font></td>
                                <td class="date"><font color="#FF5001"><%=re_ins_dt%></font></td>
                                <td class="pro"><div class="box_N">공지</div></td>
                            </tr>
                            <%
                                        recom_Rs.movenext
                                        h=h+1
                                    loop
                                End if
                            
                                recom_Rs.close  : Set recom_Rs = nothing
                            %>

                            <%
                                sql ="SELECT TOP  "&pagesize&"  "
                                sql = sql & " a.num ,a.user_id ,a.user_nm ,a.title ,a.con_tents , a.secret  ,a.hit ,a.ins_dt "
                                sql = sql & " ,(SELECT   COUNT(num) FROM "& tbl&" k WHERE a.num = k.ref AND k.del_yn = 'N' AND k.ref_level > 0)  AS repl_cnt "
                                sql = sql & " from "&tbl&" a "  
                                sql = sql & " where a.num not in "
                                sql = sql & " (select top " & ((gotopage-1) * pagesize) &" a.num " 
                                sql = sql & "   from "&tbl&" a  "
                                sql = sql & "   where a.del_yn='N' and ref_level='0' and a.re_comd='N' "
                                if cont <> "" then sql = sql & ans
                                    sql = sql & " order by a.num desc ) "
                                    sql = sql & " and a.del_yn='N' and ref_level='0' and a.re_comd='N'"
                                if cont <> "" then  sql = sql &  ans
                                    sql = sql & "   order by  a.num desc "
                                
                                Set Rs = objConn.Execute(Sql)
                                if  (Rs.eof or Rs.bof) then
                            %>
                            <tr>
                                <td colspan="5"><div class="none_list">등록된 자료가 없습니다.</div></td>
                            </tr>
                            <% 
                                Else
                                    i=1
                                    r_cnt=1
                                    Do until Rs.EOF
                
                                        num       = Rs("num")
                                        title     = Rs("title")
                                        user_nm   = Trim(Rs("user_nm"))
                                        
                                        len_chk   = Len(user_nm)
                                            if len_chk < 3  then
                                                user1 = Left(user_nm,1)
                                                user2 = Mid(user_nm,2,1)
                                                user_nm  =user1&"O"
                                            else
                                                user1 = Left(user_nm,1)
                                                user2 = Mid(user_nm,3,1)
                                                user_nm  =user1&"O"&user2
                                            end if
                
                                        con_tents = Rs("con_tents")
                                        secret    = Lcase(Rs("secret"))
                                        hit       = Rs("hit")
                                        repl_cnt  = Rs("repl_cnt")
                
                                        ins_dt    = Left(Rs("ins_dt"),10)
                                        check_new = Datediff("d",left(now,10),ins_dt)
                            %> 
                            <tr>
                                <td class="date"><%=r_num%></td>
                                <td class="subject">
                                    <% if secret="y" then %>
                                        <span><a onclick="fn_pass('common_pa.asp?num=<%=num%>&gotopage=<%=gotopage%>&f_ts=qna_view');return false;" style="cursor:pointer;"><span style="cursor:pointer;" title="비공개글입니다. 비밀번호를 입력하시기 바랍니다!"><%=title%></span></a></span>
                                        <span style="padding:0 0 0 10px;color:#999"><i class="xi-lock-o"></i></span>
                                        <% if check_new=0 then %>
                                            <span style="color:#FF0000"><i class="xi-new"></i></span>
                                        <% end if %>
                                    <% else %>	
                                        <span><a href="qna_view.asp?num=<%=num%>&gotopage=<%=gotopage%>"/><%=title%></a></span>
                                        <% if check_new=0 then %>
                                            <span style="color:#FF0000"><i class="xi-new"></i></span>
                                        <% end if %>
                                    <% end if %>
                                </td>
                                <td class="date"><%=user_nm%></td>
                                <td class="date"><%=ins_dt%></td>
                                <td class="pro">
                                    <% if repl_cnt >0 then %>
                                        <div class="box_A">완료</div>
                                    <% else %>
                                        <div class="box_Q">접수</div>
                                    <% end if %>
                                </td>
                            </tr>
                            <%
                                        Rs.movenext
                                        i=i+1
                                        r_num = r_num - 1
                              
                                    Loop
                
                                End if 
                
                                Rs.close :Set Rs = nothing
                            %>
                        </tbody>
                    </table> 
                
                    <% if r_cnt=1 then %>
                        <div class="paginate">
                            <% Call fn_goPage(gotopage,pagecount,pageblock,"qna_list.asp?s_cont="&s_cont,"&cont="&cont) %>
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


<div id="pop_password" title="비밀번호"></div>
<script language="javascript">
    function fn_pass(_url1){
        $("#pop_password").html('<iframe id="modalIframeId1" width="100%" height="200px" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="no" />').dialog("open");
        $("#modalIframeId1").attr("src",_url1);
    }
    $(document).ready(function(){
        $("#pop_password").dialog({
            autoOpen: false,
            modal: true,
            width: 400,
            height: 270
        });
    });
</script>
    
<script type="text/javascript">
<!--
    function chk_frm(){
        if (document.s_frm.cont.value==""){
            alert("검색어를 입력해 주세요.");
            return false;
        }
        document.s_frm.submit();
    }
//--> 
</script>
