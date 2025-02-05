

function funSetToggle(sw) {
	switch(sw) {
		case 1: //숙소명
				if(document.f.fdorder84.checked) {
					document.f.fdorder84.checked = true;
					document.getElementById("idset1").style.display="inline";
				} else {
					document.f.fdorder84.checked = false;
					document.getElementById("idset1").style.display="none";
					document.f.fdorder35.value="";
					document.f.fdorder3701.value="";
					document.f.fdorder3702.value="";
					document.f.fdorder3703.value="";
					document.f.fdorder3704.value="";
				}
				break;
		case 2: //관광차량
				if(document.f.fdorder85.checked) {
					document.f.fdorder85.checked = true;
					document.getElementById("idset2").style.display="inline";
				} else {
					document.f.fdorder85.checked = false;
					document.getElementById("idset2").style.display="none";
					document.f.fdorder3801.value="";
					document.f.fdorder3802.value="";
					document.f.fdorder3803.value="";
					document.f.fdorder3805.value="";
				}
				break;
		case 3: //렌트사
				if(document.f.fdorder86.checked) {
					document.f.fdorder86.checked = true;
					document.getElementById("idset3").style.display="inline";
				} else {
					document.f.fdorder86.checked = false;
					document.getElementById("idset3").style.display="none";
					document.f.fdorder3901.value="";
					document.f.fdorder3902.value="";
					document.f.fdorder3905.value="";
					document.f.fdorder43.value="";
				}
				break;
		case 4: //입장료
				if(document.f.fdorder87.checked) {
					document.f.fdorder87.checked = true;
					document.getElementById("idset4").style.display="inline";
				} else {
					document.f.fdorder87.checked = false;
					document.getElementById("idset4").style.display="none";
					document.f.fdorder4401.value="0";
					document.f.fdorder4402.value="";
					document.f.fdorder4403.value="";
					document.f.fdorder4501.value="0";
					document.f.fdorder4502.value="";
					document.f.fdorder4503.value="";
					document.f.fdorder4601.value="0";
					document.f.fdorder4602.value="";
					document.f.fdorder4603.value="";
					document.f.fdorder4701.value="0";
					document.f.fdorder4702.value="";
					document.f.fdorder4703.value="";
				}
				break;
		case 5: //식사비
				if(document.f.fdorder88.checked) {
					document.f.fdorder88.checked = true;
					document.getElementById("idset5").style.display="inline";
				} else {
					document.f.fdorder88.checked = false;
					document.getElementById("idset5").style.display="none";
					document.f.fdorder4801.value="";
					document.f.fdorder4802.value="";
					document.f.fdorder4803.value="";
					document.f.fdorder4804.value="";
					document.f.fdorder4901.value="";
					document.f.fdorder4902.value="";
					document.f.fdorder4903.value="";
					document.f.fdorder4904.value="";
					document.f.fdorder5001.value="";
					document.f.fdorder5002.value="";
					document.f.fdorder5003.value="";
					document.f.fdorder5004.value="";
				}
				break;
		case 6: //항공료
				if(document.f.fdorder92.checked) {
					document.f.fdorder92.checked = true;
					document.getElementById("idset6").style.display="inline";
				} else {
					document.f.fdorder92.checked = false;
					document.getElementById("idset6").style.display="none";
					document.f.fdorder2701.value="0";
					document.f.fdorder2702.value="0";
					document.f.fdorder2703.value="0";
					document.f.fdorder2705.value="0";
					document.f.fdorder2801.value="0";
					document.f.fdorder2802.value="0";
					document.f.fdorder2803.value="0";
					document.f.fdorder2805.value="0";
					document.f.fdorder2901.value="0";
					document.f.fdorder2902.value="0";
					document.f.fdorder2903.value="0";
					document.f.fdorder2905.value="0";
					document.f.fdorder3001.value="0";
					document.f.fdorder3002.value="0";
					document.f.fdorder3003.value="0";
					document.f.fdorder3005.value="0";
					document.f.fdorder3006.value="0";

				}
				break;
	}
}




function funSyncDate1() {
	funSyncYear1(document.f.fdorder140101);
	funSyncMonth1(document.f.fdorder140102);
	funSyncDay1(document.f.fdorder140103);
	funUseTime();
}

function funSyncDate2() {
	funSyncYear2(document.f.fdorder160101);
	funSyncMonth2(document.f.fdorder160102);
	funSyncDay2(document.f.fdorder160103);
	funUseTime();
}





function funSyncYear1(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4001.options.length;


	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4001.options[i].value) {
			document.f.fdorder4001.options[i].selected = true;
			
		} else {
			document.f.fdorder4001.options[i].selected = false;
		}
	}
}


function funSyncYear2(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4101.options.length;
	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4101.options[i].value) {
			document.f.fdorder4101.options[i].selected = true;
		} else {
			document.f.fdorder4101.options[i].selected = false;
		}
	}
}


function funSyncMonth1(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4002.options.length;
	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4002.options[i].value) {
			document.f.fdorder4002.options[i].selected = true;
		} else {
			document.f.fdorder4002.options[i].selected = false;
		}
	}
}

function funSyncMonth2(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4102.options.length;
	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4102.options[i].value) {
			document.f.fdorder4102.options[i].selected = true;
		} else {
			document.f.fdorder4102.options[i].selected = false;
		}
	}
}


function funSyncDay1(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4003.options.length;
	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4003.options[i].value) {
			document.f.fdorder4003.options[i].selected = true;
		} else {
			document.f.fdorder4003.options[i].selected = false;
		}
	}
}

function funSyncDay2(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4103.options.length;
	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4103.options[i].value) {
			document.f.fdorder4103.options[i].selected = true;
		} else {
			document.f.fdorder4103.options[i].selected = false;
		}
	}
}


function funSyncHour1(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4004.options.length;
	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4004.options[i].value) {
			document.f.fdorder4004.options[i].selected = true;
		} else {
			document.f.fdorder4004.options[i].selected = false;
		}
	}
}

function funSyncHour2(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4104.options.length;
	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4104.options[i].value) {
			document.f.fdorder4104.options[i].selected = true;
		} else {
			document.f.fdorder4104.options[i].selected = false;
		}
	}
}

