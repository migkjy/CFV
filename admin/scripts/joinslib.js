
//팝업메뉴
var arrsubmenu = new Array(9); 
arrsubmenu[0] = "1px";


//==============================================
//submenu
//==============================================
function funScroll() {
	//top.frames["frameBody"].document.getElementById("dissubmenu").style.visibility = "hidden";
	//top.frames["frameBody"].document.getElementById("dissubmenu").style.top = (1 +  window.document.body.scrollTop) + "px";
}




function submenuhidden() {
	top.frames["frameTop"].document.getElementById("dissubmenu").style.visibility = "hidden";
}




function retHCenter(arg) {
	try{
		if(KindOfBrowser()=="IE") {
			return Math.floor((window.document.body.clientWidth - arg) / 2);
		} else {
			return Math.floor((window.innerWidth - arg) / 2);
		}
	} catch(ex) {
		return 0;
	}
}

function retVCenter(arg) {
	try{
		if(KindOfBrowser()=="IE") {
			return Math.floor((window.document.body.clientHeight - arg) / 2);
		} else {
			return Math.floor((window.innerHeight - arg) / 2);
		}
	} catch(ex) {
		return 0;
	}
}


function gbInvalidText(arg) {
	var strMatch=/[^0-9^a-z^A-Z]/gi;
	
	if(strMatch.test(arg)) {
		return true;
	} else {
		return false;
	}
}


function chkDate(arg1,arg2,arg3) {
	var arrMonth = [0,31,28,31,30,31,30,31,31,30,31,30,31];
	var yy = retNum(arg1.toString());
	var mm = retNum(arg2.toString());
	var dd = retNum(arg3.toString());
	if(yy == "" || mm == "" || dd == "") {
			return false;
	}
	if(mm < 1 || mm > 12) {
		 return false ;
	}
	if(yy % 4 == 0) {
		arrMonth[2] = 29;
	}
	if(dd < 1 || dd > arrMonth[mm]) {
		return false;
	}
	return true;
}
function chkBizNo(argBizno){ 
  	var checksum = 0; 
	var arrNo = new Array(10); 
	var arrDigit = new Array("1","3","7","1","3","7","1","3","5"); 
	var modVal = 0;
	var checkDigit = 0;
        var Biznum = argBizno.replace(/[^0-9]/g,'');
	
	if(Biznum.length < 10) {
		arrNo = null;
		arrDigit = null;
		return false;
	}
  	for (i=0;i<10;i++){   
      		arrNo[i] = Biznum.substring(i,i+1); 
  	} 
  	for (i=0;i<9;i++){   
      		checksum += arrNo[i]* arrDigit[i]; 
  	} 
  	checksum = checksum + parseInt((arrNo[8] * 5) / 10) ; 
  	modVal = checksum % 10; 
  	if ( modVal != 0 ) {   
      		checkDigit = 10 - modVal;   
  	} else {   
      		checkDigit = 0;   
  	} 
  	if ( checkDigit != arrNo[9] ) { 
		arrNo = null;
		arrDigit = null;
      		return false; 
  	} 
	arrNo = null;
	arrDigit = null;
  	return true; 
  	} 


function autotab1(arg1,arg2,evt) {
	var keyCode = (KindOfBrowser() == "IE") ? evt.keyCode : evt.which;
	if(keyCode !=9 && keyCode != 16 && KindOfBrowser() == "IE") {
		if(arg1.value.length >= arg1.maxLength) {
			eval("document.getElementById('" + arg2 + "')").focus();
		}
	}
}


function autotab(arg,evt) {
        if(evt.keyCode != 9 && evt.keyCode != 16 && KindOfBrowser() == "IE") {
                if(arg.value.length >= arg.maxLength) {
                        for(i=0;i<document.forms[0].elements.length;i++) {
                                if(arg.name == document.forms[0].elements[i].name) {
                                        break;
                                }
                        }
                        document.forms[0].elements[i+1].focus();
                }
        }
}


function retNum(arg) {
        return arg.replace(/[^0-9]/g,'');               
}


function onlyNumPoint(arg,evt) {
	var keyCode = (KindOfBrowser() == "IE") ? evt.keyCode : evt.which;
        var str = arg.value; 
        if(keyCode != 9 && keyCode != 16) {
                str = str.replace(/[^0-9.]/g,'');               
                arg.value = str;
	}
}



