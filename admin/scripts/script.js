<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}



function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}



function newwin() {
window.open("http://www.jungfrau.co.kr/home/agent/nicetrip/menu05_01.php", 'coupon', width='632',height='650');
}


function newwin2() {
window.open("http://www.nicetrip.co.kr/topas/tb_db.asp", 'coupon', width='645',height='550');
}

function chk_login_frm(frm){
	if (frm.id.value == ""){
		alert("회원님의 아이디를 입력하세요!\n\n");
		frm.id.focus();
		return false;
	}else if (frm.pw.value == ""){
		alert("회원님의 비밀번호를 입력하세요!\n\n");
		frm.pw.focus();
		return false;
	}
	return true;
}

//-->


