<!--#include virtual="/home/conf/config.asp" -->
<!--include virtual="/home/inc/cookies2.asp"-->
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
    <!--include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">

            <%
                tbl = "trip_after"
                tbl2 = "trip_after_dat"
            
                num = Request("num")
                If Trim(num)="" or isnull(num) then
                    Response.write "<script type='text/javascript'>"
                    Response.write " alert('주요인자전송에러!!'); "
                    Response.write " history.back();"
                    Response.write " </script>	 "
                    Response.end
                End if
            
                gotopage = Request("gotopage")
            
                s_cont = Request("s_cont")
                s_cont = Replace(s_cont,"'","") 
                cont = Request("cont")
                cont = Replace(cont,"'","")
            
            
                OpenF5_DB objConn
            
                Sql = "SELECT  num , user_id , user_nm,  title , con_tents ,img, img_w, img_h , hit , ins_dt FROM "&tbl&" WHERE num ="&num&" and del_yn='N'  "
            
                Set Rs = objConn.Execute(Sql)
                If rs.eof or rs.bof then
                    Response.write "<script type='text/javascript'>"
                    Response.write " alert('접근하실수 없습니다....'); "
                    Response.write " history.back(); "
                    Response.write " </script>	 "
                    Response.End
                Else
            
                    num = Rs("num")
                    user_id = Rs("user_id")
                    user_nm = Rs("user_nm")
            
                    title = Rs("title")
                    con_tents = Rs("con_tents")
                           if not isnull(con_tents) or con_tents <> "" then   
                 con_tents = replace(con_tents,chr(13)&chr(10),"<br>")
             end if 
                    t_img = Rs("img")
                    img_w = Rs("img_w")
                    img_h  = Rs("img_h")
                    hit = Rs("hit")
                    ins_dt = left(Rs("ins_dt"),10)
            
                End if
            
                CloseRs Rs
            
            
                sql = " update "&tbl&" set hit = hit + 1 where num ="&num
                objConn.Execute(sql)
            %>  
            
            <script language="JavaScript">
            <!-- 
                if (navigator.userAgent.match(/iPad/) == null && navigator.userAgent.match(/iPhone|Mobile|UP.Browser|Android|BlackBerry|Windows CE|Nokia|webOS|Opera Mini|SonyEricsson|opera mobi|Windows Phone|IEMobile|POLARIS/) != null){       
                    window.location.href = "<%=global_url%>/mobile/board/food_view.asp?num=<%=num%>";
                }
            //-->
            </script>
        
            <div id="contBody">
                <div class="pt10"></div>
                <div class="infor_title"><%=title%></div>

                <div style="border-bottom:1px solid #EAEAEA;"></div>
    
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
                    </tbody>
                </table>

                <% if Len(t_img)> 3 then %>
                    <div><img src="/board/upload/after/<%=t_img%>" border="0" width="100%"></div>
                    <div class="pt30"></div>
                <% end if %>
                
                <div class="infor_content"><%=con_tents%></div>

                <div class="prev_next">
                    <dl class="prev">
                        <dt style="font-weight:500;">이전</dt>
                        <%
                            p_sql =  " Select TOP 1 num  as prenum ,title from "&tbl&" where del_yn='N' and num < "&num&"   order by num desc"
                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                            Rs.open p_sql,objConn,3
                
                            If Rs.eof or Rs.bof  then
                        %>
                            <dd>이전글이 없습니다.</dd>
                        <% Else  %>  
                            <dd><a href="food_view.asp?num=<%=Rs("prenum")%>&gotopage=<%=gotopage%>"><%=Rs("title")%></a></dd>
                        <%
                            End if
                            Rs.close :Set Rs = nothing
                        %>
                    </dl>
                    <dl class="next">
                        <dt style="font-weight:500;">다음</dt>
                        <%
                            n_sql =  " Select TOP 1 num as nextnum ,title from "&tbl&" where del_yn='N' and num > "&num&"   order by num asc "
                        
                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                            Rs.open n_sql,objConn,3
                
                            If Rs.eof or Rs.bof  then
                        %>
                            <dd>다음글이 없습니다.</dd>
                        <% Else %>
                            <dd><a href="food_view.asp?num=<%=Rs("nextnum")%>&gotopage=<%=gotopage%>"><%=Rs("title")%></a></dd>
                        <%
                            End if
                            Rs.close :Set Rs = nothing
                        %>
                    </dl>
                </div>
                
                <div class="board_btn_w">
                    <ul class="btn_r">
                        <li><a href="food_list.asp?&gotopage=<%=gotopage%>">목록</a></li>		
                        <li class="gray"><a onclick="fn_pass('common_pa.asp?num=<%=num%>&f_ts=food_del');return false;" style="cursor:pointer;">삭제</a></li>
                        <li class="color"><a onclick="fn_pass('common_pa.asp?num=<%=num%>&f_ts=food_upd');return false;" style="cursor:pointer;">수정</a></li>	
                    </ul>
                </div>
        
                <div class="dat_box">
                    <% 
                       sql2="select seq ,num ,user_nm, content, passwd,ins_dt  from "&tbl2&" "
                       sql2= sql2 &" where num="&num&" and del_yn='N' order by seq desc "
                
                       Set Rs2 = objConn.Execute(Sql2)
                
                       if NOT (Rs2.eof or Rs2.bof) then
                          Do until Rs2.EOF
                              r_seq     = Rs2("seq")
                              r_num     = Rs2("num")
                              r_user_nm = Rs2("user_nm")
                              r_content = Rs2("content")
                                If not isnull(r_content) or r_content <> "" then   
                                   r_content = Replace(r_content,chr(13)&chr(10),"<br>")
                                End if
                              r_ins_dt  = Left(Rs2("ins_dt"),10)
                    %> 
                    <div align="left">
                        <table>
                        	<tr>
                        		<td width="60px;" valign="top" style="padding:5px 10px 0 0;font-weight:500;"><%=r_user_nm%></td>
                        		<td>
                        		    <table width="100%" border="0">
                        		        <tr>
                        		            <td class="dat_q_1"></td>
                        		            <td class="dat_q_2"></td>
                        		            <td class="dat_q_3"></td>
                        		        </tr>
                        		        <tr>
                        		            <td class="dat_q_4"></td>
                        		            <td class="dat_q_10">
                        		                <div style="font-size:14px;"><%=r_content%></div>
                        		                <table width="100%">
                        		                	<tr>
                        		                		<td style="padding:0 10px 0 0;font-size:13px;font-weight:700;"><%=r_ins_dt%></td>
                        		                        <td>
                        		                            <div class="dat_ico">
                        		                                <img src="/images/board/dat_delete.png" border="0" style="cursor:pointer;border-radius:4px;" onclick="dat_layer('<%=r_seq%>','on');">
                        		                                <div id="divMenu_<%=r_seq%>"  style="position:absolute;display:none;width:240px;height:110px;margin-left:0px">
                        		                                    <iframe src="dat_pass.asp?tbl=af&idx=<%=r_seq%>" frameborder="0" width="240px" height="110px" scrolling="no"></iframe>
                        		                                </div>
                        		                            </div>
                        		                        </td>
                        		                    </tr>
                        		                </table>
                        		            </td>
                        		            <td class="dat_q_5"></td>
                        		        </tr>
                        		        <tr>
                        		            <td class="dat_q_6"></td>
                        		            <td class="dat_q_7"></td>
                        		            <td class="dat_q_8"></td>
                        		        </tr> 
                        		    </table>
                        		</td>
                        	</tr>
                        </table>
                    </div>
                
                    <div class="pt30"></div>
                    <%
                
                               Rs2.movenext
                          Loop
                
                       End if
                
                       CloseRs Rs2
                
                       CloseF5_DB objConn
                    %>
                </div>
        
        
                <div style="border-bottom:1px solid #EAEAEA;"></div>
                <div class="pt20"></div>
                
                <form name="reply" method="post" action="dat_write.asp"   style="display:inline; margin:0px;" >
                <input type="hidden"  name="num" value="<%=num%>">
                <input type="hidden"  name="tb" value="af" >
                <input type="hidden"  name="ss" value="<%=Session.SessionID%>">
                
                    <div align="left">
                        <table border="0" cellspacing="0" cellpadding="0">
                        	<tr>
                        		<td class="txt_dat">이름</td>
                        		<td width="7"></td>
                        		<td><input type="text" name="dat_user_nm" style="width:130px;height:28px; border-radius:0px;"></td>
                        		<td width="20"></td>
                        		<td class="txt_dat">비밀번호</td>
                        		<td width="7"></td>
                        		<td><input type="password" name="dat_pass" style="width:130px;height:28px; border-radius:0px;"></td>
                        		<td width="20"></td>
                        		<td class="txt_dat">보안문자</td>
                        		<td width="7"></td>
                        		<td class="txt_dat"><a href="javascript:void(0)" onclick="RefreshImage('imgCaptcha')"><img id="imgCaptcha" src="captcha.asp" border="0"></a></td>
                        		<td width="5"></td>
                        		<td><input type="text" name="captchacode" id="captchacode" style="width:130px;height:28px; border-radius:0px;" /></td>
                        		<td width="5"></td>
                        		<td><a onclick="RefreshImage('imgCaptcha')" style="cursor:pointer;"><span class="dat_check">새로고침</span></a></td>
                        		<td><span class="tage_disc">옆의 글자를 입력해주세요.</span></td>
                        	</tr>
                        </table>
                    </div>
                    
                    <div class="pt20"></div>
                    
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="*"><textarea name="dat_content" style="width:98%; height:68px; border:1px solid #EAEAEA;background-color:#FFF;border-radius:0px;" wrap="VIRTUAL" ></textarea></td>
                            <td width="20"></td>
                            <td width="100"><p class="dat_login"><a href="javascript:;" onclick="dat_write();">댓글 등록</a></p></td>
                        </tr>
                    </table>
                    <div align="right"><iframe src="about:blank" name="dat_wr" id="dat_wr" width="0" height="0"  style="display:none"></iframe></div>
                </form>
                
                <div class="pt80"></div>

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

