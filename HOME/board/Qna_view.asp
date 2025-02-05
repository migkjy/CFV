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
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script type="text/javascript" src="/home/js/jquery.fancybox.pack.js?v=2.1.4"></script>
<link type="text/css" href="/home/js/jquery.fancybox.css?v=2.1.4" />

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>
</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--#include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">
        	
            <div id="contBody">
                <%
                    tbl = "trip_qna"
                    num = Request("num")
                
                    password = Request.form("password")
                
                    gotopage = Request("gotopage")
                    s_cont = Request("s_cont")
                    s_cont = Replace(s_cont,"'","") 
                    cont = Request("cont")
                    cont = Replace(cont,"'","")
                
                    if gotopage = "" then gotopage = 1 end if
                    if pagesize = "" then pagesize = 20 end if
                    
                    OpenF5_DB objConn
                
                    Sql = "SELECT num , user_id , user_nm , title , con_tents , email  , secret , pwd ,ref , ref_level , deep , hit , ins_dt "
                    Sql = Sql& " FROM "&tbl&"  WHERE num ="&num&"  and del_yn='N' and deep=0 "
                
                
                    Set Rs = objConn.Execute(Sql)
                    If rs.eof or rs.bof then
                        Response.write "<script type='text/javascript'>"
                        Response.write " alert('연결이 잘못되었습니다.'); "
                        Response.write " history.back(); "
                        Response.write " </script>	 "
                        Response.End
                    Else
                        num = Rs("num")
                        user_id  = Rs("user_id")
                        user_nm  = Rs("user_nm")
                        title    = Rs("title")
                        con_tents = Rs("con_tents")
                          If not isnull(con_tents) or con_tents <> "" then   
                             con_tents = CheckWordre(con_tents)
                             con_tents = Replace(con_tents,chr(13)&chr(10),"<br>")
                          End if 
                
                        email = Rs("email")
                        pwd = Rs("pwd")
                        secret = Rs("secret")
                
                        ref = Rs("ref")
                        ref_level = Rs("ref_level")
                        deep = Rs("deep")
                
                        hit = Rs("hit")
                        ins_dt = Left(Rs("ins_dt"),10)
                    End If
                    Rs.close :Set Rs = nothing
                    
                    if Lcase(secret)="y" then
                        if pwd <> password then
                            Response.write "<script type='text/javascript'>"
                            Response.write " alert('비밀번호가 일치하지 않습니다.'); "
                            Response.write " history.back(); "
                            Response.write " </script>	 "
                            Response.End
                        End if
                    End if
                
                    Sql = "UPDATE "&tbl&" SET hit = hit + 1 WHERE num = "&num
                    objConn.execute(Sql)
                %>
                
                <input type="hidden" name="ref" value="<%=ref%>">
                <input type="hidden" name="ref_level" value="<%=ref_level%>">
                <input type="hidden" name="deep" value="<%=deep%>">
                <input type="hidden" name="gotopage" value="<%=gotopage%>">
                
                <div class="pt10"></div>
                <div class="infor_title"><%=title%></div>
                <div style="border-bottom:2px solid #000;"></div>
                
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_l">
                    <colgroup>
                        <col width="12%" />
                        <col width="60%" />
                        <col width="12%" />
                        <col width="*%" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>작성자</th>
                            <td><%=user_nm%></td>
                            <th>등록일</th>
                            <td class="date"><%=ins_dt%></td>
                        </tr>
                        <tr>
                            <td colspan="4" class="content"><%=con_tents%></td>
                        </tr>
                    </tbody>
                </table>
                
                <!--답변  ------------------->
                <%
                    Sql2 = "SELECT user_id,user_nm,title,con_tents,ins_dt  FROM "&tbl
                    Sql2 = Sql2 & "  WHERE ref ="&num&" AND (DEL_YN = 'N') AND (REF_LEVEL > 0)   "
                    Set Rs1 = objConn.Execute(Sql2)
                
                    Do while not rs1.eof 
                
                        repl_user_id = Rs1("user_id")
                        repl_user_nm = Rs1("user_nm")
                        repl_title = Rs1("title")
                        repl_con_tents = Rs1("con_tents")
                            If not isnull(repl_con_tents) or repl_con_tents <> "" then   
                                repl_con_tents = Replace(repl_con_tents,chr(13)&chr(10),"<br>")
                            End if 
                        repl_ins_dt   = left(Rs1("ins_dt"),10)
                %>
                    <div class="pt40"></div> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="dat_q_1"></td>
                            <td class="dat_q_2"></td>
                            <td class="dat_q_3"></td>
                        </tr>
                        <tr>
                            <td class="dat_q_4"></td>
                            <td style="padding:10px;">
                                <div style="font-size:17px;font-weight:700;padding:0 0 12px 0;"> <%=GLOBAL_SIN%>&nbsp;&nbsp;&nbsp;<%=repl_ins_dt%></div>
                                <div style="font-size:16px;"><%=repl_con_tents%></div>
                            </td>
                            <td class="dat_q_5"></td>
                        </tr>
                        <tr>
                            <td class="dat_q_6"></td>
                            <td class="dat_q_7"></td>
                            <td class="dat_q_8"></td>
                        </tr> 
                    </table>
                <%
                       rs1.movenext
                    Loop
                
                    rs1.close : Set rs1=nothing
                    
                    CloseF5_DB objConn
                %>
        
               <div class="board_btn_w">
                   <ul class="btn_r">
                       <li><a href="qna_list.asp?gotopage=<%=gotopage%>">목록</a></li>		
                       <li class="gray"><a onclick="fn_pass('common_pa.asp?num=<%=num%>&f_ts=qna_del');return false;" style="cursor:pointer;">삭제</a></li>
                       <li class="color"><a onclick="fn_pass('common_pa.asp?num=<%=num%>&f_ts=qna_upd');return false;" style="cursor:pointer;">수정</a></li>	
                   </ul>
               </div>
               
               <div class="pt50"></div> 
    	
            </div>
            
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