function onlyNum(arg,evt) {
	var keyCode = (KindOfBrowser() == "IE") ? evt.keyCode : evt.which;
        var str = arg.value; 
        if(keyCode != 9 && keyCode != 16) {
                str = str.replace(/[^0-9]/g,'');               
                arg.value = str;
	}
}
                       
function onlyNumHyphen(arg,evt) {
	var keyCode = (KindOfBrowser() == "IE") ? evt.keyCode : evt.which;
        var str = arg.value; 
        if(keyCode != 9 && keyCode != 16) {
                str = str.replace(/[^0-9-]/g,'');               
                arg.value = str;
	}
}

function onlyNumHyphenpr(arg,evt) {
	var keyCode = (KindOfBrowser() == "IE") ? evt.keyCode : evt.which;
        var str = arg.value; 
        if(keyCode != 9 && keyCode != 16) {
                str = str.replace(/[^0-9-()]/g,'');               
                arg.value = str;
	}
}


function PointNumFormat(arg,evt) {
        var str = arg.value; 
        var repnum = /[^0-9-+.]/gi; 
        var numfm;
        var numSign="";
        var PointNum="";

	if(str.substr(0,1) == "+" || str.substr(0,1) == "-") {
        	numSign=str.substr(0,1);
        	str=str.substr(1,str.length - 1);
	}
	
	if(str.lastIndexOf(".") != -1) {
		PointNum = str.substr(str.lastIndexOf("."),str.length - str.lastIndexOf("."));
		str = str.substr(0,str.lastIndexOf("."));
	}
	

	str = str.replace(/[^0-9]/gi,'');   
        if((evt.keyCode != 9 && evt.keyCode != 16 )) {
        	
                if(str.length >= 4 && str.length <= 6) {
                        numfm = /([0-9]+)([0-9]{3})/;
                        str = str.replace(numfm, "$1,$2"); 
                } else if(str.length >= 7 && str.length <= 9) {
                        numfm = /([0-9]+)([0-9]{3})([0-9]{3})/; 
                        str = str.replace(numfm, "$1,$2,$3"); 
                } else if(str.length >= 10 && str.length <= 12) {
                        numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})/; 
                        str = str.replace(numfm, "$1,$2,$3,$4"); 
                } else if(str.length >= 13 && str.length <= 15) {
                        numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})/; 
                        str = str.replace(numfm, "$1,$2,$3,$4,$5"); 
                } else if(str.length >= 16 && str.length <= 18) {
                        numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})/; 
                        str = str.replace(numfm, "$1,$2,$3,$4,$5,$6"); 
                }
                arg.value = numSign + str + PointNum;
        }
}

function PointAmountFormat(arg,len) {
        var str = arg.toString(); 
        var repnum = /[^0-9-+]/g; 
        var numfm;
        var numSign="";
        var PointNum="";

	if(str.substr(0,1) == "+" || str.substr(0,1) == "-") {
        	numSign=str.substr(0,1);
        	str=str.substr(1,str.length - 1);
	}

	if(str.lastIndexOf(".") != -1) {
		PointNum = str.substr(str.lastIndexOf("."),str.length - str.lastIndexOf("."));
		str = str.substr(0,str.lastIndexOf("."));
		if(PointNum.length - 1 >= len) {
			PointNum = PointNum.substr(0,len + 1);
		}
	}


        str = str.replace(/[^0-9]/gi,'');   
        if(str.length >= 4 && str.length <= 6) {
                numfm = /([0-9]+)([0-9]{3})/;
                str = str.replace(numfm, "$1,$2"); 
        } else if(str.length >= 7 && str.length <= 9) {
                numfm = /([0-9]+)([0-9]{3})([0-9]{3})/; 
                str = str.replace(numfm, "$1,$2,$3"); 
        } else if(str.length >= 10 && str.length <= 12) {
                numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})/; 
                str = str.replace(numfm, "$1,$2,$3,$4"); 
        } else if(str.length >= 13 && str.length <= 15) {
                numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})/; 
                str = str.replace(numfm, "$1,$2,$3,$4,$5"); 
        } else if(str.length >= 16 && str.length <= 18) {
                numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})/; 
                str = str.replace(numfm, "$1,$2,$3,$4,$5,$6"); 
        }
        return numSign + str  + PointNum;
}

                
function NumFormat(arg,evt) {
        var str = arg.value; 
        var repnum = /[^0-9-+]/gi; 
        var numfm;
        var numSign="";

	if(str.substr(0,1) == "+" || str.substr(0,1) == "-") {
        	numSign=str.substr(0,1);
        	str=str.substr(1,str.length - 1);
	}
	str = str.replace(/[^0-9]/gi,'');   
	
	
        if((evt.keyCode != 9 && evt.keyCode != 16 )) {
        	//str = str.replace(repnum,'');           
                if(str.length >= 4 && str.length <= 6) {
                        numfm = /([0-9]+)([0-9]{3})/;
                        str = str.replace(numfm, "$1,$2"); 
                } else if(str.length >= 7 && str.length <= 9) {
                        numfm = /([0-9]+)([0-9]{3})([0-9]{3})/; 
                        str = str.replace(numfm, "$1,$2,$3"); 
                } else if(str.length >= 10 && str.length <= 12) {
                        numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})/; 
                        str = str.replace(numfm, "$1,$2,$3,$4"); 
                } else if(str.length >= 13 && str.length <= 15) {
                        numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})/; 
                        str = str.replace(numfm, "$1,$2,$3,$4,$5"); 
                } else if(str.length >= 16 && str.length <= 18) {
                        numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})/; 
                        str = str.replace(numfm, "$1,$2,$3,$4,$5,$6"); 
                }
                arg.value = numSign + str;
        }
}


