<%
    '##################################################################################################
    intApart = Trim(Request("intApart"))
    intBpart = Trim(Request("intBpart"))
    intCpart = Trim(Request("intCpart"))
    intDpart = Trim(Request("intDpart"))
    ts = Trim(Request("ts"))
    
    
    if intApart="" then
    	intApart=0
    end if
    if intBpart="" then
    	intBpart=0
    end if
    if intCpart="" then
    	intCpart=0
    end if
     if intDpart="" then
    	intDpart=0
    end if   
    
    strApart = Trim(Request("strApart"))
    strBpart = Trim(Request("strBpart"))
    strCpart = Trim(Request("strCpart"))
    strDpart = Trim(Request("strDpart"))
    goodsNum = Trim(Request("goodsNum"))
    
    '네비게이션 초기화
    A_navi="no"
    B_navi="no"
    C_navi="no"
    D_navi="no"

    OpenF5_DB objConn '데이타베이스 오픈
    'Apart 설정
    if intApart=0 and strApart="" then
	
        if goodsNum <>"" then
            sql = "select ref_a, ref_b, ref_c, ref_d from TB_goods_new where num = "&goodsNum
            Set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sql,objConn,3
            
            If not Rs.eof or not Rs.bof then
        		tb_part_a_num = Rs("ref_a")
            	tb_part_b_num = Rs("ref_b")
            	tb_part_c_num = Rs("ref_c")
            	tb_part_d_num = Rs("ref_d")
            	
            	sql = "select A_code,A_codename  from TB_part_A where num = " & tb_part_a_num
            	Set Rs_a = objConn.Execute(sql)
            	    if not Rs_a.EOF or not Rs_a.BOF then
            	        strApart=Rs_a(0)
            	        A_navi=Rs_a(1)
            	    end if
           CloseRs Rs_a
            	
            	sql = "select b_code,B_codename  from TB_part_b where num = " & tb_part_b_num
            	Set Rs_b = objConn.Execute(sql)
            	    if not Rs_b.EOF or not Rs_b.BOF then
            	        strBpart=Rs_b(0)
            	        B_navi=Rs_b(1)
            	    end if
            	CloseRs Rs_b
        
            	sql = "select c_code,C_codename  from TB_part_c where num = " & tb_part_c_num
            	Set Rs_c = objConn.Execute(sql)
            	    if not Rs_c.EOF or not Rs_c.BOF then
            	        strCpart=Rs_c(0)
            	        C_navi=Rs_c(1)
            	    end if
            CloseRs Rs_c
            	
            	sql = "select d_code,d_codename  from TB_part_d where num = " & tb_part_d_num
            	Set Rs_d = objConn.Execute(sql)
            	    if not Rs_d.EOF or not Rs_d.BOF then
            	        strDpart=Rs_d(0)
            	        D_navi=Rs_d(1)
            	    end if
            	    CloseRs Rs_d
            	
                      
            End If '디비
    CloseRs Rs
        end if	'goodsNum
    
        if ts="goods_list_search" then
	        A_navi="상품검색"
        end if	
	
        elseif strApart<>"" then
            sql = "select num, A_codename from TB_part_A where A_code = '" & strApart & "'"
            Set Rs = objConn.Execute(sql)
                if Rs.EOF or Rs.BOF then
		            strApart="H"
		            intApart= 21		
                else
		            intApart=Rs(0)
		            A_navi=Rs(1)
                end if
    CloseRs Rs

        elseif intApart<>0 then
            sql = "select A_code, A_codename from TB_part_A where num = " & intApart
            Set Rs = objConn.Execute(sql)
                if Rs.EOF or Rs.BOF then
                    strApart="H"
                    A_navi="상품검색"
                else
                    strApart=Rs(0)
                    A_navi=Rs(1)
                end if
      CloseRs Rs
        end if
	
    'Bpart 설정
    if intBpart=0 and strBpart="" then
    	strBpart="01"
    	B_navi="칸쿤"

    elseif strBpart<>"" then
        sql = "select num, B_codename from TB_part_B where B_code = '" & strBpart & "' and ref_A=" & intApart
        Set Rs = objConn.Execute(sql)
            if Rs.EOF or Rs.BOF then
                strBpart="01"
                intBpart=101		
            else
                intBpart=Rs(0)
                B_navi=Rs(1)
            end if
      CloseRs Rs
    
    elseif intBpart<>0 then
        sql = "select B_code, B_codename from TB_part_B where num = " & intBpart
        Set Rs = objConn.Execute(sql)
            if Rs.EOF or Rs.BOF then
                strBpart="01"
                B_navi="검색결과"
            else
                strBpart=Rs(0)
                B_navi=Rs(1)
            end if
    CloseRs Rs
    end if	

    'Cpart 설정
    if intCpart=0 and strCpart="" then
    	strCpart="1"
    	C_navi="칸쿤"
    
    elseif strCpart<>"" then
        sql = "select num, C_codename from TB_part_C where C_code = '" & strCpart & "' and ref_A=" & intApart
        Set Rs = objConn.Execute(sql)
            if Rs.EOF or Rs.BOF then
                strCpart="1"
                intCpart= 251		
            else
                intCpart=Rs(0)
                C_navi=Rs(1)
            end if
      CloseRs Rs
        
    elseif intCpart<>0 then
        sql = "select C_code, C_codename from TB_part_C where num = " & intCpart
        Set Rs = objConn.Execute(sql)
            if Rs.EOF or Rs.BOF then
                strCpart="1"
                C_navi="칸쿤"
            else
                strCpart=Rs(0)
                C_navi=Rs(1)
            end if
     CloseRs Rs
        
        
  elseif strDpart<>"" then
        sql = "select num, D_codename from TB_part_D where D_code = '" & strDpart & "' and ref_A=" & intApart
        Set Rs = objConn.Execute(sql)
            if Rs.EOF or Rs.BOF then
                strDpart="1"
                intDpart= 251		
            else
                intDpart=Rs(0)
                D_navi=Rs(1)
            end if
       CloseRs Rs
        
    elseif intDpart<>0 then
        sql = "select D_code, D_codename from TB_part_D where num = " & intDpart
        Set Rs = objConn.Execute(sql)
            if Rs.EOF or Rs.BOF then
                strDpart="1"
                D_navi="칸쿤"
            else
                strDpart=Rs(0)
                D_navi=Rs(1)
            end if
    CloseRs Rs
        
                
    
    end if	
    
    CloseF5_DB objConn '데이타베이스 클로즈
%>