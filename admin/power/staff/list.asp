<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->

<%
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.AddHeader "Expires","0"
    
    OpenF5_DB objConn
    
    Dim tbl
    tbl		= "TB_EM001" '테이블 이름
    Dim cmtId,page,key,keyfield
    
    	page = Request("page")
    	key = Trim(Request("key"))
    	keyfield	 = Request("keyfield")
    emp_yn  = Request("emp_yn")
    
    If emp_yn = "" then emp_yn = 1 end if
    
    If emp_yn = "1" then
        Sql_where = Sql_where & " and (quit_day is null or quit_day = '')"
    Elseif emp_yn = "2" then
        Sql_where = Sql_where & " and (quit_day is not null) and (quit_day <> '')"
    Else
        Sql_where = Sql_where & " and (quit_day is null or quit_day = '')"
    End if
      
    '// typeRepl 0 이면 리플불가, 1이면 리불 가능
    '// typeData 0 이면 파일첨부불가, 1이면 파일첨부 가능
    '// typePhoto 0 이면 사진첨부불가, 1이면 사진첨부 가능
    
    If Page = "" Then Page = 1
    
    Dim pageSize
    
    pageSize = 500

    Dim GCount,PageCount
    
    sql = " select count(*) "
    sql = sql &	" from "& tbl
    sql = sql & " where (del_fg = 'N' or del_fg is null) " & Sql_where & ""
    If  key<>"" Then sql = sql & " and " & keyfield & " like '%" & key & "%' "
    
    Set GCount = objConn.execute(sql)
    
    If isnull(GCount) Then
        GCount = 1 
    Else
        GCount = GCount(0)
    End If
    
    If GCount/PageSize = Int(GCount/PageSize) then
        PageCount = Int(GCount / PageSize)
    Else
        PageCount = Int(GCount / PageSize) + 1
    End If
  
    Dim Rs
    

    sql = " select top "& pagesize &" emp_no,nm,em_id, isNull(em_pass,'') as em_pass, ins_dt, em_id "
    sql = sql & " ,dbo.fn_ba001_cdnm('dept',dept_cd) as dept_nm	"
    sql = sql & " from "&tbl
    sql = sql & " where emp_no not in " 
    sql = sql &" (select top " & ((page-1) * pagesize) & " emp_no "
    sql = sql & " from "&tbl&" "
    sql = sql & " where  (del_fg = 'N' or del_fg is null) 	  " & Sql_where & " "
    If key<>"" Then sql = sql & " and " & keyfield & " like '%" & key & "%' "
    sql = sql & " )"
    sql = sql & " and (del_fg = 'N' or del_fg is null)  " & Sql_where & "   	"
    If key<>"" Then sql = sql & " and " & keyfield & "	like '%" & key & "%' "
    
    Set Rs = server.CreateObject("ADODB.Recordset")
    Rs.pagesize = pagesize
    Rs.open SQL,objConn,1
    
    tCount = Rs.RecordCount
    
    list = "list.asp?cd12="
%>

