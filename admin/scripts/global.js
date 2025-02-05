// 에러메시지 포멧 정의 ///
var NO_BLANK = "{name+을를} 입력해주세요";
var NOT_VALID = "{name+이가} 올바르지 않습니다";
// var TOO_LONG = "{name}의 길이가 초과되었습니다 (최대 {maxbyte}바이트)";
var STRING_FR  = 6   
var STRING_TO  = 10  
var old_menu = '';
var old_cell = '';

/// 스트링 객체에 메소드 추가 ///

String.prototype.trim = function(str) { 
	str = this != window ? this : str; 
	return str.replace(/^\s+/g,'').replace(/\s+$/g,''); 
}

String.prototype.hasFinalConsonant = function(str) {
	str = this != window ? this : str; 
	var strTemp = str.substr(str.length-1);
	return ((strTemp.charCodeAt(0)-16)%28!=0);
}

String.prototype.bytes = function(str) {
	str = this != window ? this : str;
	for(j=0; j<str.length; j++) {
		var chr = str.charAt(j);
		len += (chr.charCodeAt() > 128) ? 2 : 1
	}
	return len;
}


/// 실질적 폼체크 함수 ///


function validate(form) {
	for (i = 0; i < form.elements.length; i++ ) {
		var el = form.elements[i];
		if (el.tagName == "FIELDSET") continue;
		el.value = el.value.trim();

		var minbyte = el.getAttribute("MINBYTE");
		var maxbyte = el.getAttribute("MAXBYTE");
		var option	= el.getAttribute("OPTION");
		var match	= el.getAttribute("MATCH");
		var glue	= el.getAttribute('GLUE');


		if (el.getAttribute("REQUIRED") != null) {	//필수 사항에 대한 처리
			if (el.value == null || el.value == "") {
				return doError(el,NO_BLANK);
			}
		}

		if (minbyte != null) { //문자열 길이 체크
			if (el.value.bytes() < parseInt(minbyte)) {
				return doError(el,"{name+은는} 최소 "+minbyte+"바이트 이상 입력해야 합니다.");
			}
		}

		if (maxbyte != null && el.value != "") { //문자열 길이 체크
			var len = 0;
			if (el.value.bytes() > parseInt(maxbyte)) {
				return doError(el,"{name}의 길이가 초과되었습니다 (최대 "+maxbyte+"바이트)");
			}
		}

		if (match && (el.value != form.elements[match].value)) return doError(el,"{name+이가} 일치하지 않습니다");  //두개의 문자열 일치 체크

		
		if(option!=="phone2"){		//전화번호 제외
			if (option != null) {   /// 특수 패턴 검사 함수 포워딩 ///
				if (el.getAttribute('SPAN') != null) {
					var _value = new Array();
					for (span=0; span<el.getAttribute('SPAN');span++ ) {
						_value[span] = form.elements[i+span].value;
					}
					var value = _value.join(glue == null ? '' : glue);
					if (!funcs[option](el,value)) return false;
				} else {
					if (!funcs[option](el)) return false;
				}
			}
		}
	}
	return true;
}
// Textarea 글자수 조절
// 입력예제 <textarea onKeyPress="fnChkRemark(this,'50')">  -- fnChkRemark(텍스트값, 자릿수) 

function fnChkRemark(obj, strCnt) {
	var strtempRemark = obj.value;
	var len = 0;
	var tString = '';
	for(j=0; j< strtempRemark.length; j++) {
		var chr = strtempRemark.charAt(j);
		len += (chr.charCodeAt() > 128) ? 2 : 1;
		if (len <= strCnt)
			tString += chr;
	} 
	if (len >= strCnt) {
		alert(' 한글은 '+ strCnt/2 + '자 이하로 입력해 주세요. ');
		obj.focus();
		obj.value = tString;
		return false;
	}		
}

	

function josa(str,tail) {
	return (str.hasFinalConsonant()) ? tail.substring(0,1) : tail.substring(1,2);
}

