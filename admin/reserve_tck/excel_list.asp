<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Buffer = True
    Response.ContentType = "appllication/vnd.ms-excel"
    Response.CacheControl = "public"
    Response.AddHeader "Content-Disposition","attachment; filename=프로그램 예약관리_"&date()&".xls"
    session.CodePage = 65001
    Response.CharSet = "utf-8" 
    
    %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
	
    <%
    
    
    OpenF5_DB objConn

    if gotopage = "" then gotopage = 1 End if
    if pagesize = "" then pagesize = 2000 End if
    
    
    subSql =""
    nat_cd = Request("nat_cd")
    s_kind  = Request("s_kind")
    s_kind1 = Request("s_kind1")
   ' If s_kind1 ="" then
   '     s_kind1="i"
  '  End if

    s_kind2 = Request("s_kind2")
    s_kind3 = Request("s_kind3")

    stext = Request("stext")
    stext = Replace(stext,"'","")

    start_ymd = Request("start_ymd")
    If start_ymd ="" or isnull(start_ymd) then
        start_ymd = Dateadd("d",-7,cdate(date)) 
    End if

    start_ymd2   = Request("start_ymd2")
    If start_ymd2 ="" or isnull(start_ymd2) then
        start_ymd2 =  Cdate(date) 
    End if


    '##########################################################################################################search
  If s_kind <> "" then
        Select Case s_kind
          Case "10"
              subSql = subSql & " AND convert(varchar(10), r.ins_dt,120) between '"&start_ymd&"'  and '"&start_ymd2&"'  "
              ord_sql = "order by t.seq desc  "
          Case "20"
              subSql = subSql &" and r2.opt_day BETWEEN '"&start_ymd&"' AND  '"&start_ymd2&"' " 
              ord_sql = "order by t.start_ymd asc  "
        End select
    End if
 


    If s_kind1 <> ""  then
       subSql = subSql &" and ( r.prod_cd = '"&s_kind1&"' ) " 
    End if

    If s_kind3 <> ""  then
       subSql = subSql &" and ( r.g_kind = '"&s_kind3&"' ) " 
    End if


   If stext <> "" then
        Select Case s_kind2
            Case "N" 
                subSql = subSql &" and ( r.res_nm like '%" & stext & "%' ) " 
            Case "H"
                subSql = subSql &" and r.res_hp3 like '%" & stext & "%' " 
            Case "R"
                subSql = subSql &" and r.reserve_code like '%" & stext & "%' " 
            Case "G"
                subSql = subSql &" and g.title like '%" & stext & "%' "                     
        End select
    End if


    bet_A = ( (gotopage-1 ) * pagesize ) +1
    if bet_A< 0 then  bet_A=0 end if
    bet_B = ( gotopage * pagesize ) 
                    
    sql = " select * from (        "
    sql = sql & " select Row_number() over(order by r.seq desc) as rownum ,  r.seq , r.good_num, r.reserve_code, r.g_kind , r.pc_tp ,r.res_nm , r.res_eng_nm_f, r.res_eng_nm_L ,r.res_hp1, r.res_hp2, r.res_hp3, r.res_email "
    sql = sql & " ,r.res_amt, r.add_amt , r.dc_amt , r.prod_cd ,r.del_yn, r.ins_dt , r2.opt_day,r2.opt_nm,  g.title   "
    sql = sql & " FROM  w_res_tck001 r inner join w_res_tckopt r2 on r.reserve_code=r2.reserve_code left outer join trip_gtck g ON r.good_num = g.num "
    sql = sql & " WHERE r.del_yn='N' and r2.opt_tp='F'"
    sql = sql& subsql
    sql = sql & " )t "
    sql = sql & " where t.rownum between '"&bet_A&"' and '"&bet_B&"' "
    sql = sql & " order by t.seq desc  "

   ' response.write sql

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3

    If Rs.eof then
        response.write "<table border='1' cellspacing='0' cellpadding='5' bordercolordark='#FFFFFF' bordercolorlight='#000000'>" & vbcrlf
        response.write "    <tr align=center>" & vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>No.</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>예약일</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>예약자</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>인원</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>프로그램 상품명</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>출발일</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>휴대전화번호</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>진행현황</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>결제 포인트</strong></td> "& vbcrlf
        response.write "    </tr>" & vbcrlf
        response.write "    <tr>" & vbcrlf
        response.write "        <td align=center colspan='9' height=400>NO DATA</TD>" & vbcrlf
        response.write "    </tr>" & vbcrlf
        response.write "</table>" & vbcrlf
        response.end
    Else
        response.write "<table border='1' cellspacing='0' cellpadding='5' bordercolordark='#FFFFFF' bordercolorlight='#000000'>" & vbcrlf
        response.write "    <tr align=center>" & vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>No.</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>예약일</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>예약자</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>인원</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>프로그램 상품명</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>출발일</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>휴대전화번호</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>진행현황</strong></td> "& vbcrlf
        response.write "        <td bgcolor=#E7E7EF><strong>결제 포인트</strong></td> "& vbcrlf
        response.write "    </tr>" & vbcrlf

        i=1
        Do until Rs.eof
        	
            seq = Rs("seq")
            good_num = Rs("good_num")
            reserve_code = Rs("reserve_code")
            res_nm = Rs("res_nm")
            res_eng_nm_f = Rs("res_eng_nm_f")
            res_eng_nm_L = Rs("res_eng_nm_L")
                            
            res_hp1 = Rs("res_hp1")
            res_hp2 = Rs("res_hp2")
            res_hp3 = Rs("res_hp3")  
            res_hp = res_hp1&"-"&res_hp2&"-"&res_hp3
                            
            res_email  = Rs("res_email") 
            res_amt = Rs("res_amt")
         
                            
            prod_cd = Rs("prod_cd")
            prod_cd_nm = ch_procd_tnm(prod_cd)
                          
            ins_dt = Left(Rs("ins_dt"),10)
                            
            opt_day = Rs("opt_day")
            opt_nm = Rs("opt_nm")
            '  response.write opt_nm
                             
            title = Rs("title")


        response.write "    <tr>" & vbcrlf
        response.write "        <td align=center>"&i&"</TD>" & vbcrlf
        response.write "        <td align=center>"&ins_dt&"</TD>" & vbcrlf
        response.write "        <td align=center>"&res_nm&"</TD>" & vbcrlf
        response.write "        <td align=center>1명</TD>" & vbcrlf
        response.write "        <td align=left>"&title&"("&opt_nm&")</TD>" & vbcrlf
        response.write "        <td align=center>"&opt_day&"</TD>" & vbcrlf
        response.write "        <td align=center>"&res_hp&"</TD>" & vbcrlf
        response.write "        <td align=center>"&prod_cd_nm&"</TD>" & vbcrlf
        response.write "        <td align=center>"&FormatNumber(res_amt,0)&" CP</TD>" & vbcrlf
        response.write "    </tr>" & vbcrlf

            Rs.MoveNext
            i = i +1

        Loop
        
        response.write " </table>" & vbcrlf
        
    End if

    Rs.close :Set Rs=nothing
    objConn.close : Set objConn = nothing
 %>
</body>
</html>