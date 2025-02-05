<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"--> 

<%
    num = Request("num")
    g_kind = Request("g_kind")
    s_area = Request("s_area")

    OpenF5_DB objConn
   
    If Trim(memnum) <> "" then
        sql = "SELECT * FROM TB_member WHERE num = "&memnum
        Set rs = objConn.Execute(sql)

        CloseRs Rs
	
        CloseF5_DB objConn 
    End if
%>

<!DOCTYPE html>
<html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link type="text/css" rel="stylesheet" href="<%=global_url%>/css/style.css" />
<script type="text/javascript" src="/home/js/jquery-3.4.1.min.js"></script>
 <link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
</head>

<body style="padding:20px;overflow-y:hidden;" onload="javascript:document.check.email.focus();">

    <form name="check" method="post"  onsubmit="return email_check();" action="sendmail_mem_ok.asp">
    <input type="hidden" name="data0" value="">
    <input type="hidden" name="data1" value="">
    <input type="hidden" name="data2" value="">
    <input type="hidden" name="data3" value="">
    <input type="hidden" name="data4" value="">
    <input type="hidden" name="data4" value="">
    <input type="hidden" name="g_kind" value="<%=g_kind%>">
    
        <div class="pt10"></div>
        <div class="rater_title">메일보내기</div>
        <div class="pt10"></div>
        
        <div class="mail_box">
            <table>
            	<colgroup>
            		<col width="120px">
            		<col width="*">
            	</colgroup>
            	<tbody>  
            		<tr>
            			<td class="typ1">메일</td>
            			<td class="typ2"><input  name="email" type="text" style="width:100%;"></td>
            		</tr>
            		<tr>
            			<td class="typ3">메세지</td>
            			<td class="typ4"><textarea name="email2" style="width:98%;height:110px;"></textarea></td>
            		</tr>  		
            		<tr>
            		    <td class="typ3">보완문자</td>
            		    <td class="typ4">
            		        <span><a href="javascript:void(0)" onclick="RefreshImage('imgCaptcha')"><img id="imgCaptcha" src="captcha.asp" border="0" alt="글자가 잘 안보이시면 클릭하세요" align="absmiddle"></a></span>
            		        <span><input type="text" name="captchacode" id="captchacode" style="width:100px;" class="input_basic" /></span>
            		        <span style="font-size:13px; color: #FF0000; font-weight:500;padding: 0px 7px;">옆 글자 입력</span>
            		    </td>
            		</tr>
            	</tbody>
            </table> 
        </div>

        <div class="pt20"></div>

        <div style="width:100%;border:1px solid #E7E8E9;background:#FFFFFF;OVERFLOW-Y:auto;height:320px">
            <div style="color: #666; font-size:13px; padding:20px; line-height:1.5em;">
                <strong>메일 발송 서비스 제공을 위해 아래와 같이 개인정보를 수집할 수 있습니다.<br>단순 메일 보내기 기능으로써 기재 정보는 별도 보관되어지지 않습니다.</strong>
                 <br>
                <br>회사는 적법한 절차와 법적기준에 의거하여 고객의 개인정보를 수집하고 있으며, 고객의 서비스이용에 필요한 최소한의 정보만을 수집하고 있습니다. <br>정보통신망법으로 규제하는 개인정보보호제도에 의거하여, 고객의 주민번호는 수집.이용을 제한하고 있습니다.
                <br>회사는 고객의 인권을 침해할 우려가 있는 민감한 개인정보항목 (인종, 종교, 사상, 정치적 성향, 건강상태, 성생활정보 등)은 수집하지 않습니다
                <br>
                <br>- 수집항목 : 받는 사람의 이메일 주소
                <br>- 수집목적 : 이용자의 상품 공유 메일 발송을 위함
                <br>- 보유기간 : 보유하지 않음
            </div>
        </div>

        <div class="pt20"></div>
        
        <div> 
            <span class="checks"><input type="checkbox" name="agreement" value="1" id="check_ok"><label for="check_ok" style="font-weight:500;">이메일 발송 서비스를 위한 개인정보 수집 이용에 동의합니다.</label></span>
        </div>
   
        <div class="pt20"></div>
        
        <div align="center">
            <input type="image" src="/images/goods/mail_but.png" border="0" style="border:0px solid #FFF;">
        </div>
        
    </form>

</body> 
</html> 

<iframe id="detail" src="Sendmail_ticket.asp?num=<%=num%>&g_kind=<%=g_kind%>&s_area=<%=s_area%>" width="0"  height="0" marginwidth="0" marginheight="0" frameborder="no"></iframe>
	
<script language="JavaScript">
    function email_check(){
        form = document.check;
        
        if(form.email.value == "") {
            alert("받는 분의 메일을 입력하세요")
            form.email.focus();
            return false;
        }
        
        if (form.email.value.search(/(\S+)@(\S+)\.(\S+)/) == -1 ){
            alert("받는 분 메일이 부정확합니다.");     
            form.email.focus(); 
            return false;    
        }	

        if(form.captchacode.value == "") {
            alert("스팸방지 글자를 입력하셔야 합니다.");
            form.captchacode.focus();
            return false;
        }

        if (document.all.agreement.checked == false){
            alert("개인정보 수집 항목 및 수집방법에 동의하셔야 메일전송이 가능합니다.");
            form.agreement.focus();
            return false;
        }
  
        var getval = $('#detail').contents().find('#contents0').html();
        form.data0.value=getval;
    }
</script>