function doError(el,type,action) { //에러 처리 함수
	var pattern = /{([a-zA-Z0-9_]+)\+?([가-힝]{2})?}/;
	var name = (hname = el.getAttribute("HNAME")) ? hname : el.getAttribute("NAME");
	pattern.exec(type);
	var tail = (RegExp.$2) ? josa(eval(RegExp.$1),RegExp.$2) : "";
	alert(type.replace(pattern,eval(RegExp.$1) + tail));
	if (action == "sel") {
		el.select();
	} else if (action == "del")	{
		el.value = "";
	}
	el.focus();
	return false;
}	

/// 특수 패턴 검사 함수 매핑 ///
var funcs = new Array();
funcs['email']	= isValidEmail;
funcs['phone']	= isValidPhone;
funcs['userid'] = isValidUserid;
funcs['pass']	= isValidPass;
funcs['hangul']	= hasHangul;
funcs['number']	= isNumeric;
funcs['engonly']= alphaOnly;
funcs['jumin']	= isValidJumin;
funcs['bizno']	= isValidBizNo;
funcs['domain'] = isValidDomain;


/// 패턴 검사 함수들 ///
function isValidEmail(el,value) {
	var value = value ? value : el.value;
	var pattern = /^[_a-zA-Z0-9-\.]+@[\.a-zA-Z0-9-]+\.[a-zA-Z]+$/;
	return (pattern.test(value)) ? true : doError(el,NOT_VALID);
}

function isValidUserid(el) {
	var pattern = /^[a-zA-Z]{1}[a-zA-Z0-9_]{3,9}$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+은는} 4자이상 10자 이하이어야 하고, \n\n숫자나 특수문자로 시작할 수 없으며, \n\n영문 또는 영문/숫자 조합이어야 합니다");
}

function isValidPass(el) {
	var pattern = /^[a-zA-Z0-9]{1}[a-zA-Z0-9]{3,14}$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+은는} 4자이상 15자 이하이어야 하고,\n\n영문이나 숫자 영문/숫자 조합이어야 합니다");
}

function hasHangul(el) {
	var pattern = /^[가-힝]+$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+은는} 반드시 한글로만 입력해야 합니다");
}

function alphaOnly(el) {
	var pattern = /^[a-zA-Z/ ]+$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+은는} 반드시 영문으로만 입력해야 합니다");
}

function isNumeric(el) {
	var pattern = /^[0-9]+$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+은는} 반드시 숫자로만 입력해야 합니다","sel");
}

function isValidJumin(el,value) { //주민번호 체크
    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
	var num = value ? value : el.value;
    if (!pattern.test(num)) return doError(el,NOT_VALID); 
    num = RegExp.$1 + RegExp.$2;

	var sum = 0;
	var last = num.charCodeAt(12) - 0x30;
	var bases = "234567892345";
	for (var i=0; i<12; i++) {
		if (isNaN(num.substring(i,i+1))) return doError(el,NOT_VALID);
		sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
	}
	var mod = sum % 11;
	return ((11 - mod) % 10 == last) ? true : doError(el,NOT_VALID);
}

function isValidBizNo(el, value) { //사업번호 체크
    var pattern = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/; 
	var num = value ? value : el.value;
    if (!pattern.test(num)) return doError(el,NOT_VALID); 
    num = RegExp.$1 + RegExp.$2 + RegExp.$3;
    var cVal = 0; 
    for (var i=0; i<8; i++) { 
        var cKeyNum = parseInt(((_tmp = i % 3) == 0) ? 1 : ( _tmp  == 1 ) ? 3 : 7); 
        cVal += (parseFloat(num.substring(i,i+1)) * cKeyNum) % 10; 
    } 
    var li_temp = parseFloat(num.substring(i,i+1)) * 5 + '0'; 
    cVal += parseFloat(li_temp.substring(0,1)) + parseFloat(li_temp.substring(1,2)); 
    return (parseInt(num.substring(9,10)) == 10-(cVal % 10)%10) ? true : doError(el,NOT_VALID); 
}