function funSyncMin1(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4005.options.length;
	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4005.options[i].value) {
			document.f.fdorder4005.options[i].selected = true;
		} else {
			document.f.fdorder4005.options[i].selected = false;
		}
	}
}

function funSyncMin2(obj) {
	var optcnt=0;

	optcnt=document.f.fdorder4105.options.length;
	for(i=0;i<optcnt;i++) {
		if(obj.value == document.f.fdorder4105.options[i].value) {
			document.f.fdorder4105.options[i].selected = true;
		} else {
			document.f.fdorder4105.options[i].selected = false;
		}
	}
}


function funSyncDate() {
	var optcnt=0;
	var opt;

	optcnt=document.f.fdorder4001.options.length;
	for(i=0;i<optcnt;i++) {
		if(document.f.fdorder140101.value == document.f.fdorder4001.options[i].value) {
			document.f.fdorder4001.options[i].selected = true;
		} else {
			document.f.fdorder4001.options[i].selected = false;
		}

		if(document.f.fdorder160101.value == document.f.fdorder4101.options[i].value) {
			document.f.fdorder4101.options[i].selected = true;
		} else {
			document.f.fdorder4101.options[i].selected = false;
		}
	}

	optcnt=document.f.fdorder4002.options.length;
	for(i=0;i<optcnt;i++) {
		if(document.f.fdorder140102.value == document.f.fdorder4002.options[i].value) {
			document.f.fdorder4002.options[i].selected = true;
		} else {
			document.f.fdorder4002.options[i].selected = false;
		}

		if(document.f.fdorder160102.value == document.f.fdorder4102.options[i].value) {
			document.f.fdorder4102.options[i].selected = true;
		} else {
			document.f.fdorder4102.options[i].selected = false;
		}
	}
	
	
	optcnt=document.f.fdorder4003.options.length;
    	for(i=0;i<optcnt;i++) {
            	document.f.fdorder4003.options[0] = null;
    	} 
	optcnt=document.f.fdorder140103.options.length;
    	for(i=1;i<=optcnt;i++) {
            	if(i < 10) {
                    	tmpval = "0" + i.toString();
            	} else {
                    	tmpval = i;
            	}
            	opt = document.createElement('OPTION');
            	opt.text = tmpval;
            	opt.value = tmpval;
            	if(document.f.fdorder140103.options[i-1].selected) {
            		opt.selected=true;
            	} else {
            		opt.selected=false;
            	}
            	document.f.fdorder4003.options.add(opt);
    	} 
	
	optcnt=document.f.fdorder4103.options.length;
    	for(i=0;i<optcnt;i++) {
            	document.f.fdorder4103.options[0] = null;
    	} 
	optcnt=document.f.fdorder160103.options.length;
    	for(i=1;i<=optcnt;i++) {
            	if(i < 10) {
                    	tmpval = "0" + i.toString();
            	} else {
                    	tmpval = i;
            	}
            	opt = document.createElement('OPTION');
            	opt.text = tmpval;
            	opt.value = tmpval;
            	if(document.f.fdorder160103.options[i-1].selected) {
            		opt.selected=true;
            	} else {
            		opt.selected=false;
            	}
            	document.f.fdorder4103.options.add(opt);
    	} 
	
	
	optcnt=document.f.fdorder4004.options.length;
	for(i=0;i<optcnt;i++) {
		if(document.f.fdorder140104.value == document.f.fdorder4004.options[i].value) {
			document.f.fdorder4004.options[i].selected = true;
		} else {
			document.f.fdorder4004.options[i].selected = false;
		}

		if(document.f.fdorder160104.value == document.f.fdorder4104.options[i].value) {
			document.f.fdorder4104.options[i].selected = true;
		} else {
			document.f.fdorder4104.options[i].selected = false;
		}
	}
	
	optcnt=document.f.fdorder4005.options.length;
	for(i=0;i<optcnt;i++) {
		if(document.f.fdorder140105.value == document.f.fdorder4005.options[i].value) {
			document.f.fdorder4005.options[i].selected = true;
		} else {
			document.f.fdorder4005.options[i].selected = false;
		}

		if(document.f.fdorder160105.value == document.f.fdorder4105.options[i].value) {
			document.f.fdorder4105.options[i].selected = true;
		} else {
			document.f.fdorder4105.options[i].selected = false;
		}
	}
	

	funUseTime();
}

function funUseTime() {
	var oDate1= new Date(document.f.fdorder4001.value,document.f.fdorder4002.value-1,document.f.fdorder4003.value,document.f.fdorder4004.value,document.f.fdorder4005.value,0);
	var oDate2= new Date(document.f.fdorder4101.value,document.f.fdorder4102.value-1,document.f.fdorder4103.value,document.f.fdorder4104.value,document.f.fdorder4105.value,0);
	var diffSec=gbDiffSec(oDate2,oDate1);
	document.f.fdorder4201.value = gbCompHour(diffSec);
	diffSec=gbCompHourMod(diffSec);
	document.f.fdorder4202.value = gbCompMin(diffSec);
}




