<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/conf/before_url.asp" -->  
<!--#include virtual="/home/inc/cookies2.asp" -->
<!--#include virtual="/home/inc/support.asp" -->
<!--#include virtual="/home/inc/URLTools.asp"-->

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"


    If memid = "" Or pwd = "" Or memnum = ""  Then
        response.write "<script language='javascript'>  "
        Response.write " alert('로그인정보없습니다..'); "
        Response.write " history.back();"
        response.write "</script>                             " 
        response.end
    end if
        
        
    OpenF5_DB objConn  
    

    '#################################
    pc_tp = "P"
    g_kind =  request("g_kind")

     s_ymd =  Request("tmp_day")
    s_ymd2 = Replace(s_ymd,"-","")
    '#################################
    
    good_num =  request("good_num")
    If good_num = "" then
        Response.write "<script language='javascript'>"
        Response.write " alert('상품번호가 없습니다.'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if


    s_day =  request("s_day")
    s_day2=  Replace(s_day,"-","")
    if s_day = "" then
        Response.write "<script language='javascript'>"
        Response.write " alert('선택일자가 없습니다.'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if
    
    opt_seq =  request("opt_seq")
    if opt_seq = "" then
        Response.write "<script language='javascript'>"
        Response.write " alert('선택상품이 없습니다.'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

  
    '#############################################data
    good_data = Request("good_data")
    opt_data = Request("opt_data")

    if good_data="" or isnull(opt_data) then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자 오류1...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

    arr_good_data = split(good_data,"|")

    good_num = arr_good_data(0)
    good_ad_cnt = arr_good_data(1)
    good_ch_cnt = arr_good_data(2)
    good_ba_cnt = arr_good_data(3)
    
    tot_cnt = Cdbl(good_ad_cnt) 


    sql = " Select g.num, g.g_kind,  g.title ,g.eng_title  from trip_gtck g where num="&good_num
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3

    If Rs.eof or Rs.bof then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자전송에러!!...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    Else
        g_kind = Rs("g_kind")
        g_title = Rs("title")
        g_title_eng = Rs("eng_title")
    End if
  
    Rs.close  : Set Rs = nothing


    '-----------------reserve1----------------------------
    res_nm = Trim(Request.form("res_nm") )
    res_nm = Replace(res_nm,"'","''")

    res_nm_eng_f = Trim(Request.form("res_nm_eng_F") )
    res_nm_eng_f = Ucase(res_nm_eng_f)
    res_nm_eng_f = Replace(res_nm_eng_f,"'","''")

    res_nm_eng_L = Trim(Request.form("res_nm_eng_L") )
    res_nm_eng_L = Ucase(res_nm_eng_L)
    res_nm_eng_L = Replace(res_nm_eng_L,"'","''")

    res_hp1 = Request.form("res_hp1") 
    res_hp1 = Replace(res_hp1,"'","")
    res_hp2 = Request.form("res_hp2") 
    res_hp2 = Replace(res_hp2,"'","")
    res_hp3 = Request.form("res_hp3") 
    res_hp3 = Replace(res_hp3,"'","")
    tot_htel = res_hp1&"-"&res_hp2&"-"&res_hp3

    tot_email = Request.form("tot_email") 
    
    d_gender = Request.form("d_gender") 
    d_birth = Request.form("d_birth") 
  
    res_hotel = Request.form("res_hotel") 
    res_hotel = Replace(res_hotel,"'","''")

    res_remark = Request.form("res_remark")
    res_remark = Replace(res_remark,"'","")

    objConn.BeginTrans

    
    '#############################################################################res_cd코드 예약
    Sql = "SELECT MAX(seq) FROM w_res_tck001"
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Set Rs = objConn.Execute(sql)

    If IsNull(Rs(0)) then
        new_num = 1
    Else
        new_num = Rs(0) + 1
    End if

    Rs.close :Set Rs = nothing

    temp_day = Replace(date(),"-","")
    reserve_code = temp_day&new_num


    '#####################################################################상품데이타
    f_sql = " SELECT d.seq, d.room_seq, d.good_cd,  d.price_1, d.day, d.magam ,o.nm_c  from w_tck_day d left outer join  trip_gtck_opt o  on d.room_seq= o.seq "
    f_sql = f_sql&"  where d.room_seq="&opt_seq&" and d.day ='"&s_day2&"'  "

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open f_sql,objConn,3
 
    If Rs.eof or Rs.bof then
        f_price_1 = 0
    Else
         magam = Rs("magam")
        f_price_1 = Rs("price_1")
        f_nm_c = Rs("nm_c")
        nm_c_k = left(f_nm_c,2)
        
        if magam ="Y" then
            f_price_1 = 0
        else
            f_price_1 = f_price_1
        end if
                                	
    End if
%>