function isValidPhone(el,value) {//전화번호	
	var pattern = /^[0-9]{2,4}$/;
	var num = value ? value : el.value;
	if (num == null || num == "") {
		return doError(el,NO_BLANK);
	}
	else {

	return (pattern.test(num)) ? true : doError(el,"{name+은는} 3자이상 4자 이하이어야 하고, 반드시 숫자로만 입력해야 합니다");
	}
}

function isValidPhone2(el,value) {//전화번호	
	var pattern = /^[0-9]{2,4}$/;
	var num = value ? value : el.value;
	return (pattern.test(num)) ? true : doError(el,"{name+은는} 3자이상 4자 이하이어야 하고, 반드시 숫자로만 입력해야 합니다");
}




function isValidDomain(el) { //도메인 체크
	var pattern = /^.+(\.[a-zA-Z]{2,3})$/;
	return (pattern.test(el.value)) ? true : doError(el,NOT_VALID);
}

function isValidDomain(el,value) { //도메인 체크
	var value = value ? value : el.value;
	var pattern = new RegExp("^(http://)?(www\.)?([가-힝a-zA-Z0-9-]+\.[a-zA-Z]{2,3}$)","i");
	if (pattern.test(value)) {
		el.value = RegExp.$3;
		return true;
	} else {
		return doError(el,NOT_VALID);
	}
}

function onlyNumber(){             /* 숫자 체크 함수 */

	var e1 = event.srcElement;
	var num ="0123456789";
	event.returnValue = true;

	for (var i=0;i< e1.value.length;i++)
	{
		if(-1 == num.indexOf(e1.value.charAt(i)))
		event.returnValue = false;
	}
	if (!event.returnValue)
	e1.value="";
}


function chk_focus(){	//주민번호 입력시 자동 포커스
	if(document.chk_member.cu_jmno1.value.length == 6){
	document.chk_member.cu_jmno2.focus();
	}
}
function moveFocus(num,fromform,toform){
	var str = fromform.value.length;
	if(str == num)
	toform.focus();
} 


function menuclick( submenu, cellbar, tbl, seq )
{
  if( old_menu != submenu ) {
    if( old_menu !='' ) {
      old_menu.style.display = 'none';
    }
    submenu.style.display = 'block';
    old_menu = submenu;
    old_cell = cellbar;

  } else {
    submenu.style.display = 'none';
    old_menu = '';
    old_cell = '';
  }



}
function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}
function moveLayer(strlayer, left, top) {
	var theObj;
	if (navigator.appName == 'Netscape' && document.layers != null)
		theObj = eval("document.layers['" + strlayer + "']");
	else if (document.all != null) //IE
		theObj = eval("document.all['" + strlayer + "'].style");

	if(theObj) {
		theObj.left = left;
		theObj.top = top;
	}
}

function showLayer(strlayer, left, top) {	//다른 함수에서 콜, 레이어를 show속성으로 변경
	moveLayer(strlayer, left, top);
	MM_showHideLayers(strlayer, "show");
}

function hideLayer(strlayer) {				//다른 함수에서 콜, 레이어를 hide속성으로 변경
	MM_showHideLayers(strlayer, "hide");
}

function showreLayer(url, left, top, tbl, seq) {	//특정 레이어를 컨트롤한다. 특히 게시판이나 달력에서 많이 쓰이고 있음
	if(document.all['LayerA'].style.visibility=="visible")
		hideLayer('LayerA');
	else
		openLayer(reLayer, url+"?tbl="+tbl+"&seq="+seq, 'LayerA', left, top);
}
function openLayer(win, url, strlayer, left, top) {	//
	win.location.href=url
	moveLayer(strlayer, left, top);
	MM_showHideLayers(strlayer, "show");
}




function find_id01() {	//
	var form = document.form1;
	if(form.cu_id.value == ""){
	alert("사용하실 ID를 먼저 입력하세요");
	form.cu_id.focus();
	return;
	}
	if((form.cu_id.value.length<4)||(form.cu_id.value.length>8)){
		alert("사용하실 아이디는 4자 이상 8자 이하입니다.")
		form.cu_id.select();
		return;

	}	
	else {
	window.open("mem_idcheck_pop.asp?cu_id=" + form.cu_id.value,"fdid","width=400,height=174,left=400,top=380");
	}
	return;
}