function funInputAble() {
	if(document.f.fdorder1801.value != "" && document.f.fdorder1805.value != "") {
		document.f.fdorder2701.disabled = false;
		document.f.fdorder2701.className="imeen";
		document.f.fdorder2702.disabled = false;
		document.f.fdorder2702.className="imeen";
		document.f.fdorder4401.disabled = false;
		document.f.fdorder4401.className="imeen";
		
	} else {
		document.f.fdorder2701.disabled = true;
		document.f.fdorder2701.className="imedisb";
		document.f.fdorder2702.disabled = true;
		document.f.fdorder2702.className="imedisb";
		document.f.fdorder4401.disabled = true;
		document.f.fdorder4401.className="imedisb";
	}

	if(document.f.fdorder1802.value != "" && document.f.fdorder1806.value != "") {
		document.f.fdorder2801.disabled = false;
		document.f.fdorder2801.className="imeen";
		document.f.fdorder2802.disabled = false;
		document.f.fdorder2802.className="imeen";
		document.f.fdorder4501.disabled = false;
		document.f.fdorder4501.className="imeen";
		
	} else {
		document.f.fdorder2801.disabled = true;
		document.f.fdorder2801.className="imedisb";
		document.f.fdorder2802.disabled = true;
		document.f.fdorder2802.className="imedisb";
		document.f.fdorder4501.disabled = true;
		document.f.fdorder4501.className="imedisb";
	}

	if(document.f.fdorder1803.value != "" && document.f.fdorder1807.value != "") {
		document.f.fdorder2901.disabled = false;
		document.f.fdorder2901.className="imeen";
		document.f.fdorder2902.disabled = false;
		document.f.fdorder2902.className="imeen";
		document.f.fdorder4601.disabled = false;
		document.f.fdorder4601.className="imeen";
		
	} else {
		document.f.fdorder2901.disabled = true;
		document.f.fdorder2901.className="imedisb";
		document.f.fdorder2902.disabled = true;
		document.f.fdorder2902.className="imedisb";
		document.f.fdorder4601.disabled = true;
		document.f.fdorder4601.className="imedisb";
	}

	if(document.f.fdorder1804.value != "" && document.f.fdorder1808.value != "") {
		document.f.fdorder3001.disabled = false;
		document.f.fdorder3001.className="imeen";
		document.f.fdorder3002.disabled = false;
		document.f.fdorder3002.className="imeen";
		document.f.fdorder4701.disabled = false;
		document.f.fdorder4701.className="imeen";
		
	} else {
		document.f.fdorder3001.disabled = true;
		document.f.fdorder3001.className="imedisb";
		document.f.fdorder3002.disabled = true;
		document.f.fdorder3002.className="imedisb";
		document.f.fdorder4701.disabled = true;
		document.f.fdorder4701.className="imedisb";
	}

}



function funTransCnt() {
	var tot=0;
	var tmp1801 = document.f.fdorder1801.value.toString().replace(/[^0-9-]/gi,"");
	var tmp1802 = document.f.fdorder1802.value.toString().replace(/[^0-9-]/gi,"");
	var tmp1803 = document.f.fdorder1803.value.toString().replace(/[^0-9-]/gi,"");
	var tmp1804 = document.f.fdorder1804.value.toString().replace(/[^0-9-]/gi,"");

	tmp1801 = (tmp1801 == "") ? 0 : tmp1801;
	tmp1802 = (tmp1802 == "") ? 0 : tmp1802;
	tmp1803 = (tmp1803 == "") ? 0 : tmp1803;
	tmp1804 = (tmp1804 == "") ? 0 : tmp1804;
	
	tot = parseInt(tmp1801) + parseInt(tmp1802) + parseInt(tmp1803) + parseInt(tmp1804);


	document.f.fdorder2704.value = document.f.fdorder1801.value;
	document.f.fdorder2804.value = document.f.fdorder1802.value;
	document.f.fdorder2904.value = document.f.fdorder1803.value;
	document.f.fdorder3004.value = document.f.fdorder1804.value;

	document.f.fdorder4402.value = document.f.fdorder1801.value;
	document.f.fdorder4502.value = document.f.fdorder1802.value;
	document.f.fdorder4602.value = document.f.fdorder1803.value;
	document.f.fdorder4702.value = document.f.fdorder1804.value;
	
	document.f.fdorder4803.value = AmountFormat(tot);
	document.f.fdorder4903.value = AmountFormat(tot);
	document.f.fdorder5003.value = AmountFormat(tot);
}



function funCompAir() {
	var tmp2701 = document.f.fdorder2701.value.toString().replace(/[^0-9-]/gi,"");
	var tmp2702 = document.f.fdorder2702.value.toString().replace(/[^0-9-]/gi,"");
	var tmp2704 = document.f.fdorder2704.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp2801 = document.f.fdorder2801.value.toString().replace(/[^0-9-]/gi,"");
	var tmp2802 = document.f.fdorder2802.value.toString().replace(/[^0-9-]/gi,"");
	var tmp2804 = document.f.fdorder2804.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp2901 = document.f.fdorder2901.value.toString().replace(/[^0-9-]/gi,"");
	var tmp2902 = document.f.fdorder2902.value.toString().replace(/[^0-9-]/gi,"");
	var tmp2904 = document.f.fdorder2904.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp3001 = document.f.fdorder3001.value.toString().replace(/[^0-9-]/gi,"");
	var tmp3002 = document.f.fdorder3002.value.toString().replace(/[^0-9-]/gi,"");
	var tmp3004 = document.f.fdorder3004.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp2705=0;
	var tmp2805=0;
	var tmp2905=0;
	var tmp3005=0;
	
	tmp2701 = (tmp2701 == "") ? 0 : tmp2701;
	tmp2702 = (tmp2702 == "") ? 0 : tmp2702;
	tmp2704 = (tmp2704 == "") ? 0 : tmp2704;
	
	tmp2801 = (tmp2801 == "") ? 0 : tmp2801;
	tmp2802 = (tmp2802 == "") ? 0 : tmp2802;
	tmp2804 = (tmp2804 == "") ? 0 : tmp2804;

	tmp2901 = (tmp2901 == "") ? 0 : tmp2901;
	tmp2902 = (tmp2902 == "") ? 0 : tmp2902;
	tmp2904 = (tmp2904 == "") ? 0 : tmp2904;

	tmp3001 = (tmp3001 == "") ? 0 : tmp3001;
	tmp3002 = (tmp3002 == "") ? 0 : tmp3002;
	tmp3004 = (tmp3004 == "") ? 0 : tmp3004;
	
	
	document.f.fdorder2703.value = AmountFormat(parseInt(tmp2701) + parseInt(tmp2702));
	document.f.fdorder2803.value = AmountFormat(parseInt(tmp2801) + parseInt(tmp2802));
	document.f.fdorder2903.value = AmountFormat(parseInt(tmp2901) + parseInt(tmp2902));
	document.f.fdorder3003.value = AmountFormat(parseInt(tmp3001) + parseInt(tmp3002));
	
	document.f.fdorder2705.value = AmountFormat((parseInt(tmp2701) + parseInt(tmp2702)) * parseInt(tmp2704));
	document.f.fdorder2805.value = AmountFormat((parseInt(tmp2801) + parseInt(tmp2802)) * parseInt(tmp2804));
	document.f.fdorder2905.value = AmountFormat((parseInt(tmp2901) + parseInt(tmp2902)) * parseInt(tmp2904));
	document.f.fdorder3005.value = AmountFormat((parseInt(tmp3001) + parseInt(tmp3002)) * parseInt(tmp3004));
	
	tmp2705 = document.f.fdorder2705.value.toString().replace(/[^0-9-]/gi,"");
	tmp2805 = document.f.fdorder2805.value.toString().replace(/[^0-9-]/gi,"");
	tmp2905 = document.f.fdorder2905.value.toString().replace(/[^0-9-]/gi,"");
	tmp3005 = document.f.fdorder3005.value.toString().replace(/[^0-9-]/gi,"");
	
	tmp2705 = (tmp2705 == "") ? 0 : tmp2705;
	tmp2805 = (tmp2805 == "") ? 0 : tmp2805;
	tmp2905 = (tmp2905 == "") ? 0 : tmp2905;
	tmp3005 = (tmp3005 == "") ? 0 : tmp3005;
	
	document.f.fdorder3006.value = AmountFormat(parseInt(tmp2705) + parseInt(tmp2805) + parseInt(tmp2905) + parseInt(tmp3005));
	
}


