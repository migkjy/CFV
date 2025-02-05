<!--#include virtual="/admin/conf/config.asp"-->

<%
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.AddHeader "Expires","0"

    OpenF5_DB objConn

    rekind = Request("rekind")
    cd_fg = Request("cd_fg")
    cd = Request("cd")
    emp_no = Request("emp_no")
    key = Request("key")
    keyfield = Request("keyfield")
    page = Request("page")

    tbl	= "TB_em001"
    sql = " select nm,  "
	sql = sql & " dept_cd	= dbo.fn_ba001_cdnm('dept',dept_cd) "
	sql = sql & " from "& tbl 
	sql = sql & "	where emp_no = '"&emp_no&"'" 
	sql = sql & " and del_fg = 'N' "


    Set Rs = objConn.Execute(sql)
    If Not Rs.Eof Then 
        nm = Rs("nm")
        dept_cd = Rs("dept_cd")	
    End if
    CloseRs Rs 
%>

<!DOCTYPE html>
<html>
<head>
<title><%=fnTitle(cd)%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/global.js"></script>
</head>

<body>
    
    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=fnTitle(cd)%></div>

        <div class="table_list">
            <table>
                <tr>
                    <td width="12%" class="top1">No</td>
                    <td width="20%" class="top2">코드값</td>
                    <td width="25%" class="top2">권한 등록 페이지</td>
                    <td width="12%" class="top2">사용여부</td>
                    <td width="*%" class="top2">비고</td>
                </tr>
                <%
                    cd_fg2 = "page"
                    sql = "				select cd, cd_nm, cd_fg from TB_ba001 where cd_fg in ('"&cd_fg2&"') and del_fg='N' order by  cd asc "
                    Set Rs = objConn.Execute(sql)
                    i=1
                    If Not Rs.Eof Then
                
                    Do Until Rs.Eof
                    	
                        cd_fg = Rs("cd_fg")
                        cd = Rs("cd")
                        
                        Select Case UCase(Left(cd,1))
                        Case "A"
                            bgColor = "#9282CD"
                        Case "B"
                            bgColor = "#E19B50"
                        Case "C"
                            bgColor = "#E6749D"
                        Case "D"
                            bgColor = "#3E7E36"
                        Case "E"
                            bgColor = "#941494"
                        Case "F"
                            bgColor = "#20618e"
                        Case "G"
                            bgColor = "#A23737"	
                        Case "H"
                            bgColor = "#1B7984"		
                        Case "K"
                            bgColor = "#6581D0"		
                        Case "T"
                            bgColor = "#ee6704"		
                        Case "U"
                            bgColor = "#4c9254"		
                        End Select
                        
                        If Right(Rs("cd"),5) Mod 10 = 0 Then ' 대카테고리
                            title	="<span style='padding-left:30px;color:#C00000;font-weight:500;'><i class='xi-caret-down-square xi-x'></i> 상단메뉴</span>"
                        Else
                            title	="<span style='padding-left:60px;color:#0050C0'><i class='xi-check-square-o xi-x'></i> 서브메뉴</span>"
                        End if
                		    	
                        If k<>1 Then
                        End if
                %>
                <tr bgcolor="#FFFFFF">
                    <td class="tob1"><%=i%></td>
                    <td class="tob3"><%=title%>&nbsp;&nbsp;&nbsp;&nbsp;<%=cd%></td>
                    <td class="tob3" style="padding-left:50px;color:<%=bgColor%>"><%=Rs("cd_nm")%></td>
                    <td class="tob2" style="padding-top:4px;">
                        <% If Right(Rs("cd"),5) Mod 10 <> 0 Then %>
                            <iframe name="condi" src="power_use.asp?cd=<%=cd%>&emp_no=<%=emp_no%>" width="150" height="26" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
                        <% end if %>
                    </td>
                    <td class="tob3"></td>
                </tr>
                <%
                        Rs.MoveNext
                        i=i+1
                        Loop
                    Else
                %>
                    <tr>
                        <td class="bin" colspan="5">등록된 내용이 없습니다.</td>
                    </tr>
                <% End If %>
            </table>
        </div>

        <div class="pt25"></div>   
            
        <div align="center">
            <span class="button_b" style="padding:0px 4px"><a onClick="fnBoardWrite()">새로고침</a></span>
            <span class="button_b" style="padding:0px 4px"><a onClick="fnBoardList()">목록</a></span>
        </div>
            
    </div>
        
</body>
</html>
                
<%
    CloseF5_DB objConn
%>


<script language="javascript">
<!--
	function fnBoardList(){
		var url = 'cd=<%=cd%>&key=<%=key%>&keyfield=<%=keyfield%>&page=<%=page%>';
		location.href='list.asp?'+url;
	}
	function fnBoardWrite(){
		location.reload();
	}
//-->
</script>
