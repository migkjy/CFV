<!--#include virtual="/home/conf/config.asp" -->
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->   

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private" 
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

<script type="text/javascript" src="/seditor/js/HuskyEZCreator_e.js" charset="utf-8"></script>

</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">
    	
        <!--#include virtual="/mobile/include/left_menu.asp"-->
        <!--#include virtual="/mobile/include/top_menu.asp"-->

        <div class="best_main3">
        	
            <div class="infor_title">발리 맛집</div>
            <div style="border-bottom:2px solid #000;"></div>
            
            <form name="form1" method="post" action="food_write_ok.asp" enctype="multipart/form-data" style="display:inline; margin:0px;">
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
                                <td class="typ3"><font color="#E9250B">*</font> 제목</td>
                                <td class="typ4"><input type="text" name="title"  style="width:100%;" maxlength="80" class="input_basic" /></td>
                            </tr>
                            <tr height="54">
                                <td class="typ3"><font color="#E9250B">*</font> 썸네일 이미지</td>
                                <td class="typ4"><input type="file" name="srcfile" style="width:100%;" class="input_file" /></td>
                            </tr>
                        </tbody>
                    </table>
                    	<font color="red">
                      ※ 작성TIP<br>
                      게시글을 먼저 작성하신 후 마지막으로 오른쪽에 있는 "사진" 버튼을 활용하여 이미지를 첨부해주세요!<br>
                     이미지를 여러장 첨부하실 경우에는 "사진" 버튼을 활용하여 한장씩 한장씩 순차적으로 올려 주셔야 합니다. </font>
                    <div><textarea name="ir_1" id="ir_1" style="width:100%;height:500px; display:none;"></textarea></div>

                    <table>
                        <colgroup>
                            <col width="24%">
                            <col width="*">
                        </colgroup>
                        <tbody>  
                            <tr>
                                <td class="typ3"><font color="#E9250B">*</font> 비밀번호</td>
                                <td class="typ4">
                                    <div><input type="password" name="password" style="width:100px;ime-mode:disabled;" maxlength="10" class="input_basic" /></div>
                                    <div class="pt5"></div>
                                    <div class="disc">비밀번호는 숫자와 영문자를 혼용하여야 합니다.<br>(최대 10자이내)</div>
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

                <div class="board_btn_q">
                    <ul class="btn_r">
                        <li><a href="food_list.asp?gotopage=<%=gotopage%>">목록</a></li>		
                        <li class="color"><a onclick="inputok();" style="cursor:pointer;">등록</a></li>		
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
        var oEditors = [];
    
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ir_1",
        sSkinURI: "/seditor/SmartEditor2Skin_e.html",	
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
            alert("스팸방지 글자를 입력하셔야 합니다.");
            document.form1.captchacode.focus();
            return false;
        }

        //document.form1.submit();
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