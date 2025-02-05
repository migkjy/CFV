<div class="text_e1">
<% 
	Dim blockpage,PageI
	
	blockPage=Int((Page-1)/10)*10+1

	If blockPage = 1 Then
		Response.Write "<img src='/admin/images/but_prev.gif' width='11' height='11' align='absmiddle'>"
	Else 
		Response.Write "<a href='#' onClick="&Chr(34)&"fnBoardUrl('"&blockPage-10&"')"&Chr(34)&"><img src='/admin/images/but_prev.gif' width='11' height='11' align='absmiddle'> </a>"
	End If


	Response.Write "&nbsp;&nbsp;"
	
	PageI=1
	Do Until PageI > 10 or blockPage > PageCount
		If blockPage=int(Page) Then
			Response.Write "<span class=""page_type_select"">"&blockPage&"</span> "
		Else
			Response.Write "<a href='#' onClick="&Chr(34)&"fnBoardUrl('"&blockPage&"')"&Chr(34)&">["&blockPage&"]</a> "  
		End If
		blockPage=blockPage+1
			PageI = PageI + 1
	Loop
	
	Response.Write "&nbsp;&nbsp;"
	
	If  blockPage > PageCount Then
		Response.Write "<img src='/admin/images/but_next.gif' width='11' height='11' align='absmiddle'>" 
	Else 
		Response.Write "<a href='#' onClick="&Chr(34)&"fnBoardUrl('"&blockPage&"')"&Chr(34)&"><img src='/admin/images/but_next.gif' width='11' height='11' align='absmiddle'></a>" 
	End If
%>
</div>


<SCRIPT LANGUAGE="JavaScript">
<!--
	function fnBoardUrl(page){
		url1	= "<%=list%>"
		url		= url1+'&page='+page+'&level=<%=level%>&cmtKind=<%=cmtKind%>&typeBrd=<%=typeBrd%>&cd_fg=<%=cd_fg%>&cd=<%=cd%>&key=<%=key%>&keyfield=<%=keyfield%>';
		location.href=url;
	} 
//-->
</SCRIPT>