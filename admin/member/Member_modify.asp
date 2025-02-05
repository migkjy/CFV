<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->

<%
    OpenF5_DB objConn

    num = Request("num")

    
    Sql = "SELECT * FROM TB_member WHERE num = "&num
    Set Rs = objConn.Execute(Sql)
      
   
%>

<!DOCTYPE html>
<html>
<head>
<title>회원정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 회원정보</div>

        <form name="form1" method="POST" style="display:inline; margin:0px;">
        <input type="hidden" name="num" value="<%=num%>">
        <input type="hidden" name="admin_action" value="member_modify">

            <div class="table_box">
                <table>
                   
                    <tr>
                        <td class="lop1" width="15%">아이디(이메일)</td>
                        <td class="lop2" width="*%"><input type="text" name="memid" value="<%=Rs("memid")%>" style="width:200px;" maxlength="10" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="lob1">비밀번호</td>
                        <td class="lob2"><input type="text" name="pwd1" value="<%=Base64_Decode(Rs("pwd"))%>" style="width:200px;" maxlength="30" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="lob1">비밀번호 재확인</td>
                        <td class="lob2"><input type="text" name="pwd2" value="<%=Base64_Decode(Rs("pwd"))%>" style="width:200px;" maxlength="30" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="lob1">닉네임</td>
                        <td class="lob2"><input type="text" name="kname" value="<%=Rs("kname")%>"  style="width:200px;" maxlength="10" class="input_basic"></td>
                    </tr>
                   <!-- <tr>
                        <td class="lob1">생년월일</td>
                        <td class="lob2"><input type="text" name="birthday" style="width:200px;" maxlength=10 value="<%=(Rs("birthday"))%>" class="input_basic"> </td>
                    </tr>-->
                    <tr>
                        <td class="lob1">휴대전화번호</td>
                        <td class="lob2"><input type="text" name="handtel" value="<%=Rs("htel")%>" style="width:200px;" maxlength="20" class="input_basic"><span style="padding:0px 10px"><font color="#888">예) 010-0000-0000</font></span></td>
                    </tr>
                </table>
            </div>
              
            <div class="pt25"></div>   
                
            <div align="center">
                <span class="button_b" style="padding:0px 2px"><a onClick="inputok();">수정</a></span> 
                <span class="button_b" style="padding:0px 2px"><a href="member_list.asp">취소</a></span>
            </div>

        </form>
    </div>
        
</body>
</html>



<%
    CloseRs Rs 
    CloseF5_DB objConn 
%>


<script language="javascript">
<!--
    function inputok(){
	
        var thisfrm = document.form1;
        var strAlNumcomp="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 ";   
        var strmailcomp=strAlNumcomp + "@.-_";    
        var strspcomp="'~!@#$%^&*()_-+=\<>?/:;|,.";    
	               
        var thisfrm = document.form1;
        if (document.form1.memid.value=="" || document.form1.kname.value=="" ||   document.form1.handtel.value==""){
            alert("필수 항목을 입력해 주세요.");
            return;
        }
	
        if (thisfrm.pwd1.value == ""){
            alert("비밀번호를 입력하세요\n비밀번호는 필수 입력사항입니다.\n\n");
            thisfrm.pwd1.focus();
            return;
        }
        
        if (thisfrm.pwd2.value == ""){
            alert("비밀번호확인을 입력하세요\n비밀번호확인은 필수 입력사항입니다.\n\n");
            thisfrm.pwd2.focus();
            return;
        }
        
        if (thisfrm.pwd1.value != thisfrm.pwd2.value){
            alert("입력하신 비밀번호가 서로 다릅니다.\n확인하여 주세요\n\n");
            thisfrm.pwd1.focus();
            return;
        }

        if (thisfrm.kname.value == ""){
            alert("이름을 입력하세요\n이름은 필수 입력사항입니다.\n\n");
            thisfrm.kname.focus();
            return;
        }
	
        if (thisfrm.handtel.value == ""){
            alert("핸드폰번호를 입력하세요.\n핸드폰번호는 필수 입력사항입니다.\n");
            thisfrm.handtel.focus();
            return;
        }
        document.form1.action="process.asp";
        document.form1.submit();
    }  


    function chk_pass(){
        var thisfrm = document.form1;
        if (thisfrm.pwd1.value != thisfrm.pwd2.value){
            alert("입력하신 비밀번호가 서로 다릅니다.\n확인하여 주세요\n\n");
        }
    }
    
    
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
  

    function toUpCase(object){
        object.value = object.value.toUpperCase(); 
    }
//-->
</script>
