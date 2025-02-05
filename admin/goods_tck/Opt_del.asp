<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%

    OpenF5_DB objConn

    On Error Resume Next

    good_num = Request("good_num")
    
    del_seq = Request("seq")
    gubun = Request("gubun")

    If gubun="10" then

        sql = " update trip_gtck_opt set del_yn='Y' where seq="&del_seq
        objConn.Execute(sql)

        '###################################################################출발일까지 삭제
        sql2 = "	delete from w_tck_day where room_seq="&del_seq
        objConn.Execute(sql2)


        '###################################################################마감일까지 삭제
        '마감일자 전체 체크
        d_sql =  "delete from  trip_gtck_daychk WHERE (good_cd = '"&good_num&"') "
        objConn.Execute(d_sql)

        min_day = Left(now(),8)

        'sql = "SELECT  room_seq, day FROM w_tck_day WHERE (good_cd = '"&good_cd&"') AND (magam = 'Y') GROUP BY room_seq, day"
        sql = "SELECT  day FROM w_tck_day WHERE (good_cd = '"&good_num&"') AND (magam = 'Y') and (day>='"&min_day&"')  GROUP BY day "
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql,objConn,3

        If Rs.eof then
        Else

            do until Rs.eof
 
                d_day = Rs("day")
                
                ins_sql = "insert into trip_gtck_daychk (good_cd, day) values "
                ins_sql = ins_sql & " ( '" & good_num & "' , '" & d_day& "' )"

                objConn.Execute(ins_sql)

                Rs.movenext
            Loop

        End if


    Elseif gubun="20" then
        sql = "	update trip_gtck_opt set del_yn='Y' where seq="&del_seq
        objConn.Execute(sql)


    Elseif gubun="30" then
        sql = "	update trip_gtck_sub set del_yn='Y' where idx="&del_seq
        objConn.Execute(sql)

    End if
       
    objConn.close   : Set objConn = Nothing


    If Err.Number <> 0 then 
        response.write "1"
    Else 
        response.write "0"
    End if
%>