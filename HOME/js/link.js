/* 
'------------------------------------------------------------------------------
'작성일자 : 20.09.16
'작성자 : 에프파이브시스템
'파일명 : link.js
'------------------------------------------------------------------------------
*/

function goUrl0(url) {//홈
    switch (url) {
        case 1:	//홈
            location.href='/';	 	
            break;
    }
}


function goUrl2(url) {//커뮤니티
    switch (url) {
        case 1:	//공지사항
            location.href='/home/board/notice_list.asp';
            break;
        case 2:	//상담문의
            location.href='/home/board/qna_list.asp';
            break;
        case 3:	//자주묻는질문
            location.href='/home/board/faq_list.asp';
            break;
    }
}


function goUrl4(url) {//로그인
    var preurl = location.href;	
		switch (url) {
		case 1:	//로그인
			location.href='/home/member/login.asp';
			break;
		case 2:	//로그아웃
			location.href='/home/member/logout.asp';
			break;
    }
}


function goUrl5(url) {//마이페이지
    switch (url) {
		case 1:	//예약확인
			location.href='/home/member/login_my.asp';
			break;	
    }
}

function goUrl100(url) {//준비중입니다
		switch (url) {
		case 1:	//첫번째
			alert("OPEN 준비중입니다");
		    return;
			location.href='/';
			break;		
    }
}

function MM_preloadImages() { //v3.0
    var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
    var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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