function AmountFormat(arg) {
        var str = arg.toString(); 
        var repnum = /[^0-9-+]/g; 
        var numfm;
        var numSign="";

	if(str.substr(0,1) == "+" || str.substr(0,1) == "-") {
        	numSign=str.substr(0,1);
        	str=str.substr(1,str.length - 1);
	}

        str = str.replace(/[^0-9]/gi,'');   
        if(str.length >= 4 && str.length <= 6) {
                numfm = /([0-9]+)([0-9]{3})/;
                str = str.replace(numfm, "$1,$2"); 
        } else if(str.length >= 7 && str.length <= 9) {
                numfm = /([0-9]+)([0-9]{3})([0-9]{3})/; 
                str = str.replace(numfm, "$1,$2,$3"); 
        } else if(str.length >= 10 && str.length <= 12) {
                numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})/; 
                str = str.replace(numfm, "$1,$2,$3,$4"); 
        } else if(str.length >= 13 && str.length <= 15) {
                numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})/; 
                str = str.replace(numfm, "$1,$2,$3,$4,$5"); 
        } else if(str.length >= 16 && str.length <= 18) {
                numfm = /([0-9]+)([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})([0-9]{3})/; 
                str = str.replace(numfm, "$1,$2,$3,$4,$5,$6"); 
        }
        return numSign + str;
}





function KindOfBrowser() {
	if (navigator.userAgent.indexOf("MSIE") != -1) {
		return "IE";
	} else if (navigator.userAgent.indexOf("Firefox") != -1) {
		return "FF";
	} else if (navigator.userAgent.indexOf("Netscape") != -1) {
		return "NC";
	} else if (navigator.userAgent.indexOf("Konqueror") != -1) {
		return "KQ";
	} else if (navigator.userAgent.indexOf("Galeon") != -1) {		
		return "GO";
	} else if(window.opera) {
		return "OP";
	} else {
		return "NO";
	}
}


function getAjax() {
	if(window.ActiveXObject) {
		try { 
			return new ActiveXObject("Msxml2.XMLHTTP");
		} catch(e1) {
			try {
				return new ActiveXObject("Microsoft.XMLHTTP");
			} catch(e2) {
				return null;
			}
		}
	} else if(window.XMLHttpRequest) {
			return new XMLHttpRequest();
	} else {
		return null;
	}
}


