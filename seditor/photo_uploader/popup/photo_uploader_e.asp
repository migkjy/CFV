<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->   

<!DOCTYPE html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />

<style type="text/css">
/* NHN Web Standard 1Team JJS 120106 */ 
/* Common */
body,p,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,table,th,td,form,fieldset,legend,input,textarea,button,select{margin:0;padding:0}
body,input,textarea,select,button,table{font-family:'돋움',Dotum,Helvetica,sans-serif;font-size:1.00em;}
img,fieldset{border:0}
ul,ol{list-style:none}
em,address{font-style:normal}
a{text-decoration:none}
a:hover,a:active,a:focus{text-decoration:underline}

/* Contents */
.blind{visibility:hidden;position:absolute;line-height:0}
#pop_wrap{width:100%}
#pop_header{height:40px;padding:15px 0 0 20px;border-bottom:1px solid #ededeb;background:#f4f4f3}
.pop_container{padding:11px 20px 0}
#pop_footer{margin:21px 20px 0;padding:10px 0 16px;border-top:1px solid #e5e5e5;text-align:center}
h1{color:#333;font-size:1.25em;letter-spacing:-1px}
.btn_area{word-spacing:2px}
.pop_container .drag_area{overflow:hidden;overflow-y:auto;position:relative;width:341px;height:129px;margin-top:4px;border:1px solid #eceff2}
.pop_container .drag_area .bg{display:block;position:absolute;top:0;left:0;width:341px;height:129px;background:#fdfdfd url(../../img/photoQuickPopup/bg_drag_image.png) 0 0 no-repeat}
.pop_container .nobg{background:none}
.pop_container .bar{color:#e0e0e0}
.pop_container .lst_type li{overflow:hidden;position:relative;padding:7px 0 6px 8px;border-bottom:1px solid #f4f4f4;vertical-align:top}
.pop_container :root .lst_type li{padding:6px 0 5px 8px}
.pop_container .lst_type li span{float:left;color:#222}
.pop_container .lst_type li em{float:right;margin-top:1px;padding-right:22px;color:#a1a1a1;font-size:11px}
.pop_container .lst_type li a{position:absolute;top:6px;right:5px}
.pop_container .dsc{margin-top:6px;color:#666;line-height:18px}
.pop_container .dsc_v1{margin-top:12px}
.pop_container .dsc em{color:#13b72a}
.pop_container2{padding:46px 30px}
.pop_container2 .dsc{margin-top:6px;color:#666;line-height:18px}
.pop_container2 .dsc strong{color:#13b72a}
.upload{margin:0 4px 0 0;_margin:0;padding:6px 0 4px 6px;border:solid 1px #d5d5d5;color:#a1a1a1;font-size:12px;border-right-color:#efefef;border-bottom-color:#efefef;length:300px;}
:root  .upload{padding:6px 0 2px 6px;}
</style>
</head>

<body>
	
    <div id="pop_wrap">
        <!-- header -->
        <div id="pop_header"><h1>사진 첨부하기<h1></div>
        <!-- //header -->
        
        <!-- container -->
        <div id="pop_container2" class="pop_container2">
            <form id="editor_upimage" name="editor_upimage" action="imgupload_dext_e.asp" method="post" enctype="multipart/form-data" onSubmit="return false;">
                <div id="pop_content2">
                    <div style="border:1px solid #C0C0C0;padding:10px 0; border-radius:4px;">
                        <input type="file" class="upload" id="uploadInputBox" name="Filedata" style="width:100%; border:0px solid #C0C0C0; padding:0 0 0 5px;font-size:1.00em;">
                    </div>
                    <p class="dsc" id="info" style="padding:10px 0 0 0;"><strong>10MB</strong>이하의 이미지 파일만 등록할 수 있습니다.<br>(JPG, GIF, PNG, BMP)</p>
                </div>
            </form>
        </div>
        <!-- //container -->

        <!-- footer -->
        <div id="pop_footer">
            <div class="btn_area">
                <a href="#"><img src="../../img/photoQuickPopup/btn_confirm.png" width="49" height="28" alt="확인" id="btn_confirm" onclick="sendit()"></a>
                <a href="#"><img src="../../img/photoQuickPopup/btn_cancel.png" width="48" height="28" alt="취소" id="btn_cancel" onclick="self.close();"></a>
            </div>
        </div>
        <!-- //footer -->
    </div>

</body>
</html>

<script type="text/javascript">
<!--
	function posion_c(){ 
    var x,y; 
    if (self.innerHeight) {
        x = (screen.availWidth - self.innerWidth) / 2; 
        y = (screen.availHeight - self.innerHeight) / 2; 
    }else if (document.documentElement && document.documentElement.clientHeight) {
        x = (screen.availWidth - document.documentElement.clientWidth) / 2; 
        y = (screen.availHeight - document.documentElement.clientHeight) / 2; 
    }else if (document.body) {
        x = (screen.availWidth - document.body.clientWidth) / 2; 
        y = (screen.availHeight - document.body.clientHeight) / 2; 
    } 
    window.moveTo(x,y); 
	} 

	function sendit(){ 
    document.editor_upimage.submit();

  }
//-->
</script> 
<script type="text/javascript">posion_c(); </script> 

