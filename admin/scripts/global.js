// �����޽��� ���� ���� ///
var NO_BLANK = "{name+����} �Է����ּ���";
var NOT_VALID = "{name+�̰�} �ùٸ��� �ʽ��ϴ�";
// var TOO_LONG = "{name}�� ���̰� �ʰ��Ǿ����ϴ� (�ִ� {maxbyte}����Ʈ)";
var STRING_FR  = 6   
var STRING_TO  = 10  
var old_menu = '';
var old_cell = '';

/// ��Ʈ�� ��ü�� �޼ҵ� �߰� ///

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


/// ������ ��üũ �Լ� ///


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


		if (el.getAttribute("REQUIRED") != null) {	//�ʼ� ���׿� ���� ó��
			if (el.value == null || el.value == "") {
				return doError(el,NO_BLANK);
			}
		}

		if (minbyte != null) { //���ڿ� ���� üũ
			if (el.value.bytes() < parseInt(minbyte)) {
				return doError(el,"{name+����} �ּ� "+minbyte+"����Ʈ �̻� �Է��ؾ� �մϴ�.");
			}
		}

		if (maxbyte != null && el.value != "") { //���ڿ� ���� üũ
			var len = 0;
			if (el.value.bytes() > parseInt(maxbyte)) {
				return doError(el,"{name}�� ���̰� �ʰ��Ǿ����ϴ� (�ִ� "+maxbyte+"����Ʈ)");
			}
		}

		if (match && (el.value != form.elements[match].value)) return doError(el,"{name+�̰�} ��ġ���� �ʽ��ϴ�");  //�ΰ��� ���ڿ� ��ġ üũ

		
		if(option!=="phone2"){		//��ȭ��ȣ ����
			if (option != null) {   /// Ư�� ���� �˻� �Լ� ������ ///
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
// Textarea ���ڼ� ����
// �Է¿��� <textarea onKeyPress="fnChkRemark(this,'50')">  -- fnChkRemark(�ؽ�Ʈ��, �ڸ���) 

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
		alert(' �ѱ��� '+ strCnt/2 + '�� ���Ϸ� �Է��� �ּ���. ');
		obj.focus();
		obj.value = tString;
		return false;
	}		
}

	

function josa(str,tail) {
	return (str.hasFinalConsonant()) ? tail.substring(0,1) : tail.substring(1,2);
}

function doError(el,type,action) { //���� ó�� �Լ�
	var pattern = /{([a-zA-Z0-9_]+)\+?([��-��]{2})?}/;
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

/// Ư�� ���� �˻� �Լ� ���� ///
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


/// ���� �˻� �Լ��� ///
function isValidEmail(el,value) {
	var value = value ? value : el.value;
	var pattern = /^[_a-zA-Z0-9-\.]+@[\.a-zA-Z0-9-]+\.[a-zA-Z]+$/;
	return (pattern.test(value)) ? true : doError(el,NOT_VALID);
}

function isValidUserid(el) {
	var pattern = /^[a-zA-Z]{1}[a-zA-Z0-9_]{3,9}$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+����} 4���̻� 10�� �����̾�� �ϰ�, \n\n���ڳ� Ư�����ڷ� ������ �� ������, \n\n���� �Ǵ� ����/���� �����̾�� �մϴ�");
}

function isValidPass(el) {
	var pattern = /^[a-zA-Z0-9]{1}[a-zA-Z0-9]{3,14}$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+����} 4���̻� 15�� �����̾�� �ϰ�,\n\n�����̳� ���� ����/���� �����̾�� �մϴ�");
}

function hasHangul(el) {
	var pattern = /^[��-��]+$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� �ѱ۷θ� �Է��ؾ� �մϴ�");
}

function alphaOnly(el) {
	var pattern = /^[a-zA-Z/ ]+$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� �������θ� �Է��ؾ� �մϴ�");
}

function isNumeric(el) {
	var pattern = /^[0-9]+$/;
	return (pattern.test(el.value)) ? true : doError(el,"{name+����} �ݵ�� ���ڷθ� �Է��ؾ� �մϴ�","sel");
}

