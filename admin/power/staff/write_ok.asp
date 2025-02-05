<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->

<%
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.AddHeader	"Expires","0"
    
    OpenF5_DB objConn
    
    Set UploadForm = Server.CreateObject("DEXT.FileUpload") 
    PhysicalImgPath = server.MapPath("/upload/em")	
    UploadForm.DefaultPath	= PhysicalImgPath
    
    
    nm = UploadForm("nm")	'//한글명
    nm_eng = UploadForm("nm_eng") 	'//영문명
    jmno = UploadForm("jmno1") & UploadForm("jmno2")		'//주민번호
    birthday = UploadForm("birth_year") & UploadForm("birth_month") & UploadForm("birth_day")	'//여권 만료일
    birth_chk = UploadForm("birth_chk")					'//여권번호
    ent_day = UploadForm("ent_year") & UploadForm("ent_month") & UploadForm("ent_day")	'//입사일
    pp_no = UploadForm("pp_no")					'//여권번호
    pp_termination_day = UploadForm("pp_year") & UploadForm("pp_month") & UploadForm("pp_day")	'//여권 만료일
    sex = UploadForm("sex")	'//성별
    
    email1 = UploadForm("email1")	'//이메일 첫번째 
    email2 = UploadForm("email2")	'//이메일 두번째
    email = email1 & "@" & email2
    email_yn = UploadForm("email_yn")	'//이메일 수신여부
    
    addnum1 = UploadForm("addnum1") '//우편번호
    addnum2 = UploadForm("addnum2") '//우편번호
    address = UploadForm("address")						'//나머지주소
    tell = UploadForm("tell")						'//연락처
    tel2 = UploadForm("tel2")						'//연락처
    
    dept_cd = UploadForm("dept_cd")				'//부서코드
    grade_cd = UploadForm("grade_cd")			'//직급코드
    broad_cd = UploadForm("broad_cd")			'//어학코드
    position_cd = UploadForm("position_cd") 	'//클래스 
    team_cd = UploadForm("team_cd") 			'//팀구분
    
    
    business = UploadForm("business") 			'//직무
    holidays_tot = UploadForm("holidays_tot") 	'//연차총수
    holidays_cnt = UploadForm("holidays_cnt") 	'//연차 사용수
    
    cd = UploadForm("cd") 	'//연차 사용수
    rekind = UploadForm("rekind") 	'//연차 사용수
    emp_no = UploadForm("emp_no") 	'//연차 사용수
    em_id = UploadForm("em_id") 	'//사번
    em_pass = UploadForm("em_pass") 	'//사번비밀번호
    em_pass = Base64_Encode(em_pass)
    tbl = "TB_em001"
    
    
    If Len(pp_no)>7 Then pp_yn = "Y"
    	
    '*********** 이미지 폴더 생성 Start *****************
    filedata_nm = server.mapPath("/") & "\upload\"
    board_nm = server.mapPath("/") & "\upload\em"
    
    
    Set FSO = Server.CreateObject("Scripting.FileSystemObject")
    If Not FSO.FolderExists(filedata_nm)  then FSO.CreateFolder(filedata_nm)
    If Not FSO.FolderExists(board_nm)			then FSO.CreateFolder(board_nm)
    Set fso = Nothing													
    '*********** 이미지 폴더 생성 End *****************
    
    
    If rekind<>"u"	Then '//새로 등록
    	
        '============================================ 등록된 사번이 있는지 체크 ==================================
        objConn.BeginTrans
    
        sql = " select emp_no "
        sql = sql & " from " & tbl
        sql = sql & " where em_id = '"& em_id &"' "
        sql = sql & " and del_fg = 'N' "
        sql = sql & " and em_id <>'' "
        sql = sql & " and em_id is Not Null "
        Set Rs = objConn.Execute(sql)
    
        if Not Rs.Eof Then
            fnUrl "이미 등록된 사번입니다.\n확인하고 다시 입력하세요    ","history.back()"
        end if
        Rs.Close : Set Rs = Nothing
        '============================================ 등록된 사번이 있는지 체크 ==================================
    
    
        '=================================== 사번가져오기 ================================	
        sql = " Select   top 1 b=case substring(emp_no,1,4) when substring(cast(DATEPART(yyyy, GETDATE())  as varchar(50)),1,4) "  
        sql = sql & " then max(cast(substring(emp_no,5,4) as int))+1 else 1 end "
        sql = sql & " from "& tbl
        sql = sql & " group by emp_no "
        sql = sql & " order by b desc "
        Set Rs =objConn.execute(sql)		
        year_now	= Year(now)		
    
        if  Rs.eof or  Rs.bof then
            emp_no = year_now&"0001"
        else 
            emp_no1 = Rs(0)
            Select Case CStr(Len(emp_no1))
                Case "1"
                    emp_no = year_now&"000" & emp_no1
                Case "2"
                    emp_no = year_now&"00" & emp_no1
                Case "3"
                    emp_no = year_now&"0" & emp_no1
                Case "4"
                    emp_no = year_now & emp_no1
            End Select 
        end if
    
        Rs.Close : Set Rs = Nothing
    
        file_nm = emp_no
        if Len(uploadform("file").FileName)>3 Then
            file_type1 = Right(uploadform("file").FileName,3)
        end if
    
    
        if Len(uploadform("file").FileName)>3	Then 
            if file_type1 = "asp" Or file_type1="exe" Or file_type1="ocx" Or file_type1=".js" Or file_type1="jsp" Or file_type1="php" Or file_type1="aspx" Then 
                fnUrl "잘못된 파일 형식입니다.       ",""
            end if
            img_path = "/upload/em/"&file_nm&"."&file_type1
        end if
    
    
        '=================================== 사번가져오기 ================================	
        sql = ""
        sql = sql & "Exec proc_TB_em001_insert "
        sql = sql & "	@emp_no = '" & emp_no & "', "
        sql = sql & "	@nm = N'" & nm & "', "
        sql = sql & "	@nm_eng = N'" & nm_eng & "', "
        sql = sql & "	@jmno = '" & jmno & "', "
        sql = sql & "	@birthday = '" & birthday & "', "
        sql = sql & "	@birth_chk = '" & birth_chk & "', "
        sql = sql & "	@ent_day = '" & ent_day & "', "
        sql = sql & "	@pp_no = '" & pp_no & "', "
        sql = sql & "	@pp_termination_day = '" & pp_termination_day   & "', "
        sql = sql & "	@sex = '" & sex & "', "
        sql = sql & "	@email = '" & email & "', "
        sql = sql & "	@addnum1 = '" & addnum1 & "', "
        sql = sql & "	@addnum2 = '" & addnum2 & "', "
        sql = sql & "	@address = N'" & address & "', "
        sql = sql & "	@tell = '" & tell & "', "
        sql = sql & "	@tel2 = '" & tel2 & "', "
        sql = sql & "	@dept_cd = '" & dept_cd & "', "
        sql = sql & "	@grade_cd = '" & grade_cd & "', "
        sql = sql & "	@broad_cd = '" & broad_cd & "', "
        sql = sql & "	@position_cd = '" & position_cd & "', "
        sql = sql & "	@team_cd = '" & team_cd & "', "
        sql = sql & "	@business = N'" & business & "', "
        sql = sql & "	@img_path = '" & img_path & "', "
        sql = sql & "	@em_id = '" & em_id & "', "
        sql = sql & "	@em_pass = '" & em_pass & "', "
        sql = sql & "	@ins_emp_no = '" &Request.Cookies("emp_no")& "', "
        sql = sql & "	@holidays_tot = '" & holidays_tot & "', "
        sql = sql & "	@holidays_cnt = '" & holidays_cnt & "'  "
        objConn.Execute (sql)
    
    
    Else '//사원 수정
    
        '============================================ 등록된 사번이 있는지 체크 ==================================
        objConn.BeginTrans
    
        sql = " select emp_no "
        sql = sql & " from " & tbl
        sql = sql & " where em_id = '"& em_id &"' "
        sql = sql & " and del_fg = 'N' "
        sql = sql & " and em_id <>'' "
        sql = sql & " and em_id is Not Null "
        sql = sql & " and emp_no <> '"& emp_no &"'"
    
        Set Rs =objConn.Execute(sql)
    
        if Not Rs.Eof Then
            fnUrl "이미 등록된 사번입니다.\n확인하고 다시 입력하세요    ","history.back()"
        end If
        Rs.Close : Set Rs = Nothing
        '============================================ 등록된 사번이 있는지 체크 ==================================
    
        file_nm = emp_no
    
        if Len(uploadform("file").FileName)>3 Then
            file_type1 = Right(uploadform("file").FileName,3)
        end if
    
    
        if Len(uploadform("file").FileName)>3	Then 
            if file_type1 = "asp" Or file_type1="exe" Or file_type1="ocx" Or file_type1=".js" Or file_type1="jsp" Or file_type1="php" Or file_type1="aspx" Then 
                fnUrl "잘못된 파일 형식입니다. ",""
            end if
            img_path = "/upload/em/"&file_nm&"."&file_type1
        end if
    
        sql = ""
        sql = sql & "Exec proc_TB_em001_modify "
        sql = sql & "	@emp_no = '" & emp_no & "', "
        sql = sql & "	@nm = N'" & nm & "', "
        sql = sql & "	@nm_eng = N'" & nm_eng & "', "
        sql = sql & "	@jmno = '" & jmno & "', "
        sql = sql & "	@birthday = '" & birthday & "', "
        sql = sql & "	@birth_chk = '" & birth_chk & "', "
        sql = sql & "	@ent_day = '" & ent_day & "', "
        sql = sql & "	@pp_no = '" & pp_no & "', "
        sql = sql & "	@pp_termination_day = '" & pp_termination_day & "', "
        sql = sql & "	@sex = '" & sex & "', "
        sql = sql & "	@email = '" & email & "', "
        sql = sql & "	@addnum1 = '" & addnum1 & "', "
        sql = sql & "	@addnum2 = '" & addnum2 & "', "
        sql = sql & "	@address = N'" & address & "', "
        sql = sql & "	@tell = '" & tell & "', "
        sql = sql & "	@tel2 = '" & tel2 & "', "
        sql = sql & "	@dept_cd = '" & dept_cd & "', "
        sql = sql & "	@grade_cd = '" & grade_cd & "', "
        sql = sql & "	@broad_cd = '" & broad_cd & "', "
        sql = sql & "	@position_cd = '" & position_cd & "', "
        sql = sql & "	@team_cd = '" & team_cd & "', "
        sql = sql & "	@business = N'" & business & "', "
        sql = sql & "	@img_path = '" & img_path & "', "
        sql = sql & "	@em_id = '" & em_id & "', "
        sql = sql & "	@em_pass = '" & em_pass & "', "
        sql = sql & "	@upd_dt = '" & now() & "', "
        sql = sql & "	@upd_emp_no = '" & Request.Cookies("emp_no")	& "', "
        sql = sql & "	@holidays_tot = '" & holidays_tot & "', "
        sql = sql & "	@holidays_cnt = '" & holidays_cnt & "'  "
        'response.write sql
        'response.end
        objConn.Execute(sql)
    
    End if
    
    
    
    If Err.number = 0 Then
        objConn.CommitTrans		
    
        CloseF5_DB objConn
        
        '============================================== 사진저장 ==========================
        if file_type1<>""	Then 
            uploadform("file").SaveAs board_nm &"\"&file_nm&"."&file_type1
        end if
        '============================================== 사진저장 ==========================
        
        if rekind<>"u" Then 
            Response.Redirect "list.asp?cd="&cd
        else
            fnUrl "처리되었습니다..","location.href='list.asp'"
        end if
        Response.End
    Else 
        objConn.RollbackTrans
        CloseF5_DB objConn 
        fnUrl "등록중 오류가 발생했습니다.      ",""
    End if
%>