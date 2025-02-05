<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<%
    rsmemid = Request("rsmemid")

    OpenF5_DB objConn 

    sql = "Select Count(num) From TB_member Where memid ='"&rsmemid&"'"
    Set rs = objConn.Execute(sql)

    If rs(0) = 0 Then
	    '사용할수 있슴
	    checkvalue = 1
    Else
	    '사용할수 없슴
	    checkvalue= 2
    End If

    CloseRs Rs 
    CloseF5_DB objConn 
%>

<!DOCTYPE html>
<html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>

<body>

    <div class="pt15"></div>   

    <form name="form1" style="display:inline; margin:0px;">
        <div class="table_box">
            <table>
                <tr>
                    <td width="20%" class="lop1">아이디</td>
                    <td width="*%" class="lop2"><input type="text" name="rsmemid" value="<%=rsmemid%>" style="width:100%" class="input_basic"></td>
                    <td width="20%" class="lop2"><span class="button_a"><a onclick="return memberid();">확인</a></span></td>
                </tr>
            </table>
        </div>
        
        <div class="pt15"></div>  
        
        <div align="center">
            <% If checkvalue = "1" Then %>
                <font color="#35559F">"입력하신 회원 ID는 사용이 가능합니다."</font>
            <% Elseif checkvalue = "2" Then %>  
                <font color="#35559F">"입력하신 회원 ID는 이미 존재합니다."<br>"다른 ID을 사용하시기 바랍니다."</font>
            <% End If %>  
        </div>  
         
        <div align="center" style="padding:25px 0 30px 0;">
            <span class="button_b"><a onClick="sendit();return false;">확인</a>
            <span class="button_b"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
        </div>
    </form>  

</body>
</html>

<script language="javascript">
<!--
    function closeIframe(){
        parent.$('#chain_id').dialog('close');
        return false;
    }
-->
</script> 

<script language="javascript">  
<!--  
    function memberid(){  
        if(document.form1.rsmemid.value.substr(0,1)==" "){  
            alert("아이디의 첫글자에는 공백문자를 넣을 수 없습니다!");  
            document.form1.rsmemid.focus();  
            return false;  
        }	  
    	  
        if(document.form1.rsmemid.value==""){  
            alert("아이디를 입력해주세요!");  
            document.form1.rsmemid.focus();  
            return false;  
        }  
      
        document.form1.method="post";  
        document.form1.action="idsearch.asp";  
        form1.target = 'selfWin';
        window.name = 'selfWin';
        document.form1.submit();  
    }  
      
    function sendit(){ 
        parent.document.form1.memid.value=document.form1.rsmemid.value;  
        parent.$('#chain_id').dialog('close');
    }  
//-->  
</script>  
