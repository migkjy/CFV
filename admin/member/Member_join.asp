<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<%
    OpenF5_DB objConn 
%>

<!DOCTYPE html>
<html>
<head>
<title>회원등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/admin/scripts/global.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
</head>

<body onload="init_orderid();">

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 회원등록</div>

        <form name="form1" method="POST" style="display:inline; margin:0px;">
        <input type="hidden" name="admin_action" value="member_join">
        <input type="hidden" name="memkind" value="4">

            <div class="table_box">
                <table>
                    <tr>
                        <td width="12%" class="lop1">고객등급</td>
                        <td width="*%" class="lop2">
                            <select name="cugr_cd" hname="고객등급" required class="select_basic" style="width:157px;">
                                <%
                                    subBa001 "CUGR", cugr_cd
                                %>
                            </select>	         	
                        </td>
                    </tr>
                    <tr>
                        <td class="lob1">회원 아이디</td>
                        <td class="lob2">
                            <span><input type="text" name="memid" style="width:200px;" maxlength="10" class="input_basic"></span>
                            <span class="button_a" style="padding:0px 10px"><a onClick="idsearch();return false;">중복확인</a></span>
                            <span><font color="#0080C0">공백없이 4~15자, 영문/숫자만 가능</font></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="lob1">비밀번호</td>
                        <td class="lob2"><input type="text" name="pwd1" style="width:200px;" maxlength=30  class="input_basic">&nbsp;&nbsp;<font color="#0080C0">영문, 숫자 4~10자리까지</font></td>
                    </tr>
                    <tr>
                        <td class="lob1">비밀번호확인</td>
                        <td class="lob2"><input type="text" name="pwd2" style="width:200px;" maxlength=30  class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="lob1">한글명</td>
                        <td class="lob2"><input type="text" name="kname" style="width:200px;" maxlength="10" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="lob1">영문명</td>
                        <td class="lob2"><input type="text" name="elname" onKeyUp="toUpCase(this)" style="width:200px;" maxlength="20" class="input_basic"> / <input type="text" name="efname" onKeyUp="toUpCase(this)" style="width:300px;"maxlength="40" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="lob1">생년월일</td>
                        <td class="lob2">
                            <select name="ent_year"  id="ent_year" class="select_basic" style="width:100px;" hname="생년" required>
                                <option value="">----</option>
                                <%
                                    start_year	= CInt(Year(now))-80
                                    end_year = CInt(Year(now))
                                    subYear start_year, end_year, ent_year					    											
                                %>
                            </select>
                            <span style="padding: 0 10px 0 5px;">년</span>
                            <select name="ent_month"  id="ent_month" class="select_basic" style="width:50px;" hname="생년월" required onChange="fnDayCall(document.getElementById('ent_year').value,this.value,document.getElementById('ent_day'))">
                                <option value="">----</option>
                                <%
                                    subMonth(ent_month)					    										
                                %>
                            </select>
                            <span style="padding: 0 10px 0 5px;">월</span>
                            <select name="ent_day" id="ent_day" class="select_basic" style="width:50px;"  hname="생년일" required>
                                <option value="<%=ent_day%>"><%=ent_day%></option>
                            </select>
                            <span style="padding: 0 10px 0 5px;">일</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="lob1">이메일</td>
                        <td class="lob2">
                            <span><input type="text" name="email1" style="width:200px;" maxlength="20" class="input_basic" onKeyUp="LowerCase(this)"></span>
                            <span style="padding:0 2px;">@</span>
                            <span><input type="text" name="email2" style="width:300px;" maxlength="40" class="input_basic" onFocus="setEmailEnable(form1.emailcode,form1.email2)"  onKeyUp="LowerCase(this)"></span>
                            <span style="padding:0 0 0 10px;">
                                <select name="emailcode"  class="select_basic" style="width:200px;" class="input" onChange="setEmailcode(form1.email2,form1.emailcode,form1.emailcode.selectedIndex)">
                                    <option value="0">--선택하세요--</option>
                                    <%
                                        subBa001_Email "mail",email
                                    %>
                                    <option value="9">직접입력 </option>
                                </select>
                            </span>
                        </td>
                    </tr> 
                    <tr>
                        <td class="lob1">전화번호</td>
                        <td class="lob2"><input type="text" name="comtel" style="width:200px;" maxlength="20" class="input_basic"><span style="padding:0px 10px"><font color="#0080C0">예) 02-0000-0000</font></span></td>
                    </tr>
                    <tr>
                        <td class="lob1">휴대전화번호</td>
                        <td class="lob2"><input type="text" name="handtel" style="width:200px;" maxlength="20" class="input_basic"><span style="padding:0px 10px"><font color="#0080C0">예) 010-0000-0000</font></span></td>
                    </tr>
                    <tr>
                        <td class="lob1">이메일 수신여부</td>
                        <td class="lob2">
                            <select name="email_yn" class="select_basic" style="width:100px;">
                                <option value="Y" selected>수신동의</option>
                                <option value="N">수신거부</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="lob1">SMS 수신여부</td>
                        <td class="lob2">
                            <select name="sms_yn" class="select_basic" style="width:100px;">
                                <option value="Y" selected>수신동의</option>
                                <option value="N">수신거부</option>
                            </select>
                        </td>
                    </tr>   
                </table>
            </div>
              
            <div class="pt25"></div>   
                
            <div align="center">
                <span class="button_b" style="padding:0px 2px"><a onClick="inputok();">등록</a></span> 
                <span class="button_b" style="padding:0px 2px"><a onClick="history.back();">취소</a></span>
            </div>

        </form>
    </div>
        
