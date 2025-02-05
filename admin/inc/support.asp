<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>

<%
    Function list_totalcnt(tb)
        Dim Rsp, tot 
        Sql = "SELECT COUNT(*) FROM "&tb
        
        Set Rsp = objConn.Execute(Sql)
        
        tot = Rsp(0)
        Rsp.close
        Set Rsp = nothing
        list_totalcnt = tot
    End Function


'-------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION cutStr(str, cutLen)
        Dim strLen, strByte, strCut, strRes, char, i
        strLen = 0
        strByte = 0
        strLen = Len(str)
        
        For i = 1 to strLen
            char = ""
				
            strCut = Mid(str, i, 1)	'	일단 1만큼 잘라서 strRes에 저장한다.
            char = Asc(strCut)		'	아스키 코드값 읽어오기
            char = Left(char, 1)
            IF char = "-" Then			'	"-"이면 2바이트 문자로 처리
                strByte = strByte + 2
            ELSE
                strByte = strByte + 1
            END IF

            IF cutLen < strByte Then
                strRes = strRes & ".."
                exit for
            ELSE
                strRes = strRes & strCut
            END IF
        Next
        cutStr = strRes
    END FUNCTION
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function list_paging(gotopage, pagesize, totalcnt)
        Dim totalpage, namuji, pagecnt
        totalpage = int(totalcnt / pagesize)
        namuji = totalcnt MOD pagesize

        if namuji > 0 then
            totalpage = totalpage + 1
        end if
 
        if int(totalpage) > 1 AND int(gotopage) > 1 then
            Response.write "<a href='javascript:page(1);' class='href'>"
        end if
        Response.write "<span style='font-weight:500;'>이전 △</span>"
        
        if gotopage > 1 then
            Response.write "</a>"
        end if
        
        if int(totalpage) > 1 AND int(totalpage) > int(gotopage) then
            Response.write "<a href='javascript:page(2);' class='href'>"
        end if
        response.write "<span style='padding:0 10px 0 5px;font-weight:500;'>다음 ▽</span>"

        if int(totalpage) > 1 AND int(totalpage) > int(gotopage) then
            Response.write "</a>"
        end if
        response.write "<select name='gotopage' onchange='page(3);' class='select_basic' style='width:50px;'>"
        
        for pagecnt = 1 to totalpage
            Response.write "<option value='"&pagecnt&"'"
            if pagecnt = int(gotopage) then
                Response.write "selected"
            end if 
            Response.write " >"&pagecnt&"</option>"
        next
        Response.write "</select><span style='padding:0 0px 0 10px;font-weight:700;'>Total "&totalpage&" Page</span>" 
        list_paging = totalpage
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function list_line_control(sv, ev, st)
        Dim pageline
        Response.write "<span style='padding:0 10px 0 5px;font-weight:500;'>라인조정</span><select name='pagesize' onchange='pagesetting();' class='select_basic'>"
        for pageline = sv to ev step st
            Response.write "<option value='"&pageline&"'"
            if pageline = int(pagesize) then
                Response.write "selected"
            end if 
            Response.write " >"&pageline&" 라인</option>"
        next
        Response.write "</select>" 
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
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
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
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
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
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
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
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
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function list_paging2(gotoname, gotopage, pagesize, totalcnt)
        Dim totalpage, namuji, pagecnt
        totalpage = int(totalcnt / pagesize)
        namuji = totalcnt MOD pagesize
    
        if namuji > 0 then
            totalpage = totalpage + 1
        end if
     
        if int(totalpage) > 1 AND int(gotopage) > 1 then
            Response.write "<a href='javascript:page(1);' class='href'>"
        end if
        Response.write "[이전△]"
        
        if gotopage > 1 then
            Response.write "</a>"
        end if
        
        if int(totalpage) > 1 AND int(totalpage) > int(gotopage) then
            Response.write "<a href='javascript:page(2);' class='href'>"
        end if
        response.write "[다음▽]"
    
        if int(totalpage) > 1 AND int(totalpage) > int(gotopage) then
            Response.write "</a>"
        end if
        response.write "<select name='"&gotoname&"' onchange='page(3);'>"
        
        for pagecnt = 1 to totalpage
            Response.write "<option value='"&pagecnt&"'"
            if pagecnt = int(gotopage) then
                Response.write "selected"
            end if 
            Response.write " >"&pagecnt&"</option>"
        next
        Response.write "</select> / <b>Total "&totalpage&" Page</b>" 
        list_paging2 = totalpage
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function list_line_control2(sizename, pagesize, sv, ev, st)
        Dim pageline
        Response.write "라인조정 <select name='"&sizename&"' onchange='pagesetting();'>"
        for pageline = sv to ev step st
            Response.write "<option value='"&pageline&"'"
            if pageline = int(pagesize) then
                Response.write "selected"
            end if 
            Response.write " >"&pageline&" 라인</option>"
        next
        Response.write "</select>" 
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function getYoil(str)
        yoilNum = WeekDay(str)
        select case yoilNum
            case 1
                yoilStr = "일"
            case 2
                yoilStr = "월"
            case 3
                yoilStr = "화"
            case 4
                yoilStr = "수"
            case 5
                yoilStr = "목"
            case 6
                yoilStr = "금"
            case 7
                yoilStr = "토"
        end select
        getYoil = yoilStr
    End Function

    Dim weekdaystr(8) 
    weekdaystr(1) = "일요일"
    weekdaystr(2) = "월요일"
    weekdaystr(3) = "화요일"
    weekdaystr(4) = "수요일"
    weekdaystr(5) = "목요일"
    weekdaystr(6) = "금요일"
    weekdaystr(7) = "토요일"
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function goPage(a,b,Aspfilename,etc) '페이징 함수
        Dim blockpage, p
       
        blockpage=Int((gotopage-1)/10)*10+1
            if blockPage = 1 Then
                Response.Write "<span class='direction'>이전</span>&nbsp;&nbsp;&nbsp;&nbsp;"
            Else
                Response.Write"<a href='"&Aspfilename &"&gotopage=" & blockPage-1 & etc &"' class='direction'>이전</span>&nbsp;&nbsp;&nbsp;&nbsp;"
            End If

        p=1
        Do Until p > 10 or blockpage > Pagecount
            If blockpage=int(gotopage) Then
                Response.Write "<strong>"& blockpage &"</strong>&nbsp;&nbsp;" 
            Else
                Response.Write"<a href='"&Aspfilename &"&gotopage=" & blockpage & etc & "'>" & blockpage & "</a>&nbsp;&nbsp;"
            End If
	         
        blockpage=blockpage+1
        p = p + 1
        Loop

        if blockpage > Pagecount Then
            Response.write "&nbsp;&nbsp;<span class='direction'>다음</span>"
        Else
            Response.write "&nbsp;&nbsp;<a href='"&Aspfilename &"&gotopage=" &  blockpage & etc &"' class='direction'>다음</a>"
        End If
    End Function
    
     
    Function fn_goPage(a,b,c,Aspfilename,etc) '페이징 함수
    Dim blockpage, p

        if inStr(Aspfilename,"?") > 0 then 
            strStartArg = "&"
        else
	        strStartArg = "?"
        end if
   
        blockpage=Int((gotopage-1)/pageblock)*pageblock+1
        if blockPage = 1 Then
                Response.Write "<span class='direction'>이전</span>&nbsp;&nbsp;&nbsp;&nbsp;"
        Else
            Response.Write"<a href='"&Aspfilename&strStartArg &"gotopage=" & blockPage-1 & etc &"' class='direction'>이전</span>&nbsp;&nbsp;&nbsp;&nbsp;"
        End If

        p=1
        Do Until p > pageblock or blockpage > b
            If blockpage=int(gotopage) Then
                Response.Write "<strong>"& blockpage &"</strong>&nbsp;&nbsp;" 
            Else
                Response.Write"<a href='"&Aspfilename&strStartArg &"gotopage=" & blockpage & etc & "'>" & blockpage & "</a>&nbsp;&nbsp;"
            End If
	         
        blockpage=blockpage+1
        p = p + 1
        Loop

        if blockpage > Pagecount Then
            Response.write "&nbsp;&nbsp;<span class='direction'>다음</span>"
        Else
            Response.write "&nbsp;&nbsp;<a href='"&Aspfilename&strStartArg &"gotopage=" &  blockpage & etc &"' class='direction'>다음</a>"
        End If 

    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function Func_ClearTag(TargetText)
        set tagfree = New Regexp 
        tagfree.Pattern= "<[^>]+>" 
        tagfree.Global=true 
        Func_ClearTag =tagfree.Replace(TargetText,"")
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ch_changeday(byval s_procd)
        If Len(s_procd)=8 then
            s_change_day = Left(s_procd,4)&"-"&Mid(s_procd,5,2)&"-"&Right(s_procd,2)
        Else
            s_change_day = s_procd
        End if
    	
        ch_changeday = s_change_day
    End function
    
    
    FUNCTION ch_changetime(byval t)
        real_t = Trim(t)
      
        If real_t ="" or isnull(real_t) then
            s_change_time = real_t
        Else
            If Len(real_t)=4 then
                s_change_time = Left(real_t,2)&":"&Right(real_t,2)
            Else
                s_change_time = real_t
            End if
        End if
        
        ch_changetime = s_change_time
    End function