function funCompEtc() {
	var tmp3702 = document.f.fdorder3702.value.toString().replace(/[^0-9-]/gi,"");
	var tmp3703 = document.f.fdorder3703.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp3802 = document.f.fdorder3802.value.toString().replace(/[^0-9-]/gi,"");
	var tmp3803 = document.f.fdorder3803.value.toString().replace(/[^0-9-]/gi,"");
	
	
	tmp3702 = (tmp3702 == "") ? 0 : tmp3702;
	tmp3703 = (tmp3703 == "") ? 0 : tmp3703;
	
	tmp3802 = (tmp3802 == "") ? 0 : tmp3802;
	tmp3803 = (tmp3803 == "") ? 0 : tmp3803;

	
	document.f.fdorder3704.value = AmountFormat(parseInt(tmp3702) * parseInt(tmp3703));
	document.f.fdorder3805.value = AmountFormat(parseInt(tmp3802) * parseInt(tmp3803));
}





function funCompEnt() {
	var tmp4401 = document.f.fdorder4401.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4402 = document.f.fdorder4402.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp4501 = document.f.fdorder4501.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4502 = document.f.fdorder4502.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp4601 = document.f.fdorder4601.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4602 = document.f.fdorder4602.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp4701 = document.f.fdorder4701.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4702 = document.f.fdorder4702.value.toString().replace(/[^0-9-]/gi,"");
	
	tmp4401 = (tmp4401 == "") ? 0 : tmp4401;
	tmp4402 = (tmp4402 == "") ? 0 : tmp4402;
	
	tmp4501 = (tmp4501 == "") ? 0 : tmp4501;
	tmp4502 = (tmp4502 == "") ? 0 : tmp4502;

	tmp4601 = (tmp4601 == "") ? 0 : tmp4601;
	tmp4602 = (tmp4602 == "") ? 0 : tmp4602;

	tmp4701 = (tmp4701 == "") ? 0 : tmp4701;
	tmp4702 = (tmp4702 == "") ? 0 : tmp4702;
	
	document.f.fdorder4403.value = AmountFormat(parseInt(tmp4401) * parseInt(tmp4402));
	document.f.fdorder4503.value = AmountFormat(parseInt(tmp4501) * parseInt(tmp4502));
	document.f.fdorder4603.value = AmountFormat(parseInt(tmp4601) * parseInt(tmp4602));
	document.f.fdorder4703.value = AmountFormat(parseInt(tmp4701) * parseInt(tmp4702));
}



function funCompDin() {
	var tmp4801 = document.f.fdorder4801.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4802 = document.f.fdorder4802.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4803 = document.f.fdorder4803.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp4901 = document.f.fdorder4901.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4902 = document.f.fdorder4902.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4903 = document.f.fdorder4903.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp5001 = document.f.fdorder5001.value.toString().replace(/[^0-9-]/gi,"");
	var tmp5002 = document.f.fdorder5002.value.toString().replace(/[^0-9-]/gi,"");
	var tmp5003 = document.f.fdorder5003.value.toString().replace(/[^0-9-]/gi,"");
	
	tmp4801 = (tmp4801 == "") ? 0 : tmp4801;
	tmp4802 = (tmp4802 == "") ? 0 : tmp4802;
	tmp4803 = (tmp4803 == "") ? 0 : tmp4803;
	
	tmp4901 = (tmp4901 == "") ? 0 : tmp4901;
	tmp4902 = (tmp4902 == "") ? 0 : tmp4902;
	tmp4903 = (tmp4903 == "") ? 0 : tmp4903;

	tmp5001 = (tmp5001 == "") ? 0 : tmp5001;
	tmp5002 = (tmp5002 == "") ? 0 : tmp5002;
	tmp5003 = (tmp5003 == "") ? 0 : tmp5003;
	
	document.f.fdorder4804.value = AmountFormat((parseInt(tmp4801) * parseInt(tmp4802)) * parseInt(tmp4803) );
	document.f.fdorder4904.value = AmountFormat((parseInt(tmp4901) * parseInt(tmp4902)) * parseInt(tmp4903) );
	document.f.fdorder5004.value = AmountFormat((parseInt(tmp5001) * parseInt(tmp5002)) * parseInt(tmp5003) );

}



