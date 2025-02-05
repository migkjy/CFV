﻿<!--#include virtual="/home/conf/config.asp" -->
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
<script type="text/javascript" src="/seditor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">

            <div id="contBody">
                <div class="pt10"></div>
                <div class="infor_title">발리 맛집</div>
                <div style="border-bottom:2px solid #000;"></div>
                
                <form name="form1" method="post" action="food_write_ok.asp" enctype="multipart/form-data" style="display:inline; margin:0px;">
                    <div class="board_write">
                        <table>
                            <colgroup>
                                <col width="15%" />
                                <col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><font color="#E9250B">*</font> 작성자</th>
                                    <td><input type="text" name="writer" value="<%=cu_nm_kor%>" style="width:250px;" maxlength="20"  /></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 제목</th>
                                    <td><input type="text" name="title"  style="width:80%;" maxlength="80" /></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 썸네일 이미지등록</th>
                                    <td><input type="file" name="srcfile" style="width:99%;" /></td>
                                </tr>
                            </tbody>
                        </table>
                      <font color="red">
                      ※ 작성TIP<br>
                      게시글을 먼저 작성하신 후 마지막으로 오른쪽에 있는 "사진" 버튼을 활용하여 이미지를 첨부해주세요!<br>
                     이미지를 여러장 첨부하실 경우에는 "사진" 버튼을 활용하여 한장씩 한장씩 순차적으로 올려 주셔야 합니다. </font>
                        <div style="padding:15px 0;"><textarea name="ir_1" id="ir_1" style="width:100%;height:600px; display:none;"></textarea></div>
                        <div style="border-bottom:1px solid #EAEAEA;"></div>
                    
                        <table>
                            <colgroup>
                                <col width="15%" />
                                <col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th><font color="#E9250B">*</font> 비밀번호</th>
                                    <td><input type="password" name="password" style="width:100px;ime-mode:disabled;" maxlength="10" />&nbsp;&nbsp;<span class="disc">비밀번호는 숫자와 영문자를 혼용하여야 합니다. (최대 10자이내)</span></td>
                                </tr>
                                <tr>
                                    <th><font color="#E9250B">*</font> 보안문자</th>
                                    <td>
                                        <a href="javascript:void(0)" onclick="RefreshImage('imgCaptcha')"><img id="imgCaptcha" src="captcha.asp" border="0" alt="글자가 잘 안보이시면 클릭하세요"></a>
                                        <input type="text" name="captchacode" id="captchacode" style="width:100px;" />
                                        <span class="disc">옆의 글자를 입력해주세요.</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="pt20"></div>
  
                    <div class="board_btn_q">
                        <ul class="btn_r">
                            <li><a href="food_list.asp?gotopage=<%=gotopage%>">목록</a></li>		
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
    var oEditors = [];
    
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ir_1",
        sSkinURI: "/seditor/SmartEditor2Skin.html",	
        htParams : {
          bUseToolbar : true,	
          bUseVerticalResizer : false,
          bUseModeChanger : true,
          fOnBeforeUnload : function(){
    
          }
        }, //boolean
        fOnAppLoad : function(){
          //예제 코드
        },
        fCreator: "createSEditor2"
    });
    
    
    function inputok(){
        var n_pwd =document.form1.password.value;
        var chk_num = n_pwd.search(/[0-9]/g);
        var chk_eng = n_pwd.search(/[a-z]/ig);
            
        if (document.form1.writer.value=="" ) {
            alert("작성자를 입력해 주세요.");
            return false;
        }
        
        if (document.form1.title.value=="" ){ 
            alert("제목을 입력해 주세요.");
            return false;
        }
    
        if(document.form1.title.value.substr(0,1) == " " || document.form1.writer.value.substr(0,1) == " "){
            alert("'작성자'와 '제목' 항목의 첫글자에는 \n공백문자를 넣을 수 없습니다.");
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

    
        oEditors.getById["ir_1"].exec("UPDATE_CONTENTS_FIELD", []);
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
//-->
</script>