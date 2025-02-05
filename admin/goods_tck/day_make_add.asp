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
    tbl ="w_tck_day"

    pre_sixmonth = Dateadd("m",-3,cdate(date))
    pre_sixmonth2 = Replace(pre_sixmonth,"-","")
    pre_sixmonth2 = left(pre_sixmonth2,6)
    
    d_sql = "delete from "&tbl&" where  SUBSTRING(day, 1, 6) BETWEEN '201701' AND '"&pre_sixmonth2&"'  "
    objConn.Execute d_sql
    
    s_year  = Request("s_year")
    s_month = Request("s_month")
    s_month = "0"&s_month
    s_month = Right(s_month,2)
    start_day_sec = s_year&"-"&s_month&"-"&"01"


    good_cd = Request("good_cd")
    g_kind = Request("g_kind")

    data_seq = Request("data_seq")
    arr_data = Split(data_seq,",")
    dd_cnt = UBound(arr_data)
    
    mm_seq = Request("mm_seq")   '월 개수
    arr_mm = Split(mm_seq,",")
    mm_cnt = UBound(arr_mm)

    
    yy   = Request("yy")

    dim data_mm()
    Redim data_mm(mm_cnt)

    For ii =0 to mm_cnt
    
        data_mm(ii) = arr_mm(ii)
        data_mm(ii) = Right("0"&data_mm(ii),2)
        mm=data_mm(ii)

        new_ym = yy&mm

        if data_mm(ii) =1 then
            max_day="31"
        elseif data_mm(ii) =2 then
            max_day= m_ed_num(02, yy)
        elseif data_mm(ii) =3 then
            max_day="31"
        elseif data_mm(ii) =4 then
            max_day="30"
        elseif data_mm(ii) =5 then
            max_day="31"
        elseif data_mm(ii) =6 then
            max_day="30"
        elseif data_mm(ii) =7 then
            max_day="31"
        elseif data_mm(ii) =8 then
            max_day="31"
        elseif data_mm(ii) =9 then
            max_day="30"
        elseif data_mm(ii) =10 then
            max_day="31"
        elseif data_mm(ii) =11 then
            max_day="30"
        elseif data_mm(ii) =12 then
            max_day="31"
        end if


        For dd =1 to max_day

            if dd < 10 then
                dd = "0"&dd 
            end if

            For kk =0 to dd_cnt

                data_sp = Split( arr_data(kk),"|")
 
 'response.write data_sp
 
 
                r_seq = data_sp(0)
                'net_price = data_sp(1)
                'u_price   = data_sp(2)
                u_price = data_sp(1)
                         
                arr_price   = split(u_price,"^")
                
                price_1 = arr_price(0)
                price_1 =  Replace(price_1 , "'","''")
                if price_1="" or isnull(price_1) then
                    price_1=0
                end if	
               
                total_man = arr_price(1)
                if total_man="" or isnull(total_man) then
                    total_man=0
                end if	

              
                
                if dd=1 then
                    Sql = "delete from "&tbl&" where substring(day,1,6)='"&new_ym&"' and room_seq='"&r_seq&"'  "
                    objConn.Execute Sql
                end if	

                ins_sql = "INSERT INTO "&tbl&"  ( room_seq,  good_cd     , price_1      , total_man          , day         , magam  ) values "
                ins_sql = ins_sql           &" ( "&r_seq&", "&good_cd& " ,'"&price_1&"' ,'"&total_man&"', '"&new_ym&dd&"' , 'N' ) "
                objConn.Execute ins_sql

            Next

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
    parent.tkt_value('<%=good_cd%>','<%=yy%>','<%=mm%>');
    alert("출발일 상품금액이 생성 되었습니다.");
//-->
</script>

<%
    Function m_ed_num(ss_MM, ss_YY)
    
        selectmonth = ss_MM

        If selectmonth = 4 or selectmonth = 6 or selectmonth = 9 or selectmonth = 11 then
            nummonth = 30
        Elseif selectmonth = 2 then
            if (((ss_YY mod 4 = 0) and (ss_YY mod 100 <> 0)) or (ss_YY mod 400 = 0)) then
                nummonth = 29
            else
                nummonth = 28
            end if
        Else
            nummonth = 31
        End if

        m_ed_num = nummonth

    End Function
%>
