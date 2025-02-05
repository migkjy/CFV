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
    
    title = Lcase(Request("title"))

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

            <form name="form1" method="post" action="qna_write_ok.asp" style="display:inline; margin:0px;">
                <div class="board_write"> 
                    <table>
                        <colgroup>
                            <col width="24%">
                            <col width="*">
                        </colgroup>
                        <tbody>  
                            <tr>
                                <td class="typ1"><font color="#E9250B">*</font> 작성자</td>
                                <td class="typ2"><input type="text" name="writer" style="width:50%;" value="<%=cu_nm_kor%>" maxlength="20" class="input_basic" /></td>
                            </tr>
                            <tr>
                                <td class="typ1"><font color="#E9250B">*</font> 휴대전화</th>
                                <td class="typ2">
                                    <select name="res_hp1" id="res_hp1" class="select_com" style="width:30%;" >
                                        <option value="010" >010</option>
                                        <option value="016" >016</option>
                                        <option value="017" >017</option>
                                        <option value="018" >018</option>
                                        <option value="019" >019</option>
                                    </select> -
                                    <input type="text" name="res_hp2" id="res_hp2" style="width:30%;" maxlength="4" class="input_basic" value="<%=mid(cu_htel,5,4)%>"> - 
                                    <input type="text" name="res_hp3" id="res_hp3" style="width:30%;" maxlength="4" class="input_basic" value="<%=right(cu_htel,4)%>">
                                </td>
                            </tr>
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 이메일</td>
                                <td class="typ4"><input type="text" name="email" value="<%=memid%>" style="width:100%;" maxlength="45" class="input_basic" /></td>
                            </tr>
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 제목</td>
                                <td class="typ4"><input type="text" name="title" style="width:100%;" value="<%=title%>" maxlength="100" class="input_basic" /></td>
                            </tr>
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 상담내용</td>
                                <td class="typ4"><textarea name="content" style="width:100%; height:200px;" class="textarea_com"></textarea></td>
                            </tr>
                            <tr height="54">
                                <td class="typ3"><font color="#E9250B">*</font> 공개유무</td>
                                <td class="typ4">
                                    <span><input type="radio" name="secret" id="secret_n" value="N" class="radio_book"></span><span style="padding:0 15px 0 5px;"><label for="secret_n">공개</label></span>
                                    <span ><input type="radio" name="secret" id="secret_y" value="Y"  class="radio_book" checked></span><span style="padding:0 0 0 5px;"><label for="secret_y">비공개</label></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 비밀번호</td>
                                <td class="typ4">
                                    <span><input type="password" name="password" style="width:100px;ime-mode:disabled;" maxlength="10" class="input_basic" /></span>
                                    <span class="disc">&nbsp;숫자와 영문자를 혼용..</span>
                                </td>
                            </tr>
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 보안문자</td>
                                <td class="typ4">
                                    <a href="javascript:void(0)" onclick="RefreshImage('imgCaptcha')"><img id="imgCaptcha" src="captcha.asp" border="0" align="absmiddle"></a>
                                    <input type="text" name="captchacode" id="captchacode" style="width:100px;" class="input_basic" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="pt20"></div>
                
                <div style="border:1px solid #EEE; padding:10px;">
                   <div style="width:100%;OVERFLOW-Y:auto;height:130px">
                       <!--#include virtual="/home/board/document_agree.asp"-->
                   </div>
                </div>
                
                <div class="pt15"></div>
                <div><span class="checks"><input type="checkbox" name="agreement" id="agreement" value="Y"><label for="agreement" style="font-size:0.94em; font-weight:700;">개인정보 항목, 수집/이용목적에 동의합니다.</label></span></div>
                
                <div class="board_btn_q">
                    <ul class="btn_r">
                        <li><a href="qna_list.asp?gotopage=<%=gotopage%>">목록</a></li>	
                        <li class="color"><a onclick="inputok();">등록</a></li>		
                    </ul>
                </div>
            </form>
            
        </div> 

        <!--#include virtual="/mobile/include/foot_ci.asp"--> 
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
          alert("스팸방지 글자를 입력하셔야 합니다.");
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