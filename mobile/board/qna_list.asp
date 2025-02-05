﻿<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
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

        <%
            tbl = "trip_qna"
            num = Request("num")
            gotopage = Request("gotopage")
        
            s_cont = Request("s_cont")
            s_cont = Replace(s_cont,"'","") 
            cont = Request("cont")
            cont = Replace(cont,"'","")
        
            pagesize = 10
            pageblock = 5
        
        
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

        <div class="best_main1">
        	
            <form name="s_frm" method="post" action="qna_list.asp" style="display:inline; margin:0px;">
                <table>
                    <tr>
                        <td width="18%">
                            <select name="s_cont" class="ser_select" style="width:100%;">
                                <option value="S" <% if s_cont = "S" then %>selected<% end if %>>제목</option>
                                <option value="C" <% if s_cont = "C" then %>selected<% end if %>>내용</option>
                            </select>
                        </td>
                        <td width="2%"></td>
                        <td width="*%"><input type="text" name="cont" value=""<%=cont%>" style="width:100%;" class="ser_input"></td>
                        <td width="2%"></td>
                        <td width="20%"><div class="ser_btn"><a onclick="chk_frm();"><span style="color:#FFFFFF;"><i class="xi-magnifier xi-x"></i>검색</span></a></div></td>
                        <td width="2%"></td>
                        <td width="22%"><div class="ser_ok"><a href="qna_write.asp"><span style="color:#FFFFFF;"><i class="xi-border-color xi-x"></i>글쓰기</span></a></div></td>
                    </tr>
                </table>
            </form>

            <div class="pt30"></div>
            
            <div class="board_list">
                <table>
                    <colgroup>
                        <col width="*%">
                        <col width="25%">
                        <col width="12%">
                    </colgroup>
                    <thead>
                        <tr height="36">
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">처리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            OpenF5_DB objConn
                            
                            re_sql =" SELECT TOP 5 a.num, a.title, a.hit ,a.ins_dt  "
                            re_sql = re_sql & " FROM " &tbl& " a "  
                            re_sql = re_sql & " where a.del_yn='N' and a.re_comd='Y' and ref_level='0'  " 
                            re_sql = re_sql & " order by a.num desc " 
                            
                            Set recom_Rs = objConn.execute(re_sql)
                            
                            If recom_Rs.eof and recom_Rs.bof then
                            Else	
                                h=0
                                do until recom_Rs.eof
                                    re_num   = recom_Rs("num")
                                    re_title = recom_Rs("title")
                                    re_hit   = recom_Rs("hit") 
                                    re_ins_dt = left(recom_Rs("ins_dt"),10)
                        %>
        	                <tr height="54">
        	                    <td class="subject_1"><a href="qna_view.asp?num=<%=re_num%>" /><%=re_title%><div style="color:#888; font-size:0.875em;padding:2px 0 0 0;"><%=re_ins_dt%></div></a></td>
        	                    <td class="name_1">(주)서아</td>
        	                    <td class="name_1"><div class="box_N">공지</div></td>
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
                                sql = sql & " and a.del_yn='N' and ref_level='0' and a.re_comd='N' "
                            if cont <> "" then  sql = sql &  ans
                                sql = sql & "   order by  a.num desc "
                            
                            Set Rs = objConn.Execute(Sql)
                            If  (Rs.eof or Rs.bof) then
                        %>
                        <tr>
                            <td colspan="3"><div class="none_board">등록된 자료가 없습니다.</div></td>
                        </tr>
        	                <% 
        	                    Else  
        	                        i=1
        	                        r_cnt=1
        	                        Do until Rs.EOF

        	                            num = Rs("num")

        	                            user_nm  = Rs("user_nm")
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
                                          
        	                            title    = Rs("title")
        	                            con_tents = Rs("con_tents")

        	                            secret    = Lcase(Rs("secret"))
        	                            hit       = Rs("hit")

        	                            ins_dt    = left(Rs("ins_dt"),10)
        	                            check_new = Datediff("d",left(now,10),ins_dt)
        	                            
        	                            repl_cnt  = Rs("repl_cnt")
        	                            
        	                %>
        	                <tr height="54">
        	                    <td class="subject">
        	                        <% if secret="y" then %>
        	                            <a onclick="fn_pass('common_pa.asp?num=<%=num%>&gotopage=<%=gotopage%>&f_ts=qna_view');return false;" style="cursor:pointer;"><%=title%><div style="color:#888; font-size:0.875em;padding:2px 0 0 0;"><%=ins_dt%> <i class="xi-lock-o xi-x" style="font-size:1.063em;"></i></div></a>
        	                        <% else %>	
        	                            <a href="qna_view.asp?num=<%=num%>&gotopage=<%=gotopage%>" /><%=title%><div style="color:#888; font-size:0.875em;padding:2px 0 0 0;"><%=ins_dt%></div></a>
        	                        <% end if %>
        	                    </td>
        	                    <td class="name"><%=user_nm%></td>
        	                    <td class="name">
        	                        <% if repl_cnt >0 then %>
        	                           <div class="box_A">답변</div>
        	                       <% else %>
        	                           <div class="box_Q">질문</div>
        	                       <% end if %>
        	                   </td>
        	                </tr>
        	                <%
        	                            Rs.movenext
        	                            i=i+1
        	                            r_num = r_num - 1
                                  
        	                        Loop
                            
        	                        Rs.close :Set Rs = nothing
                            
        	                    End if 
        	                    
        	                    CloseF5_DB objConn
        	                %>
        	            </tbody>
        	        </table> 
        	    </div>
        	    
        	    <% if r_cnt=1 then %>
        	        <div class="paginate">
		            <% Call fn_goPage(gotopage,pagecount,pageblock,"qna_list.asp", "") %>
        	        </div> 
        	    <% End if %>

        </div>
        
        <!--#include virtual="/mobile/include/foot_ci.asp"-->
    
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
            width: 330,
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
--> 
</script>