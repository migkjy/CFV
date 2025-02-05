<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<% 
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    title = Lcase(Request("title"))
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
                
                <form name="form1" method="post" action="qna_write_ok.asp" style="display:inline; margin:0px;">
                    <div class="board_write">
                        <table>
                            <colgroup>
                                <col width="15%" />
                                <col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><font color="#E9250B">*</font> 작성자</th>
                                    <td><input type="text" name="writer" value="<%=cu_nm_kor%>" style="width:212px;" maxlength="20" /></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 휴대전화번호</th>
                                    <td>
                                        <select name="res_hp1" id="res_hp1"  style="width:100px;" >
                                            <option value="010" >010</option>
                                            <option value="016" >016</option>
                                            <option value="017" >017</option>
                                            <option value="018" >018</option>
                                            <option value="019" >019</option>
                                        </select> -
                                        <input type="text" name="res_hp2" id="res_hp2" style="width:100px;" maxlength="4" value="<%=mid(cu_htel,5,4)%>"> - 
                                        <input type="text" name="res_hp3" id="res_hp3" style="width:100px;"  maxlength="4" value="<%=right(cu_htel,4)%>">
                                        <span class="disc">정확한 연락처를 기입해 주십시오</span>
                                    </td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 이메일</th>
                                    <td><input type="text" name="email" value="<%=memid%>" style="width:400px;" maxlength="45" /></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 제목</th>
                                    <td><input type="text" name="title" value="<%=title%>" style="width:99%;" maxlength="100" /></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 상담내용</th>
                                    <td><textarea name="content" style="width:99%; height:300px;border-radius:4px;"></textarea></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 공개유무</th>
                                    <td height="65">
                                        <span><input type="radio" name="secret" id="secret_n" value="N" class="radio_book1"></span><span style="padding:0 20px 0 10px;"><label for="secret_n" style="cursor:pointer;">공개</label></span>
                                        <span ><input type="radio" name="secret" id="secret_y" value="Y"  class="radio_book1" checked></span><span style="padding:0 0 0 10px;"><label for="secret_y" style="cursor:pointer;">비공개</label></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 비밀번호</th>
                                    <td>
                                        <input type="password" name="password" style="width:150px;ime-mode:disabled;" maxlength="10" />&nbsp;&nbsp;
                                        <span class="disc">비밀번호는 숫자와 영문자를 혼용하여야 합니다..</span>
                                    </td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 보안문자</th>
                                    <td>
                                        <a href="javascript:void(0)" onclick="RefreshImage('imgCaptcha')"><img id="imgCaptcha" src="captcha.asp" border="0" alt="글자가 잘 안보이시면 클릭하세요"></a>
                                        <input type="text" name="captchacode" id="captchacode" style="width:150px;" />
                                        <span class="disc">옆의 글자를 입력해주세요.</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="pt20"></div>
            
                    <div style="border:1px solid #EEE; padding:20px;border-radius:10px;">
                       <div style="width:100%;OVERFLOW-Y:auto;height:130px">
                           <!--#include virtual="/home/board/document_agree.asp"-->
                       </div>
                    </div>
                    
                    <div class="pt20"></div>
                    <div><span class="checks"><input type="checkbox" name="agreement" id="agreement" value="Y"><label for="agreement" style="font-weight:500;">수집하는 개인정보 항목, 수집/이용목적, 개인정보 보유기간에 동의합니다.</label></span></div>
            
                    <div class="board_btn_q">
                        <ul class="btn_r">
                            <li><a href="qna_list.asp?gotopage=<%=gotopage%>">목록</a></li>		
                            <li class="color"><a onclick="inputok();" style="cursor:pointer;">등록</a></li>		
                        </ul>
                    </div>
            
                    <div class="pt50"></div>
                </form>

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
        var n_pwd =document.form1.password.value;
        var chk_num = n_pwd.search(/[0-9]/g);
        var chk_eng = n_pwd.search(/[a-z]/ig);
      
        if (document.form1.writer.value=="" ){
            alert("작성자를 입력해 주세요.");
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
        
        
        if (document.form1.title.value=="" ){
            alert("제목을 입력해 주세요");
            return false;
        }
        
        if (document.form1.content.value=="" ){
            alert("내용을 입력해 주세요.");
            return false;
        }
        
        if(document.form1.title.value.substr(0,1) == " " || document.form1.writer.value.substr(0,1) == " "){
            alert("작성자와 제목의 첫글자에는\n공백문자를 넣을 수 없습니다.");
            return false;
        }
        
        if(document.form1.password.value == "") {
            alert("비밀번호를 입력하셔야 합니다.");
            document.form1.password.focus();
            return false;
        }
        
        if(chk_num < 0 || chk_eng < 0){
            alert('비밀번호는 숫자와 영문자를 혼용하여야 합니다.');
            document.form1.password.focus();
            return false;
        }
        
        if(/(\w)\1\1\1/.test(n_pwd)){
            alert('비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.');
            document.form1.password.focus();
            return false;
        }
        
        if (document.form1.password.value.length< 4|| document.form1.password.value.length>10 ) {
          alert("비밀번호는 4글자 이상 10글자 이하 입력하셔야 합니다.");
          document.form1.password.focus();
          return false;
        }
        
        if(document.form1.captchacode.value == "") {
          alert("보안문자를 입력하셔야 합니다.");
          document.form1.captchacode.focus();
          return false;
        }
        
        if(document.form1.agreement.checked == false){
             alert("개인정보 수집 항목 및 수집방법에  동의하셔야 등록이 가능합니다.");
             document.form1.agreement.focus();
             return false;
        }
        
        document.form1.submit();
    }


    function RefreshImage(valImageId) {
        var objImage = document.images[valImageId];
        if (objImage == undefined) {
            return;
        }
        var now = new Date();
        objImage.src = objImage.src.split('?')[0] + '?x=' + now.toUTCString();
    }

   function toUpCase(object){
       object.value = object.value.toUpperCase();  
    }  
//-->
</script>  