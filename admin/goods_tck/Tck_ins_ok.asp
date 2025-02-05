<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    Server.ScriptTimeOut = 1000000
    Response.buffer = true

    OpenF5_DB objConn
    
    
    Dim tbl ,file_path
    Dim remark1  ,remark2  ,remark3  ,remark4  
    Dim emp_nm, emp_ph,emp_email

    Dim ImgFile_Nm  ,arrTFile_Size 
    Dim OldFileName , OldName  ,Ext  ,NewFileName ,strWidth  ,strHeight ,real_filenm ,real_filenm2 

    dim    a_num, a_nm_c , a_price, a_total_man


    gotopage = Request("gotopage")
    s_cont = Request("s_cont")
    cont = Request("cont")
    
    g_kind = Request("g_kind")
    If g_kind=""  or  isnull(g_kind) then
        Response.write "<script language='javascript'>"
        Response.write " alert('카테고리가 없습니다.'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End If
 
     
    num = Request("num")
    s_tp = Request("s_tp")
    
    event_tp  = Request("event_tp")
    
    title = Request("title")
    title = check_html(title)

    sub_cd  = Request("sub_cd")

    '출발일 //환율
    day_0 = Request("day_0")
    if day_0="0" then
        day_0="Y"
    else
        day_0="N"
    end if
    
    day_1 = Request("day_1")
    if day_1="1" then
        day_1="Y"
    else
        day_1="N"
    end if
    
    day_2 = Request("day_2")
    if day_2="2" then
        day_2="Y"
    else
        day_2="N"
    end if

    day_3 = Request("day_3")
    if day_3="3" then
        day_3="Y"
    else
        day_3="N"
    end if
    
    day_4 = Request("day_4")
    if day_4="4" then
        day_4="Y"
    else
        day_4="N"
    end if

    day_5 = Request("day_5")
    if day_5="5" then
        day_5="Y"
    else
        day_5="N"
    end if
    
    day_6 = Request("day_6")
    if day_6="6" then
        day_6="Y"
    else
        day_6="N"
    end if

    tot_day = day_0&day_1&day_2&day_3&day_4&day_5&day_6&day_7
    
    exchange = Request("exchange")
     
    t_use = Request("t_use")


    good_tip = Request("good_tip")
    good_tip = Replace(good_tip,",",",,")

    eng_title = Request("eng_title")
    eng_title = check_html(eng_title)
 
    emp_nm = Request("emp_nm")
    emp_email  = Request("emp_email")

    ir_1 = Request("ir_1")
    ir_1 = Replace(ir_1,"'","''")
    ir_2 = Request("ir_2")
    ir_2 = Replace(ir_2,"'","''")
    ir_3 = Request("ir_3")
    ir_3 = Replace(ir_3,"'","''")
    ir_4 = Request("ir_4")
    ir_4 = Replace(ir_4,"'","''")
 
    objConn.BeginTrans

    If num = "" then

         msg = "등록 되었습니다."

         cnt = Request("add_price").Count

         Redim  u_num(cnt), u_nm(cnt) , u_price(cnt) , u_total_man(cnt)  ,  u_sunseo(cnt) , u_useyn(cnt) 

         Sql = "SELECT MAX(num) FROM trip_gtck"
         Set Rs = Server.CreateObject("ADODB.RecordSet")
         Rs.open sql , objConn,3

         if isnull(Rs(0)) then
             n_num = 1000
         else
             n_num = rs(0) + 1
         end if
         Rs.close :	Set Rs = Nothing

         Sql2 = "INSERT INTO trip_gtck (    num, event_tp,  title, eng_title , good_tip , g_kind , s_area , tot_day , exchange   , t_use , remark1  , remark2    , remark3  , remark4    "
         Sql2 = Sql2 &"   , emp_nm,   emp_email, sunseo, re_comd, m_comd, del_yn, ins_dt ) VALUES "
         Sql2 = Sql2 &" (     "&n_num&", '"&event_tp&"',N'"&title&"',N'"&eng_title&"',N'"&good_tip&"','"&g_kind&"','"&sub_cd&"', '"&tot_day&"','"&exchange&"','"&t_use&"', N'"&ir_1&"',N'"&ir_2&"',N'"&ir_3&"',N'"&ir_4&"' "
         Sql2 = Sql2 &"   ,  N'"&emp_nm&"',  N'"&emp_email&"' ,0, 'NNN', 'N' , 'N' , getdate()  )"

         objConn.Execute Sql2


         For i = 1 To cnt

             u_nm(i)  =  Request("add_nm_c")(i)
             u_nm(i)  =  Replace(u_nm(i) , "'","''")

             u_price(i)  =  Request("add_price")(i)
             u_price(i)  =  Replace(u_price(i) , "'","''")
             if u_price(i)="" or isnull(u_price(i)) then
                 u_price(i)=0
             end if	

             u_total_man(i)  =  Request("add_total_man")(i)
             u_total_man(i)  =  Replace(u_total_man(i) , "'","''")
             if u_total_man(i)="" or isnull(u_total_man(i)) then
                 u_total_man(i)=0
             end if	

           

             u_sunseo(i)  =  Request("add_sunseo")(i)
             u_useyn(i)  =  Request("add_useyn")(i)

             ins_sql = "INSERT INTO  trip_gtck_opt ( good_cd ,   nm_c    ,  price         , total_man                , sub_tp  ,sunseo       ,  use_yn       ,nat_cd ) values "
             ins_sql = ins_sql             &" ( '"&n_num&"', N'"&u_nm(i)&"', '"&u_price(i)&"' ,  '"&u_total_man(i)&"' , 'F','"&u_sunseo(i)&"','"&u_useyn(i)&"' ,'"&nat_cd&"') "

             objConn.Execute ins_sql

         Next


      

     Else

         msg = "수정 되었습니다."

         sql = "Update trip_gtck  Set title=N'"&title&"' , eng_title =N'"&eng_title&"' , good_tip =N'"&good_tip&"', event_tp ='"&event_tp&"' "
         sql = sql &" , g_kind='"&g_kind&"'  , s_area='"&sub_cd&"'  "
     
         sql = sql &" , tot_day='"&tot_day&"'  "
         sql = sql &" , exchange='"&exchange&"' , t_use='"&t_use&"' "
 
         sql = sql &" , emp_nm=N'"&emp_nm&"'  "
         sql = sql &" , emp_email=N'"&emp_email&"'  "
 
         sql = sql & " ,remark1= N'"&ir_1&"'  "
         sql = sql & " ,remark2= N'"&ir_2&"'  "
         sql = sql & " ,remark3= N'"&ir_3&"'  "
         sql = sql & " ,remark4= N'"&ir_4&"'  "
         sql = sql &" where num="&num
 
         objConn.Execute(sql)

         cnt = Request("add_price").Count

         Redim  u_num(cnt), u_nm(cnt) , u_price(cnt),   u_total_man(cnt),  u_sunseo(cnt),u_useyn(cnt)
     
         For i = 1 To cnt
     
             u_nm(i)  =  Request("add_nm_c")(i)
             u_nm(i)  =  Replace(u_nm(i) , "'","''")
     
             u_price(i)  =  Request("add_price")(i)
             u_price(i)  =  Replace(u_price(i) , "'","''")
             if u_price(i)="" or isnull(u_price(i)) then
                 u_price(i)=0
             end if
      
             u_total_man(i)  =  Request("add_total_man")(i)
             u_total_man(i)  =  Replace(u_total_man(i) , "'","''")
             if  u_total_man(i)="" or isnull(u_total_man(i)) then
                  u_total_man(i)=0
             end if
      
        
             
             u_num(i) = Request("o_num")(i)
             u_sunseo(i) =  Request("add_sunseo")(i)
             u_useyn(i) =  Request("add_useyn")(i)


             if u_num(i)="" then
                 ins_sql = "INSERT INTO  trip_gtck_opt ( good_cd ,   nm_c  ,  price        , total_man               ,  sub_tp  ,sunseo         ,  use_yn     ,  nat_cd) values "
                 ins_sql = ins_sql             &" ( "&num&", N'"&u_nm(i)&"', "&u_price(i)&" ,  "&u_total_man(i)&" ,   'F'   ,'"&u_sunseo(i)&"','"& u_useyn(i)&"' ,'"&nat_cd&"') "
                 
                 objConn.Execute ins_sql
             else
                 up_sql = "update trip_gtck_opt "
                 up_sql = up_sql&" set nm_c =N'"& u_nm(i) &"' , price="&u_price(i)&"  ,  total_man="&u_total_man(i)&"  ,sunseo ='"&u_sunseo(i)&"' , use_yn='"&u_useyn(i)&"'  where seq="&u_num(i)

                 objConn.Execute up_sql
             end if 
     
         Next
           
     
     

         n_num =num

     End if

 
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
%>
          <script type="text/javascript">
          <!--
              alert("<%=msg%>");
              location.href="tck_view.asp?num=<%=n_num%>&g_kind=<%=g_kind%>&gotopage=<%=gotopage%>";
          //-->
          </script>
<%   
     End if 

     objConn.close   : Set objConn = Nothing
%>