<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->

<%
	memkind = request("memkind")
	
    OpenF5_DB objConn

    num = Request("num")
    
    if num="" then
        Alert_Window("주요인자 전송에러!!")
        response.end
    end if
    
    Sql = "SELECT  memid, pwd, kname, elname, efname, birthday, htel,Gender  FROM TB_member WHERE num = "&num
    Set Rs = objConn.Execute(Sql)
    
    if Rs.EOF or Rs.BOF then
        Alert_Window("선택된 고객의 정보가 없습니다.")
        response.end
    end if
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

            <div class="table_box">
                <table>
                    <tr>
                        <td class="lop1" width="15%">아이디(이메일)</td>
                        <td class="lop2" width="*%"><%=Rs("memid")%></td>
                    </tr>
                    <tr>
                        <td class="lob1">비밀번호</td>
                        <td class="lob2"><%=Rs("pwd")%></td>
                    </tr>
                    <tr>
                        <td class="lob1">한글명</td>
                        <td class="lob2"><%=Rs("kname")%></td>
                    </tr>
                 <!--   <tr>
                        <td class="lob1">생년월일</td>
                        <td class="lob2"><%=(Rs("birthday"))%> </td>
                    </tr>-->
                    <tr>
                        <td class="lob1">휴대전화번호</td>
                        <td class="lob2"><%=Rs("htel")%></td>
                    </tr>
                </table>
            </div>

            <div class="pt25"></div>   
                
            <div align="center">
                <span class="button_b" style="padding:0px 4px"><a onClick="location.href='member_modify.asp?num=<%=num%>&memkind=<%=memkind%>'">수정</a></span> 
                 <span class="button_b" style="padding:0px 4px"><a onClick="del();">삭제</a></span>
                <span class="button_b" style="padding:0px 4px"><a onClick="go_list();">목록</a></span>
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
    function go_list(){
        location.href='member_list.asp';
    }
 
    function del(){
        if(!confirm("삭제 하시겠습니까?")){
            return false;
        }else{
            location.href="process.asp?num=<%=num%>&admin_action=member_del"
            return true;
        }
    }
//-->  
</script>  
