<%@ Language=VBScript %>

<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->

<%
    OpenF5_DB objConn
 
    old_codepage = Session.CodePage
    Session.CodePage = "65001"
    With Response
        .CharSet = "utf-8" 
        .Expires = -1
        .ExpiresAbsolute = Now() - 1
        .AddHeader "pragma", "no-cache"
        .CacheControl = "no-cache"
        .Buffer = true
    End With
%>

<%
    ProgID = request.QueryString("ProgressID")


    set uploadform=server.CreateObject("DEXT.FileUpload")

    uploadform.SetProgress(ProgID)
    filePath ="upload\res_excel"
    fileRootPath = Server.MapPath("\")
    PhysicalImgPath = fileRootPath & "\" & filePath

    UploadForm.DefaultPath = PhysicalImgPath

    OldFileName = uploadform("srcfile").FileName
    Ext = lcase(Mid(OldFileName, Instr(OldFileName, ".") + 1))

    If NOT( (Ext = "xls") )Then
        uploadform.DeleteAllSavedFiles	
       Alert_Window("Excel 파일 이외의 파일은 등록하실수 없습니다..\n다시 업로드하세요.")
    End If

    arrTFile_Size =  uploadform("file").FileLen     
    If (arrTFile_Size > (1*10240*10240)) Then	
        Alert_Window("전체 파일크기를 10MB 미만으로 다시 올려주시기 바랍니다.")	
    End If			

    unqname= right(now,8)
    unqname=trim(Replace(unqname,":",""))
    
    NewFileName =  unqname&"_"&ProgID & "." & Ext

    unqProgID= unqname&"_"&ProgID
    
    SaveFullPath = PhysicalImgPath  &"\"& NewFileName	
 	uploadform("srcfile").SaveAs SaveFullPath, true
 	FileName= uploadform("srcfile").LastSavedFileName 
%>

<%
    If  progid <>"" then 

        objConn.BeginTrans
        On Error Resume Next

        progidex=unqProgID&".xls"

        Dim excelConn, excelDB, excelRS, oADOX, rsCount
        Dim sql, oTable , sqlSelect,Sheet_name, progid
        dim dbObj, bData, arrRs,total
	      
        filePath ="upload\res_excel\"&progidex&""
        
        fileRootPath = Server.MapPath("\")
        excelFile = fileRootPath & "\" & filePath
        
        excelConn="Provider=Microsoft.ACE.OLEDB.12.0; Data Source=" & excelFile & "; Mode=ReadWrite|Share Deny None; Extended Properties='Excel 8.0; HDR=YES;';Persist Security Info=False"
        Set excelDB = Server.CreateObject("ADODB.Connection") 
        excelDB.Open excelConn
      
        Set oADOX = CreateObject("ADOX.Catalog")
        oADOX.ActiveConnection = excelConn
      
        For Each oTable in oADOX.Tables
            Sheet_name= oTable.Name 
            total= total+1
            if total = 1 then
                exit for
            end if
        Next

        Dim dateka(80)
        
        sql="select * from ["&Sheet_name&"]"
        set excelRS=excelDB.execute(sql)
        i=0
        
        For each ofield in excelRS.fields
            dateka(i) = ofield.name
            i=i+1
        Next
	
        excelRS.close
        set excelRS=nothing
%>

    <% if dateka(0) <> "사번" or dateka(1) <> "이름" or dateka(2) <> "패스워드"  or dateka(3) <> "전화번호"  or dateka(4) <> "포인트" then %>
        <script language="javascript">
            alert("샘플로 제공된 엑셀 파일이 아닙니다.\n또는 제공된 엑셀파일을 잘못 수정하셨습니다.\n엑셀파일을 다시 올려주세요.");
              self.close();
        </script>
    <%
        response.end
        end if
    %>
    
    <%
        sql = "select count(*) from ["&Sheet_name&"] where 사번 IS NOT NULL"
        Set excelRS = excelDB.Execute(sql)
    
        If excelRS.eof or excelRS.bof then
            cnt = ""
        else
            cnt = Trim(excelRS(0))
        end if
    
        excelRS.close
        Set excelRS = nothing
    
        If cnt = "" then cnt = 1 end if
        
        ReDim memid(cnt),kname(cnt),pwd(cnt),htel(cnt),point(cnt)
    	
    	sqlSelect = "사번,이름,패스워드,전화번호,포인트"
    	
        sql = "SELECT " & sqlSelect &" FROM ["&Sheet_name&"] where 사번 IS NOT NULL"	
        Set excelRS = excelDB.Execute(SQL)
    	
        If not excelRS.eof or not excelRS.bof then
    
            z = 1
            Do Until excelRS.eof
    
                memid(z)   = Trim(excelRS("사번"))
                kname(z)   = Trim(excelRS("이름"))
                pwd(z)  = Trim(excelRS("패스워드"))
                htel(z)  = Trim(excelRS("전화번호"))
                point(z)  = Trim(excelRS("포인트"))
    	         
                Sql = "SELECT MAX(num) FROM TB_member"
                Set Rs = objConn.Execute(sql)
    	
                if isnull(Rs(0)) then
                    num = 1
                else
                    num = rs(0) + 1
                end if
    	
               ' pwd1 = pwd(z)
    	
               ' pwd1  = Base64_Encode(pwd1)
    
                f = "num, memid, pwd, kname,   htel,memdate, memcnt,point "
                v = num&", '"&memid(z)&"', '"&pwd(z)&"', '"&kname(z)&"', '"&htel(z)&"', '"&date&"' , '1','"&point(z)&"'" 
                Sql = "INSERT INTO TB_member( "&f&" )"
                Sql = sql &"VALUES ( "&v&" )"
                objConn.Execute Sql
    	
            z = z + 1
            excelRS.movenext
            Loop
        
        End if
    
        excelRS.close
        Set excelRS = nothing
    %>
    
    
    <%
        Set uploadform =nothing
        Session.CodePage = old_codepage

        if Err.number = 0 Then 
            objConn.CommitTrans
        Else 
            objConn.RollbackTrans
            objConn.close
            Set objConn = Nothing 
            response.write "<script language='javascript'>               "
            response.write "  alert('등록중오류발생\n엑셀파일데이타를 확인하세요');"
            response.write "  history.go(-1);                            "
            response.write "</script>                                    " 
            response.end
        End If
    %>

<%    
    End If
%>

     
 <%
   response.write "<script language='javascript'>"
	response.write "alert(' 처리되었습니다 ');"
   response.write "parent.$('#chain_member').dialog('close');"
   response.write "</script>"
 %>
     
<%
    CloseF5_DB objConn	
%>