<%
  '$$$$$ 일단은 이페이지에서는 필요 없을듯 $$$$$$$$$$$$$$$$
  ' sql =" SELECT  res_nm, tot_htel "  
 '   sql = sql &" FROM  w_res_tckopt "
  '  sql = sql &" WHERE res_nm ='"&res_nm&"' and opt_day ='"&s_ymd&"'  and  tot_htel ='"&tot_htel&"' and substring(opt_nm,1,2) ='"&nm_c_k&"' AND (opt_cancd='N')"
  ' response.write sql 
 ' response.end
    
   ' Set Rs = Server.CreateObject("ADODB.RecordSet")
   ' Rs.open sql,objConn ,3
    
    'If not Rs.eof or not Rs.bof then
     '   Response.write "<script type='text/javascript'>"
     '   Response.write " alert(' 동일시간대 중복예약이 있습니다.'); "
     '   Response.write " history.back();"
     '   Response.write " </script>	 "
     '   Response.end
   ' End if
   ' Rs.close   : Set Rs=nothing


    sql = "SELECT  total_man   FROM w_tck_day WHERE (good_cd = '"&good_num&"')  and (day ='"&s_ymd2&"') and room_seq ='"&opt_seq&"' "
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3

    If Rs.eof then
        op_total_man =0
    Else
        op_total_man = Rs("total_man")
        if op_total_man="" or isnull(op_total_man) then
            op_total_man=0    
        end if

        sql77 = "select  count(1) as op_seq_cnt  from  w_res_tckopt where opt_seq = '"&opt_seq&"' and opt_day= '"&s_ymd&"' AND (opt_cancd='N')"
        Set rs77 = objConn.Execute(sql77)
        op_seq_cnt = Trim(rs77("op_seq_cnt"))
        CloseRs Rs77
        curRestCnt = Int(op_total_man) - Int(op_seq_cnt)
  
        if int(curRestCnt) <= 0 then                               
            Response.write "<script language='javascript'>"
            Response.write " alert('블럭인원초과'); "
            Response.write " history.back();"
            Response.write " </script>	 "
            Response.end
        end if	
    End if
%>


<%
    f_opt_amt_1 =  Cdbl(f_price_1) * 1
    f_opt_amt = Cdbl(f_opt_amt_1) 

    '############################################################################메인 선택
    sql_1 = "INSERT INTO w_res_tckopt (  reserve_code , opt_tp ,good_num , opt_seq  , opt_day    , opt_nm       , opt_ad_cnt        , opt_ad_price , opt_cancd,res_nm,tot_htel) values "
    sql_1 = sql_1&" ( '"&reserve_code&"', 'F' ,'"&good_num&"'   , "&opt_seq&" ,'"&s_day&"', '"&f_nm_c&"', "&good_ad_cnt&"  , '"&f_price_1&"'  ,'N',N'"&res_nm&"','"&tot_htel&"' ) "
    objConn.Execute sql_1
    
    '############################################################################추가 선택
    sql_2 = "INSERT INTO  w_res_tck002 (  reserve_code   , d_age, d_gender,d_nm,d_eng_f,d_eng_L ,d_birth) values "
    sql_2 = sql_2&" ( '"&reserve_code&"' ,'A' ,'"&d_gender&"',N'"&res_nm&"',N'"&res_nm_eng_F&"',N'"&res_nm_eng_L&"','"&d_birth&"' ) "
    objConn.Execute sql_2
 
    '############################################################################################res_amt
    res_amt = Cdbl(f_opt_amt) + Cdbl(tot_opt_amt)
    
    
    '###########################################################################master
    sql_3 = "INSERT INTO  w_res_tck001 (seq, user_id   ,  good_num     , reserve_code        , pc_tp     , g_kind    , res_nm       , res_eng_nm_f     , res_eng_nm_L         , res_hp1     , res_hp2     , res_hp3      , res_email   , res_hotel    ,res_pick_idx ,res_pick_place,res_pick_time   "
    sql_3 = sql_3 & "  , res_remark     ,res_amt  ,add_amt , dc_amt ,prod_cd  ,del_yn )"
    sql_3 = sql_3 & " VALUES ("&new_num&",  '"&memid&"', '"&good_num&"', '"&reserve_code&"', '"&pc_tp&"' ,'"&g_kind&"','"&res_nm&"' , '"&res_nm_eng_F&"' ,'"&res_nm_eng_L&"' ,'"&res_hp1&"','"&res_hp2&"', '"&res_hp3&"', '"&tot_email&"', '"&res_hotel&"', '"&sub_idx&"','"&s_day&"', '"&f_nm_c&"'"
    sql_3 = sql_3 & " , '"&res_remark&"' ,"&res_amt&" ,0      ,0      ,0  ,'N')"

    objConn.Execute sql_3


    sql_4 = "INSERT INTO  TB_save_money (  reserve_code ,  good_num     , opt_seq       , use_money , tot_htel,can_yn) values "
    sql_4 = sql_4&" ( '"&reserve_code&"', '"&good_num&"' ,"&opt_seq&" ,'"&res_amt&"' ,'"&tot_htel&"','N'  ) "

    objConn.Execute sql_4

    If Err.Number <> 0 then 
       objConn.RollbackTrans
%>
    <script type="text/javascript">
    <!--
       alert("예약시 에러가 발생했습니다.\n정확한 데이타를 입력해 주십시오");
       history.back();
    //-->
    </script>
<% 
       Response.end
    Else 

       objConn.CommitTrans
       objConn.close : Set objConn = nothing

    End if
%>

<script type="text/javascript">
<!--
   alert('프로그램 상품이 예약 신청되었습니다.');
   location.href="res_end.asp?g_kind=<%=g_kind%>&res_cd=<%=reserve_code%>";
//-->
</script>