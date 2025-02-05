<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->


<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    OpenF5_DB objConn
    
     pc_tp   = "P"

    good_num =  Request("good_num")
    If good_num = "" then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자오류'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

       
    g_kind  =  Request("g_kind")
    s_ymd   =  Request("tmp_day")
    s_ymd2   = Replace(s_ymd,"-","")
    
    tot_opt_seq   =  Request("tot_opt_seq")
    all_good_data =  Request("all_good_data")
    all_opt_data  =  Request("all_opt_data")

    sub_time  = Request("sub_time")
       

    sql = " SELECT title,exchange  from trip_gtck where num=" &good_num&"  and del_yn='N' ORDER BY num DESC "
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql , objConn , 3
    If Rs.eof or Rs.bof then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자오류'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    Else
        r_title  = Rs("title")
        exchange = Rs("exchange")
    End if
    Rs.close : Set Rs = Nothing
     

    '예약자
    res_nm    = Trim(Request.form("res_nm") )
    res_nm   = Replace(res_nm,"'","''")

    res_nm_eng_f  = Trim(Request.form("res_nm_eng_F") )
    res_nm_eng_f = Ucase(res_nm_eng_f)
    res_nm_eng_f = Replace(res_nm_eng_f,"'","''")

    res_nm_eng_L  = Trim(Request.form("res_nm_eng_L") )
    res_nm_eng_L = Ucase(res_nm_eng_L)
    res_nm_eng_L = Replace(res_nm_eng_L,"'","''")

    res_hp1    = Request.form("res_hp1") 
    res_hp1    = Replace(res_hp1,"'","")
    res_hp2    = Request.form("res_hp2") 
    res_hp2    = Replace(res_hp2,"'","")
    res_hp3    = Request.form("res_hp3") 
    res_hp3    = Replace(res_hp3,"'","")
    tot_htel    = res_hp1&"-"&res_hp2&"-"&res_hp3


    emailhead   = Request.form("emailhead") 
    emaildomain = Request.form("emaildomain")
    tot_email   = emailhead&"@"&emaildomain

    res_hotel   = Request.form("res_hotel") 
    res_hotel = Replace(res_hotel,"'","''")


    objConn.BeginTrans
    
    Sql = "SELECT MAX(seq) FROM w_res_tck001"
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Set Rs = objConn.Execute(sql)

    If IsNull(Rs(0)) then
        new_num = 1
    Else
        new_num = Rs(0) + 1
    End if

    Rs.close :Set Rs = nothing

    temp_day     = Replace(date(),"-","")
    reserve_code = temp_day&new_num


    arr_good_data = split(all_good_data,"|")