<script language="javascript" type="text/javascript">
    $(function(){
        var img = $(".infor_content img");
        img.each(function() {
            $(this).css("width","100%");
            $(this).css("height","auto");
        });
    });
</script> 

<script language="javascript">
<!--
    function dat_write(){
        var	f = document.reply;
        if(!f.dat_user_nm.value){
            alert("한글명을 넣어주세요.");
            f.dat_user_nm.focus();
            return false;
        }

        if(!f.dat_pass.value){
            alert("비밀번호를 넣어주세요.");
            f.dat_pass.focus();
            return false;
        }

        if(f.dat_pass.value.length< 4){
            alert("비밀번호는 4글자 이상 10글자 이하로 입력하셔야 합니다.");
            f.dat_pass.focus();
            return false;
        }

        if(!f.captchacode.value) {
            alert("보안문자를 입력하셔야 합니다.");
            f.captchacode.focus();
            return false;
        }

        if(!f.dat_content.value){
            alert("내용을 넣어주세요.");
            f.dat_content.focus();
            return false;
        }
        f.target = "dat_wr";
        f.submit();
    }


    function dat_layer(n,v) {
        var dat_n= n;
        var dat_v= v;
      
        if(dat_v=='on'){
            document.getElementById("divMenu_"+dat_n).style.display = "block";
        }else{
            document.getElementById("divMenu_"+dat_n).style.display = "none";
        }
    }


    function RefreshImage(valImageId) {
        var objImage = document.images[valImageId];
        if (objImage == undefined) {
            return;
        }
        var now = new Date();
        objImage.src = objImage.src.split('?')[0] + '?x=' + now.toUTCString();
    }
//-->
</script>
