<%
'#####################################################################
Sub Board_Count(table, column1, column2, idx)
dim sql_count,B_Count_Chk
  B_Count_Chk = Request.Cookies("B_Count_Chk")
  if B_Count_Chk = "" then
    Response.Cookies("B_Count_Chk") = "."& table & idx & "."
    sql_count = "Update "& table &" Set "& column1 &" = "& column1 &" + 1 where "& column2 &" = "& idx
    objConn.execute(sql_count)
  else
    if Instr(B_Count_Chk,"."& table & idx &".") < 1 then
      sql_count = "Update "& table &" Set "& column1 &" = "& column1 &" + 1 where "& column2 &" = "& idx
      objConn.execute(sql_count)
      Response.Cookies("B_Count_Chk") = B_Count_Chk & table & idx & "."
    end if
  end if
end Sub
'#####################################################################

'#####################################################################
function NewsTitle(count,titlelen,table,board_url)
dim news, newssql, i, title, title_url
  set news = Server.CreateObject("Adodb.Recordset")
  newssql = "select top "& count &" * from "& table &" order by N_Idx desc"
  news.open newssql,objConn,3
  if news.bof and news.eof then
    if count = 1 then
      NewsTitle = "등록된 News가 없습니다."
	else
	  NewsTitle = ""
	end if
  else
    for i=1 to count
      if news.eof then
        exit for
      end if
      if i = count then
        if len(news("N_Title")) > titlelen then
          title = mid(replace(replace(news("N_Title"),"''","'"),"<br>",chr(13)),1,titlelen-2) & "..."
	      title_url = "<a href='"& board_url &"?idx=" & news("N_Idx") & "'>" & title & "</a></td><td align='right' background='img/bg-dot-28.gif'>"& left(news("N_Date"),10)
        else
          title = replace(replace(news("N_Title"),"''","'"),"<br>",chr(13))
	      title_url = "<a href='"& board_url &"?idx=" & news("N_Idx") & "'>" & title & "</a></td><td align='right' background='img/bg-dot-28.gif'>"& left(news("N_Date"),10)
        end if
        NewsTitle = title_url
      end if
      news.movenext
    next
  end if
end function
'#####################################################################
'경고창 띄우는 함수
Sub Alert_Window(args)
dim write_String
  write_String = "<script language='javascript'>"
  write_String = write_String & "alert('"& args &"');"
  write_String = write_String & "history.back();"
  write_String = write_String & "</script>"
  response.write write_String
end Sub
'#####################################################################

'#####################################################################
'경고창 띄우는 함수
Sub Alert_No_Back_Window(args)
dim write_String
  write_String = "<script language='javascript'>"
  write_String = write_String & "alert('"& args &"');"
  write_String = write_String & "</script>"
  response.write write_String
end Sub
'#####################################################################

'#####################################################################
'경고창 띄우는 함수
Sub Alert_Close_Window(args)
dim write_String
  write_String = "<script language='javascript'>"
  write_String = write_String & "alert('"& args &"');"
  write_String = write_String & "window.close();"
  write_String = write_String & "</script>"
  response.write write_String
end Sub
'#####################################################################

'#####################################################################
'경고창 띄우는 함수
Sub Alert_Window_Location(args1,args2)
dim write_String
  write_String = "<script language='javascript'>"
  write_String = write_String & "alert('"& args1 &"');"
  write_String = write_String & "location.href='"& args2 &"';"
  write_String = write_String & "</script>"
  response.write write_String
end Sub
'#####################################################################