'response.write arr_good_data

    'good_num    = arr_good_data(0)
    'good_ad_cnt = arr_good_data(1)
   ' good_ch_cnt = arr_good_data(2)
  '  good_ba_cnt = arr_good_data(3)
 

    sql = " SELECT seq, good_cd, nm_c  from trip_gtck_opt s2 where s2.seq="&tot_opt_seq&" and sub_tp='F' order by seq asc "
  ' response.write sql
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3

    If Rs.eof or Rs.bof then
    Else
        seq     = Rs("seq")
        nm_c    = trim(Rs("nm_c"))
        nm_c_k    = left(nm_c,2)
    End if




    sql =" SELECT  res_nm, tot_htel "  
    sql = sql &" FROM  w_res_tckopt "
    sql = sql &" WHERE res_nm ='"&res_nm&"' and opt_day ='"&s_ymd&"'  and  tot_htel ='"&tot_htel&"' and substring(opt_nm,1,2) ='"&nm_c_k&"' AND (opt_cancd='N')"
  ' response.write sql 
 ' response.end
    
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3
    
    If not Rs.eof or not Rs.bof then
        Response.write "<script type='text/javascript'>"
        Response.write " alert(' 동일시간대 중복예약이 있습니다.'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if
    Rs.close   : Set Rs=nothing


  sql = "SELECT  price_1 ,total_man   FROM w_tck_day WHERE (good_cd = '"&good_num&"')  and (day ='"&s_ymd2&"') and room_seq ='"&tot_opt_seq&"' "
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3

    If Rs.eof then
        op_price1 =0

    Else
        price_1  = Rs("price_1")
        if price_1="" or isnull(op_price1) then
            price_1=0
        end if
      
            
        op_total_man  = Rs("total_man")
        if op_total_man="" or isnull(op_total_man) then
            op_total_man=0    
        end if
      
  
      sql77 = "select  count(1) as op_seq_cnt  from  w_res_tckopt where opt_seq = '"&tot_opt_seq&"' and opt_day= '"&s_ymd&"' AND (opt_cancd='N')"
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


    f_opt_amt_1  = Cdbl(price_1) 

    f_opt_amt    = Cdbl(f_opt_amt_1)
 
    
    '필수선택
    sql_1 = "INSERT INTO w_res_tckopt (  reserve_code , opt_tp , good_num     , opt_seq       , opt_day    , opt_nm    , opt_ad_cnt     , opt_ad_price     ,opt_cancd,res_nm,tot_htel) values "
    sql_1 = sql_1&"              ( '"&reserve_code&"', 'F'    ,'"&good_num&"' ,"&tot_opt_seq&" ,'"&s_ymd&"', N'"&nm_c&"',' 1', '"&price_1&"'  ,'N',N'"&res_nm&"','"&tot_htel&"'  ) "
    ' response.write sql_1
    'response.end
    objConn.Execute sql_1

    '상품금액
    res_amt = Cdbl(f_opt_amt) 

    '인원
  
        sql_2 = "INSERT INTO  w_res_tck002 (  reserve_code   , d_age, d_gender,d_nm,d_eng_f,d_eng_L ) values "
        sql_2 = sql_2&" ( '"&reserve_code&"' ,'A' ,'M',N'"&res_nm&"',N'"&res_nm_eng_F&"',N'"&res_nm_eng_L&"' ) "
        objConn.Execute sql_2

   
    'master
    sql_3 = "INSERT INTO  w_res_tck001 (seq, user_id   ,  good_num     , reserve_code        , pc_tp     , g_kind    , res_nm       , res_eng_nm_f     , res_eng_nm_L         , res_hp1     , res_hp2     , res_hp3      , res_email   , res_hotel    ,res_pick_idx ,res_pick_time"
    sql_3 = sql_3 & "  , res_remark     ,res_amt  ,add_amt , dc_amt ,prod_cd  ,del_yn )"
    sql_3 = sql_3 & " VALUES ("&new_num&",  N'"&memid&"', '"&good_num&"', '"&reserve_code&"', '"&pc_tp&"' ,'"&g_kind&"',N'"&res_nm&"' , N'"&res_nm_eng_F&"' ,N'"&res_nm_eng_L&"' ,'"&res_hp1&"','"&res_hp2&"', '"&res_hp3&"', N'"&tot_email&"', N'"&res_hotel&"', '"&sub_time&"', N'"&nm_sub&"'"
    sql_3 = sql_3 & " , N'"&res_remark&"' ,"&res_amt&" ,0      ,0      ,0  ,'N')"
    objConn.Execute sql_3



    sql_4 = "INSERT INTO  TB_save_money (  reserve_code ,  good_num     , opt_seq       , use_money , can_yn) values "
    sql_4 = sql_4&"              ( '"&reserve_code&"', '"&good_num&"' ,"&tot_opt_seq&" ,'"&res_amt&"' ,'N'  ) "

    objConn.Execute sql_4


    If Err.Number <> 0 then 
            
        objConn.RollbackTrans
%>
        <script type="text/javascript">
        <!--
            alert("예약시 에러가 발생했습니다.\n 정확한 데이타를 입력해 주십시오");
            history.back();
        //-->
        </script>
<% 
    Else 

        objConn.CommitTrans
        objConn.close : Set objConn = nothing
%>
        <script type="text/javascript">
        <!--
            alert('예약이 신청되었습니다.');
            location.href="/admin/reserve_tck/reserve_detail.asp?reserve_code=<%=reserve_code%>";
        //-->
        </script>
<%
    End if
%>