function fnDayCall2(year,mon,obj,num) {

		var day;
		mon	= parseInt(mon);
		if(year==""){
			alert("년도를 선택하세요   ");
			return;
		}
		if (mon==1 || mon==3 || mon==5 || mon==7 || mon==8 || mon==10 || mon==12) day=31;
		else if (mon==2) { if (year%4==0) day=29; else day=28; } // 2월처리
		else day=30;
		if(mon==8) day=31		


		var obj1 = eval("obj.start_day"+num)
			
		for(i=0 ; i < day; i++){
			str = "0"+(i+1).toString()
			if (str.length==3) str=str.substr(1,2);
			str = fnTrim(str);	//공백제거
			obj1.options[i] = new Option(str,str); 
		}	 
}
function fnDayCall(year,mon,obj) {		//날자를 체크

		var day;
		mon	= parseInt(mon);
		if(year==""){
			alert("년도를 선택하세요   ");
			return;
		}

		if (mon==1 || mon==3 || mon==5 || mon==7 || mon==8 || mon==10 || mon==12) day=31;
		else if (mon==2) { if (year%4==0) day=29; else day=28; } // 2월처리
		else day=30;

		if(mon==0) day=31	

		for(i=obj.length+1; i > 0 ; i--){
			obj.options[i] = null;		
		}		
			
		for(i=0 ; i < day; i++){
			str = "0"+(i+1).toString()
			if (str.length==3) str=str.substr(1,2);
			str = fnTrim(str);	//공백제거
			obj.options[i] = new Option(str,str); 
		}	 
}


function fnChkJumin(value) {    //주민번호 체크 함수

	IDtot = 0;
	IDAdd="234567892345";

	for(i=0;i<12;i++){
			IDtot=IDtot+parseInt(value.substring(i,i+1))*parseInt(IDAdd.substring(i,i+1)); 
	}
	IDtot=11-(IDtot%11);

	if(IDtot==10) {
		IDtot=0;
	}else if(IDtot==11){
		IDtot=1;
	}
	if(parseInt(value.substring(12,13))!=IDtot) return true;
} 


function check_box() {
	var count;
	var form = document.chk_insert; 
	count = 0; 
	var choice = form.elements.length;

	for (var i=0; i<= choice - 1; i++) { 
		if (form.elements[i].checked==true) { 
		   count++; 
		} 
	}
	if (count <= 0) {
		alert("   이용약관에 동의하셔야 합니다 !   "); 
		return false; 
	}
	form.submit();
	 
}




//set todays date
Now = new Date();
NowDay = Now.getDate();
NowMonth = Now.getMonth();
NowYear = Now.getYear();
if (NowYear < 2000) NowYear += 1900; //for Netscape

//윤년을 포함하여 각 월의 날 수 계산하는 함수
function DaysInMonth(WhichMonth, WhichYear)
{
  var DaysInMonth = 31;
  if (WhichMonth == "4" || WhichMonth == "6" || WhichMonth == "9" || WhichMonth == "11") DaysInMonth = 30;
  if (WhichMonth == "2" && (WhichYear/4) != Math.floor(WhichYear/4))	DaysInMonth = 28;
  if (WhichMonth == "2" && (WhichYear/4) == Math.floor(WhichYear/4))	DaysInMonth = 29;
  return DaysInMonth;
}

//각 월에서 사용 가능한 날짜로 변경
function ChangeOptionDays(Which)
{
  DaysObject = eval("document.incentive." + Which + "day");
  MonthObject = eval("document.incentive." + Which + "month");
  YearObject = eval("document.incentive." + Which + "year");

  Month = MonthObject[MonthObject.selectedIndex].text;
  Year = YearObject[YearObject.selectedIndex].text;

  DaysForThisSelection = DaysInMonth(Month, Year);
  CurrentDaysInSelection = DaysObject.length;
  if (CurrentDaysInSelection > DaysForThisSelection)
  {
    for (i=0; i<(CurrentDaysInSelection-DaysForThisSelection); i++)
    {
      DaysObject.options[DaysObject.options.length - 1] = null
    }
  }
  if (DaysForThisSelection > CurrentDaysInSelection)
  {
    for (i=0; i<(DaysForThisSelection-CurrentDaysInSelection); i++)
    {
      NewOption = new Option(DaysObject.options.length + 1);
      DaysObject.add(NewOption);
    }
  }
    if (DaysObject.selectedIndex < 0) DaysObject.selectedIndex == 0;
}