'#####################################################################
'파일을 업로드 시키는 함수(등록,답변)
Function UpFile(FullFilePath,UploadPath)
  Dim attachfile1,attachfile2,filename
  if FullFilePath <> "" then
	attachfile1 = FullFilePath '경로 포함 전체 파일		
	file1 = Mid(attachfile1,instrrev(attachfile1,"\")+1) '확장자 포함 파일 이름		
	file1name = Mid(file1,1,instr(file1,".")-1) '순수한 파일명		
	file1exe = Mid(file1,instr(file1,".")+1) '확장자		
						
	Dim fso,fexist,filenameadd,count1
	Set fso = Server.CreateObject("Scripting.FileSysTemObject")
		fexist = true
			filenameadd1 = UploadPath & file1
			count1 = 0
			while fexist = true
				if (fso.FileExists(filenameadd1)) then
					count1 = count1 + 1
					file1 = file1name & count1 &"."& file1exe
					filenameadd1 = UploadPath & file1
				else
					fexist = false
				end if
			wend
	Set fso = Nothing					
		
	UploadForm("file1").SaveAs filenameadd1 '업로드 되는 부분
	UpFile = file1	
  else
	UpFile = "No"
  end if
end Function
'#####################################################################

'#####################################################################
'파일을 업로드 시키는 함수(등록,답변)
Function UpFiles(FullFilePath,UploadPath,file_count)
  Dim attachfile1,attachfile2,filename
  'response.Write(FullFilePath&"<br>")
  if Trim(FullFilePath) <> "" then
	attachfile1 = FullFilePath '경로 포함 전체 파일		
	file1 = Mid(attachfile1,instrrev(attachfile1,"\")+1) '확장자 포함 파일 이름		
	file1name = Mid(file1,1,instr(file1,".")-1) '순수한 파일명		
	file1exe = Mid(file1,instr(file1,".")+1) '확장자		
						
	Dim fso,fexist,filenameadd,count1
	Set fso = Server.CreateObject("Scripting.FileSysTemObject")
		fexist = true
			filenameadd1 = UploadPath & file1
			count1 = 0
			while fexist = true
				if (fso.FileExists(filenameadd1)) then
					count1 = count1 + 1
					file1 = file1name & count1 &"."& file1exe
					filenameadd1 = UploadPath & file1
				else
					fexist = false
				end if
			wend
	Set fso = Nothing					
		
	UploadForm("files")(file_count).SaveAs filenameadd1 '업로드 되는 부분
	UpFiles = file1	
  else
	UpFiles = "No"
  end if
end Function
'#####################################################################

'#####################################################################
Function getString(str, strlen)
	dim rValue,f,tmpStr
	dim nLength,tmpLen
	
	nLength = 0.00
	rValue = ""
	for f = 1 to len(str)
		tmpStr = MID(str,f,1)
		tmpLen = ASC(tmpStr)
		if  (tmpLen < 0) then
			' 한글
			nLength = nLength + 1.4        '한글일때 길이값 설정
			rValue = rValue & tmpStr
		elseif (tmpLen >= 97 and tmpLen <= 122) then
			' 영문 소문자
			nLength = nLength + 0.75       '영문소문자 길이값 설정
			rValue = rValue & tmpStr
		elseif (tmpLen >= 65 and tmpLen <= 90) then 
			' 영문 대문자
			nLength = nLength + 1           ' 영문대문자 길이값 설정
			rValue = rValue & tmpStr
		else
			' 그외 키값
			nLength = nLength + 0.6         '특수문자 기호값...
			rValue = rValue & tmpStr			
		end if
		If (nLength > strlen) then
			rValue = rValue & "..."
			exit for
		end if
	next 
	getString = rValue
End Function
'#####################################################################
'#####################################################################
'개인정보를 숨기는 함수
Function Hidden_Str(str1,int1)
  Dim string_count,repl_string,str2,i
  string_count = len(str1)
  repl_string = ""
  for i = 1 to string_count
	str2 = mid(str1,i,1)
    if i <= int1 then
	  repl_string = repl_string & str2
	else
	  if str2 = " " or str2 = "-" then
	    repl_string = repl_string & str2
	  else
	    repl_string = repl_string & Replace(str2,str2,"*")
	  end if
	end if
  next
  Hidden_Str = repl_string
  Set string_count = Nothing
  Set repl_string = Nothing
  Set i = Nothing
end Function
'#####################################################################
%>
