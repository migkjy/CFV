<!--#include virtual="/home/conf/config.asp" -->
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
        
        <div class="best_main3">
        	
            <div class="infor_title">문의 게시판</div>
            <div style="border-bottom:2px solid #000;"></div>

            <%
                tbl = "trip_qna"
        
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
        
        
                If pwd <> password then
                    Response.write "<script type='text/javascript'>"
                    Response.write " alert('비밀번호가 일치하지 않습니다.'); "
                    Response.write " history.back(); "
                    Response.write " </script>	 "
                    Response.End
                End if
            %> 
        
            <form name="form1" method="post" action="qna_upd_ok.asp" style="display:inline; margin:0px;">
            <input type="hidden" name="num" value="<%=num%>">
            <input type="hidden" name="gotopage" value="<%=gotopage%>">
                <div class="board_write"> 
                    <table>
                        <colgroup>
                            <col width="24%">
                            <col width="*">
                        </colgroup>
                        <tbody>  
                            <tr>
                                <td class="typ1"><font color="#E9250B">*</font> 작성자</td>
                                <td class="typ2"><input type="text" name="writer" value="<%=user_nm%>" style="width:50%;" maxlength="20" class="input_basic" /></td>
                            </tr>
                            <tr>
                                <td class="typ1"><font color="#E9250B">*</font> 휴대전화</th>
                                <td class="typ2">
                                    <select name="res_hp1" id="res_hp1" class="select_com" style="width:30%;" >
                                        <option value="010" <% if res_hp1="010" then response.write "selected" end if %> >010</option>
                                        <option value="016" <% if res_hp1="016" then response.write "selected" end if %> >016</option>
                                        <option value="017" <% if res_hp1="017" then response.write "selected" end if %> >017</option>
                                        <option value="018" <% if res_hp1="018" then response.write "selected" end if %> >018</option>
                                        <option value="019" <% if res_hp1="019" then response.write "selected" end if %> >019</option>
                                    </select> -
                                    <input type="text" name="res_hp2" id="res_hp2" value="<%=res_hp2%>" style="width:30%;" maxlength="4" class="input_basic" > - 
                                    <input type="text" name="res_hp3" id="res_hp3" value="<%=res_hp3%>" style="width:30%;" maxlength="4" class="input_basic" >
                                </td>
                            </tr>
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 이메일</td>
                                <td class="typ4"><input type="text" name="email" value="<%=email%>" style="width:100%;" maxlength="45" class="input_basic" /></td>
                            </tr>
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 제목</td>
                                <td class="typ4"><input type="text" name="title" value="<%=title%>" style="width:100%;" maxlength="100" class="input_basic" /></td>
                            </tr>
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 상담내용</td>
                                <td class="typ4"><textarea name="content" style="width:100%; height:200px;" class="textarea_com"><%=con_tents%></textarea></td>
                            </tr>
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 공개유무</td>
                                <td class="typ4">
                                    <span><input type="radio" name="secret" id="secret_n" value="N" class="radio_book"></span><span style="padding:0 15px 0 5px;"><label for="secret_n">공개</label></span>
                                    <span ><input type="radio" name="secret" id="secret_y" value="Y"  class="radio_book" checked></span><span style="padding:0 0 0 5px;"><label for="secret_y">비공개</label></span>
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
            </form> 
            
            <% CloseF5_DB objConn %>
            
        </div>  
        
        <!--#include virtual="/mobile/include/foot_ci.asp"--> 
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
