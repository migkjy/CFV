<%
    dim filepath, goods, filename
    dim upfile, fso, nowYMdate, path, src
    dim file_ext_array, file_ext_name


	img_url = "https://www.cfvacation.com/upload/goods"



    Set upfile = Server.CreateObject("DEXT.FileUpload")
 
    
    upfile.CodePage = 65001
    upfile.UploadTimeout = 1800
    upfile.DefaultPath = "D:\hosting\cfvacation.com\upload\goods"  
 
    Response.Buffer = True
    Response.CharSet = "utf-8"
    

         path= server.MapPath("/upload/goods")	


        set fso = server.createobject("scripting.filesystemobject")

        If fso.FolderExists(path) = false then  '경로에 폴더가 없다면 생성한다...
	        fso.CreateFolder(path)
        end If

        if len(uploadMaxSize) < 7 then
	       ' upload_file_size = 2097152	
	        upload_file_size = 3 * 1024 * 1024
        else
	        upload_file_size = uploadMaxSize
        end if
	
        upfile.MaxFileLen = upload_file_size

        upfile.DefaultPath = path

       ' response.Write path
    	
        src = trim(upfile("up_file"))
       ' response.Write src
'response.end
        file_ext_array = split(src, ".")
        file_ext_name  = file_ext_array(0)
        fileext  = Lcase(file_ext_array(1))


        if len(src) > 0 then
	        If upfile("up_file").FileLen > upfile.MaxFileLen Then  
		        Response.Write "파일용량은 "&left(upload_file_size,1)&"MBytes입니다. 용량을 초과하셨습니다"  
		        response.end
	        else
		   	         
		     if Chk_Image(fileext)=True then
             Else
          	  With Response .write " JPG,JPEG,PNG,GIF,BMP 파일만 가능합니다... "
              End With
	           upfile.flush
             Response.End
            End if
  	          ' upfile("up_file").Save upfile.DefaultPath,false  ' 함수 안거치고바로있는이름그대로사용시
		        file = setName()
 	           file = upfile.SaveAs(DefaultPath & file & "." & upfile.FileExtension)
     	        file = upfile("up_file").LastSavedFileName 
			
	        end if
	 
	        filepath = img_url & "/" & goods & file
          response.write "1|" & filepath & "|" & upfile("up_file") & "|" & file_ext_name
        else
            response.write "0|upload fail (not image file)"
        end if

  


Public Function setName()
	'------------------------------------------
	' 저장할 파일명 설정
	'------------------------------------------
		Dim serialNo

		Randomize

		'1 ~ 9999 까지중 임의수 가져오기
		'-------------------------------
		serialNo = Int((9999 - 1 + 1) * Rnd + 1)
		'-------------------------------

		setName = Year(Now()) & Month(Now()) & Day(Now()) & Hour(Now()) & Minute(Now()) & Second(Now()) & serialNo
	End Function
Function Chk_Image(sType)
	'------------------------------------------
	' 이미지파일형식 검사
	'------------------------------------------
		Dim sAllow, Chk_OK, intLoop

		Chk_OK = False
		sAllow = Split("jpg|jpeg|png|gif|bmp","|")

		For intLoop = 0 To UBound(sAllow)
			If sType = sAllow(intLoop) Then
				Chk_OK = True
				Exit For
			End If
		Next

		Chk_Image = Chk_OK

End Function
%>