//현재 날짜로 셋팅
function SetToToday(Which)
{
  DaysObject = eval("document.incentive." + Which + "day");
  MonthObject = eval("document.incentive." + Which + "month");
  YearObject = eval("document.incentive." + Which + "year");

  YearObject[0].selected = true;
  MonthObject[NowMonth].selected = true;

  ChangeOptionDays(Which);

  DaysObject[NowDay-1].selected = true;
}

//option years를 지정한 만큼 작성하는 함수
function WriteYearOptions(YearsAhead)
{
  line = "";
  for (i=0; i<YearsAhead; i++)
  {
    line += "<OPTION>";
    line += NowYear + i;
  }
  return line;
}
function ch_evDay(){
	var form    = document.incentive ;
	if (form.ev_day_cnt1.value > form.ev_day_cnt2.value) {
		form.ev_day_cnt2.value = Number(form.ev_day_cnt1.value) + 1
	}
}
function moveFocus(num,fromform,toform){
	var str = fromform.value.length;
	if(str == num)
	toform.focus();
} 



// 이메일 관련
function setEmailEnable(emailcodeObject,ipmenu2Object) {
	if (emailcodeObject.value == "0" || emailcodeObject.value == "9") {
		ipmenu2Object.value = "";
		ipmenu2Object.focus();
	}
	else
		ipmenu2Object.blur();

}
//by jpspace, 2004-08-09, emaildomain을 select로 선택
function setEmailcode(setObject,selectObject,index) {
	setObject.value = selectObject[index].text;
	if (selectObject.value == "0" || selectObject.value == "9") {
		//alert("기타 도메인을 입력하세요!");
		setObject.focus();
	}
	else
		setObject.blur();
		
}



//동영상플레이어 팝업창
function onair() {
	wURL = "/onair.ts";
	var winl = 0
	var wint = 0
	winprops = 'height='+500+',width='+400+',top='+wint+',left='+winl+',toolbar='+0+',location='+0+',status='+0+',menubar='+0+',resizable='+0
	win = window.open(wURL, "광고방송", winprops)
}


function fnCheckBox(obj,value){			//체크박스 체크시 값 세팅
	if(value=="N"){
		obj.value	= "Y";
	}else{
		obj.value	= "N";
	}
}

function isNum(strNum,obj){//숫자인지 확인하는 함수	
	for(i=0; i < strNum.length ; i++){
		if(Number(strNum.charAt(i)) >= 0 || Number(strNum.charAt(i)) <= 9){
			continue;
		}
		else{
			obj.value	= "";
			alert("숫자만 입력 가능합니다.    ");
			return false;
			break;
		}
	}
	return true;
}

