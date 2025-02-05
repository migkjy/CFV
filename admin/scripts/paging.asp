<%'-----------------------------------------------------------------

'		content : 게시판 페이징
'
'---------------------------------------------------------------------%>

<script language=javascript>
	function goPage(nPage)
	{
		document.frmList.page.value = nPage;
		document.frmList.submit();
	}
</script>
<%
'관리자용 페이징

Sub goPage(page, Pagecount, Aspfilename,etc) '페이징 함수
   Dim blockpage, p
   if inStr(Aspfilename,"?") > 0 then 
	strStartArg = "&"
   else
	strStartArg = "?"
   end if
   blockpage=Int((page-1)/10)*10+1
   if blockPage = 1 Then
   Response.Write "<img src='/images/community/but_prev.gif' align=absmiddle> &nbsp;"
   Else
	   Response.Write"<a href='"&Aspfilename & strStartArg & "page=" & blockPage-1 & etc &"'><img src='/images/community/but_prev.gif' align=absmiddle></a> "
   End If

   p=1
   Do Until p > 10 or blockpage > Pagecount
      If blockpage=int(page) Then
         Response.Write "" &"<b>" & blockpage & "</b>"&" &nbsp;" 
      Else
         Response.Write"<a href='"&Aspfilename & strStartArg & "Page=" & blockpage & etc & "'>"  & blockpage &  "</a> &nbsp;"
      End If
	         
      blockpage=blockpage+1
      p = p + 1
   Loop

   if blockpage > Pagecount Then
      Response.write " <img src='/images/community/but_next.gif' align=absmiddle>"
   Else
      Response.write" <a href='"&Aspfilename & strStartArg & "Page=" &  blockpage & etc &"'><img src='/images/community/but_next.gif' border=0 align=absmiddle></a>"
   End If
End Sub

Sub goPage2(page, Pagecount, Aspfilename,etc) '페이징 함수
   Dim blockpage, p
   if inStr(Aspfilename,"?") > 0 then 
	strStartArg = "&"
   else
	strStartArg = "?"
   end if
   blockpage=Int((page-1)/10)*10+1
   if blockPage = 1 Then
   Response.Write "<img src='/images/community/but_prev.gif'align=absmiddle> &nbsp;"
   Else
	   Response.Write"<a href='"&Aspfilename & strStartArg & "page=" & blockPage-1 & etc &"'><img src='/images/community/but_prev.gif'align=absmiddle></a> "
   End If

   p=1
   Do Until p > 10 or blockpage > Pagecount
      If blockpage=int(page) Then
         Response.Write blockpage &  " &nbsp;" 
      Else
         Response.Write"<a href='"&Aspfilename & strStartArg & "Page=" & blockpage & etc & "'>"  & blockpage &  "</a> &nbsp;"
      End If
	         
      blockpage=blockpage+1
      p = p + 1
   Loop

   if blockpage > Pagecount Then
      Response.write " <img src='/images/community/but_next.gif'align=absmiddle>"
   Else
      Response.write" <a href='"&Aspfilename & strStartArg & "Page=" &  blockpage & etc &"'><img src='/images/community/but_next.gif'border=0 align=absmiddle></a>"
   End If
End Sub


Sub gotoPageHTML(AspFileName, page, Pagecount)
   Dim blockpage, i
   blockpage=Int((page-1)/10)*10+1

   '********** 이전 10 개 구문 시작 **********
   if blockPage = 1 Then
      Response.Write "&nbsp;<img src='/images/community/but_prev.gif'align=absmiddle>&nbsp;"
   Else
   	Response.Write "&nbsp;<a href='" & AspFileName & "&page=" & blockPage-10 &"'><img src='/images/community/but_prev.gif'align=absmiddle></a>&nbsp;"
   End If
   '********** 이전 10 개 구문 끝**********

   i=1
   Do Until i > 10 or blockpage > Pagecount
      If blockpage=int(page) Then
         Response.Write "<span style='color:#FF7700'>&nbsp;<b>" & blockpage & "</b>&nbsp;</span>"
      Else
         Response.Write "<a href='" & AspFileName & "&page=" & blockpage &"'>" & "&nbsp;" & blockpage & "</a> "
      End If
	         
      blockpage=blockpage+1
      i = i + 1
   Loop

   '********** 다음 10 개 구문 시작********** 
   if blockpage > Pagecount Then
      Response.Write "&nbsp;<img src='/images/community/but_next.gif'align=absmiddle>" 
   Else
      Response.write "&nbsp;<a href='" & AspFileName & "&page=" &  blockpage &"'><img src='/images/community/but_next.gif'align=absmiddle></a>"
   End If
   '********** 다음 10 개 구문 끝**********
End Sub



%>

