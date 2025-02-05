<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
 
    admin_action = Request("admin_action")
    If Trim(admin_action)="" then
        Alert_Window("주요인자 전송에러!!")
        response.end
    End if
    
    OpenF5_DB objConn
     
    nat_cd = Trim(Request("nat_cd"))
    city_cd = Trim(Request("city_cd"))
    
    
    description = Request("description")
    description = replace(description,"'","''")
    
    'description = replace(description,"&","&amp;")
    'description = replace(description,"  ","&nbsp;&nbsp;")
    'description = replace(description,"&amp;nbsp;&amp;nbsp;","&nbsp;&nbsp;")
    'description = replace(description,"&amp;nbsp;"," ")
    'description = replace(description,"'","''")
    '##################################################################################################
    
    
    '#######################################국가정보#####################################
    If admin_action="info_make" then
    
        Sql = "SELECT nat_cd FROM TB_ti110 where nat_cd='"&nat_cd&"' "
        Set Rs = objConn.Execute(sql)
        if  not Rs.EOF or  not Rs.BOF then
            response.write "<script language='javascript'>           "
            response.write "    alert('국가정보가 등록되어 있습니다. 정보변경은 수정버튼을 누르세요.');"
            response.write "    history.go(-1); "
            response.write "</script> " 
            response.end
    
        else
            objConn.BeginTrans
            cols = " nat_cd, desc_cd, description"
            values = " ('"&nat_cd&"', '01', N'"&description&"') "
    
            sql = "INSERT INTO TB_ti110 (" & cols & ") VALUES " & values
            objConn.Execute(sql)
       
            if Err.number = 0 Then
                objConn.CommitTrans	
            else 
                objConn.RollbackTrans
                CloseF5_DB objConn
                fnUrl"등록중 오류가 발생했습니다.      ",""
            end if
    
            response.write "<script language='javascript'> "
            response.write "    alert('국가정보가 등록되었습니다.');"
            response.write "    window.location.href='nat_detail.asp?nat_cd="&nat_cd&"'; "
            response.write "</script> " 
            response.end
        end if
        CloseRs Rs
    
    
    Elseif  admin_action="info_modify" then
    
        Sql = "SELECT nat_cd FROM TB_ti110 where nat_cd='"&nat_cd&"' "
        Set Rs = objConn.Execute(sql)
        if Rs.EOF or Rs.BOF then
            response.write "<script language='javascript'> "
            response.write "    alert('국가정보입력후 수정가능합니다.');"
            response.write "    history.go(-1); "
            response.write "</script> " 
            response.end
    
        else
            objConn.BeginTrans
            sql = "UPDATE TB_ti110 SET description='" & description & "'"
            sql = sql & " where nat_cd='" & nat_cd&"'"
            objConn.Execute(sql)
      
            if Err.number = 0 Then
                objConn.CommitTrans	
            else 
                objConn.RollbackTrans
                CloseF5_DB objConn
                fnUrl"등록중 오류가 발생했습니다.      ",""
            end if
      
            response.write "<script language='javascript'> "
            response.write "    alert('국가정보가 수정 되었습니다.');"
            response.write "    window.location.href='nat_detail.asp?nat_cd="&nat_cd&"'; "
            response.write "</script> " 
            response.end
        end if  
        CloseRs Rs
    
    
    Elseif  admin_action="info_del" then
      
        objConn.BeginTrans
        sql = "delete from TB_ti100 "
        sql = sql & " where nat_cd='" &nat_cd&"' "
        objConn.Execute(sql)
    
        if Err.number = 0 Then
            objConn.CommitTrans	
        else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            fnUrl"등록중 오류가 발생했습니다.      ",""
        end if
    	
        objConn.BeginTrans
        sql = "delete from TB_ti110 "
        sql = sql & " where nat_cd='" &nat_cd&"' "
        objConn.Execute(sql)
       
        if Err.number = 0 Then
            objConn.CommitTrans	
        else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            fnUrl"등록중 오류가 발생했습니다.      ",""
        end if
    	
        objConn.BeginTrans
        sql = "delete from TB_ti200 "
        sql = sql & " where nat_cd='" &nat_cd&"' "
        objConn.Execute(sql)
        if Err.number = 0 Then
            objConn.CommitTrans	
        else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            fnUrl"등록중 오류가 발생했습니다.      ",""
        end if
      
        response.write "<script language='javascript'> "
        response.write "    alert('국가가 삭제 되었습니다.'); "
        response.write "    parent.location.reload(); "
        response.write "    parent.$('#chain_schedule28k').dialog('close'); "
        response.write "</script> " 
        response.end
       
 
     
    Elseif  admin_action="info_nat_del" then
    
        Sql = "SELECT nat_cd FROM TB_ti110 where nat_cd='"&nat_cd&"'"
        Set Rs = objConn.Execute(sql)
        if Rs.EOF or Rs.BOF then
            response.write "<script language='javascript'> "
            response.write "    alert('국가정보입력후 삭제가능합니다.');"
            response.write "    window.location.href='nat_detail.asp?nat_cd="&nat_cd&"'; "
            response.write "</script> " 
            response.end
        else
            objConn.BeginTrans
            sql = "delete from TB_ti110 where nat_cd='" & nat_cd&"'"
            objConn.Execute(sql)
            if Err.number = 0 Then
                objConn.CommitTrans	
            else 
                objConn.RollbackTrans
                CloseF5_DB objConn
                fnUrl"등록중 오류가 발생했습니다.      ",""
            end if
    
            response.write "<script language='javascript'> "
            response.write "    alert('국가정보가 삭제 되었습니다.');"
            response.write "    window.location.href='nat_detail.asp?nat_cd="&nat_cd&"'; "
            response.write "</script> " 
            response.end
        end if
      
      
      
     
    '#######################################도시정보#####################################
    Elseif  admin_action="info_city" then
    
        Sql = "SELECT nat_cd FROM TB_ti210 where nat_cd='"&nat_cd&"' and city_cd='"&city_cd&"' "
    
       
        Set Rs = objConn.Execute(sql)
        if  not Rs.EOF or  not Rs.BOF then
            response.write "<script language='javascript'> "
            response.write "    alert('도시정보가 등록되어 있습니다. 정보변경은 수정버튼을 누르세요.');"
            response.write "    history.go(-1); "
            response.write "</script> " 
            response.end
            
        else
            objConn.BeginTrans
            cols = "      nat_cd,     city_cd,           desc_cd,            description"
            values = " ('"&nat_cd&"', '"&city_cd&"',       '00',           N'"&description&"') "
    
            sql = "INSERT INTO TB_ti210 (" & cols & ") VALUES " & values
            objConn.Execute(sql)
        
            if Err.number = 0 Then
                objConn.CommitTrans	
            else 
                objConn.RollbackTrans
                CloseF5_DB objConn
                fnUrl"등록중 오류가 발생했습니다.      ",""
            end if
    	
            response.write "<script language='javascript'> "
            response.write "    alert('도시정보가 등록되었습니다.');"
            response.write "    window.location.href='area_detail.asp?nat_cd="&nat_cd&"&city="&city_cd&"'; "
            response.write "</script> " 
            response.end
        end if
        CloseRs Rs
    
    
    Elseif  admin_action="info_city_modify" then
    
        Sql = "SELECT nat_cd FROM TB_ti210 where nat_cd='"&nat_cd&"'and city_cd='"&city_cd&"' "
        Set Rs = objConn.Execute(sql)
        if Rs.EOF or Rs.BOF then
            response.write "<script language='javascript'> "
            response.write "    alert('도시정보입력후 수정가능합니다.');"
            response.write "    history.go(-1); "
            response.write "</script> " 
            response.end
    
        else
            objConn.BeginTrans
            sql = "UPDATE TB_ti210 SET description=N'" & description & "'"
            sql = sql & " where nat_cd='" & nat_cd&"'and city_cd='"&city_cd&"'"
            objConn.Execute(sql)
            if Err.number = 0 Then
                objConn.CommitTrans	
            else 
                objConn.RollbackTrans
                CloseF5_DB objConn
                fnUrl"등록중 오류가 발생했습니다.      ",""
            end if
        
            response.write "<script language='javascript'> "
            response.write "    alert('도시정보가 수정 되었습니다.');"
            response.write "    window.location.href='area_detail.asp?nat_cd="&nat_cd&"&city="&city_cd&"'; "
            response.write "</script> " 
            response.end
        end if  
        CloseRs Rs
    
    
    Elseif  admin_action="info_city_del" then
    
        Sql = "SELECT nat_cd FROM TB_ti210 where nat_cd='"&nat_cd&"'and city_cd='"&city_cd&"' "
        Set Rs = objConn.Execute(sql)
        if Rs.EOF or Rs.BOF then
            response.write "<script language='javascript'>               "
            response.write "  alert('도시정보입력후 삭제가능합니다.');"
            response.write "  window.location.href='area_detail.asp?nat_cd="&nat_cd&"&city="&city_cd&"'; "
            response.write "</script>                                    " 
            response.end
        else
            objConn.BeginTrans
            sql = "delete from TB_ti210 where nat_cd='" & nat_cd&"'and city_cd='"&city_cd&"'"
            objConn.Execute(sql)
            if Err.number = 0 Then
                objConn.CommitTrans	
            else 
                objConn.RollbackTrans
                CloseF5_DB objConn
                fnUrl"등록중 오류가 발생했습니다.      ",""
            end if
        
        response.write "<script language='javascript'> "
        response.write "    alert('도시정보가 삭제 되었습니다.'); "
        response.write "    parent.location.reload(); "
        response.write "    parent.$('#chain_schedule28k').dialog('close'); "
        response.write "</script> " 
        response.end 
            
        end if
        CloseRs Rs
    
    

    '#######################################관광지정보#####################################
    Elseif  admin_action="tour_make" then
    
        nat_cd = Trim(Request("nat_cd"))     '국가코드
        city_cd = Trim(Request("city_cd"))    '도시코드
        
        nm_kor = Trim(Request("nm_kor"))     '관광지명(한글)
        nm_kor = check_html(nm_kor)  
        
        nm_eng = Trim(Request("nm_eng"))     '관광지명(영문)
        nm_eng = check_html(nm_eng)  
        
        tel = Trim(Request("tel"))        '전화번호
        tel = check_html(tel)
        tel = cutStr(tel,50)
        
        fax = Trim(Request("fax"))        '팩스번호
        fax = check_html(fax)
        fax = cutStr(fax,50)
        
        addr = Trim(Request("addr"))       '주소
        addr = check_html(addr)
        addr = cutStr(addr,150)
        
        url = Trim(Request("url"))        '홈페이지
        url = check_html(url)
        url = cutStr(url,100)
        
        holiday = Trim(Request("holiday"))    '공휴일
        holiday =  check_html(holiday)
        holiday = cutStr(holiday,50)
        
        buss_tm = Trim(Request("buss_tm"))    '영업시간
        buss_tm = replace(buss_tm,"'","''")
        
        place = Trim(Request("place"))      '위치
        place = replace(place,"'","''")
        
        traffic = Trim(Request("traffic"))    '교통편
        traffic = replace(traffic,"'","''")
        
        detail = Trim(Request("detail"))     '세부사항
        detail = replace(detail,"'","''")
        
        point1 = Trim(Request("point1")) '구글포인트1
        point2 = Trim(Request("point2")) '구글포인트2
        
        
         Sql = "SELECT MAX(seq) FROM TB_ti320"
        	Set Rs = objConn.Execute(sql)
        
        	if isnull(Rs(0)) then
        		seq = 1
        	else
        		seq = rs(0) + 1
        	end if
        
        	objConn.BeginTrans
        	cols = "      seq,       nat_cd,       city_cd,       nm_kor,       nm_eng,      tel,       fax,      addr,        url,       holiday,       buss_tm,        place,       traffic,       detail  ,point1, point2  "
        	values = " ('"&seq&"', '"&nat_cd&"', '"&city_cd&"', N'"&nm_kor&"', N'"&nm_eng&"', '"&tel&"', '"&fax&"', N'"&addr&"', '"&url&"', N'"&holiday&"', N'"&buss_tm&"',  N'"&place&"', N'"&traffic&"', N'"&detail&"','"&point1&"', '"&point2&"') "
        	sql = "INSERT INTO TB_ti320 (" & cols & ") VALUES " & values
        	objConn.Execute(sql)
         
        	if Err.number = 0 Then
        	    objConn.CommitTrans	
        	else 
        	    objConn.RollbackTrans
        	    CloseF5_DB objConn
              response.write "<script language='javascript'>"
              response.write "    alert('등록중 오류가 발생했습니다.');"
              response.write "    parent.$('#chain_tour_make').dialog('close');"
              response.write "</script>" 
              response.end        	   
        	end if
        	
        response.write "<script language='javascript'>"
        response.write "     alert('관광지정보가 등록되었습니다.');"
        response.write "    parent.location.reload();"
        response.write "    parent.$('#chain_tour_make').dialog('close');"
        response.write "</script>" 
        response.end   
        
        CloseRs Rs
    
    
    Elseif  admin_action="tour_modify" then
    
        seq = Trim(Request("seq"))        '일련번호
        
        nm_kor = Trim(Request("nm_kor"))     '관광지명(한글)
        nm_kor = check_html(nm_kor)  
        
        nm_eng = Trim(Request("nm_eng"))     '관광지명(영문)
        nm_eng = check_html(nm_eng)  
        
        tel = Trim(Request("tel"))        '전화번호
        tel = check_html(tel)  
        tel = cutStr(tel,50)
        
        fax = Trim(Request("fax"))        '팩스번호
        fax = check_html(fax)  
        fax = cutStr(fax,50)
        
        addr = Trim(Request("addr"))       '주소
        addr = check_html(addr)
        addr = cutStr(addr,150)
        
        url = Trim(Request("url"))        '홈페이지
        url = check_html(url)
        url = cutStr(url,100)
        
        
        holiday = Trim(Request("holiday"))    '호텔등급
        holiday =  check_html(holiday)
        holiday = cutStr(holiday,50)
        
        
        buss_tm = Trim(Request("buss_tm")) '영업시간
        buss_tm = replace(buss_tm,"'","''")
        
        place = Trim(Request("place"))      '위치
        place = replace(place,"'","''")
        
        traffic = Trim(Request("traffic"))    '교통편
        traffic = replace(traffic,"'","''")
        
        detail = Trim(Request("detail"))     '세부사항
        detail = replace(detail,"'","''")
        
        point1 = Trim(Request("point1")) '구글포인트1
        point2 = Trim(Request("point2")) '구글포인트2
        objConn.BeginTrans
     
        sql = "UPDATE TB_ti320 SET nm_kor=N'" & nm_kor & "',nm_eng=N'" & nm_eng & "',tel='" & tel & "',fax='" & fax & "' ,addr=N'" & addr 
        sql = sql & "',url='"&url&"', holiday =N'"&holiday&"',buss_tm = N'"&buss_tm&"',place = N'"&place&"',traffic = N'"&traffic
        sql = sql & "',detail = N'"&detail&"',point1='"&point1&"',point2='"&point2
        sql = sql & "'  where seq='" & seq&"'"
        objConn.Execute(sql)
     
        if Err.number = 0 Then
            objConn.CommitTrans	
        else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            response.write "<script language='javascript'> "
            response.write "  alert('등록중 오류가 발생했습니다.'); "
            response.write "  parent.$('#chain_tour_modify').dialog('close'); "
            response.write "</script> " 
            response.end                
        end if

        response.write "<script language='javascript'> "
        response.write "  alert('관광지정보가 수정되었습니다.'); "
        response.write " parent.location.reload();         "
        response.write "  parent.$('#chain_tour_modify').dialog('close'); "
        response.write "</script> " 
        response.end  
    
    
    Elseif  admin_action="tour_del" then
    
        seq = Trim(Request("seq"))        '일련번호
        nat_cd = Trim(Request("nat_cd"))        '국가코드
        city = Trim(Request("city"))        '도시코드
     
        objConn.BeginTrans
    
        sql = "delete from TB_ti320 where seq=" & seq
        objConn.Execute(sql)
      
        if Err.number = 0 Then
            objConn.CommitTrans	
        Else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            fnUrl"등록중 오류가 발생했습니다.      ",""
        End If
    
        objConn.BeginTrans
       
        sql = "UPDATE  TB_ph020 set del_yn='Y'  where info_cd='02' and seq=" & seq
        objConn.Execute(sql)
    
        if Err.number = 0 Then
           objConn.CommitTrans	
        else 
           objConn.RollbackTrans
           CloseF5_DB objConn
           fnUrl"등록중 오류가 발생했습니다.      ",""
        end if
    	
        response.write "<script language='javascript'> "
        response.write "    alert('관광지정보가 삭제 되었습니다.');"
        response.write "    window.location.href='area_detail_infor.asp?nat_cd="&nat_cd&"&city="&city&"&infor_cd=02'; "
        response.write "</script>                                    " 
        response.end
    '#######################################관광지정보#####################################
    
    
    
    '#######################################호텔정보#####################################
    Elseif  admin_action="hotel_make" then

        nat_cd = Trim(Request("nat_cd"))     '국가코드
        city_cd = Trim(Request("city_cd"))    '도시코드
        nm_kor = Trim(Request("nm_kor"))     '호텔명(한글)
        nm_kor = check_html(nm_kor)  
        nm_eng = Trim(Request("nm_eng"))     '호텔명(영문)
        nm_eng = check_html(nm_eng)  
        grade = Trim(Request("grade"))      '호텔등급
        
        room = Trim(Request("room"))       '객실수
        room = check_html(room)  
        room = cutStr(room,150)
        
        tel = Trim(Request("tel"))        '전화번호
        tel = check_html(tel)  
        tel = cutStr(tel,50)
        
        fax = Trim(Request("fax"))        '팩스번호
        fax = check_html(fax)  
        fax = cutStr(fax,50)
        
        url = Trim(Request("url"))        '홈페이지
        url = check_html(url)  
        url = cutStr(url,100)
        
        addr = Trim(Request("addr"))       '주소
        addr = check_html(addr) 
        addr = cutStr(addr,150)
        
        place = Trim(Request("place"))      '위치
        place = replace(place,"'","''")
        
        traffic = Trim(Request("traffic"))    '교통편
        traffic = replace(traffic,"'","''")
        
        base_intro = Trim(Request("base_intro")) '호텔소개
        base_intro = replace(base_intro,"'","''")
        
        detail = Trim(Request("detail"))     '세부사항
        detail = replace(detail,"'","''")
        
        room_intro = Trim(Request("room_intro")) '객실정보
        room_intro = replace(room_intro,"'","''")
        
        unit_intro = Trim(Request("unit_intro")) '부대시설
        unit_intro = replace(unit_intro,"'","''")
        
        rest_intro = Trim(Request("rest_intro")) '레스토랑소개
        rest_intro = replace(rest_intro,"'","''")
        
        point1 = Trim(Request("point1")) '구글포인트1
        point2 = Trim(Request("point2")) '구글포인트2
    
    
        Sql = "SELECT MAX(seq) FROM TB_ti310"
        Set Rs = objConn.Execute(sql)
    
        if isnull(Rs(0)) then
            seq = 1
        else
            seq = rs(0) + 1
        end if
    
        objConn.BeginTrans
        cols = "        seq,         nat_cd,         city_cd,         nm_kor,          nm_eng,         place,         addr,          grade,        room,          tel,         fax,          url,         traffic,          detail,         base_intro,         room_intro,         unit_intro,         rest_intro,         point1,        point2  ,del_yn   "
        values = " ('"&seq&"', '"&nat_cd&"', '"&city_cd&"', N'"&nm_kor&"', N'"&nm_eng&"', N'"&place&"', N'"&addr&"', '"&grade&"', '"&room&"', '"&tel&"', '"&fax&"',  '"&url&"', N'"&traffic&"', N'"&detail&"', N'"&base_intro&"', N'"&room_intro&"', N'"&unit_intro&"', N'"&rest_intro&"','"&point1&"','"&point2&"' ,'N'  ) "
        sql = "INSERT INTO TB_ti310 (" & cols & ") VALUES " & values
        objConn.Execute(sql)

        	if Err.number = 0 Then
        	    objConn.CommitTrans	
        	else 
        	    objConn.RollbackTrans
        	    CloseF5_DB objConn
              response.write "<script language='javascript'>"
              response.write "    alert('등록중 오류가 발생했습니다.');"
              response.write "    parent.$('#chain_hotel_make').dialog('close');"
              response.write "</script>" 
              response.end        	   
        	end if
        	
        response.write "<script language='javascript'>"
        response.write "    alert('호텔정보가 등록되었습니다.');"
        response.write "    parent.location.reload();"
        response.write "    parent.$('#chain_hotel_make').dialog('close');"
        response.write "</script>" 
        response.end   
        
        CloseRs Rs

    
    Elseif  admin_action="hotel_modify" then
    
        seq = Trim(Request("seq"))        '일련번호
        nm_kor = Trim(Request("nm_kor"))     '호텔명(한글)
        nm_kor = check_html(nm_kor)  
        nm_eng = Trim(Request("nm_eng"))     '호텔명(영문)
        nm_eng = check_html(nm_eng)  
        grade = Trim(Request("grade"))      '호텔등급
        
        room = Trim(Request("room"))       '객실수
        room = check_html(room)
        
        tel = Trim(Request("tel"))        '전화번호
        tel = check_html(tel)
        tel = cutStr(tel,50)
        
        fax = Trim(Request("fax"))        '팩스번호
        fax = check_html(fax)
        fax = cutStr(fax,50)
        
        url = Trim(Request("url"))        '홈페이지
        url = check_html(url)
        url = cutStr(url,100)
        
        addr = Trim(Request("addr"))       '주소
        addr = check_html(addr)
        addr = cutStr(addr,150)
        
        place = Trim(Request("place"))      '위치
        place = replace(place,"'","''")
        
        traffic = Trim(Request("traffic"))    '교통편
        traffic = replace(traffic,"'","''")
        
        base_intro = Trim(Request("base_intro")) '호텔소개
        base_intro = replace(base_intro,"'","''")
        
        detail = Trim(Request("detail"))     '세부사항
        detail = replace(detail,"'","''")
        
        room_intro = Trim(Request("room_intro")) '객실정보
        room_intro = replace(room_intro,"'","''")
        
        unit_intro = Trim(Request("unit_intro")) '부대시설
        unit_intro = replace(unit_intro,"'","''")
        
        rest_intro = Trim(Request("rest_intro")) '레스토랑소개
        rest_intro = replace(rest_intro,"'","''")
        
        point1 = Trim(Request("point1")) '구글포인트1
        point2 = Trim(Request("point2")) '구글포인트2
    
        objConn.BeginTrans
    
        sql = "UPDATE TB_ti310 SET nm_kor=N'" & nm_kor & "',nm_eng=N'" & nm_eng & "',grade='" & grade & "',room='" & room & "' ,tel='" & tel 
        sql = sql & "',fax='"&fax&"', url='"&url&"', place =N'"&place&"',addr = N'"&addr&"',traffic = N'"&traffic&"',base_intro = N'"&base_intro
        sql = sql & "',detail=N'"&detail&"', room_intro=N'"&room_intro&"', unit_intro = N'"&unit_intro&"',rest_intro = N'"&rest_intro&"',point1='"&point1&"',point2='"&point2
        sql = sql & "'  where seq='" & seq&"'"
        objConn.Execute(sql)
    
        if Err.number = 0 Then
            objConn.CommitTrans	
        else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            response.write "<script language='javascript'>"
            response.write "    alert('등록중 오류가 발생했습니다.');"
            response.write "    parent.$('#chain_hotel_modify').dialog('close');"
            response.write "</script>" 
            response.end        	   
        end if
        	
        response.write "<script language='javascript'>"
        response.write "    alert('호텔정보가 수정되었습니다.');"
        response.write "    parent.location.reload();"
        response.write "    parent.$('#chain_hotel_modify').dialog('close');"
        response.write "</script>" 
        response.end   
    
    
    Elseif  admin_action="hotel_del" then
    
        seq = Trim(Request("seq"))        '일련번호
        nat_cd = Trim(Request("nat_cd"))        '국가코드
        city = Trim(Request("city"))        '도시코드

        objConn.BeginTrans
    
        sql = "delete from TB_ti310 where seq=" & seq
        objConn.Execute(sql)
      
        if Err.number = 0 Then
            objConn.CommitTrans	
        Else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            fnUrl"등록중 오류가 발생했습니다.      ",""
        End If
    
        objConn.BeginTrans
       
        sql = "UPDATE  TB_ph020 set del_yn='Y'  where info_cd='01' and seq=" & seq
        objConn.Execute(sql)
    
        if Err.number = 0 Then
           objConn.CommitTrans	
        else 
           objConn.RollbackTrans
           CloseF5_DB objConn
           fnUrl"등록중 오류가 발생했습니다.      ",""
        end if
    	
        response.write "<script language='javascript'> "
        response.write "    alert('호텔정보가 삭제 되었습니다.');"
        response.write "    window.location.href='area_detail_infor.asp?nat_cd="&nat_cd&"&city="&city&"&infor_cd=01'; "
        response.write "</script> " 
        response.end
    '#######################################호텔정보#####################################


    
    '#######################################골프장정보#####################################
    Elseif  admin_action="golf_make" then
    
        nat_cd = Trim(Request("nat_cd"))     '국가코드
        city_cd = Trim(Request("city_cd"))    '도시코드
        
        nm_kor = Trim(Request("nm_kor"))     '골프장명(한글)
        nm_kor = check_html(nm_kor)  
        
        nm_eng = Trim(Request("nm_eng"))     '골프장명(영문)
        nm_eng = check_html(nm_eng) 

        addr = Trim(Request("addr"))       '주소
        addr = check_html(addr)
        addr = cutStr(addr,150)
        
        tel = Trim(Request("tel"))        '전화번호
        tel = check_html(tel)
        tel = cutStr(tel,50)

        fax = Trim(Request("fax"))        '팩스번호
        fax = check_html(fax)
        fax = cutStr(fax,50)
        
        dgn_nm = Trim(Request("dgn_nm"))     '설계자
        dgn_nm = check_html(dgn_nm)
        dgn_nm = cutStr(dgn_nm,50)

        open_dd = Trim(Request("open_dd"))    '개장일
        open_dd = check_html(open_dd)
        open_dd = cutStr(open_dd,50)
 
        url = Trim(Request("url"))        '홈페이지
        url = check_html(url)
        url = cutStr(url,50)
        
        place = Trim(Request("place"))      '위치
        place = replace(place,"'","''")

        traffic = Trim(Request("traffic"))    '교통편
        traffic = replace(traffic,"'","''")

        detail = Trim(Request("detail"))     '기본소개
        detail = replace(detail,"'","''")

        hole = Trim(Request("hole"))       '홀
        hole = replace(hole,"'","''")

        par = Trim(Request("par"))        '파
        par = replace(par,"'","''")

        tot_yard = Trim(Request("tot_yard"))   '총야드
        tot_yard = replace(tot_yard,"'","''")

        point1 = Trim(Request("point1")) '구글포인트1
        point2 = Trim(Request("point2")) '구글포인트2
    
        Sql = "SELECT MAX(seq) FROM TB_ti370"
        Set Rs = objConn.Execute(sql)
    
        if isnull(Rs(0)) then
            seq = 1
        else
            seq = rs(0) + 1
        end if
    
        objConn.BeginTrans
        cols = "      seq,       nat_cd,       city_cd,       nm_kor,       nm_eng,      addr,       tel,      fax,        dgn_nm,        open_dd,       url,       place,       traffic,        detail,       hole,        par  ,    tot_yard ,      point1,      point2  "
        values = " ('"&seq&"', '"&nat_cd&"', '"&city_cd&"', N'"&nm_kor&"', N'"&nm_eng&"', N'"&addr&"', '"&tel&"', '"&fax&"', N'"&dgn_nm&"',  '"&open_dd&"', '"&url&"', N'"&place&"', N'"&traffic&"', N'"&detail&"', '"&hole&"', '"&par&"','"&tot_yard&"', '"&point1&"','"&point2&"') "
        sql = "INSERT INTO TB_ti370 (" & cols & ") VALUES " & values

        objConn.Execute(sql)
        if Err.number = 0 Then
            objConn.CommitTrans	
        else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            response.write "<script language='javascript'>"
            response.write "    alert('등록중 오류가 발생했습니다.');"
            response.write "    parent.$('#chain_golf_make').dialog('close');"
            response.write "</script>" 
            response.end        	   
        end if
        	
        response.write "<script language='javascript'>"
        response.write "    alert('골프장 정보가 등록되었습니다.');"
        response.write "    parent.location.reload();"
        response.write "    parent.$('#chain_golf_make').dialog('close');"
        response.write "</script>" 
        response.end   
        
        CloseRs Rs
    
    Elseif  admin_action="golf_modify" then
    
        seq = Trim(Request("seq"))        '일련번호
        nm_kor = Trim(Request("nm_kor"))     '골프장명(한글)
        nm_kor = check_html(nm_kor)  

        nm_eng = Trim(Request("nm_eng"))     '골프장명(영문)
        nm_eng = check_html(nm_eng)  
        
        
        addr = Trim(Request("addr"))       '주소
        addr = check_html(addr)  
        addr = cutStr(addr,150)
        
        tel = Trim(Request("tel"))        '전화번호
        tel = check_html(tel)  
        tel = cutStr(tel,50)

        fax = Trim(Request("fax"))        '팩스번호
        fax = check_html(fax)  
        fax = cutStr(fax,50)

        dgn_nm = Trim(Request("dgn_nm"))     '설계자
        dgn_nm = check_html(dgn_nm)  
        dgn_nm = cutStr(dgn_nm,100)

        open_dd = Trim(Request("open_dd"))    '개장일
        open_dd = check_html(open_dd)  
        open_dd = cutStr(open_dd,100)

        url = Trim(Request("url"))        '홈페이지
        url = check_html(url)  
        url = cutStr(url,100)

        place = Trim(Request("place"))      '위치
        place = replace(place,"'","''")

        traffic = Trim(Request("traffic"))    '교통편
        traffic = replace(traffic,"'","''")

        detail = Trim(Request("detail"))     '기본소개
        detail = replace(detail,"'","''")

        hole = Trim(Request("hole"))       '홀
        hole = replace(hole,"'","''")
        
        par = Trim(Request("par"))        '파
        par = replace(par,"'","''")

        tot_yard = Trim(Request("tot_yard"))   '총야드
        tot_yard = replace(tot_yard,"'","''")

        point1 = Trim(Request("point1")) '구글포인트1
        point2 = Trim(Request("point2")) '구글포인트2
    
        objConn.BeginTrans
     
        sql = "UPDATE TB_ti370 SET nm_kor=N'" & nm_kor & "',nm_eng=N'" & nm_eng & "',addr=N'" & addr & "',tel='" & tel & "' ,fax='" & fax 
        sql = sql & "',dgn_nm=N'"&dgn_nm&"', open_dd='"&open_dd&"', url ='"&url&"',place = N'"&place&"',traffic = N'"&traffic&"',detail = N'"&detail
        sql = sql & "',hole='"&hole&"', par='"&par&"', tot_yard = '"&tot_yard&"',point1='"&point1&"',point2='"&point2
        sql = sql & "'  where seq='" & seq&"'"

        objConn.Execute(sql)
        if Err.number = 0 Then
            objConn.CommitTrans	
        else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            response.write "<script language='javascript'>"
            response.write "    alert('등록중 오류가 발생했습니다.');"
            response.write "    parent.$('#chain_golf_modify').dialog('close');"
            response.write "</script>" 
            response.end        	   
        end if
        	
        response.write "<script language='javascript'>"
        response.write "    alert('골프장 정보가 수정되었습니다.');"
        response.write "    parent.location.reload();"
        response.write "    parent.$('#chain_golf_modify').dialog('close');"
        response.write "</script>" 
        response.end  
        
        
    Elseif  admin_action="golf_del" then
    
        seq = Trim(Request("seq"))        '일련번호
        nat_cd = Trim(Request("nat_cd"))  '국가코드
        city = Trim(Request("city"))      '도시코드

       objConn.BeginTrans
    
        sql = "delete from TB_ti370 where seq=" & seq
        objConn.Execute(sql)
      
        if Err.number = 0 Then
            objConn.CommitTrans	
        Else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            fnUrl"등록중 오류가 발생했습니다.      ",""
        End If
    
        objConn.BeginTrans
       
        sql = "UPDATE  TB_ph020 set del_yn='Y'  where info_cd='07' and seq=" & seq
        objConn.Execute(sql)
    
        if Err.number = 0 Then
           objConn.CommitTrans	
        else 
           objConn.RollbackTrans
           CloseF5_DB objConn
           fnUrl"등록중 오류가 발생했습니다.      ",""
        end if
    	
        response.write "<script language='javascript'> "
        response.write "    alert('골프장정보가 삭제 되었습니다.');"
        response.write "    window.location.href='area_detail_infor.asp?nat_cd="&nat_cd&"&city="&city&"&infor_cd=07'; "
        response.write "</script> " 
        response.end
    '#######################################골프장정보#####################################



    Elseif admin_action="nat_make" then   '국가등록
    
        cont_cd = Trim(Request("cont_cd")) '대륙코드 (아시아,유럽등등)
        nm_kor = Trim(Request("nm_kor")) 
        nm_eng = Trim(Request("nm_eng")) 
    
        Sql = "SELECT nat_cd FROM TB_ti100 where nat_cd='"&nat_cd&"' "
        Set Rs = objConn.Execute(sql)
        
        if  not Rs.EOF or  not Rs.BOF then
            '    ClsPop "이미 등록되어 있는 국가정보입니다      ",""
            response.write "<script language='javascript'> "
            response.write "    alert('이미 등록되어 있는 국가정보입니다.');   "
            response.write "    history.back(); "
            response.write "</script> " 
            response.end
        
        else
            objConn.BeginTrans
            cols = " nat_cd, cont_cd, nm_kor, nm_eng, del_yn"
            values = " ('"&nat_cd&"', '"&cont_cd&"', N'"&nm_kor&"',N'"&nm_eng&"','N') "
    
            sql = "INSERT INTO TB_ti100 (" & cols & ") VALUES " & values
            objConn.Execute(sql)
            if Err.number = 0 Then
                objConn.CommitTrans	
            else 
                objConn.RollbackTrans
                CloseF5_DB objConn
                
                response.write "<script language='javascript'> "
                response.write "    alert('등록중 오류가 발생했습니다.'); "
                response.write "    parent.$('#chain_schedule27k').dialog('close'); "
                response.write "</script> " 
                response.end
            end if
    	   
            response.write "<script language='javascript'> "
            response.write "    alert('국가가 등록되었습니다.'); "
            response.write "    parent.location.reload(); "
            response.write "    parent.$('#chain_schedule27k').dialog('close'); "
            response.write "</script> " 
            response.end
            
        end if
        CloseRs Rs
    
    
    Elseif  admin_action="nat_modify" then
        
        nm_kor = Trim(Request("nm_kor")) 
        nm_eng = Trim(Request("nm_eng")) 
       
        objConn.BeginTrans
        sql = "UPDATE TB_ti100 SET nm_kor=N'" & nm_kor & "',nm_eng=N'" & nm_eng & "'"
        sql = sql & " where nat_cd='" & nat_cd&"'"
        objConn.Execute(sql)
      
        if Err.number = 0 Then
            objConn.CommitTrans	
        else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            
            response.write "<script language='javascript'> "
            response.write "    alert('등록중 오류가 발생했습니다.'); "
            response.write "    parent.$('#chain_schedule28k').dialog('close'); "
            response.write "</script> " 
            response.end
        end if
    	
        response.write "<script language='javascript'> "
        response.write "    alert('국가가 수정 되었습니다.'); "
        response.write "    parent.location.reload(); "
        response.write "    parent.$('#chain_schedule28k').dialog('close'); "
        response.write "</script> " 
        response.end
        
        CloseRs Rs
    
    Elseif admin_action="city_make" then   '도시등록
        
        city_cd = Trim(Request("city_cd")) 
        nm_kor = Trim(Request("nm_kor")) 
        nm_eng = Trim(Request("nm_eng")) 
    
        Sql = "SELECT nat_cd FROM TB_ti200 where city_cd='"&city_cd&"' "
        Set Rs = objConn.Execute(sql)
        
        if  not Rs.EOF or  not Rs.BOF then
            response.write "<script language='javascript'> "
            response.write "    alert('이미 등록되어 있는 도시정보입니다.'); "
            response.write "    history.back(); "
            response.write "</script> " 
            response.end
      
        else
            objConn.BeginTrans
            cols = "   nat_cd, city_cd, nm_kor, nm_eng, del_yn"
            values = " ('"&nat_cd&"', '"&city_cd&"', N'"&nm_kor&"',N'"&nm_eng&"','N') "
    
            sql = "INSERT INTO TB_ti200 (" & cols & ") VALUES " & values
            objConn.Execute(sql)
    	 
            if Err.number = 0 Then
                objConn.CommitTrans	
            else 
                objConn.RollbackTrans
                CloseF5_DB objConn
                
                response.write "<script language='javascript'> "
                response.write "    alert('등록중 오류가 발생했습니다.');  "
                response.write "    parent.$('#chain_schedule27k').dialog('close'); "
                response.write "</script> " 
                response.end
            end if
        
            response.write "<script language='javascript'> "
            response.write "    alert('도시가 등록되었습니다'); "
            response.write "    parent.location.reload(); "
            response.write "    parent.$('#chain_schedule27k').dialog('close'); "
            response.write "</script> " 
            response.end
        end if
        
        CloseRs Rs
    
    
    Elseif  admin_action="city_modify" then
    	
        city_cd = Trim(Request("city_cd")) 
        nm_kor = Trim(Request("nm_kor")) 
        nm_eng = Trim(Request("nm_eng")) 
       
        objConn.BeginTrans
        
        sql = "UPDATE TB_ti200 SET nm_kor=N'" & nm_kor & "',nm_eng=N'" & nm_eng & "'"
        sql = sql & " where city_cd='" & city_cd&"'"
        objConn.Execute(sql)
      
        if Err.number = 0 Then
            objConn.CommitTrans	
        else 
            objConn.RollbackTrans
            CloseF5_DB objConn
            response.write "<script language='javascript'> "
            response.write "    alert('등록중 오류가 발생했습니다.'); "
            response.write "    parent.$('#chain_schedule28k').dialog('close'); "
            response.write "</script> " 
            response.end
        end if
    	
        response.write "<script language='javascript'> "
        response.write "    alert('도시가 수정되었습니다'); "
        response.write "    parent.location.reload(); "
        response.write "    parent.$('#chain_schedule28k').dialog('close'); "
        response.write "</script> " 
        response.end      
        
        CloseRs Rs
  
    
    Elseif  admin_action="city_del" then
    
        sql = "delete from TB_ti200 "
        sql = sql & " where nat_cd='" & nat_cd&"' and city_cd='" & city_cd&"' "
        objConn.Execute(sql)
    
        response.write "<script language='javascript'> "
        response.write "    alert('도시가 삭제 되었습니다'); "
        response.write "    parent.location.reload(); "
        response.write "    parent.$('#chain_schedule28k').dialog('close'); "
        response.write "</script> " 
        response.end      
    
        CloseRs Rs
    
    End if
    
    CloseF5_DB objConn
%>