function fnAllMoney(strNum1){/////////////단위 환산을 위해
	var strReturn;
	if(strNum1.indexOf(',')=="-1" && strNum1.length==4){
		n=strNum1.length
		if(n>3){
			strReturn=strNum1.substr(0,1)+','+strNum1.substr(1,3);
			return strReturn;
		}
	}else{

		strNum2=strNum1.replace(',','');
		strNum3=strNum2.replace(',','');
		strNum4=strNum3.replace(',','');
		strNum=strNum4.replace(',','');

		n=strNum.length
			if(n<5){
				return strNum;
			}else if(n==5){
				strReturn=strNum.substr(0,2)+','+strNum.substr(2,3);
				return strReturn;
			}else if(n==6){
				strReturn=strNum.substr(0,3)+','+strNum.substr(3,3);
				return strReturn;
			}else if(n==7){
				strReturn=strNum.substr(0,1)+','+strNum.substr(1,3)+','+strNum.substr(4,3);
				return strReturn;
			}else if(n==8){
				strReturn=strNum.substr(0,2)+','+strNum.substr(2,3)+','+strNum.substr(5,3);
				return strReturn;
			}else if(n==9){
				strReturn=strNum.substr(0,3)+','+strNum.substr(3,3)+','+strNum.substr(6,3);
				return strReturn;
			}else if(n==10){
				strReturn=strNum.substr(0,1)+','+strNum.substr(1,3)+','+strNum.substr(4,3)+','+strNum.substr(7,3);
				return strReturn;
			}else if(n==11){
				strReturn=strNum.substr(0,2)+','+strNum.substr(2,3)+','+strNum.substr(5,3)+','+strNum.substr(8,3);//////9999억까지
				return strReturn;
			}else if(n==12){
				strReturn=strNum.substr(0,3)+','+strNum.substr(3,3)+','+strNum.substr(6,3)+','+strNum.substr(9,3);//////9999억까지
				return strReturn;
			}else{
				strReturn=strNum.substr(0,3)+','+strNum.substr(3,3)+','+strNum.substr(6,3)+','+strNum.substr(9,3);//////9999억까지
				return strReturn;
			}
	}
}
function fnReMoney(strValue,strObj){
		strValue=strValue.replace(',','');
		strValue=strValue.replace(',','');
		strValue=strValue.replace(',','');
		strValue=strValue.replace(',','');
		if(isNaN(strValue)){
			alert("가격은 숫자만 입력 가능합니다");
			return;
		}

		if(fnAllMoney(strValue)){
			if(strValue.length==4 && strValue.indexOf(",")!="-1"){
				strObj.value=strValue.substr(0,1)+','+strValue.substr(1,3);
				return false;
			}else if(strValue.length<4){
				strObj.value=strValue;
				return false;
			}else if(strValue.length>14){
				strObj.value='';
				return false;
			}else{
				strObj.value=fnAllMoney(strValue);
				return false;
			}
		}
}

//플래시 박스 없애기
function flash(width,height,flash_name) {
 var flash_tag = "";
 flash_tag = '<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" ';
 flash_tag +='codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0" ';
 flash_tag +='WIDTH="'+width+'" HEIGHT="'+height+'" >';
 flash_tag +='<param name="movie" value="'+flash_name+'">';
 flash_tag +='<param name="quality" value="high">';
 flash_tag +='<param name="wmode" value="transparent">';
 flash_tag +='<embed src="'+flash_name+'" wmode="transparent" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" ';
 flash_tag +='type="application/x-shockwave-flash"  WIDTH="'+width+'" HEIGHT="'+height+'"></embed></object>'
 
 document.write(flash_tag);
}


//이미지주위에 점선없애기
function bluring(){ 
	if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus();
}
//document.onfocusin=bluring;

//윈도우 새창 열기
function fnWinOpen(width,height,name,url,scroll,obj){
	LeftPosition	= (screen.width)?(screen.width-width)/2:100;
	TopPosition		= (screen.height)?(screen.height-height)/2:100;
	winprops		= 'width='+width+', height='+height+', top='+TopPosition+', left='+LeftPosition+' scrollbars='+scroll+', toolbar=no';
	if(obj){
		window.open('',name, winprops);	
		obj.target		= name;
		obj.action		= url;
		obj.submit();
		return;
	}else{
		window.open(url,name, winprops);	
	}
}

function fnWinOpen2(width,height,name,url,scroll,obj){
	LeftPosition	= (screen.width)?(screen.width-width)/2:100;
	TopPosition		= (screen.height)?(screen.height-height)/2:100;
	winprops		= 'width='+width+', height='+height+', top=-1000, left=-1000 scrollbars='+scroll+', toolbar=no';
	window.open('',name, winprops);	
	obj.target		= name;
	obj.action		= url;
	obj.submit();
	return;
}



function fnTrim(str){		//공백제거
	str	= str.replace(/(^\s+)|(\s+)$/,"");
	return str;
}
function fnConfirm(msg){
	ans = confirm(msg);
	if(!ans) return;
}