<!DOCTYPE html>
<html>
<head>
<title><%=fnTitle(cd)%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=fnTitle(cd)%></div>

        <form name="frmSearch" method="post" action="list.asp" style="display:inline; margin:0px;">
        <input type="hidden" name="cd" value="<%=cd%>">
        <input type="hidden" name="page" value="<%=page%>">
        <input type="hidden" name="keyfield" value="dept_cd">

            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
                <tr>
                    <td>
                        <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="bin_pa" width="150px">
                                    <select name="emp_yn" onChange="frmSearch.key.value=this.value;frmSearch.page.value=1;frmSearch.submit()" class="select_basic" style="width:100%;">
                                        <option value="1" <% if emp_yn = "1" then %>selected<% end if %>>재직사원</option>
                                        <option value="2" <% if emp_yn = "2" then %>selected<% end if %>>퇴직사원</option>
                                    </select>
                                </td>
                                <td class="bin_pa" width="150px">
                                    <select name="key" onChange="frmSearch.key.value=this.value;frmSearch.page.value=1;frmSearch.submit()" class="select_basic" style="width:100%;">
                                        <option value="">부서선택</option>
                                        <%
                                            subBa001 "dept", key
                                        %>
                                    </select>
                                </td>
                                <td class="bin_pa" width="100px"><span class="button_a"><a onClick="fnBoardList('<%=cd%>','','/admin/power/staff/list.asp','','','')">새로고침</a></span></td>
                                <td class="bin_pb" width="*%">
                                   <span class="button_a" style="padding:0 8px 0 0;"><a onClick="fnBoardWrite('<%=emp_no%>')">인사등록</a></span>
                                   <span class="button_a"><a href='list.asp'">목록</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <div class="pb15"></div> 
        
            <div class="table_list">
                <table>
                    <tr>
                        <td width="*%" class="top1">No.</td>
                        <td width="11%" class="top2">사원번호</td>
                        <td width="11%" class="top2">아이디</td>
                        <td width="11%" class="top2">비밀번호</td>
                        <td width="11%" class="top2">한글명</td>
                        <td width="10%" class="top2">부서</td>
                        <td width="10%" class="top2">등록일</td>
                        <td width="10%" class="top2">권한관리</td>
                        <td width="10%" class="top2">퇴사</td>   
                        <td width="10%" class="top2">삭제</td>
                    </tr>
                    <%
                        If Not Rs.Eof Then
                            Dim i, k
                            k = 1
                            i = GCount-((page-1)*PageSize)
                            Do Until Rs.Eof
                            
                                em_id = Rs("em_id")
                                If em_id<>"" Then em_id =""&em_id&"" Else em_id = ""  
                                If Len(Rs("ins_dt"))>7 Then ins_dt	= Left(Rs("ins_dt"),10) 
                                If k<>1 Then
                                End if
                    %>
                    <tr bgcolor="FFFFFF" onmouseover="this.style.backgroundColor='#d7ecff';" onmouseout="this.style.backgroundColor='';" >
                        <td class="tob1"><span style="cursor:pointer;" onClick="fnBoardView('<%=Rs("emp_no")%>')"><%=i%></span></td>
                        <td class="tob2"><span style="cursor:pointer;" onClick="fnBoardView('<%=Rs("emp_no")%>')"><%=em_id%></span></td>
                        <td class="tob2"><span style="cursor:pointer;" onClick="fnBoardView('<%=Rs("emp_no")%>')"><%=Rs("emp_no")%></span></td>
                        <td class="tob2"><span style="cursor:pointer;" onClick="fnBoardView('<%=Rs("emp_no")%>')"><%=Base64_Decode(Rs("em_pass"))%></span></td>
                        <td class="tob2"><span style="cursor:pointer;" onClick="fnBoardView('<%=Rs("emp_no")%>')"><%=Rs("nm")%></span></td>
                        <td class="tob2"><span style="cursor:pointer;" onClick="fnBoardView('<%=Rs("emp_no")%>')"><%=Rs("dept_nm")%></span></td>
                        <td class="tob2"><span style="cursor:pointer;" onClick="fnBoardView('<%=Rs("emp_no")%>')"><%=ins_dt%></span></td>
                        <td class="tob2"><span class="button_a"><a onClick="fnPower('<%=Rs("emp_no")%>')">권한관리</a></span></td>
                        <td class="tob2"><span class="button_a"><a onClick="member1_out('<%=Rs("emp_no")%>')")">퇴사</a></span></td>
                        <td class="tob2"><span class="button_a"><a onClick="fnEmDel('<%=Rs("emp_no")%>')">삭제</a></span></td>
                    </tr>
                    <%
                            Rs.MoveNext
                            i=i-1
                            k=k+1
                            Loop
                    
                        Else
                    %>
                    <tr>
                        <td class="bin" colspan="10">등록된 사원이없습니다.</td>
                    </tr>
                    <%
                        End If
                    %>
                </table>
            </div>
            
            <!--
            <div class="pt20"></div> 
            <div class="paginate1">
                <div align="center">
                    <% 
                        Dim blockpage,PageI
                    	
                        blockPage=Int((Page-1)/10)*10+1
                    
                        If blockPage = 1 Then
                            Response.Write "<span class='direction'>이전</span>&nbsp;&nbsp;&nbsp;&nbsp;"
                        Else 
                    		Response.Write "<a href='#' onClick="&Chr(34)&"fnBoardUrl('"&blockPage-10&"')"&Chr(34)&" class='direction'>이전</span>&nbsp;&nbsp;&nbsp;&nbsp;"
                        End If
                    
                        PageI=1
                        Do Until PageI > 10 or blockPage > PageCount
                            If blockPage=int(Page) Then
                                Response.Write "<strong>"& blockPage &"</strong>&nbsp;&nbsp;" 
                            Else
                                Response.Write "<a href='#' onClick="&Chr(34)&"fnBoardUrl('"&blockPage&"')"&Chr(34)&">" & blockPage & "</a>&nbsp;&nbsp;"
                            End If
                            blockPage=blockPage+1
                            PageI = PageI + 1
                    	Loop
                    	
                    	If  blockPage > PageCount Then
                    		Response.write "&nbsp;&nbsp;<span class='direction'>다음</span>"
                    	Else 
                    		Response.Write "<a href='#' onClick="&Chr(34)&"fnBoardUrl('"&blockPage&"')"&Chr(34)&" class='direction'>다음</a>"
                    	End If
                    %>
                </div>
            </div>
            -->
            
        </form>
    </div>
        
</body>
</html>

<%
    CloseF5_DB objConn 
%>
<iframe name="ifmJob" id="ifmJob" src=""  allowTransparency=true width="0" height="0" marginwidth="0" marginheight="0" vspace="2" scrolling="yes" frameborder="0" framespacing="0" frameborder="0"></iframe></td>
<script language="javascript">
<!--
	function fnBoardUrl(page){
	    url1	= "<%=list%>"
	    URL = url1+'&page='+page+'&level=<%=level%>&cmtKind=<%=cmtKind%>&typeBrd=<%=typeBrd%>&cd_fg=<%=cd_fg%>&cd=<%=cd%>&key=<%=key%>&keyfield=<%=keyfield%>';
	    location.href=url;
	} 


	var url = 'cd=<%=cd%>&key=<%=key%>&keyfield=<%=keyfield%>&page=<%=page%>';
	function fnBoardList(){

		location.href='list.asp?'+url;
	}
	function fnBoardView(emp_no){		// 페이지 보기
	    url = 'write.asp?emp_no='+emp_no+'&rekind=u&'+url;
	    location.href=url;
	}


	function fnPower(emp_no){		// 페이지 보기
	    url = 'power.asp?emp_no='+emp_no+'&'+url;
	    location.href=url;
	}


	function member1_out(emp_no){
		if(!confirm("퇴사처리 하시겠습니까?")){
		    return false;
		}else{
		    location.href='quit_emp.asp?emp_no='+emp_no+'&'+url;
	    return true;
		}
	}


	function fnBoardWrite(){
	    location.href='write.asp?'+url;
	}	


	function fnEmDel(emp_no){
		ans = confirm('<%="정말로 삭제하시겠습니까?"%>      ');
		if(ans){
		    url = "del.asp?emp_no="+emp_no+"&"+url;
		    ifmJob.location.href = url;
		}else{
		    return;
		}		
	}
//-->
</SCRIPT>


