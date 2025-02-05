<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    Dim objMem ,query_mem
    Dim from_date ,to_date
    OpenF5_DB objConn
    If emp_no = "" Or em_pass = ""  Then
    	Call Alert_Window_Location("로그인 하지 않으셨거나 회원님의 정보를 확인할 수 없습니다.\n\n다시 로그인 하여주세요.\n\n","/admin/erp_login.asp")
    	Response.End
    end if
    
    query_mem = "Select emp_no,dept_cd,em_pass,email,nm,tell,handphone from TB_em001 where emp_no = '"& Request.cookies("emp_no") &"'"
    
    Set objMem = objConn.Execute(query_mem)
    if objMem.eof and objMem.bof then
    	 Call Alert_Window_Location("회원님의 정보를 확인할 수 없습니다.\n\n다시 로그인 하여주세요.\n\n","/admin/login.asp")
    	 Response.End
    else
    
        emp_no = objMem("emp_no")
        Response.Cookies("dept_cd") =objMem("dept_cd")
        em_pass = objMem("em_pass")
        email  = objMem("email")
    	  nm = objMem("nm")
    	  tell  = objMem("tell")
    	  handphone = objMem("handphone")
    
    end if
    
    objMem.close  : Set objMem = Nothing
%>

<!DOCTYPE html>
<html>
<head>
<title>메인</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>

<style type="text/css">
    .Acls {color:#000000;}
    .Bcls {color:#C926C0;}
    .Ccls {color:#B72200;}
    .Dcls {color:#3939CA;}
    .Ecls {color:#888888;}
    .Fcls {color:#00901B;}
    .Gcls {color:#FF0000;}
</style>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">

        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="*%" valign="top">
                    <div class="main_cata"><i class="xi-align-left xi-x"></i> 프로그램 예약</div>
                    <!--#include virtual="/admin/main/reserve_tkt.asp"-->
                    <div align="right"  style="padding:10px 0 0 0;"><a href="/admin/reserve_tck/reserve_list.asp"><i class="xi-plus-min xi-x"></i>more</a></div>
                </td>
                <td width="2%"></td>
                <td width="49%" valign="top">
                    <div class="main_cata"><i class="xi-align-left xi-x"></i>발리 맛집</div>
                    <!--#include virtual="/admin/main/main_food.asp"-->
                    <div align="right"  style="padding:10px 0 0 0;"><a href="/admin/board/after_list.asp"><i class="xi-plus-min xi-x"></i>more</a></div>
                </td>
            </tr>
            <tr>
                <td height="30" colspan="3"></td>
            </tr>
            <tr>
                <td valign="top">
                    <div class="main_cata"><i class="xi-align-left xi-x"></i> 룸메이트 매칭현황</div>
                    <!--#include virtual="/admin/main/main_matching.asp"-->
                    <div align="right"  style="padding:10px 0 0 0;"><a href="/admin/roommate/matching_list.asp"><i class="xi-plus-min xi-x"></i>more</a></div>

                </td>
                <td></td>
                <td valign="top">

                    <div class="main_cata"><i class="xi-align-left xi-x"></i> 공지사항</div>
                    <!--#include virtual="/admin/main/main_notice.asp"-->
                    <div align="right"  style="padding:10px 0 0 0;"><a href="/admin/board/notice_list.asp?g_kind=10"><i class="xi-plus-min xi-x"></i>more</a></div>

                </td>
            </tr>
        </table>

    </div> 

</body>
</html> 

<%
    CloseF5_DB objConn	
%>