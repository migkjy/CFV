<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    Response.AddHeader	"Expires","0"

    OpenF5_DB objConn
%>

<!DOCTYPE html>
<html>
<head>
<title>상품코드</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script language="javascript" type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script language="javascript" type="text/javascript" src="/admin/scripts/iframeResizer.contentWindow.min.js"></script>
</head>

<body>
	
    <form name="left_menu" id="left_menu" method="post" style="display:inline; margin:0px;">
    <input type="hidden" name="cd_" id="cd_" value=""><!------ 좌측 기초코드값 세팅하기  ---->
    <input type="hidden" name="cd_fg_" id="cd_fg_" value=""><!------ 좌측 기초코드값 세팅하기  ---->
    <input type="hidden" name="cd_nm_" id="cd_nm_" value=""><!------ 좌측 기초코드명  ---->
    <input type="hidden" name="num_"  id="num_" value=""><!----- 좌측 선택되어진 코드  ---->
    <input type="hidden" name="count_" id="count_" value="">			     <!------ 좌측 코드 총 개수  ---->
    <input type="hidden" name="insert_num" id="insert_num" value="1000"><!------ 좌측 추가시 넘버링  ---->
    <input type="hidden" name="base_add_in" id="base_add_in" value=""><!------ 좌측 추가시 넘버 저장 1000@1001@1002.... ---->
    </form>
    <form name="frmIn" id="frmIn" method="post" style="display:inline; margin:0px;">
    <input type="hidden" name="cd_fg" id="cd_fg" value="!!!!"><!------ 좌측 등록 기초코드값 세팅하기  ---->
    <input type="hidden" name="cd" id="cd" value=""><!------ 좌측 등록 기초 설명 세팅하기  ---->
    <input type="hidden" name="cd_nm" id="cd_nm" value=""><!------ 좌측 등록 기초 설명 세팅하기  ---->
    <input type="hidden" name="size_left"  id="size_left" value=""><!------ 좌측 등록 기초 설명 세팅하기  ---->
    <input type="hidden" name="size_main" id="size_main" value=""><!------ 좌측 등록 기초 설명 세팅하기  ---->
    <input type="hidden" name="size_top" id="size_top" value=""><!------ 좌측 등록 기초 설명 세팅하기  ---->
    <input type="hidden" name="size_bottom" id="size_bottom" value=""><!------ 좌측 등록 기초 설명 세팅하기  ---->
    </form>	
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #C0C0C0;height:40px;">
        <tr>
            <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="50%" style="padding:0px 0px 0px 20px">추가버튼을 누르시고 추가할 항목 입력하세요.</td>
                        <td width="*%">
                            <div align="right">
                                <span class="button_a" style="padding:0px 5px 0px 0px"><a onClick="fnChkBaseList()">새로고침</a></span>
                                <span class="button_a" style="padding:0px 20px 0px 0px"><a onClick="fnChkBaseIn()">추가</a></span>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table> 
    
    <div class="pb15"></div>  
    
    <div id="left_div" style="padding:0px;margin-left:0px;width:100%">
        <div class="p_overbox1" style="height:100%;width:100%"  onScroll="SetScrollPos_Left(this,document.getElementById('base_left_table'));">
            <div id="base_left_table">
                
                <div class="table_list">
                    <table>
                        <tr>
                            <td width="20%" class="top1">구분</td>
                            <td width="*%" class="top2">코드구분명</td>
                            <td width="15%" class="top2">수정</td>
                            <td width="15%" class="top2">삭제</td>
                        </tr>
                    </table>
                    
                    <div id="base_in_table"></div>

                    <table>
                        <%
                            sql = "	exec proc_TB_ba001_s01_pre01"
                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                            Rs.open sql,objConn,3
                    		    				
                            count		= Rs.Recordcount
                            If Not Rs.Eof Then 
                            k = 1
                            onload3="fnChkBase('"&Rs("cd")&"', '"&Rs("cd_nm")&"',1,"&count&");document.getElementById('cd1').select();"
                            Do Until Rs.Eof
                        %>		
                        <tr bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                            <td width="20%"class="tob1"><input type="text" name="cd<%=k%>" id="cd<%=k%>" value="<%=Rs("cd")%>" style="width:80%;" class="input_basic" onClick="fnChkBase('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>',<%=k%>,<%=count%>);this.select()"></td>
                            <td width="*%"class="tob2"><input type="text" name="cd_nm<%=k%>" id="cd_nm<%=k%>" value="<%=Rs("cd_nm")%>" style="width:90%;" class="input_basic" onClick="fnChkBase('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>',<%=k%>,<%=count%>);this.select();"></td>
                            <td width="15%"class="tob2"><span class="button_a"><a onClick="fnChkBase('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>',<%=k%>,<%=count%>);fnChkBaseUp(document.getElementById('cd<%=k%>').value, document.getElementById('cd_nm<%=k%>').value,'<%=Rs("cd")%>','<%=Rs("cd_nm")%>')" name='base_up'>수정</a></span></td>
                            <td width="15%"class="tob2"><span class="button_a"><a onClick="fnChkBase('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>',<%=k%>,<%=count%>);fnChkBaseDel(document.getElementById('cd<%=k%>').value, document.getElementById('cd_nm<%=k%>').value,'<%=Rs("cd")%>','<%=Rs("cd_nm")%>')"  name='base_del'>삭제</a></span></td>
                        </tr>
                        <%
                                Rs.MoveNext
                                k = k+1
                                Loop
                            
                            End If 
                            
                            CloseRs Rs
                        %>
                    </table>
                    <iframe name="ifmJob" id="ifmJob" src=""  allowTransparency=true width="0" height="0" marginwidth="0" marginheight="0" vspace="0" scrolling="no" frameborder="0" framespacing="0" frameborder="0"></iframe>
                </div>
                
            </div>
        </div>
    </div>