function ChkIdNo(idno1,idno2) {
        var sum = 0;
        var chkdigit = 0;
        var na  = 0;
        
        if(idno1 == "" || idno2 == "") {
        	return false;
        }

        if (idno1.length == 6 && idno2.length == 7) {
                sum = idno1.substr(0, 1) * 2;
                sum += idno1.substr(1, 1) * 3;
                sum += idno1.substr(2, 1) * 4;
                sum += idno1.substr(3, 1) * 5;
                sum += idno1.substr(4, 1) * 6;
                sum += idno1.substr(5, 1) * 7;

                sum += idno2.substr(0, 1) * 8;
                sum += idno2.substr(1, 1) * 9;
                sum += idno2.substr(2, 1) * 2;
                sum += idno2.substr(3, 1) * 3;
                sum += idno2.substr(4, 1) * 4;
                sum += idno2.substr(5, 1) * 5;
                chkdigit = idno2.substr(6, 1);

                na = sum % 11;
                na = 11 - na;

                if (na >= 10) {
                    	na = na - 10;
                }

                if (chkdigit == na) {
                    	return true;
                }

                if ((na == 1 && chkdigit == 0) || (na == 0 && chkdigit == 1)) {
                    	return true;
                }
        }
        return false;
}

function retDay(argDate) {
        switch(argDate.getMonth()) {
                case 0:
                        return 31;
                case 1:
                        if((argDate.getFullYear() % 4) == 0) {
                                return 29;
                        } else {
                                return 28;
                        }
                case 2:
                        return 31;
                case 3:
                        return 30;
                case 4:
                        return 31;
                case 5:
                        return 30;
                case 6:
                        return 31;
                case 7:
                        return 31;
                case 8:
                        return 30;
                case 9:
                        return 31;
                case 10:
                        return 30;
                case 11:
                        return 31;
	}
}
		
function getWeekDay(argDate) {
        switch (argDate.getDay()) {        
                case 0: 
                        return "일요일";
                case 1: 
                        return "월요일";
                case 2: 
                        return "화요일";
                case 3: 
                        return "수요일";
                case 4: 
                        return "목요일";
                case 5: 
                        return "금요일";
                case 6: 
                        return "토요일";
        }
}

//날자계산  파라미터 -- 초

function gbDiffSec(curDate,diffDate) {
        var diff=0;
        if(curDate > diffDate) {
	        diff = curDate.getTime() - diffDate.getTime();
        	return diff = Math.round(diff / 1000);
        } else {
        	return diff;
        }
}



function gbCompDay(arg) {
	var gbtmp=0;
   	if(arg >= 86400) {
   		gbtmp = Math.floor(arg / 86400);
   		return gbtmp;
   	} 
   	return gbtmp;
}

function gbCompDayMod(arg) {
	var gbtmp=0;
   	if(arg >= 86400) {
   		gbtmp = arg % 86400;
   		return gbtmp;
   	} 
   	return arg;
}


function gbCompHour(arg) {
	var gbtmp=0;
   	if(arg >= 3600) {
   		gbtmp = Math.floor(arg / 3600);
   		return gbtmp;
   	}
   	return gbtmp;
}

function gbCompHourMod(arg) {
	var gbtmp=0;
   	if(arg >= 3600) {
   		gbtmp = arg % 3600;
   		return gbtmp;
   	}
   	return arg;
}

	
function gbCompMin(arg) {
	var gbtmp=0;
   	if(arg >= 60) {
   		gbtmp = Math.floor(arg / 60);
   		return gbtmp;
   	}
   	return gbtmp;
}

function gbCompMinMod(arg) {
	var gbtmp=0;
   	if(arg >= 60) {
   		gbtmp = arg % 60;
   		return gbtmp;
   	}
   	return arg;
}


function gbTodayTime(arg) {
	var dt = new Date();
	var yy=dt.getFullYear();
	var mm = ((dt.getMonth() + 1) < 10) ? "0" + (dt.getMonth() + 1) : (dt.getMonth() + 1);
	var dd = (dt.getDate() < 10) ? "0" + dt.getDate() : dt.getDate();
	var h = (dt.getHours() < 10) ? "0" + dt.getHours() : dt.getHours() ;
	var m = (dt.getMinutes() < 10) ? "0" + dt.getMinutes()  : dt.getMinutes() ;
	var s = (dt.getSeconds() < 10) ? "0" + dt.getSeconds() : dt.getSeconds();
	switch(arg) {
		//날자만
		case 1: 
			return yy + "-" + mm + "-" + dd;
		//시간만	
		case 2:
			return h + ":" + m + ":" + s;
		//전체 날자와 시간
		case 3:
			return yy + "-" + mm + "-" + dd + " " + h + ":" + m + ":" + s;
		//초를 제외한 날자와 시간
		case 4:
			return yy + "-" + mm + "-" + dd + " " + h + ":" + m;
	}
}
				