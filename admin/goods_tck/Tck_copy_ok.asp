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

    Dim    a_num, a_nm_c , a_price

    g_kind = Request("g_kind")
    s_area = Request("s_area")

    event_tp = Request("event_tp")

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

     tot_day    = day_0&day_1&day_2&day_3&day_4&day_5&day_6&day_7
     
     exchange   = Request("exchange")

     good_tip = Request("good_tip")
     good_tip = Replace(good_tip,",",",,")
     
     eng_title = Request("eng_title")
     
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
            
     cnt = Request("add_price").Count
       
     Sql = "SELECT MAX(num) FROM trip_gtck"
     Set Rs = Server.CreateObject("ADODB.RecordSet")
     Rs.open sql , objConn,3
       
     if isnull(Rs(0)) then
         n_num = 1000
     else
         n_num = rs(0) + 1
     end if

     Rs.close :	Set Rs = Nothing

     '####################################################################################################################################################################
     m_sql = "INSERT INTO trip_gtck (    num, event_tp, title, g_kind, s_area , tot_day , exchange  ,remark1  , remark2    , remark3  , remark4    "
     m_sql = m_sql &"   , good_tip, eng_title, emp_nm,  emp_email, sunseo, re_comd, del_yn, ins_dt ) VALUES "
     m_sql = m_sql &" (     "&n_num&", '"&event_tp&"',N'"&title&"','"&g_kind&"','"&s_area&"' , '"&tot_day&"','"&exchange&"',N'"&ir_1&"',N'"&ir_2&"',N'"&ir_3&"',N'"&ir_4&"' "
     m_sql = m_sql &"    , N'"&good_tip&"', '"&eng_title&"', N'"&emp_nm&"', N'"&emp_email&"' ,0, 'NNN' , 'N' , getdate()  )"
     objConn.Execute m_sql

     If cnt > 0 then

         For i = 1 To cnt
             u_nm  =  Request("add_nm_c")(i)
             u_nm  =  Replace(u_nm , "'","''")
         
             u_price  =  Request("add_price")(i)
             u_price  =  Replace(u_price , "'","''")
             u_price  =  Replace(u_price , ",","")
             if u_price="" or isnull(u_price) then
                 u_price=0
             end if	
         
            
         
             u_sub_tp  =  Request("add_sub_tp")(i)
         
             ins_sql = "INSERT INTO  trip_gtck_opt ( good_cd , nm_c ,  price ,    sub_tp       ,  sunseo , use_yn ,nat_cd) values "
             ins_sql = ins_sql        &" ( "&n_num&", N'"&u_nm&"', "&u_price&" ,  '"&u_sub_tp&"','20'   ,'Y'     ,'"&nat_cd&"') "
         
             objConn.Execute ins_sql
         
         Next
                
                
         '추가선택
         opt_cnt = Request("opt_price_1").Count
               
         Redim  op_num(opt_cnt), op_nm(opt_cnt) , op_price_1(opt_cnt)    
               
         For i = 1 To opt_cnt
               
             op_nm(i)  =  Request("opt_nm_c")(i)
             op_nm(i)  =  Replace(op_nm(i) , "'","''")
               
             op_price_1(i)  =  Request("opt_price_1")(i)
             op_price_1(i)  =  Replace(op_price_1(i) , "'","''")
             if op_price_1(i)="" or isnull(op_price_1(i)) then
                 op_price_1(i)=0
             end if
               
          
               
             s_sql = "INSERT INTO  trip_gtck_opt ( good_cd ,   nm_c   ,  price             , sub_tp  ,  sunseo , use_yn,  nat_cd ) values "
             s_sql = s_sql             &" ( "&n_num&", N'"&op_nm(i)&"', "&op_price_1(i)&" ,   'S'      ,'30'   ,'Y' ,'"&nat_cd&"' ) "
               
             objConn.Execute s_sql
               
         Next
               
               
         sub_cnt = Request("sub_num").Count
               
         Redim  sub_num(sub_cnt), sub_nm(sub_cnt)
               
         For i = 1 To sub_cnt
         
             sub_nm(i)  =  Request("sub_nm")(i)
             sub_nm(i)  =  Replace(sub_nm(i) , "'","''")
             sub_num(i)  =  Request("sub_num")(i)
               
             s_sql = "INSERT INTO  trip_gtck_sub ( good_cd, nm_sub, del_yn ) values "
             s_sql = s_sql  &" ( "&n_num&", N'"&sub_nm(i)&"','N' ) "
             objConn.Execute s_sql
               
         Next

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
        <script language="javascript">
        <!--
            alert("상품이 정상적으로 복사되었습니다.");
            parent.location.reload();
            parent.$('#chain_copy').dialog('close');
        //-->
        </script>
<%   
    End if 
    
    objConn.close   : Set objConn = Nothing
%>
