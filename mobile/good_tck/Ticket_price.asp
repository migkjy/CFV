<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/support.asp"-->

<%
    OpenF5_DB objConn
    
    On Error Resume Next

  
  '###############################################################
   good_num = Request("good_num")
    s_ymd    = Request("s_ymd")
    s_ymd2   = Replace(s_ymd,"-","")

    room_seq = Request("room_seq")
    
    sql = " Select g.num,  g.event_tp, g.g_kind, g.s_area , g.title , g.eng_title , g.good_tip , g.tot_day, g.exchange  "
    sql = sql &" from trip_gtck g where num="&good_num

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3

    If Rs.eof or Rs.bof then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자전송에러!!...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    Else
        title = Rs("title")
        exchange = Rs("exchange")
    End if

    Rs.close :      Set Rs=nothing

    
    '#####################################################################################환율
    sql = "SELECT  price_1 ,total_man   FROM w_tck_day WHERE (good_cd = '"&good_num&"')  and (day ='"&s_ymd2&"') and room_seq ='"&room_seq&"' "
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3

    If Rs.eof then
        op_price1 =0
    Else
        op_price1  = Rs("price_1")
        if op_price1="" or isnull(op_price1) then
            op_price1=0
        end if
      
            
        op_total_man  = Rs("total_man")
        if op_total_man="" or isnull(op_total_man) then
            op_total_man=0    
        end if
      
  
      sql77 = "select  count(1) as op_seq_cnt  from  w_res_tckopt where opt_seq = '"&room_seq&"' and opt_day= '"&s_ymd&"'"
          Set rs77 = objConn.Execute(sql77)
        op_seq_cnt = Trim(rs77("op_seq_cnt"))
        CloseRs Rs77
        currestcnt = Int(op_total_man) - Int(op_seq_cnt)
    End if
    
    tot_price = op_price1&"|"&currestcnt&"|"&op_price3
    'tot_price = op_price1&"|"&currestcnt
  '  tot_price = op_price1
 

    If Err.Number <> 0 then 
        response.write "1"
    Else 
        response.write tot_price
    End if
%>