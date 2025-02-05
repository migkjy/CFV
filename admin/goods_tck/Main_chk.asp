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
       
        
    Dim step, cd_type
    
    tp = Ucase(Trim(Request("tp")))
    num  = Trim(Request("num"))
    
    
    sql ="select re_comd  from trip_gtck where num="&num
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql , objConn,3
    
    e_recomd = Rs("re_comd")
    
    Rs.close : Set Rs = nothing
    
    r_home = Left(e_recomd,1)
    r_main = Mid(e_recomd,2,1)
    r_sub  = Right(e_recomd,1)
    
    
    If tp="H" then
        if r_home ="N" then
            r_rev1 ="Y"
        else
            r_rev1 ="N"
        end if
    Else
        r_rev1 =r_home
    End if
    
    If tp="M" then
        if r_main ="N" then
            r_rev2 ="Y"
        else
            r_rev2 ="N"
        end if
    Else
    	 	 r_rev2 =r_main
    End if
     
    If tp="S" then
        if r_sub ="N" then
            r_rev3 ="Y"
        else
            r_rev3 ="N"
        end if
    Else
    	 	 r_rev3 =r_sub
    End if
    
    tot_rev = r_rev1&r_rev2&r_rev3
    
    sql2 =" update trip_gtck set re_comd ='"&tot_rev&"'  where num = "&num
    objConn.Execute(sql2)
    
    objConn.close : SET objConn=nothing
%>