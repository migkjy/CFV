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
    tbl  = "w_tck_day"

    g_kind = Request("g_kind")
    ss_yy = Request("ss_yy")
    ss_mm = Request("ss_mm")
    gotopage  = Request("gotopage")
    
    good_cd = Request("good_cd")
    If good_cd="" or isnull(good_cd) then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자 오류...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

    s_tp = Request("s_tp")
    If s_tp="" or isnull(s_tp) then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자 오류...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if
    

    '#################################################################################################################################'//가격셋팅
    If s_tp="D" then '삭제
    	
        chk_seq = Request("checkedcard")
        
       ' response.write chk_seq
        
        arr_chk_seq = split(chk_seq,",")  


        For i=0 to ubound(arr_chk_seq)
        
       ' response.write arr_chk_seq(i)
        
            sql =" delete from  "&tbl&" where seq='"&Trim(arr_chk_seq(i))&"' "
      '  response.write sql &"<br>"
     ' response.end
            objConn.Execute(sql)
            
        Next
   
    Elseif  s_tp="U" then '수정

        opt_seq = Request("opt_seq")
        arr_seq = split(opt_seq,",")

        d_price_1 = Request("d_price_1")
        arr_price1 = split(d_price_1,",")
      
        d_total_man = Request("d_total_man")
        arr_total_man = split(d_total_man,",")


        For i=0 to ubound(arr_seq)
        
            price_1 = Trim(arr_price1(i))
            if price_1 ="" then
                price_1=0
            end if

            total_man = Trim(arr_total_man(i))
            if total_man ="" then
                total_man=0
            end if
           
    
            
            sql =" update "&tbl&" set magam='N',price_1 ="&price_1&" ,total_man ="&total_man&"  where  seq='"&Trim(arr_seq(i))&"' "
            objConn.Execute(sql)
           
        Next
       
    Elseif  s_tp="M" then '마감

        chk_seq = Request("chk_seq")
        arr_chk_seq = split(chk_seq,",")

        r_seq = Request("r_seq")
        arr_r_seq = split(r_seq,",")  

        For i=0 to ubound(arr_chk_seq)

            sql =" update "&tbl&" set magam='N' where seq='"&Trim(arr_chk_seq(i))&"' "
            objConn.Execute(sql)

        Next


        For j=0 to ubound(arr_r_seq)

            arr_chk_seq  = split(arr_r_seq(j),"|")
            chk_seq = arr_chk_seq(0)
            room_seq = arr_chk_seq(1)
        
            sql =" update "&tbl&" set magam='Y' where seq='"&Trim(chk_seq)&"' "
            objConn.Execute(sql)

        Next


        '마감일자 전체 체크
        d_sql =  "delete from  trip_gtck_daychk WHERE (good_cd = '"&good_cd&"') "
        objConn.Execute(d_sql)

        min_day = Left(now(),8)

        sql = "SELECT  day FROM w_tck_day WHERE (good_cd = '"&good_cd&"') AND (magam = 'Y') and (day>='"&min_day&"') GROUP BY day"
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql,objConn,3
        
        if Rs.eof then
        else

            do until Rs.eof

                d_day      = Rs("day")
                ins_sql =  "insert into trip_gtck_daychk (good_cd, day ) values "
                ins_sql = ins_sql      & " ( '" & good_cd & "' , '" & d_day& "' )"
                objConn.Execute(ins_sql)

               Rs.movenext
            Loop

        end if

    End if

    objConn.close   : Set objConn = nothing


    Select case ss_mm
        case "01","02" : ss_mm ="01"
        case "03","04" : ss_mm ="03"
        case "05","06" : ss_mm ="05"
        case "07","08" : ss_mm ="07"
        case "09","10" : ss_mm ="09"
        case "11","12" : ss_mm ="11"
    End select
%>
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>

<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
<script language=Javascript>
<!--
    parent.location.href="day_make.asp?&g_kind=<%=g_kind%>&good_cd=<%=good_cd%>&ss_yy=<%=ss_yy%>&ss_mm=<%=ss_mm%>&gotopage=<%=gotopage%>";
    parent.$('#chain_day_cost').dialog('close');
//-->
</script>