function funCompTip() {
	var tmp5101 = document.f.fdorder5101.value.toString().replace(/[^0-9-]/gi,"");
	var tmp5102 = document.f.fdorder5102.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp5201 = document.f.fdorder5201.value.toString().replace(/[^0-9-]/gi,"");
	var tmp5202 = document.f.fdorder5202.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp5301 = document.f.fdorder5301.value.toString().replace(/[^0-9-]/gi,"");
	var tmp5302 = document.f.fdorder5302.value.toString().replace(/[^0-9-]/gi,"");
	
	document.f.fdorder5403.value=document.f.fdorder5402.value;
	
	tmp5101 = (tmp5101 == "") ? 0 : tmp5101;
	tmp5102 = (tmp5102 == "") ? 0 : tmp5102;
	
	tmp5201 = (tmp5201 == "") ? 0 : tmp5201;
	tmp5202 = (tmp5202 == "") ? 0 : tmp5202;

	tmp5301 = (tmp5301 == "") ? 0 : tmp5301;
	tmp5302 = (tmp5302 == "") ? 0 : tmp5302;

	
	document.f.fdorder5103.value = AmountFormat(parseInt(tmp5101) * parseInt(tmp5102));
	document.f.fdorder5203.value = AmountFormat(parseInt(tmp5201) * parseInt(tmp5202));
	document.f.fdorder5303.value = AmountFormat(parseInt(tmp5301) * parseInt(tmp5302));
}



function funCompTot() {
	var tot=0;
	
	var tmp2705 = document.f.fdorder2705.value.toString().replace(/[^0-9-]/gi,"");
	var tmp2805 = document.f.fdorder2805.value.toString().replace(/[^0-9-]/gi,"");
	var tmp2905 = document.f.fdorder2905.value.toString().replace(/[^0-9-]/gi,"");
	var tmp3005 = document.f.fdorder3005.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp3704 = document.f.fdorder3704.value.toString().replace(/[^0-9-]/gi,"");
	var tmp3805 = document.f.fdorder3805.value.toString().replace(/[^0-9-]/gi,"");
	var tmp3905 = document.f.fdorder3905.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp4403 = document.f.fdorder4403.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4503 = document.f.fdorder4503.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4603 = document.f.fdorder4603.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4703 = document.f.fdorder4703.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp4804 = document.f.fdorder4804.value.toString().replace(/[^0-9-]/gi,"");
	var tmp4904 = document.f.fdorder4904.value.toString().replace(/[^0-9-]/gi,"");
	var tmp5004 = document.f.fdorder5004.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp5103 = document.f.fdorder5103.value.toString().replace(/[^0-9-]/gi,"");
	var tmp5203 = document.f.fdorder5203.value.toString().replace(/[^0-9-]/gi,"");
	var tmp5303 = document.f.fdorder5303.value.toString().replace(/[^0-9-]/gi,"");
	var tmp5403 = document.f.fdorder5403.value.toString().replace(/[^0-9-]/gi,"");
	
	tmp2705 = (tmp2705 == "") ? 0 : tmp2705;
	tmp2805 = (tmp2805 == "") ? 0 : tmp2805;
	tmp2905 = (tmp2905 == "") ? 0 : tmp2905;
	tmp3005 = (tmp3005 == "") ? 0 : tmp3005;
	
	tmp3704 = (tmp3704 == "") ? 0 : tmp3704;
	tmp3805 = (tmp3805 == "") ? 0 : tmp3805;
	tmp3905 = (tmp3905 == "") ? 0 : tmp3905;
	
	tmp4403 = (tmp4403 == "") ? 0 : tmp4403;
	tmp4503 = (tmp4503 == "") ? 0 : tmp4503;
	tmp4603 = (tmp4603 == "") ? 0 : tmp4603;
	tmp4703 = (tmp4703 == "") ? 0 : tmp4703;
	
	tmp4804 = (tmp4804 == "") ? 0 : tmp4804;
	tmp4904 = (tmp4904 == "") ? 0 : tmp4904;
	tmp5004 = (tmp5004 == "") ? 0 : tmp5004;
	
	tmp5103 = (tmp5103 == "") ? 0 : tmp5103;
	tmp5203 = (tmp5203 == "") ? 0 : tmp5203;
	tmp5303 = (tmp5303 == "") ? 0 : tmp5303;
	tmp5403 = (tmp5403 == "") ? 0 : tmp5403;
	
	tot += parseInt(tmp2705) + parseInt(tmp2805) + parseInt(tmp2905) + parseInt(tmp3005) + parseInt(tmp3704) + parseInt(tmp3805) + parseInt(tmp3905);
	tot += parseInt(tmp4403) + parseInt(tmp4503) + parseInt(tmp4603) + parseInt(tmp4703) + parseInt(tmp4804) + parseInt(tmp4904) + parseInt(tmp5004);
	tot += parseInt(tmp5103) + parseInt(tmp5203) + parseInt(tmp5303) + parseInt(tmp5403);
	document.f.fdorder57.value = AmountFormat(tot);
	
}


function funCompPerOne() {
	var tothuman = 0;
	var tmp1801 = document.f.fdorder1801.value.toString().replace(/[^0-9-]/gi,"");
	var tmp1802 = document.f.fdorder1802.value.toString().replace(/[^0-9-]/gi,"");
	var tmp1803 = document.f.fdorder1803.value.toString().replace(/[^0-9-]/gi,"");
	var tmp1804 = document.f.fdorder1804.value.toString().replace(/[^0-9-]/gi,"");
	
	var tmp57 = document.f.fdorder57.value.toString().replace(/[^0-9-]/gi,"");
	
	tmp1801 = (tmp1801 == "") ? 0 : tmp1801;
	tmp1802 = (tmp1802 == "") ? 0 : tmp1802;
	tmp1803 = (tmp1803 == "") ? 0 : tmp1803;
	tmp1804 = (tmp1804 == "") ? 0 : tmp1804;
	
	tmp57 = (tmp57 == "") ? 0 : tmp57;
	
	tothuman = parseInt(tmp1801) + parseInt(tmp1802) + parseInt(tmp1803) + parseInt(tmp1804);
	
	if(tmp57 != 0) {
		document.f.fdorder58.value = AmountFormat(Math.round(tmp57 / tothuman));
	} else {
		document.f.fdorder58.value = 0;
	}
}

function funCompDiffAmt1() {
	var tmp57 = document.f.fdorder57.value.toString().replace(/[^0-9-]/gi,"");
	var tmp59 = document.f.fdorder59.value.toString().replace(/[^0-9-]/gi,"");
	
	tmp57 = (tmp57 == "") ? 0 : tmp57;
	tmp59 = (tmp59 == "") ? 0 : tmp59;
	
	document.f.fdorder60.value = AmountFormat(parseInt(tmp57) - parseInt(tmp59));
}