function isValidJumin(el,value) { //�ֹι�ȣ üũ
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

function isValidBizNo(el, value) { //�����ȣ üũ
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

function isValidPhone(el,value) {//��ȭ��ȣ	
	var pattern = /^[0-9]{2,4}$/;
	var num = value ? value : el.value;
	if (num == null || num == "") {
		return doError(el,NO_BLANK);
	}
	else {

	return (pattern.test(num)) ? true : doError(el,"{name+����} 3���̻� 4�� �����̾�� �ϰ�, �ݵ�� ���ڷθ� �Է��ؾ� �մϴ�");
	}
}

function isValidPhone2(el,value) {//��ȭ��ȣ	
	var pattern = /^[0-9]{2,4}$/;
	var num = value ? value : el.value;
	return (pattern.test(num)) ? true : doError(el,"{name+����} 3���̻� 4�� �����̾�� �ϰ�, �ݵ�� ���ڷθ� �Է��ؾ� �մϴ�");
}




function isValidDomain(el) { //������ üũ
	var pattern = /^.+(\.[a-zA-Z]{2,3})$/;
	return (pattern.test(el.value)) ? true : doError(el,NOT_VALID);
}

function isValidDomain(el,value) { //������ üũ
	var value = value ? value : el.value;
	var pattern = new RegExp("^(http://)?(www\.)?([��-��a-zA-Z0-9-]+\.[a-zA-Z]{2,3}$)","i");
	if (pattern.test(value)) {
		el.value = RegExp.$3;
		return true;
	} else {
		return doError(el,NOT_VALID);
	}
}

function onlyNumber(){             /* ���� üũ �Լ� */

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


function chk_focus(){	//�ֹι�ȣ �Է½� �ڵ� ��Ŀ��
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

function showLayer(strlayer, left, top) {	//�ٸ� �Լ����� ��, ���̾ show�Ӽ����� ����
	moveLayer(strlayer, left, top);
	MM_showHideLayers(strlayer, "show");
}

function hideLayer(strlayer) {				//�ٸ� �Լ����� ��, ���̾ hide�Ӽ����� ����
	MM_showHideLayers(strlayer, "hide");
}

function showreLayer(url, left, top, tbl, seq) {	//Ư�� ���̾ ��Ʈ���Ѵ�. Ư�� �Խ����̳� �޷¿��� ���� ���̰� ����
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
	alert("����Ͻ� ID�� ���� �Է��ϼ���");
	form.cu_id.focus();
	return;
	}
	if((form.cu_id.value.length<4)||(form.cu_id.value.length>8)){
		alert("����Ͻ� ���̵�� 4�� �̻� 8�� �����Դϴ�.")
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
			alert("�⵵�� �����ϼ���   ");
			return;
		}
		if (mon==1 || mon==3 || mon==5 || mon==7 || mon==8 || mon==10 || mon==12) day=31;
		else if (mon==2) { if (year%4==0) day=29; else day=28; } // 2��ó��
		else day=30;
		if(mon==8) day=31		


		var obj1 = eval("obj.start_day"+num)
			
		for(i=0 ; i < day; i++){
			str = "0"+(i+1).toString()
			if (str.length==3) str=str.substr(1,2);
			str = fnTrim(str);	//��������
			obj1.options[i] = new Option(str,str); 
		}	 
}
function fnDayCall(year,mon,obj) {		//���ڸ� üũ

		var day;
		mon	= parseInt(mon);
		if(year==""){
			alert("�⵵�� �����ϼ���   ");
			return;
		}

		if (mon==1 || mon==3 || mon==5 || mon==7 || mon==8 || mon==10 || mon==12) day=31;
		else if (mon==2) { if (year%4==0) day=29; else day=28; } // 2��ó��
		else day=30;

		if(mon==0) day=31	

		for(i=obj.length+1; i > 0 ; i--){
			obj.options[i] = null;		
		}		
			
		for(i=0 ; i < day; i++){
			str = "0"+(i+1).toString()
			if (str.length==3) str=str.substr(1,2);
			str = fnTrim(str);	//��������
			obj.options[i] = new Option(str,str); 
		}	 
}


function fnChkJumin(value) {    //�ֹι�ȣ üũ �Լ�

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
		alert("   �̿����� �����ϼž� �մϴ� !   "); 
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

//������ �����Ͽ� �� ���� �� �� ����ϴ� �Լ�
function DaysInMonth(WhichMonth, WhichYear)
{
  var DaysInMonth = 31;
  if (WhichMonth == "4" || WhichMonth == "6" || WhichMonth == "9" || WhichMonth == "11") DaysInMonth = 30;
  if (WhichMonth == "2" && (WhichYear/4) != Math.floor(WhichYear/4))	DaysInMonth = 28;
  if (WhichMonth == "2" && (WhichYear/4) == Math.floor(WhichYear/4))	DaysInMonth = 29;
  return DaysInMonth;
}

//�� ������ ��� ������ ��¥�� ����
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

//���� ��¥�� ����
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

//option years�� ������ ��ŭ �ۼ��ϴ� �Լ�
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



// �̸��� ����
function setEmailEnable(emailcodeObject,ipmenu2Object) {
	if (emailcodeObject.value == "0" || emailcodeObject.value == "9") {
		ipmenu2Object.value = "";
		ipmenu2Object.focus();
	}
	else
		ipmenu2Object.blur();

}
//by jpspace, 2004-08-09, emaildomain�� select�� ����
function setEmailcode(setObject,selectObject,index) {
	setObject.value = selectObject[index].text;
	if (selectObject.value == "0" || selectObject.value == "9") {
		//alert("��Ÿ �������� �Է��ϼ���!");
		setObject.focus();
	}
	else
		setObject.blur();
		
}



//�������÷��̾� �˾�â
function onair() {
	wURL = "/onair.ts";
	var winl = 0
	var wint = 0
	winprops = 'height='+500+',width='+400+',top='+wint+',left='+winl+',toolbar='+0+',location='+0+',status='+0+',menubar='+0+',resizable='+0
	win = window.open(wURL, "������", winprops)
}


function fnCheckBox(obj,value){			//üũ�ڽ� üũ�� �� ����
	if(value=="N"){
		obj.value	= "Y";
	}else{
		obj.value	= "N";
	}
}

function isNum(strNum,obj){//�������� Ȯ���ϴ� �Լ�	
	for(i=0; i < strNum.length ; i++){
		if(Number(strNum.charAt(i)) >= 0 || Number(strNum.charAt(i)) <= 9){
			continue;
		}
		else{
			obj.value	= "";
			alert("���ڸ� �Է� �����մϴ�.    ");
			return false;
			break;
		}
	}
	return true;
}

function fnAllMoney(strNum1){/////////////���� ȯ���� ����
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
				strReturn=strNum.substr(0,2)+','+strNum.substr(2,3)+','+strNum.substr(5,3)+','+strNum.substr(8,3);//////9999�����
				return strReturn;
			}else if(n==12){
				strReturn=strNum.substr(0,3)+','+strNum.substr(3,3)+','+strNum.substr(6,3)+','+strNum.substr(9,3);//////9999�����
				return strReturn;
			}else{
				strReturn=strNum.substr(0,3)+','+strNum.substr(3,3)+','+strNum.substr(6,3)+','+strNum.substr(9,3);//////9999�����
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
			alert("������ ���ڸ� �Է� �����մϴ�");
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

//�÷��� �ڽ� ���ֱ�
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


//�̹��������� �������ֱ�
function bluring(){ 
	if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus();
}
//document.onfocusin=bluring;

//������ ��â ����
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



function fnTrim(str){		//��������
	str	= str.replace(/(^\s+)|(\s+)$/,"");
	return str;
}
function fnConfirm(msg){
	ans = confirm(msg);
	if(!ans) return;
}