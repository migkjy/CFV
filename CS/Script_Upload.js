function fnSizeChange(objValue){														
	document.frm.goodSize.value	= objValue;
}
function fnTest(strValue){																		//�ؽ�Ʈ �ڽ����� üũ�� ����Ʈ �ڽ� �����ϱ�
	var list
	list = document.frm.goodSizeS
	strValue = strValue.replace(" ","")
	for(i=0;i<list.length;i++){
		if(strValue.length>1){								//���õ� ���� ������
			if(strValue==list.options[i].value){			//�Ѿ�°��� üũ�� ���� ������
				list.options[i].selected = true;
				break
			}	
		}else{
				list.options[i].selected = true;
				break
		}
	}
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
// Ŭ�������� ���� �ٲٱ�
function fnClick(strObj){
	if(strObj.value=="-"){
		strObj.value							= "";
		strObj.style.backgroundColor	= "#ffffff";
	}
}
// ��Ŀ���� ������� ���� �־��ش�.
function fnBlur(strObj, strValue, strSeq, goUrl){
	var strForm = document.frm
	if(isNaN(strValue) || strValue==""){
		strObj.value							= "-";
		strObj.style.backgroundColor	= "EDEDEE";
	}
	if(strValue.length>2){
		alert("������ ���ڸ� �Է¸� �����մϴ�.");
		strObj.value="";
		strObj.focus();
	}
	strForm.blurNum.value	= strSeq;
	strForm.blurValue.value	= strObj.value;
	strForm.action				= goUrl
	strForm.submit();
}

function fnAllMoney(strNum1){////////////�ڸ����� �ĸ� ��� 
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
				strReturn=strNum.substr(0,2)+','+strNum.substr(2,3)+','+strNum.substr(5,3)+','+strNum.substr(8,3);
				return strReturn;
			}else if(n==12){
				strReturn=strNum.substr(0,3)+','+strNum.substr(3,3)+','+strNum.substr(6,3)+','+strNum.substr(9,3);
				return strReturn;
			}else{
				strReturn=strNum.substr(0,3)+','+strNum.substr(3,3)+','+strNum.substr(6,3)+','+strNum.substr(9,3);
				return strReturn;
			}
	}
}