function funCompDiffAmt2() {
	var tmp62 = document.f.fdorder62.value.toString().replace(/[^0-9-]/gi,"");
	var tmp63 = document.f.fdorder63.value.toString().replace(/[^0-9-]/gi,"");
	
	tmp62 = (tmp62 == "") ? 0 : tmp62;
	tmp63 = (tmp63 == "") ? 0 : tmp63;
	
	document.f.fdorder64.value = AmountFormat(parseInt(tmp62) - parseInt(tmp63));
}

function funCompDiffAmt3() {
/*	
	var tmp57 = document.f.fdorder57.value.toString().replace(/[^0-9-]/gi,"");
	var tmp62 = document.f.fdorder62.value.toString().replace(/[^0-9-]/gi,"");
	
	tmp57 = (tmp57 == "") ? 0 : tmp57;
	tmp62 = (tmp62 == "") ? 0 : tmp62;
	
	document.f.fdorder65.value = AmountFormat(parseInt(tmp57) - parseInt(tmp62));
*/
	var tmp59 = document.f.fdorder59.value.toString().replace(/[^0-9-]/gi,"");
	var tmp63 = document.f.fdorder63.value.toString().replace(/[^0-9-]/gi,"");
	
	tmp59 = (tmp59 == "") ? 0 : tmp59;
	tmp63 = (tmp63 == "") ? 0 : tmp63;
	
	document.f.fdorder65.value = AmountFormat(parseInt(tmp59) - parseInt(tmp63));

}



function funAllComp() {
	funTransCnt();
	funCompAir();
	funCompEtc();
	funCompEnt();
	funCompDin();
	funCompTip();
	funCompTot();
	funCompPerOne();
	funCompDiffAmt1();
	funCompDiffAmt2();
	funCompDiffAmt3();
}

	

function funDisItem() {
	document.getElementById("iddisitem51").innerHTML = "&nbsp;" + document.f.fdorder1805.value;
	document.getElementById("iddisitem52").innerHTML = "&nbsp;" + document.f.fdorder1805.value;
	document.getElementById("iddisitem61").innerHTML = "&nbsp;" + document.f.fdorder1806.value;
	document.getElementById("iddisitem62").innerHTML = "&nbsp;" + document.f.fdorder1806.value;
	document.getElementById("iddisitem71").innerHTML = "&nbsp;" + document.f.fdorder1807.value;
	document.getElementById("iddisitem72").innerHTML = "&nbsp;" + document.f.fdorder1807.value;
	document.getElementById("iddisitem81").innerHTML = "&nbsp;" + document.f.fdorder1808.value;
	document.getElementById("iddisitem82").innerHTML = "&nbsp;" + document.f.fdorder1808.value;
}

	 

function funChgOrder(pnum) {
	document.f.fdorder06.focus();
	if(pnum == 1) {
		location.href="order1c.asp";
	} else if(pnum == 2) {
		location.href="order2c.asp";
	} else {
		location.href="order3c.asp";
	}
}


function funSubmit() {

	if(document.f.fdorder06.value == "") {
		window.alert("거래처/담당을 입력하여 주십시요 !!!");
		document.f.fdorder06.focus();
	
	// } else if(document.f.eventnum1.value == "") {
	//	window.alert("견적과 행사를 연결해주세요");
			
		
	 } else if(document.f.fdorder1801.value != "" && document.f.fdorder1805.value == "") {
		window.alert("여행인원 항목1을 입력하여 주십시요 !!!");
		document.f.fdorder1805.focus();
		
	 } else if(document.f.fdorder1802.value != "" && document.f.fdorder1806.value == "") {
		window.alert("여행인원 항목2을 입력하여 주십시요 !!!");
		document.f.fdorder1806.focus();
		
	 } else if(document.f.fdorder1803.value != "" && document.f.fdorder1807.value == "") {
		window.alert("여행인원 항목3을 입력하여 주십시요 !!!");
		document.f.fdorder1807.focus();
		
	 } else if(document.f.fdorder1804.value != "" && document.f.fdorder1808.value == "") {
		window.alert("여행인원 항목4을 입력하여 주십시요 !!!");
		document.f.fdorder1808.focus();
		
	 } else if(document.f.fdorder2704.value != "" && document.f.fdorder2701.value == "") {
		window.alert("항공료 성인 요금을 입력하여 주십시요 !!!");
		document.f.fdorder2701.focus();
		
	 } else if(document.f.fdorder2804.value != "" && document.f.fdorder2801.value == "") {
		window.alert("항공료 어린이 요금을 입력하여 주십시요 !!!");
		document.f.fdorder2801.focus();
		
	 } else if(document.f.fdorder2904.value != "" && document.f.fdorder2901.value == "") {
		window.alert("항공료 청소년 요금을 입력하여 주십시요 !!!");
		document.f.fdorder2901.focus();
		
	 } else if(document.f.fdorder3004.value != "" && document.f.fdorder3001.value == "") {
		window.alert("항공료 항목입력 요금을 입력하여 주십시요 !!!");
		document.f.fdorder3001.focus();
		
	 } else if(document.f.fdorder3702.value != "" && document.f.fdorder3703.value == "" && document.f.fdorder84.checked) {
		window.alert("숙박일을 입력하여 주십시요 !!!");
		document.f.fdorder3703.focus();
		
	 } else if(document.f.fdorder3802.value != "" && document.f.fdorder3803.value == "" && document.f.fdorder85.checked) {
		window.alert("사용일을 입력하여 주십시요 !!!");
		document.f.fdorder3803.focus();
		
	 } else if(document.f.fdorder3902.value != "" && document.f.fdorder3905.value == "" && document.f.fdorder86.checked)  {
		window.alert("렌트 요금을 입력하세요 !!!");
		document.f.fdorder3905.focus();
		
	 } else if(document.f.fdorder4402.value != "" && document.f.fdorder4401.value == "" && document.f.fdorder87.checked) {
		window.alert("성인 입장료를 입력하여 주십시요 !!!");
		document.f.fdorder4401.focus();
		
	 } else if(document.f.fdorder4502.value != "" && document.f.fdorder4501.value == "" && document.f.fdorder87.checked) {
		window.alert("어린이 입장료를 입력하여 주십시요 !!!");
		document.f.fdorder4501.focus();

	 } else if(document.f.fdorder4602.value != "" && document.f.fdorder4601.value == "" && document.f.fdorder87.checked) {
		window.alert("청소년 입장료를 입력하여 주십시요 !!!");
		document.f.fdorder4601.focus();

	 } else if(document.f.fdorder4702.value != "" && document.f.fdorder4701.value == "" && document.f.fdorder87.checked) {
		window.alert("항목입력 입장료를 입력하여 주십시요 !!!");
		document.f.fdorder4701.focus();

	 } else if(document.f.fdorder4801.value != "" && document.f.fdorder4802.value == "" && document.f.fdorder88.checked) {
		window.alert("조식 횟수를 입력하여 주십시요 !!!");
		document.f.fdorder4802.focus();

	 } else if(document.f.fdorder4901.value != "" && document.f.fdorder4902.value == "" && document.f.fdorder88.checked) {
		window.alert("중식 횟수를 입력하여 주십시요 !!!");
		document.f.fdorder4902.focus();

	 } else if(document.f.fdorder5001.value != "" && document.f.fdorder5002.value == "" && document.f.fdorder88.checked) {
		window.alert("석식 횟수를 입력하여 주십시요 !!!");
		document.f.fdorder5002.focus();

	 } else if(document.f.fdorder5101.value != "" && document.f.fdorder5102.value == "") {
		window.alert("일수를 입력하여 주십시요 !!!");
		document.f.fdorder5102.focus();

	 } else if(document.f.fdorder5201.value != "" && document.f.fdorder5202.value == "") {
		window.alert("일수를 입력하여 주십시요 !!!");
		document.f.fdorder5202.focus();

	 } else if(document.f.fdorder5301.value != "" && document.f.fdorder5302.value == "") {
		window.alert("일수를 입력하여 주십시요 !!!");
		document.f.fdorder5302.focus();

	 } else if(document.f.fdorder75.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder75.focus();

	 } else if(document.f.fdorder76.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder76.focus();

	 } else if(document.f.fdorder77.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder77.focus();

	 } else if(document.f.fdorder78.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder78.focus();

	 } else if(document.f.fdorder79.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder79.focus();

	 } else if(document.f.fdorder80.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder80.focus();

	 } else if(document.f.fdorder81.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder81.focus();

	 } else if(document.f.fdorder82.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder82.focus();

	 } else if(document.f.fdorder83.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder83.focus();

	} else {
		document.f.mode.value="input";
		document.f.submit();
	}
}

