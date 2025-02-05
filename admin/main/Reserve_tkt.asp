
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr height="26" bgcolor="#E7E7EF">
            <td width="11%" class="main_1">예약번호</td>
            <td width="10%" class="main_2">예약자</td>
            <td width="*%" class="main_2">상품명</td>
            <td width="11%" class="main_2">출발일</td>
            <td width="10%" class="main_2">진행현황</td>
            <td width="11%" class="main_2">예약일</td>
        </tr>
        <%
            sql = "select top 10 r.seq, r.good_num, r.reserve_code, r.pc_tp, r.g_kind, r.res_nm, r.add_amt, r.dc_amt, r.prod_cd, r.del_yn, r.ins_dt, r2.opt_day , g.title "
            sql = sql & " from w_res_tck001 AS r INNER JOIN w_res_tckopt AS r2 ON r.reserve_code = r2.reserve_code left outer join trip_gtck g ON r.good_num = g.num "
            sql = sql & " where r.del_yn='N'  and r2.opt_tp = 'F' "
            sql = sql & " ORDER BY reserve_code desc "
            Set Rs = Server.CreateObject("ADODB.RecordSet")
                    
            Rs.open sql , objConn , 3
            If Rs.eof or Rs.bof then
        %>
        <tr>
            <td class="main_bin" colspan="6">등록된 자료가 없습니다</td>
        </tr>
        <%
            Else
            	
                Do Until Rs.EOF

                    r_seq = Rs("seq")
                    good_num = Rs("good_num")
                    reserve_code = Rs("reserve_code")
                    
                    res_nm = Rs("res_nm")
                    prod_cd = Rs("prod_cd")
                    prod_nm = ch_procd_hnm(prod_cd)
                    Select Case prod_cd
                        Case 0 : cls1 ="Acls"
                        Case 1 : cls1 ="Bcls"
                        Case 2 : cls1 ="Ccls"
                        Case 3 : cls1 ="Dcls"
                        Case 4 : cls1 ="Ecls"
                        Case 5 : cls1 ="Fcls"
                        Case 6 : cls1 ="Gcls"
                    End select
                                  
                    g_title = Rs("title")
                    
                    ins_dt = Left(Rs("ins_dt"),10)
                    opt_day = Rs("opt_day")
        %>
        <tr height="26" bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';" style="cursor:pointer;" onclick="location.href='/admin/reserve_tck/reserve_detail.asp?reserve_code=<%=reserve_code%>'">
            <td class="main_3"><span class="<%=cls1%>"><%=reserve_code%></span></td>
            <td class="main_4"><span class="<%=cls1%>"><%=res_nm%></span></td>
            <td class="main_5"><span class="<%=cls1%>"><%=g_title%></span></td>
            <td class="main_4"><span class="<%=cls1%>"><%=ch_changeday(opt_day)%></span></td>
            <td class="main_4"><span class="<%=cls1%>"><%=prod_nm%></span></td>
            <td class="main_4"><span class="<%=cls1%>"><%=ins_dt%></span></td>
        </tr> 
        <%        
                Rs.movenext
                Loop   
            End if
            
            Rs.close : Set Rs = nothing   

        %>
    </table>