</body>
</html>

<%
    CloseF5_DB objConn 
%>


<script language="javascript">
<!--
	<%=onload3%>
	function fnChkBaseList(){
		document.getElementById("base_in_table").innerHTML  =  "";
		location.reload();
	}


	function SetScrollPos_Left(tagDIV,obj_tbl){
		var positionTop = 0;
		if (tagDIV != null){
			positionTop = parseInt(tagDIV.scrollTop, 10);
			obj_tbl.style.top = positionTop;
		}
	}

	//** 좌측메뉴 클릭시 우측 내용을 보여준다.
	function fnChkBase(cd, cd_nm, num, count){
	
		var obj = document.left_menu;
		for(k=1;k<=parseInt(count);k++){
			obj1 = document.getElementById("cd"+k);
			obj2 = document.getElementById("cd_nm"+k);
			obj1.style.backgroundColor = "#ffffff";
			obj2.style.backgroundColor = "#ffffff";
			if (k==parseInt(num)){
				obj1.style.backgroundColor = "#dff2fe";
				obj2.style.backgroundColor = "#dff2fe";
			}
		}

		document.getElementById("cd_").value				= cd;
		document.getElementById("cd_nm_").value			= cd_nm;
		document.getElementById("num_").value				= num;
		document.getElementById("count_").value			= count;
		
		url		= 'cd_='+cd+'&cd_nm_'+cd_nm+'&num_='+num+'&count_='+count;
//alert(url);
		parent.ifmMain.location.href="base_contents.asp?"+url;
	} 

	//** 추가할 리스트 삭제
	function fnChkBaseAddDel(obj,num){
		var base_add_in = "";
		var num_string	= num.toString() + "@";
		base_add_in = document.getElementById("base_add_in").value;

		base_add_in	= base_add_in.replace(num_string,'');
		document.getElementById("base_add_in").value	= base_add_in;
		
		obj.style.display = "none";
	}


	//** 추가할 리스트 생성
	function fnChkBaseIn(){
	
		num = document.getElementById("insert_num").value;
		num = parseInt(num) + 1;
	
		document.getElementById("base_add_in").value	+= num.toString() + "@";
		document.getElementById("insert_num").value		= num;


		base =		       "    <table id='table_display"+num+"'> "
		base = base + "        <tr> "
		base = base + "            <td width='20%' class='tob1'><input type='text' name='cd"+num+"' id='cd"+num+"' style='width:80%;' class='input_color' maxlength='4'></td>"
		base = base + "            <td width='*%' class='tob2'><input type='text' name='cd_nm"+num+"' id='cd_nm"+num+"' style='width:90%;' class='input_color' maxlength='15'></td>"
		base = base + "            <td width='15%' class='tob2'><span class='button_a'><a onClick=\"fnChkBaseAddIn()\">등록</a></span></td>"
		base = base + "            <td width='15%' class='tob2'><span class='button_a'><a onClick=\"fnChkBaseAddDel(document.getElementById('table_display"+ num +"'),"+ num +")\" >삭제</a></span></td>"
		base = base + "        </tr>"
		base = base + "     </table>"

		document.getElementById("base_in_table").innerHTML +=  base;
	//	parent.doResize();
	}

	//**	데이터 수정
	function fnChkBaseUp(cd, cd_nm, cd_, cd_nm_){
		var msg = confirm(cd_nm+"("+cd+")(으)로 수정하시겠습니까?");
		var url = "cd="+cd+"&cd_nm="+cd_nm+"&cd_="+cd_+"&cd_nm_="+cd_nm_;

		if (msg){
			ifmJob.location.href = "base_up.asp?"+url;
		}
	} 


	//**	데이터 삭제
	function fnChkBaseDel(cd, cd_nm, cd_, cd_nm_){
		var msg = confirm(cd_nm+"("+cd+")(을)를 삭제하시겠습니까?\n"+cd_nm+"("+cd+")(을)를 삭제시 관련 코드가 모두 삭제됩니다.");
		var url = "cd="+cd+"&cd_nm="+cd_nm+"&cd_="+cd_+"&cd_nm_="+cd_nm_;

		if (msg){
			ifmJob.location.href = "base_del.asp?"+url;
		}
	}


	//** 데이터 추가
	function fnChkBaseAddIn(){//////////// 데이터 추가
		
		
		var url = ""
		var str = document.getElementById("base_add_in").value;
		var value = "";

		str = str.substring(0, str.length -1);	//새로 추가시 번호조합 1000@1001....
		str_list = str.split("@");

		size = str_list.length;//받는 페이지에서 배열 개수를 받기위해..

		if (size>10){
			alert('10개 까지 등록가능합니다');	//등록제한
			return;
		}


		for(i = 0 ; i < size; i++){
			num_i = str_list[i];
			if (num_i.length!=4){			//저장되어진 숫자들이 4자리가 아닐때
				alert('잘못된 값입니다.');
				return;
			}

			num_i = num_i.toString();
		
			cd_i = 'cd' + num_i;
			cd_nm_i = 'cd_nm' + num_i;
			cd_str = document.getElementById(cd_i).value;
			cd_nm_str	 = document.getElementById(cd_nm_i).value;
			
			if(isNaN(num_i)){
				alert("오류가 발생했습니다. 새로고침후 사용하세요");	//저장되어진 변수가 숫자가 아닐때
				return;
			}


			if (cd_str=="" || cd_nm_str==""){
				alert("입력값이 비었습니다.");	
				return;
			}

			value = value + cd_str + '||' + cd_nm_str + '@@';//스트링으로 넘겨 배열로 처리하기 위해 cd||값@@cd_nm||값
		}   
		value = value.substring(0, value.length -2);

		url = 'value='+value;

		
		ifmJob.location.href = "base_In.asp?"+url;
	}

//-->
</script>


