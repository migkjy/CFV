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
    s_year  = Request("s_year")
    s_month = Request("s_month")
    s_month = "0"&s_month
    s_month = Right(s_month,2)
    start_day_sec = s_year&"-"&s_month&"-"&"01"


    good_cd = Request("good_cd")
    data_seq = Request("data_seq")
    
    arr_data = Split(data_seq,",")
    dd_cnt = UBound(arr_data)


    yy = Request("yy")
    mm_seq = Request("mm_seq")
    arr_mm = Split(mm_seq,",")
    mm_cnt = UBound(arr_mm)
 

    dim data_mm()
    Redim data_mm(mm_cnt)

    For ii =0 to mm_cnt
    
        data_mm(ii) = arr_mm(ii)
        data_mm(ii) = Right("0"&data_mm(ii),2)
        mm=data_mm(ii)

        new_ym = yy&mm

            For kk =0 to dd_cnt
            
                sql2 = "delete from w_tck_day where substring(day,1,6)='"&new_ym&"' and room_seq='"&arr_data(kk)&"'  "
                objConn.Execute sql2
                
            Next
            
    Next

    Select case mm
        case "01","02" : ss_mm ="01"
        case "03","04" : ss_mm ="03"
        case "05","06" : ss_mm ="05"
        case "07","08" : ss_mm ="07"
        case "09","10" : ss_mm ="09"
        case "11","12" : ss_mm ="11"
    End select
%>

<script>
<!--
    parent.tkt_value('<%=good_cd%>','<%=yy%>','<%=ss_mm%>');
    alert("출발일 상품금액이 삭제 되었습니다.");
    parent.location.reload();
    parent.$('#chain_day_cost').dialog('close');
//-->
</script>

<%
    Function ch_changeday(byval s_procd)
    
        If Len(s_procd)=8 then
            s_change_day = Left(s_procd,4)&"-"&Mid(s_procd,5,2)&"-"&Right(s_procd,2)
        Else
            s_change_day = s_procd
        End if
	
        ch_changeday = s_change_day

    End Function   
%>
    