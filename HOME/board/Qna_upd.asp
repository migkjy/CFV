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
            	
                <div class="pt10"></div>
                <div class="infor_title">문의 게시판</div>
                <div style="border-bottom:2px solid #000;"></div>
                
                 <%
                    tbl    = "trip_qna"
            
                    num = Request("num")
                    if Trim(num)="" then
                        Response.write "<script type='text/javascript'>"
                        Response.write " alert('연결이 잘못되었습니다.'); "
                        Response.write " history.back(); "
                        Response.write " </script>	 "
                        Response.End
                    end if
            
            
                    password = Request.form("password")
                    gotopage = Request("gotopage")
                    s_cont = Request("s_cont")
                    s_cont = Replace(s_cont,"'","") 
                    cont = Request("cont")
                    cont = Replace(cont,"'","")
            
                    
                    OpenF5_DB objConn
            
                    Sql = "SELECT num , user_nm , res_hp1, res_hp2, res_hp3 , title , con_tents , email , secret , pwd ,ref , ref_level , deep , hit , ins_dt"
                    Sql = Sql & " FROM "&tbl
                    Sql = Sql & " WHERE num ="&num&" and del_yn='N' and deep=0 "
                    Set Rs = objConn.Execute(Sql)
            
                    If rs.eof or rs.bof then
                        Response.write "<script type='text/javascript'>"
                        Response.write " alert('Cannot access.'); "
                        Response.write " history.back(); "
                        Response.write " </script>	 "
                        Response.End
                    Else
            
                        user_nm = Rs("user_nm")
                        res_hp1 = Rs("res_hp1")
                        res_hp2 = Rs("res_hp2")
                        res_hp3 = Rs("res_hp3")
                        email = Rs("email")
            
                        title = Rs("title")
                        con_tents = Rs("con_tents")
                        pwd = Rs("pwd")
                        secret = Rs("secret")
                        ref = Rs("ref")
                        ref_level = Rs("ref_level")
                        deep = Rs("deep")
                        hit = Rs("hit")
                        ins_dt = Rs("ins_dt")
            
                    End If
            
                    Rs.close : Set Rs = nothing
            
            
                    if pwd <> password then
                        Response.write "<script type='text/javascript'>"
                        Response.write " alert('비밀번호가 일치하지 않습니다.'); "
                        Response.write " history.back(); "
                        Response.write " </script>	 "
                        Response.End
                    end if
                %> 
            
                <form name="form1" method="post" action="qna_upd_ok.asp" style="display:inline; margin:0px;">
                <input type="hidden" name="num" value="<%=num%>">
                <input type="hidden" name="gotopage" value="<%=gotopage%>">
                
                    <div class="board_write">
                        <table>
                            <colgroup>
                                <col width="15%" />
                                <col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><font color="#E9250B">*</font> 작성자</th>
                                    <td><input type="text" name="writer" value="<%=user_nm%>" style="width:212px;" maxlength="20" /></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 휴대전화번호 </th>
                                    <td>
                                        <select name="res_hp1" id="res_hp1" style="width:100px;">
                                            <option value="010" <% if res_hp1="010" then response.write "selected" end if %> >010</option>
                                            <option value="016" <% if res_hp1="016" then response.write "selected" end if %> >016</option>
                                            <option value="017" <% if res_hp1="017" then response.write "selected" end if %> >017</option>
                                            <option value="018" <% if res_hp1="018" then response.write "selected" end if %> >018</option>
                                            <option value="019" <% if res_hp1="019" then response.write "selected" end if %> >019</option>
                                        </select> - 
                                        <input type="text" name="res_hp2" id="res_hp2" value="<%=res_hp2%>" style="width:100px;" maxlength="4"> - 
                                        <input type="text" name="res_hp3" id="res_hp3" value="<%=res_hp3%>" style="width:100px;" maxlength="4">
                                    </td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 이메일</th>
                                    <td><input type="text" name="email" value="<%=email%>" style="width:400px;" maxlength="45" /></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 제목</th>
                                    <td><input type="text" name="title" value="<%=title%>" style="width:99%;" maxlength="80" /></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 상담내용</th>
                                    <td><textarea name="content" style="width:99%; height:350px;"><%=con_tents%></textarea></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 공개유무</th>
                                    <td height="65">
                                        <span><input type="radio" name="secret" id="secret_n" value="N" class="radio_book1"<% if Lcase(secret)="n" then response.write "checked" end if %>></span><span style="padding:0 20px 0 10px;"><label for="secret_n" style="cursor:pointer;">공개</label></span>
                                        <span ><input type="radio" name="secret" id="secret_y" value="Y"  class="radio_book1" <% if Lcase(secret)="y" then response.write "checked" end if %>></span><span style="padding:0 0 0 10px;"><label for="secret_y" style="cursor:pointer;">비공개</label></span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
            
                    <div class="board_btn_w">
                        <ul class="btn_r">
                            <li><a href="qna_list.asp?gotopage=<%=gotopage%>">목록</a></li>		
                            <li class="color"><a onclick="inputok();" style="cursor:pointer;">수정</a></li>		
                        </ul>
                    </div>
            
                    <div class="pt50"></div>
                </form>
                
                <% 
                    CloseF5_DB objConn
                %>
                
            </div>
            
        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

<script type="text/javascript">
<!-- 
    function inputok(){
    	if (document.form1.writer.value=="" ){
    		alert("작성자를 입력해 주세요.");
    		return false;
    	}
    	if (document.form1.title.value=="" ){
    		alert("제목을 입력해 주세요.");
    		return false;
    	}
    	 
    	if (document.form1.res_hp2.value=="" ){
    		alert("휴대전화번호를 입력해 주세요.");
    		return false;
    	}
    	if (document.form1.res_hp3.value=="" ){
    		alert("휴대전화번호를 입력해 주세요.");
    		return false;
    	}

      if (document.form1.email.value=="" ){
    		alert("이메일을 입력해 주세요.");
    		return false;
    	}

      if (document.form1.content.value=="" ){
    		alert("내용을 입력해 주세요.");
    		return false;
    	}

      if(document.form1.title.value.substr(0,1) == " " || document.form1.writer.value.substr(0,1) == " "){
      	alert("'글쓴이'와 '제목' 항목의 첫글자에는 \n공백문자를 넣을 수 없습니다.");
      	return false;
    	}

    	document.form1.submit();

    }
//-->
</script> 