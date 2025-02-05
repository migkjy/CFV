<%

Function delete_check(numm)
Dim cntt, check
for i = 1 to Len(numm)
if Mid(numm,i,1) = "," then
		cntt = cntt + 1
end if 
 next
check = split(numm,",")

for i = 0 to cntt
Sql = int_where_query(Sql,"num", check(i), "=")
next
	Sql = replace(Sql,"AND","OR")
delete_check = Sql
End Function
'--------------------------------------------------------
Function title_cutting(s, m)
Dim bytecnt, charmove, nn
bytecnt = 0 
nn = Len(s)
for charmove = 1 to nn
if ASC(Mid(s,charmove,1)) > 0 then
 bytecnt = bytecnt + 1
elseif ASC(Mid(s,charmove,1)) < 0 then
	bytecnt = bytecnt + 2
end if
if bytecnt >= int(m) then
	 s = Mid(s,1,charmove)&"..."
 charmove = nn
end if
next
title_cutting = s
End Function
'--------------------------------------------------------
Function won_cutting(w)
Dim wcnt, wtemp, nn, wwt
wwt = 0
if w < 0 then
wwt = 1 
w = w *-1
end if
w = Formatcurrency(w) 
nn = Len(w)
for wcnt = 1 to nn
if wcnt > 1 then
	wtemp = wtemp & Mid(w,wcnt,1)
end if
next
if wwt = 1 then
Response.write "-"&wtemp
else
Response.write wtemp
end if
End Function
'-------------------------------------------------------
Function won_cutting2(w)
Dim wcnt, wtemp, nn, wwt
wwt = 0
if w < 0 then
wwt = 1 
w = w *-1
end if
w = Formatcurrency(w) 
nn = Len(w)
for wcnt = 1 to nn
if wcnt > 1 then
	wtemp = wtemp & Mid(w,wcnt,1)
end if
next
if wwt = 1 then
won_cutting2 =  "-"&wtemp
else
won_cutting2 = wtemp
end if
End Function
'-------------------------------------------------------


Function fn_goPage(gotopage,Pagecount,Aspfilename,etc) '페이징 함수

   Dim blockpage, p

   if inStr(Aspfilename,"?") > 0 then 
	    strStartArg = "&"
   else
	    strStartArg = "?"
   end if


   blockpage=Int((gotopage-1)/10)*10+1

         Response.Write"<td class=ab_left><a href='"&Aspfilename& strStartArg &"gotopage=" & etc &"' ><img src='/mobile/images/goods/bt_prevl.gif' border='0' alt='처음으로' width='30px'/></a></td>"

   if blockPage = 1 Then
         Response.Write"<td class=ab_left><img src='/mobile/images/goods/bt_prev.gif' border='0' alt='다음' width='30px'/></div>"
   Else
         Response.Write"<td class=ab_left><a href='"&Aspfilename& strStartArg &"gotopage=" & blockPage-1 & etc &"'' ><img src='/mobile/images/goods/bt_prevl.gif' border='0' alt='다음' width='30px'/></td>"
   End If


   p=1
   Do Until p > 10 or blockpage > Pagecount
      If blockpage=int(gotopage) Then
         Response.Write "<td width=35><ul><li><a href='"&Aspfilename & strStartArg&"gotopage=" & blockpage & etc & "'  class=on>" & blockpage & "</a></li></ul></td>" 
      Else
         Response.Write"<td width=35><ul><li><a href='"&Aspfilename & strStartArg&"gotopage=" & blockpage & etc & "' >" & blockpage & "</a></li></ul></td>"
      End If
	         
      blockpage=blockpage+1
      p = p + 1
   Loop


   if blockpage > Pagecount Then
         Response.write "<td class=ab_right><img src='/mobile/images/goods/bt_next.gif' alt='이전' width='30px'/></td>"
   Else
         Response.write"<td class=ab_right><a href='"&Aspfilename& strStartArg &"gotopage=" &  blockpage & etc &"'' ><img src='/mobile/images/goods/bt_nextr.gif' alt='이전' width='30px'/></a></td>"
   End If 
         Response.Write"<td class=ab_right><a href='"&Aspfilename& strStartArg &"gotopage="& Pagecount & etc &"'' ><img src='/mobile/images/goods/bt_next.gif' border='0' alt='마지막으로' width='30px'/></a></td>"


End Function








%>