'-------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION price_up(byval p,e) 

     if p="" or isnull(p) then
 	     p=0
     end if
 
     if e="" or isnull(e) then
 	     e=0
     end if

     tot_amt = Cdbl(p) * e
     tot_amt1 = round(tot_amt)

     price_up = tot_amt1

    End function

'------------------------------------------------------------------------------------------------------------------------------------------- 
 FUNCTION ch_procd_tnm(byval s_procd)
       Select Case s_procd 
         Case "0" : prod_cd_nm= "예약신청"
         Case "1" : prod_cd_nm= "예약확인"
         Case "2" : prod_cd_nm= "결제요청"
         Case "3" : prod_cd_nm= "예약완료"
         Case "4" : prod_cd_nm= "예약취소"
         Case "5" : prod_cd_nm= "대기예약"
         Case "6" : prod_cd_nm= "환불완료"
       End select

	    ch_procd_tnm = prod_cd_nm
    End function

    FUNCTION ch_procd_hnm(byval s_procd)
       Select Case s_procd 
         Case "0" : prod_cd_nm= "예약신청"
         Case "1" : prod_cd_nm= "예약확인"
         Case "2" : prod_cd_nm= "결제요청"
         Case "3" : prod_cd_nm= "예약완료"
         Case "4" : prod_cd_nm= "예약취소"
         Case "5" : prod_cd_nm= "대기예약"
         Case "6" : prod_cd_nm= "환불완료"
       End select

	    ch_procd_hnm = prod_cd_nm
    End function
    



    Function bank_chkname(byval s_bank)
        Select case s_bank
            CASE "0" : s_bank_nm="은행입금"
            CASE "1" : s_bank_nm="현금"
            CASE "2" : s_bank_nm="신용카드"
            CASE "3" : s_bank_nm="전자결제"
            Case Else  : s_bank_nm="그외결제"
        End Select
        bank_chkname = s_bank_nm
    End function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function iogubun_chkname(byval iogubun)
        Select case iogubun 
            Case "I" : iio_nm="입금"
            Case "O" : iio_nm="환불"
        End select 
    
        iogubun_chkname = iio_nm
    End function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function gender_chkname(byval gender)
        Select case gender 
            Case "M" : gender_nm="남자"
            Case "F" : gender_nm="여자"
        End select 
    
        gender_chkname = gender_nm
    End function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION  order_sub_areanm(byval s_area)
        Select Case s_area 
            Case "10" : area_cd_nm= "가이드 일정"
            Case "20" : area_cd_nm= "자유 일정"
            Case "30" : area_cd_nm= "가이드+자유일정"
        End select
    
        order_sub_areanm = area_cd_nm
    End function