function funSubmit1() {

	if(document.f.fdorder06.value == "") {
		window.alert("거래처/담당을 입력하여 주십시요 !!!");
		document.f.fdorder06.focus();
	
	// } else if(document.f.eventnum1.value == "") {
	//	window.alert("견적과 행사를 연결해주세요");
			
		
	 } else if(document.f.fdorder1801.value != "" && document.f.fdorder1805.value == "") {
		window.alert("여행인원 항목1을 입력하여 주십시요 !!!");
		document.f.fdorder1805.focus();
		
	 } else if(document.f.fdorder1802.value != "" && document.f.fdorder1806.value == "") {
		window.alert("여행인원 항목2을 입력하여 주십시요 !!!");
		document.f.fdorder1806.focus();
		
	 } else if(document.f.fdorder1803.value != "" && document.f.fdorder1807.value == "") {
		window.alert("여행인원 항목3을 입력하여 주십시요 !!!");
		document.f.fdorder1807.focus();
		
	 } else if(document.f.fdorder1804.value != "" && document.f.fdorder1808.value == "") {
		window.alert("여행인원 항목4을 입력하여 주십시요 !!!");
		document.f.fdorder1808.focus();
		
	 } else if(document.f.fdorder2704.value != "" && document.f.fdorder2701.value == "") {
		window.alert("항공료 성인 요금을 입력하여 주십시요 !!!");
		document.f.fdorder2701.focus();
		
	 } else if(document.f.fdorder2804.value != "" && document.f.fdorder2801.value == "") {
		window.alert("항공료 어린이 요금을 입력하여 주십시요 !!!");
		document.f.fdorder2801.focus();
		
	 } else if(document.f.fdorder2904.value != "" && document.f.fdorder2901.value == "") {
		window.alert("항공료 청소년 요금을 입력하여 주십시요 !!!");
		document.f.fdorder2901.focus();
		
	 } else if(document.f.fdorder3004.value != "" && document.f.fdorder3001.value == "") {
		window.alert("항공료 항목입력 요금을 입력하여 주십시요 !!!");
		document.f.fdorder3001.focus();
		
	 } else if(document.f.fdorder3702.value != "" && document.f.fdorder3703.value == "" && document.f.fdorder84.checked) {
		window.alert("숙박일을 입력하여 주십시요 !!!");
		document.f.fdorder3703.focus();
		
	 } else if(document.f.fdorder3802.value != "" && document.f.fdorder3803.value == "" && document.f.fdorder85.checked) {
		window.alert("사용일을 입력하여 주십시요 !!!");
		document.f.fdorder3803.focus();
		
	 } else if(document.f.fdorder3902.value != "" && document.f.fdorder3905.value == "" && document.f.fdorder86.checked)  {
		window.alert("렌트 요금을 입력하세요 !!!");
		document.f.fdorder3905.focus();
		
	 } else if(document.f.fdorder4402.value != "" && document.f.fdorder4401.value == "" && document.f.fdorder87.checked) {
		window.alert("성인 입장료를 입력하여 주십시요 !!!");
		document.f.fdorder4401.focus();
		
	 } else if(document.f.fdorder4502.value != "" && document.f.fdorder4501.value == "" && document.f.fdorder87.checked) {
		window.alert("어린이 입장료를 입력하여 주십시요 !!!");
		document.f.fdorder4501.focus();

	 } else if(document.f.fdorder4602.value != "" && document.f.fdorder4601.value == "" && document.f.fdorder87.checked) {
		window.alert("청소년 입장료를 입력하여 주십시요 !!!");
		document.f.fdorder4601.focus();

	 } else if(document.f.fdorder4702.value != "" && document.f.fdorder4701.value == "" && document.f.fdorder87.checked) {
		window.alert("항목입력 입장료를 입력하여 주십시요 !!!");
		document.f.fdorder4701.focus();

	 } else if(document.f.fdorder4801.value != "" && document.f.fdorder4802.value == "" && document.f.fdorder88.checked) {
		window.alert("조식 횟수를 입력하여 주십시요 !!!");
		document.f.fdorder4802.focus();

	 } else if(document.f.fdorder4901.value != "" && document.f.fdorder4902.value == "" && document.f.fdorder88.checked) {
		window.alert("중식 횟수를 입력하여 주십시요 !!!");
		document.f.fdorder4902.focus();

	 } else if(document.f.fdorder5001.value != "" && document.f.fdorder5002.value == "" && document.f.fdorder88.checked) {
		window.alert("석식 횟수를 입력하여 주십시요 !!!");
		document.f.fdorder5002.focus();

	 } else if(document.f.fdorder5101.value != "" && document.f.fdorder5102.value == "") {
		window.alert("일수를 입력하여 주십시요 !!!");
		document.f.fdorder5102.focus();

	 } else if(document.f.fdorder5201.value != "" && document.f.fdorder5202.value == "") {
		window.alert("일수를 입력하여 주십시요 !!!");
		document.f.fdorder5202.focus();

	 } else if(document.f.fdorder5301.value != "" && document.f.fdorder5302.value == "") {
		window.alert("일수를 입력하여 주십시요 !!!");
		document.f.fdorder5302.focus();

	 } else if(document.f.fdorder75.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder75.focus();

	 } else if(document.f.fdorder76.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder76.focus();

	 } else if(document.f.fdorder77.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder77.focus();

	 } else if(document.f.fdorder78.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder78.focus();

	 } else if(document.f.fdorder79.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder79.focus();

	 } else if(document.f.fdorder80.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder80.focus();

	 } else if(document.f.fdorder81.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder81.focus();

	 } else if(document.f.fdorder82.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder82.focus();

	 } else if(document.f.fdorder83.value == "" ) {
		window.alert("항목을 입력하여 주십시요 !!!");
		document.f.fdorder83.focus();

	} else {
		document.f.mode.value="modify";
		document.f.submit();
	}
}

