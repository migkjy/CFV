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
    
    
    On Error Resume Next 

    Dim reserve_code, memer_cnt

    reserve_code  = Request("reserve_code")
    If reserve_code = ""  then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('주요인자 전송에러...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

    idx = Request("idx")
    If idx = ""  then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('주요인자 전송에러...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

    start_ymd  = Request("start_ymd") 
    start_ymd2 = Request("start_ymd2") 

    gotopage   = Request("gotopage")
    s_kind     = Request("s_kind")
    s_kind1    = Request("s_kind1")
    s_kind2    = Request("s_kind2")


    objConn.BeginTrans

    del_sql ="delete from w_res_tck002 where idx = '"&idx&"' "
    objConn.Execute del_sql

    '인원
    sql ="SELECT  idx, reserve_code, d_age, d_gender, d_nm FROM w_res_tck002 WHERE (reserve_code = '"&reserve_code&"')"
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql , objConn , 3

    If Rs.eof then
    Else

        Do until Rs.eof 
            
            d_age = Ucase(Rs("d_age"))

            if d_age ="A" then
                ad_cnt = ad_cnt + 1
           
            end if

        Rs.movenext
        loop
    End if


    If ad_cnt="" then
        ad_cnt=0
    End if
       
    If ch_cnt="" then
        ch_cnt=0
    End if
       
    If ba_cnt="" then
        ba_cnt=0
    End if



    '필수선택
    p_sql ="select opt_ad_price ,opt_ch_price , opt_ba_price FROM w_res_tckopt where reserve_code ='"&reserve_code&"' "
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open p_sql , objConn , 3

    If Rs.eof then
        Response.write "<script type='text/javascript'>"
        Response.write " alert(' 예약된내용이 없습니다.'); "
        Response.write " location.reload();"
        Response.write " </script>	 "
        Response.end
    Else
        ad_price =Rs("opt_ad_price")
        ch_price =Rs("opt_ch_price")
        ba_price =Rs("opt_ba_price")
    End if

    Rs.close : Set Rs=nothing

    s_per_ad_amt = Cdbl(s_ad_cnt ) * Cdbl(s_ad_price)


    s_per_amt  = Cdbl(s_per_ad_amt )
    ss_amt = Cdbl(s_per_amt)



    '추가선택
    opt_amt =0
    
    s_sql =" SELECT num, reserve_code, opt_seq ,opt_day, opt_nm, opt_ad_cnt, opt_ad_price  "
    s_sql = s_sql &" from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N') and opt_tp='S'"

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open s_sql,objConn ,3
    
    If Rs.eof or Rs.bof then
    Else
    	
        do until Rs.eof 

            o_ad_cnt   = Rs("opt_ad_cnt")
            o_ad_price = Rs("opt_ad_price")

            o_ba_price = Rs("opt_ba_price")

            o_per_ad_amt = Cdbl(o_ad_cnt ) * Cdbl(o_ad_price)
          

            o_per_amt  =  Cdbl(o_per_ad_amt ) 
            opt_amt    =  Cdbl(opt_amt) +  Cdbl(o_per_amt) 

        Rs.movenext
        Loop
    End if
 

    '판매금액
    res_amt = Cdbl(ss_amt) +  Cdbl(opt_amt) 

    o_sql = "update  w_res_tckopt  set opt_ad_cnt ="&ad_cnt&"  where reserve_code = '"&reserve_code&"'  and opt_tp='F' "
    objConn.Execute(o_sql)

    sql = " UPDATE w_res_tck001 Set res_amt='"&res_amt&"' where reserve_code='"&reserve_code&"' "
    objConn.Execute sql
    
    
    If Err.Number <> 0 then 
        objConn.RollbackTrans
%>
    <script type="text/javascript">
    <!--
        alert("에러가 발생했습니다.\n정확한 데이타를 입력해 주시기 바랍니다.");
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
        alert("여행자가 삭제 되었습니다");
        location.href="reserve_detail.asp?reserve_code=<%=reserve_code%>";
    //-->
    </script>

<% End if %>