'-------------------------------------------------------------------------------------------------------------------------------------------


'-------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION order_sub_tripnm(byval s_trip)
        Select Case s_trip 
            Case "10" : tp_trip_nm= "허니문"
            Case "20" : tp_trip_nm= "가족여행"
            Case "30" : tp_trip_nm= "일반여행"
            Case "40" : tp_trip_nm= "골프여행"
            Case "50" : tp_trip_nm= "트래킹"
            Case "60" : tp_trip_nm= "기타여행"
            Case Else : tp_trip_nm= "기타문의"
        End select
    
        order_sub_tripnm = tp_trip_nm
    End function
    
    
    '*********************************************************************'html 코드 및 일반 텍스트 혼용일 경우
    Function check_html(CheckValue) 
        CheckValue = Replace(CheckValue, "&" ,"&amp;")
        CheckValue = Replace(CheckValue, "<" ,"&lt;")
        CheckValue = Replace(CheckValue, ">" ,"&gt;")
        CheckValue = Replace(CheckValue, "'","''" )
        CheckValue = Replace(CheckValue, Chr(34),"&quot;")
        CheckValue = Replace(CheckValue,  "<br>",chr(13))
    	check_html = CheckValue
    End Function
    
    Function CheckWord(CheckValue)	
        CheckValue = replace(CheckValue, "&" , "&amp;")
        CheckValue = replace(CheckValue, "<", "&lt;")
        CheckValue = replace(CheckValue, ">", "&gt;")
        CheckValue = replace(CheckValue, "'", "&#39;")
        CheckValue = replace(CheckValue, ",", "&#44;")
        CheckWord=CheckValue	
    End Function
    	
    	'보여줄때 원래대로 보여준다.
    Function CheckWordre(CheckValue)	
        CheckValue = replace(CheckValue, "&amp;", "&")
        CheckValue = replace(CheckValue, "&lt;", "<")
        CheckValue = replace(CheckValue, "&gt;", ">")
        CheckValue = replace(CheckValue, "&quot;", Chr(34))
        CheckValue = replace(CheckValue, "&#39;", "'")
        CheckValue = replace(CheckValue, "&#44;", ",")
        CheckWordre=CheckValue	
    End Function
    	
    
    Function fnDateSplit(byval ymd,ByVal phrase)
        ymd = Replace(ymd,"-","")
        ymd = Replace(ymd,".","")
        ymd = Replace(ymd,"/","")
        ymd = Replace(ymd,"~","")
    
        ymd = Left(ymd,4)&phrase&Mid(ymd,5,2)&phrase&Right(ymd,2)
        fnDateSplit = ymd
    End function
    
    
    '*********************************************************************'파일관련
    Function GetUniqueName(byRef strFileName, DirectoryPath)
        Dim strName, strExt
        strName= Mid(strFileName, 1, InstrRev(strFileName, ".") - 1)
        strExt = Mid(strFileName, InstrRev(strFileName, ".") + 1)
    
        Dim fso
        Set fso = Server.CreateObject("Scripting.FileSystemObject")
    
        Dim bExist : bExist = True
        Dim strFileWholePath : strFileWholePath = DirectoryPath & "\" & strName & "." & strExt 
        Dim countFileName : countFileName = 0 
    
        Do While bExist
            If (fso.FileExists(strFileWholePath)) Then
                countFileName = countFileName + 1
                strFileName = strName & "(" & countFileName & ")." & strExt
                strFileWholePath = DirectoryPath & "\" & strFileName
            Else
                bExist = False
            End If
            Loop
            GetUniqueName = strFileWholePath
    End Function
    
    
    
    Function makeThumbnail(ByVal img_path, ByVal img_name, ByVal thumb_name, ByVal thumb_wsize, ByVal thumb_hsize)
        Dim thumb_path, thumb_image, objImage
        Set objImage    = Server.CreateObject("DEXT.ImageProc")
        objImage.Quality =100
    
        IF objImage.SetSourceFile(img_path &"\"& img_name) Then
            thumb_path = img_path &"\"& thumb_name &".jpg"
            thumb_image = objImage.SaveasThumbnail(thumb_path, thumb_wsize, thumb_hsize, true)
        End IF
    
        makeThumbnail = thumb_image
    End Function
    
    
    FUNCTION file_del(fileDir)
        Set fso = Server.CreateObject("Scripting.FileSystemObject") 
        If fso.FileExists(fileDir) = True Then 
            fso.DeleteFile fileDir, True 
        end if
    End FUNCTION 
    
     
    
    FUNCTION GetImageSize(file_path)
        Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
        IF objFSO.FileExists(file_path) THEN
            Set ObjImg = LoadPicture(file_path)
            img_x = Cint(objImg.Width * 24/ 635)
            obj_wid = objImg.Width
            Set ObjImg = Nothing   
        End if
        
        GetImageSize =img_x
    End FUNCTION 
     
     
    Function Chk_Image(sType)
        Dim sAllow, Chk_OK, intLoop
    
        Chk_OK = False
        sAllow = Split("JPG|JPEG|PNG|GIF|BMP","|")
    
        For intLoop = 0 To UBound(sAllow)
            If sType = sAllow(intLoop) Then
                Chk_OK = True
                Exit For
            End If
        Next
    
        Chk_Image = Chk_OK
    End Function
    
    
    Function Chk_file(sType)
        Dim sAllow, Chk_OK, intLoop
    
        Chk_OK = False
        sAllow = Split("JPG|GIF|HWP|DOC|DOCX|XLS|XLSX|PPT|PPTX|TXT|PDF|BMP|ZIP","|")
    
    		For intLoop = 0 To UBound(sAllow)
    			If sType = sAllow(intLoop) Then
    			    Chk_OK = True
    				Exit For
    			End If
    		Next
    
    		Chk_file = Chk_OK
    End Function
    '*********************************************************************'파일관련
    
    
    '*********************************************************************' 인젝션 처리
    Function SQLInj(str)
        Dim txt
    
        txt = str
    
        txt = REPLACE( txt, "'", "´" )
        txt = REPLACE( txt, ";", "" )
        txt = REPLACE( txt, "--", "" )
        txt = REPLACE( txt, "select", "", 1, -1, 1 )
        txt = REPLACE( txt, "insert", "", 1, -1, 1 )
        txt = REPLACE( txt, "update", "", 1, -1, 1 )
        txt = REPLACE( txt, "delete", "", 1, -1, 1 )
        txt = REPLACE( txt, "drop", "", 1, -1, 1 )
        txt = REPLACE( txt, "union", "", 1, -1, 1 )
        'txt = REPLACE( txt, "and", "", 1, -1, 1 )
        'txt = REPLACE( txt, "or", "", 1, -1, 1 )
        txt = REPLACE( txt, "1=1", "", 1, -1, 1 )
    
        txt = REPLACE( txt, "sp_", "", 1, -1, 1 )
        txt = REPLACE( txt, "xp_", "", 1, -1, 1 )
        txt = REPLACE( txt, "@variable", "", 1, -1, 1 )
        txt = REPLACE( txt, "@@variable", "", 1, -1, 1 )
        txt = REPLACE( txt, "exec", "", 1, -1, 1 )
        txt = REPLACE( txt, "sysobject", "", 1, -1, 1 )
    
        SQLInj = txt
    End Function	
    
    
     '****************************숫자를 한글로 만들어주기*****************************************
    FUNCTION money_amt(amt_y)             
        Dim unit1(10)
        Dim unit2(2)
        Dim unit3(2)
    
        unit1(0)=""
        unit1(1)="일"
        unit1(2)="이"
        unit1(3)="삼"
        unit1(4)="사"
        unit1(5)="오"
        unit1(6)="육"
        unit1(7)="칠"
        unit1(8)="팔"
        unit1(9)="구"
        unit2(0)="십"
        unit2(1)="백"
        unit2(2)="천"
        unit3(0)="만"
        unit3(1)="억"
        unit3(2)="조"
    
        vamt= Replace(amt_y,",","")
        xchk=IsNumeric(vamt)
    
        If xchk =True Then
            money_total = Len(CStr(CDbl(amt_y)))
            vamt= CDbl(amt_y)
    	
            krs=""
    	
            For p = 1 To money_total
    	
                num_y = Mid(vamt,p,1)
                temp1 = (money_total - p)+1
                krs= krs & unit1(num_y)
    	
                if num_y <> 0 And p <> money_total Then
                    if Len(left (vamt, (money_total - p) + 1)) Mod 4= 0 then krs = krs & unit2(2)
                    if Len(left (vamt, (money_total - p) + 1)) Mod 4= 3 then krs = krs & unit2(1)
                    if Len(left (vamt, (money_total - p) + 1)) Mod 4= 2 then krs = krs & unit2(0)
                End if		
    
                if temp1 = 5 And Right(krs,1) <> unit3(2) And Right(krs,1) <> unit3(1) then krs= krs & unit3(0)
                if temp1 = 9 And Right(krs,1) <> unit3(2)  then krs= krs & unit3(1)
                if temp1 = 13  then krs= krs & unit3(2)
    	
            Next
    
            krs = krs & "원"
    
            'response.write  "input:" & amt_y & vbCr & "output: "&krs
            response.write  krs
    
        Else
            response.write "금액확인해주세요"
        End If
    END FUNCTION


'-------------------------------------------------------------------------------------------------------------------------------------------
    Function str_where_query(sql, fe, val, sim)
        Dim constring
        If sql = "" Then
            constring = " WHERE "
        Else
            constring = " AND "
        End If
        
        sql = sql & constring & " " & fe & " " & sim
        If InStr(sim, "LIKE") > 0 Or InStr(sim, "like") Then
            sql = sql & " '%" & val & "%'"
        Else
            sql = sql & " '" & val & "' "
        End If
    str_where_query = sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    Function int_where_query(sql, fe, val, sim)
        Dim constring
        If sql = "" Then
            constring = " WHERE "
        Else
            constring = " AND "
        End If
        sql = sql & constring & " " & fe & " " & sim & " " & val & " "
        int_where_query = sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    Function order_query(sql, fe, sim)
    Dim constring
    If sql = "" Then
    constring = " ORDER BY "
    Else
    constring = " , "
    End If
    sql = sql & constring & fe & " " & sim
    order_query = sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    Function list_query(tb, Sql_where, Sql_order, gotopage, pagesize)
    Sql = "SELECT TOP " & pagesize & " * FROM "&tb
    if gotopage > 1 then 
     Sql = Sql & " WHERE num not in "
     Sql = Sql & "(SELECT TOP " & ((gotopage - 1) * pagesize) & " num FROM "&tb
     Sql = Sql& Sql_where&Sql_order&" )"
     if Sql_where <> "" then
    		Sql_where = mid(Sql_where,7,Len(Sql_where)-6)
    		Sql_where = " AND "&Sql_where
     end if
    end if
    Sql = Sql&Sql_where&Sql_order
    list_query = Sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------sms리스트
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    Function list_query_sms(tb, Sql_where, Sql_order, gotopage, pagesize)
        Sql = "SELECT TOP " & pagesize & " * FROM "&tb
        if gotopage > 1 then 
            Sql = Sql & " WHERE nRegID not in "
            Sql = Sql & "(SELECT TOP " & ((gotopage - 1) * pagesize) & " nRegID FROM "&tb
            Sql = Sql& Sql_where&Sql_order&" )"
            if Sql_where <> "" then
                Sql_where = mid(Sql_where,7,Len(Sql_where)-6)
                Sql_where = " AND "&Sql_where
            end if
        end if
        Sql = Sql&Sql_where&Sql_order
        list_query_sms = Sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    '연령별회원 리스트는 이거 사용
    Function list_query_mem(tb, Sql_where, Sql_order, gotopage, pagesize)
        Sql = "SELECT TOP " & pagesize & "   birthday, kname, DATEPART(YYYY, GETDATE()) - DATEPART(YYYY, birthday) AS AGE, email, email_yn, comtel,htel, sms_yn, addnum1, addnum2, address, memdate,memkind  FROM "&tb
        if gotopage > 1 then 
            Sql = Sql & " WHERE num not in "
            Sql = Sql & "(SELECT TOP " & ((gotopage - 1) * pagesize) & " num FROM "&tb
            Sql = Sql& Sql_where&Sql_order&" )"
            if Sql_where <> "" then
                Sql_where = mid(Sql_where,7,Len(Sql_where)-6)
                Sql_where = " AND "&Sql_where
            end if
        end if
        Sql = Sql&Sql_where&Sql_order
        list_query_mem = Sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    '지급미지급 리스트는 이거 사용
    Function list_query_su(tb, Sql_where, Sql_order, gotopage, pagesize)
        Sql = "SELECT TOP " & pagesize & " * FROM "&tb
        if gotopage > 1 then 
            Sql = Sql & " WHERE b.num not in "
            Sql = Sql & "(SELECT TOP " & ((gotopage - 1) * pagesize) & " b.num FROM "&tb
            Sql = Sql& Sql_where&Sql_order&" )"
            if Sql_where <> "" then
                Sql_where = mid(Sql_where,7,Len(Sql_where)-6)
                Sql_where = " AND "&Sql_where
            end if
        end if
        Sql = Sql&Sql_where&Sql_order
        list_query_su = Sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    '미지급 리스트 엑셀는 이거 사용
    Function list_query_ex(tb, Sql_where, Sql_order, gotopage, pagesize)
        Sql = "SELECT TOP " & pagesize & " code as 행사코드번호,title as 행사상품명,company1 as 항목,company2 as 거래처,coin_type_num  as 통화 ,coin_pay as 단가, coin_change as 환율, custom_cnt as 인원, total_price as 합계   FROM "&tb
        if gotopage > 1 then 
            Sql = Sql & " WHERE b.num not in "
            Sql = Sql & "(SELECT TOP " & ((gotopage - 1) * pagesize) & " b.num FROM "&tb
            Sql = Sql& Sql_where&Sql_order&" )"
            if Sql_where <> "" then
                Sql_where = mid(Sql_where,7,Len(Sql_where)-6)
                Sql_where = " AND "&Sql_where
            end if
        end if
        Sql = Sql&Sql_where&Sql_order
        list_query_ex = Sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    '지급 리스트 엑셀는 이거 사용
    Function list_query_exy(tb, Sql_where, Sql_order, gotopage, pagesize)
        Sql = "SELECT TOP " & pagesize & " code as 행사코드번호,title as 행사상품명,company1 as 항목,company2 as 거래처,coin_type_num  as 통화 ,coin_pay as 단가, coin_change as 환율, custom_cnt as 인원, total_price as 합계,out_day as 지급일   FROM "&tb
        if gotopage > 1 then 
            Sql = Sql & " WHERE b.num not in "
            Sql = Sql & "(SELECT TOP " & ((gotopage - 1) * pagesize) & " b.num FROM "&tb
            Sql = Sql& Sql_where&Sql_order&" )"
            if Sql_where <> "" then
                Sql_where = mid(Sql_where,7,Len(Sql_where)-6)
            Sql_where = " AND "&Sql_where
            end if
        end if
        Sql = Sql&Sql_where&Sql_order
        list_query_exy = Sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    '정산서 처리현황 리스트 엑셀은 이거 사용
    Function list_query_ex_acc(tb, Sql_where, Sql_order, gotopage, pagesize)
        Sql = "SELECT TOP " & pagesize & " code as 정산번호,title as 행사명,selectdate as 출발일,member_cnt as 인원,memdate as 최종정산일,num as 총매출액,num  as 행사수익,num as 일인당수익,num  as 총수익율,manager_num as 정산담당, selnum as 마감 FROM "&tb
        if gotopage > 1 then 
            Sql = Sql & " WHERE b.num not in "
            Sql = Sql & "(SELECT TOP " & ((gotopage - 1) * pagesize) & " b.num FROM "&tb
            Sql = Sql& Sql_where&Sql_order&" )"
            if Sql_where <> "" then
                Sql_where = mid(Sql_where,7,Len(Sql_where)-6)
                Sql_where = " AND "&Sql_where
            end if
        end if
        Sql = Sql&Sql_where&Sql_order
        list_query_ex_acc = Sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------
    '전체목록 가져오기
    Function list_query_all(tb, Sql_where, Sql_order)
        Sql = "SELECT * FROM "&tb
        if gotopage > 1 then 
            Sql = Sql & " WHERE "
            if Sql_where <> "" then
    		Sql_where = mid(Sql_where,7,Len(Sql_where)-6)
    		Sql_where = " AND "&Sql_where
            end if
        end if
        Sql = Sql&Sql_where&Sql_order
        list_query_all = Sql
    End Function
    
    
    
    Function list_query_all_mem(tb, Sql_where, Sql_order)
        Sql = "SELECT  birthday, kname, DATEPART(YYYY, GETDATE()) - DATEPART(YYYY, birthday) AS AGE, email, email_yn, comtel,htel, sms_yn, addnum1, addnum2, address, memdate,memkind FROM "&tb
        if gotopage > 1 then 
            Sql = Sql & " WHERE "
            if Sql_where <> "" then
                Sql_where = mid(Sql_where,7,Len(Sql_where)-6)
                Sql_where = " AND "&Sql_where
            end if
        end if
        Sql = Sql&Sql_where&Sql_order
        list_query_all_mem = Sql
    End Function
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------경고창 띄우는 함수
    Sub Alert_Window(args)
        dim write_String
        write_String = "<script language='javascript'>"
        write_String = write_String & "alert('"& args &"');"
        write_String = write_String & "history.back();"
        write_String = write_String & "</script>"
        response.write write_String
    end Sub
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------경고창 띄우는 함수
    Sub Alert_No_Back_Window(args)
        dim write_String
        write_String = "<script language='javascript'>"
        write_String = write_String & "alert('"& args &"');"
        write_String = write_String & "</script>"
        response.write write_String
    end Sub
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------경고창 띄우는 함수
    Sub Alert_Close_Window(args)
        dim write_String
        write_String = "<script language='javascript'>"
        write_String = write_String & "alert('"& args &"');"
        write_String = write_String & "window.close();"
        write_String = write_String & "</script>"
        response.write write_String
    end Sub
'-------------------------------------------------------------------------------------------------------------------------------------------
    
    
'-------------------------------------------------------------------------------------------------------------------------------------------경고창 띄우는 함수
    Sub Alert_Window_Location(args1,args2)
        dim write_String
        write_String = "<script language='javascript'>"
        write_String = write_String & "alert('"& args1 &"');"
        write_String = write_String & "location.href='"& args2 &"';"
        write_String = write_String & "</script>"
        response.write write_String
    end Sub
'-------------------------------------------------------------------------------------------------------------------------------------------
%>