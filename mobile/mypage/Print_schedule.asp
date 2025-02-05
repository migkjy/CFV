<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/conf/before_url.asp"--> 
<!--#include virtual="/home/conf/tourgram_base64.asp"-->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/home/inc/URLTools.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->  

<%
    Response.Expires = -1
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>

<!DOCTYPE html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />
<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
</head>

<body>
 
    <div style="padding:20px 10px;">
    	
        <div><img src="<%=global_url%>/images/logo/title_logo.png" border="0" height="25"></div>
        <div class="pt20"></div>
        
        <% 
            OpenF5_DB objConn   
            
            mem_nm = Trim(Request("mem_nm"))
        
            res_phone1 = Trim(Request("res_phone1"))
            res_phone2 = Trim(Request("res_phone2"))
            res_phone3 = Trim(Request("res_phone3"))
            tot_hp = res_phone1&"-"&res_phone2&"-"&res_phone3
        
        
            sql = " SELECT  kname,memid,  htel,point ,pdf_yn,FileName,account_number,air_pdf_yn,air_FileName  FROM TB_member where memid= '"&memid&"' "
            Set Rs = objConn.Execute(sql)
                   
            mem_nm  = Trim(Rs("kname"))
            tot_hp  = Trim(Rs("htel"))
            point  = Trim(Rs("point"))
            pdf_yn  = Trim(Rs("pdf_yn"))
            FileName  = Trim(Rs("FileName"))
            account_number  = Trim(Rs("account_number"))
            
            air_pdf_yn = Rs("air_pdf_yn")
            air_FileName  = Trim(Rs("air_FileName"))
            Rs.close  : Set Rs = nothing
        
        
            sql2 = "select sum(use_money) from TB_save_money where tot_htel = '"&tot_hp&"' and  can_yn='N'"
            Set Rs2 = Server.CreateObject("ADODB.RecordSet")
            Rs2.open sql2,objConn,3
            If Rs2.eof or Rs2.bof then
            Else
                pay_point = Rs2(0)
                if isNull(pay_point) then pay_point = 0 end if
            End if
            CloseRs Rs2 
            
            total_point = int(point) - int(pay_point)
        %>
        
        <div style="border:1px solid #DDD; padding:10px;">
            <div>
                <span class="point_txt1">* 사용 포인트</span>
                <span style="padding:0 5px;">:</span>
                <span class="point_txt2"><%=FormatNumber(pay_point,0)%>&nbsp;CP</span>
            </div>
            <div>
                <span class="point_txt1">* 잔여 포인트</span>
                <span style="padding:0 5px;">:</span>
                <span class="point_txt4"><%=FormatNumber(total_point,0)%>&nbsp;CP</span>
            </div>
        </div>
        
        <div class="pt20"></div>
        
        <% 
            sql="c"
            u_sql="select res_nm , res_hp     from ("
            u_sql=u_sql& " SELECT  name AS res_nm ,phone as res_hp , reserve_code AS res_cd FROM TB_reserve_reg "
            u_sql=u_sql& " union "
            u_sql=u_sql& " select  res_nm AS res_nm , res_hp1 + '-' + res_hp2 + '-' + res_hp3 AS res_hp , reserve_code AS res_cd FROM w_res_tck001 where del_yn='N'  "               
            u_sql=u_sql& " ) tbl "
            u_sql=u_sql& " where   res_hp ='"&tot_hp&"' and  res_nm = '"&mem_nm&"' "
        
            '  response.write u_sql
            Set Rs_u = Server.CreateObject("ADODB.RecordSet")
            Rs_u.open u_sql , objConn , 3
        
            If Rs_u.eof then
            Else  
            	
                subsql = " and (res_hp1 + '-' + res_hp2 + '-' + res_hp3 = '"&tot_hp&"' ) "
                reserve_gubun ="30"
 
               sql = " select r.seq , r.good_num, r.reserve_code, r.g_kind, r.res_amt, r.add_amt , r.dc_amt , r.prod_cd ,r.del_yn, r.ins_dt , g.title  "
               sql = sql & " FROM w_res_tck001 r left outer join trip_gtck g ON r.good_num = g.num "
               sql = sql & " WHERE r.del_yn='N'  "
               sql = sql & subsql
               sql = sql & " ORDER BY r.res_pick_place asc, r.res_pick_time asc"
              ' response.write sql
               Set Rs = Server.CreateObject("ADODB.RecordSet")
                   
               Rs.open sql , objConn , 3
               
               If Rs.eof or Rs.bof then
               Else
           %>
               <div class="sch_box">
                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                       <colgroup>
                           <col width="24%">
                           <col width="28%">
                           <col width="*">
                       </colgroup>
                       <thead>
                           <tr>
                               <td class="typu1">투어일</td>	
                               <td class="typu2">시간</td>	
                               <td class="typu2">프로그램 상품명</td>	
                           </tr>
                       </thead>
                       <tbody>
                           <%
                               Do Until Rs.EOF
                           
                                   seq = Rs("seq")
                                   good_num  = Rs("good_num")
                                   reserve_code = Rs("reserve_code")
                           
                                   r_g_kind = Rs("g_kind")
                           
                                   prod_cd = Rs("prod_cd")
                                   prod_nm = ch_procd_hnm(prod_cd)

                                   ins_dt = Left(Rs("ins_dt"),10)
                                   title = Rs("title")
                           
                           
                                   sql2 = " select top 1 opt_day ,opt_nm,opt_ad_price from w_res_tckopt where reserve_code='"&reserve_code&"' and opt_cancd ='N' order by num asc "
                                   
                                   ' response.write sql2 &"<br>"
                                   Set Rs2 = Server.CreateObject("ADODB.RecordSet")
                                   Rs2.open sql2 , objConn , 3
                                   if Rs2.eof or Rs2.bof then
                                       opt_day=""
                                   else
                                       opt_day=Rs2("opt_day")
                                       opt_nm=Rs2("opt_nm")
                                       opt_ad_price=Rs2("opt_ad_price")
                                   end if
                           
                                   Rs2.close   : Set Rs2=nothing    
                           %>
                           <% if prod_cd<>"4" then %>
                           <tr>
                               <td class="typu3"><%=opt_day%></td>
                               <td class="typu4"><%=opt_nm%></td>
                               <td class="typu5"><%=title%></td>
                           </tr>
                           <% end if %>
                           <%
                               Rs.movenext
                               Loop
                           %>
                       </tbody>
                   </table>
               </div> 
           <%
                   End if
                   Rs.close : Set Rs = nothing
   
               End if
               CloseRs Rs_u
            
               CloseF5_DB objConn
           %>

           <style type="text/css" media="print">
               .noprint {
               display: none;
               }
           </style>
           <div class="noprint">
               <div class="board_btn_w">
                   <ul class="btn_r">
                       <li class="color"><a href="javascript:void(0)" onClick="window.print();">인쇄</a></li>
                   </ul>
               </div>
           </div>
       </div>
        
    </div>

</body>
</html>