function funRetDay(arg) {
	var oDate="";
	
	if(arg == 1) {
		oDate= new Date(document.f.fdorder140101.value,document.f.fdorder140102.value-1,document.f.fdorder140103.value);
		document.f.fdorder1402.value = getWeekDay(oDate);
		
	} else {
		oDate= new Date(document.f.fdorder160101.value,document.f.fdorder160102.value-1,document.f.fdorder160103.value);
		document.f.fdorder1602.value = getWeekDay(oDate);
	}
}


function selRangeYearMonth(arg) {
        var curDate;
        var opt;
        var optLen;
        var tmpval;

	switch(arg) {
		case 1:
                        	curDate = new Date(document.f.fdorder0501[document.f.fdorder0501.selectedIndex].value, document.f.fdorder0502[document.f.fdorder0502.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder0503.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder0503.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder0503.options.add(opt);
                        	} 
                        	break;
		case 2:
				
                        	curDate = new Date(document.f.fdorder140101[document.f.fdorder140101.selectedIndex].value, document.f.fdorder140102[document.f.fdorder140102.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder140103.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder140103.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder140103.options.add(opt);
                        	} 
                        	break;
		case 3:
                        	curDate = new Date(document.f.fdorder160101[document.f.fdorder160101.selectedIndex].value, document.f.fdorder160102[document.f.fdorder160102.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder160103.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder160103.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder160103.options.add(opt);
                        	} 
                        	break;
		case 4:
                        	curDate = new Date(document.f.fdorder4001[document.f.fdorder4001.selectedIndex].value, document.f.fdorder4002[document.f.fdorder4002.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder4003.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder4003.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder4003.options.add(opt);
                        	} 
                        	break;
		case 5:
                        	curDate = new Date(document.f.fdorder4101[document.f.fdorder4101.selectedIndex].value, document.f.fdorder4102[document.f.fdorder4102.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder4103.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder4103.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder4103.options.add(opt);
                        	} 
                        	break;
		case 6:
                        	curDate = new Date(document.f.fdorder6101[document.f.fdorder6101.selectedIndex].value, document.f.fdorder6102[document.f.fdorder6102.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder6103.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder6103.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder6103.options.add(opt);
                        	} 
                        	break;
		case 7:
                        	curDate = new Date(document.f.fdorder6601[document.f.fdorder6601.selectedIndex].value, document.f.fdorder6602[document.f.fdorder6602.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder6603.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder6603.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder6603.options.add(opt);
                        	} 
                        	break;
		case 8:
                        	curDate = new Date(document.f.fdorder680101[document.f.fdorder680101.selectedIndex].value, document.f.fdorder680102[document.f.fdorder680102.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder680103.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder680103.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder680103.options.add(opt);
                        	} 
                        	break;
		case 9:
                        	curDate = new Date(document.f.fdorder690101[document.f.fdorder690101.selectedIndex].value, document.f.fdorder690102[document.f.fdorder690102.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder690103.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder690103.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder690103.options.add(opt);
                        	} 
                        	break;
		case 10:
                        	curDate = new Date(document.f.fdorder230201[document.f.fdorder230201.selectedIndex].value, document.f.fdorder230202[document.f.fdorder230202.selectedIndex].value - 1,1);
                        	optLen = document.f.fdorder230203.options.length;
                        	for(i=0;i<optLen;i++) {
                                	document.f.fdorder230203.options[0] = null;
                        	} 

                        	for(i=1;i<=retDay(curDate);i++) {
                                	if(i < 10) {
                                        	tmpval = "0" + i.toString();
                                	} else {
                                        	tmpval = i;
                                	}
                                	opt = document.createElement('OPTION');
                                	opt.text = tmpval;
                                	opt.value = tmpval;
                                	document.f.fdorder230203.options.add(opt);
                        	} 
                        	break;
                        	
	}
}