</body>
</html>

<div id="chain_id" title="아이디 중복확인"></div>

<%
    CloseF5_DB objConn
%>

<script language="javascript">
    /* 고객번호 생성 */
    function init_orderid()
    {
        var today = new Date();
        var year  = today.getFullYear();
        var month = today.getMonth() + 1;
        var date  = today.getDate();
        //var time  = today.getTime();
        var hour = today.getHours();
		    var min = today.getMinutes();
		    var sec = today.getSeconds();
	      if(hour<10) hour="0"+hour;
		    if(min<10) min="0"+min;
		    if(sec<10) sec="0"+sec;
        if(parseInt(month) < 10) {
            month = "0" + month;
        }
        //var order_idxx = year + "" + month + "" + date + "" + time;
        var order_idxx = year + "" + month + "" + date + "" + hour + "" + min + "" + sec;
        document.form1.memid.value = order_idxx;
        document.form1.pwd1.value = order_idxx;
        document.form1.pwd2.value = order_idxx;   
    }
</script>

<script language="javascript"> 
<!-- 
    function StrCheck(checkStr, checkOK)  
    {  
        for (i=0; i<checkStr.length; i++)  
        {  
            ch=checkStr.charAt(i);  
            for(j=0; j<checkOK.length; j++)  
            {  
                if (ch==checkOK.charAt(j))  
                break;  
            }  
      
            if (j==checkOK.length)  
            {  
                return (false);  
                break;  
            }  
        }  
        return (true);  
    }  
     
    
    function inputok(){
        var thisfrm = document.form1;
        if (document.form1.memid.value=="" || document.form1.kname.value=="" ||   document.form1.handtel.value==""){
            alert("필수 항목을 입력해 주세요.");
            return;
        }
    	
        if(document.form1.pwd1.value != document.form1.pwd2.value){
            alert("비밀번호를 다시 확인해 주세요.");
            return;
        }
    	
        if(document.form1.pwd1.value.substr(0,1)==" "){
            alert("비밀번호의 첫글자에는 공백문자를 넣을 수 없습니다!");
            document.form1.pwd1.focus();
            return;
        }
    	
        if ( document.form1.pwd1.value.length < 4 || document.form1.pwd1.value.length > 15 ) //4~10자리가 아니면 안됨.
        {
            alert("비밀번호는 최소4자이상 최대15자이하로 입력해주세요!");
            document.form1.pwd1.focus();
            return;
        }
    	
        if(document.form1.email1.value == ""){
            alert("예약자의 정확한 메일주소를  입력해주세요.");
            document.form1.email1.focus();
            return false;
        }
    
        if(document.form1.email2.value == ""){
            alert("예약자의 정확한 메일주소를  입력해주세요.");
            document.form1.email2.focus();
            return false;
        }
        	
        if ((document.form1.email1.value == "") || (!document.form1.emailcode.value=="")) {
            var mEmail = document.form1.email1.value + "@" + document.form1.email2.value;
            if (mEmail.search(/^[_a-zA-Z0-9-\.]+@[\.a-zA-Z0-9-]+\.[a-zA-Z]+$/) == -1 ) {
                alert("전자우편주소의 형식은 '원하는 계정@[호스트|도메인]'과 같이 구성되어야 합니다."); 
                document.form1.email1.focus(); 
                return false;
            }
        }
    
        document.form1.action="process.asp";
        document.form1.submit();
    }
    
    
    function setEmailcode(setObject,selectObject,index) {
        setObject.value = selectObject[index].text;
        if (selectObject.value == "0" || selectObject.value == "9") {
            alert("정확한 메일주소를 선택해 주세요~~~");
            setObject.focus();
        }
        else
        setObject.blur();
    }
    
    
    function setEmailEnable(emailcodeObject,ipmenu2Object) {
        if (emailcodeObject.value == "0" || emailcodeObject.value == "9") {
            ipmenu2Object.value = "";
            ipmenu2Object.focus();
        }
        else
        ipmenu2Object.blur();
    }
    
    
    function idsearch(){
        if(document.form1.memid.value==""){
            alert("희망 아이디를 입력해 주세요.");
            return;
        }
    	
        if(document.form1.memid.value.substr(0,1)==" "){
            alert("아이디명의 첫글자에는 공백문자를 넣을 수 없습니다!");
            document.form1.memid.focus();
    		return;
        }
    	
        var regExpr = /^[a-zA-Z0-9]+$/;
        if ( document.form1.memid.value.length < 4 || document.form1.memid.value.length > 14 ) //4~14자리가 아니면 안됨.
        {
            alert("아이디는 최소4자이상 최대14자이하로 입력해주세요!");
            document.form1.memid.focus();
            return;
        }
        
        if ( regExpr.test(document.form1.memid.value) ); //alphanumeric으로만 구성되어 있으면 OK!
        else //한글과 alphanumeric인지 검사.
        {
            var regExprChr = /^[a-zA-Z0-9]$/;
            var chrEscaped;
            var chrOrig;
    		
            for( var intinx = 0; intinx <= document.form1.memid.value.length -1 ; intinx++ )
            {
                chrOrig = document.form1.memid.value.substring(intinx,intinx+1);
                chrEscaped = escape(chrOrig);
                if ( ( chrEscaped.substring(2,6) < "AC00" || chrEscaped.substring(2,6) > "D7AF" ) && !regExprChr.test(chrOrig)){
                    alert("아이디는 영문 또는 숫자만 입력가능합니다.!");
                    document.form1.memid.focus();
                    return;
                }
            }
        }
        
        
        var _url1 = "idsearch.asp?rsmemid="+document.form1.memid.value;
        $("#chain_id").html('<iframe id="modalIframeId1" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId1").attr("src",_url1);
    }
    
    $(document).ready(function(){
        $("#chain_id").dialog({
            autoOpen: false,
            modal: true,
            width: 600,
            height: 400
        });
    }); 


    function toUpCase(object){
        object.value = object.value.toUpperCase(); //toLowerCase 소문자
    }
--> 
</script>
