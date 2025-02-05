<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    'Response.CharSet = "EUC-KR" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"


    OpenF5_DB objConn

    Dim reserve_gubun ,tbl, tbl2

    Dim gotopage,pagesize ,pageblock
    Dim subSql
    Dim s_kind0 ,s_kind1 ,s_kind3 , searchkind2 ,searchkind3 ,searchkind ,stext


    reserve_gubun ="30"

    
    gotopage  = Request("gotopage")
    pagesize  = Request("pagesize")

    if gotopage = "" then gotopage = 1 End if
    if pagesize = "" then pagesize = 20 End if

    pageblock  = 10

    subSql = ""
    s_kind  = Request("s_kind")
    s_kind1 = Request("s_kind1")
    s_kind2 = Request("s_kind2")
    s_kind3 = Request("s_kind3")
    
    stext = Request("stext")
    stext = Replace(stext,"'","")

    start_ymd = Request("start_ymd")
    if start_ymd ="" or isnull(start_ymd) then
        start_ymd = Dateadd("d",-7,cdate(date)) 
    End if

    start_ymd2 = Request("start_ymd2")
    if start_ymd2 ="" or isnull(start_ymd2) then
        start_ymd2 =  Cdate(date) 
    End if


    If s_kind <> "" then
        Select Case s_kind
          Case "10"
              subSql = subSql & " AND convert(varchar(10), r.ins_dt,120) between '"&start_ymd&"'  and '"&start_ymd2&"'  "
              ord_sql = "order by t.seq desc  "
          Case "20"
              subSql = subSql &" and r2.opt_day BETWEEN '"&start_ymd&"' AND  '"&start_ymd2&"' " 
              ord_sql = "order by t.start_ymd asc  "
        End select
    End if
 
    If s_kind1 <> ""  then
       subSql = subSql &" and ( r.prod_cd = '"&s_kind1&"' ) " 
    End if

    If s_kind3 <> ""  then
       subSql = subSql &" and ( r.g_kind = '"&s_kind3&"' ) " 
    End if
 
    If stext <> "" then
        Select Case s_kind2
            Case "N" 
                subSql = subSql &" and ( r.res_nm like '%" & stext & "%' ) " 
            Case "H"
                subSql = subSql &" and r.res_hp3 like '%" & stext & "%' " 
            Case "R"
                subSql = subSql &" and r.reserve_code like '%" & stext & "%' " 
            Case "G"
                subSql = subSql &" and g.title like '%" & stext & "%' "     
        End select
    End if
    


    sql =" select count(r.seq)  FROM w_res_tck001 r inner join w_res_tckopt r2 on r.reserve_code=r2.reserve_code left outer join trip_gtck g ON r.good_num = g.num WHERE r.del_yn='N' and r2.opt_tp='F' " 
    sql = sql& subsql
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Set rs = objConn.execute(sql)
    
    RecordCount = Rs(0)
    PageCount = int( (RecordCount - 1) / pagesize ) + 1
    
    Rs.close :Set Rs=nothing
    
    If Cint(gotopage) > Cint(PageCount) then
        gotopage = PageCount
    End If
    
    r_num = RecordCount - (Cint(pagesize) * cint((gotopage-1) ))
%>

<!DOCTYPE html>
<html>
<head>
<title>프로그램 예약관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
<style type="text/css">
    .ui-datepicker {font-size:15px;}
    .ui-datepicker select.ui-datepicker-month, 
    .ui-datepicker select.ui-datepicker-year { width: 70px;} 
    
    .Acls {color:#000000;}
    .Bcls {color:#C926C0;}
    .Ccls {color:#B72200;}
    .Dcls {color:#3939CA;}
    .Ecls {color:#888888;}
    .Fcls {color:#00901B;}
    .Gcls {color:#FF0000;}
</style>
<script type="text/javascript">
<!--
   $(function() {
      $( ".datepicker" ).datepicker({
           changeMonth: true,
           changeYear: true,
           monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
           monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
           dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
           numberOfMonths: 2,
           dateFormat:"yy-mm-dd" 
      });
    
   });
//-->
</script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 프로그램 예약관리</div>
        
        <form name="form1" method="post" action="reserve_list.asp" style="display:inline; margin:0px;" >
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
                <tr>
                    <td>
                        <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="bin_pa" width="10%">
                                    <select name="s_kind3" class="select_basic" style="width:100%;">  
                                        <!--<option value=""  <% If s_kind3 = ""  Then %>selected<% End If %>>상품구분</option>-->
                                        <option value="10" <% If s_kind3 = "10" Then %>selected<% End If %>>프로그램</option>
                                    </select>
                                </td>
                                <td class="bin_pa" width="8%">
                                    <select size="1" name="s_kind1"  class="select_basic" style="width:100%;" onChange="select_cate(this.form)">  
                                        <option value=""  <% If s_kind1 = ""  Then %>selected<% End If %>>진행현황</option>
                                        <option value="0" <% If s_kind1 = "0" Then %>selected<% End If %>>예약신청</option>
                                        <option value="1" <% If s_kind1 = "1" Then %>selected<% End If %>>예약확인</option>
                                        <option value="3" <% If s_kind1 = "3" Then %>selected<% End If %>>예약완료</option>
                                        <option value="4" <% If s_kind1 = "4" Then %>selected<% End If %>>예약취소</option>
                                        <option value="5" <% If s_kind1 = "5" Then %>selected<% End If %>>대기예약</option>
                                    </select>
                                </td>
                                <td class="bin_pa" width="8%">
                                    <select name="s_kind" class="select_basic" style="width:100%;">
                                        <option value="10" <% If s_kind = "10" Then%>selected<% End If %>>예약일</option>
                                        <option value="20" <% If s_kind = "20" Then%>selected<% End If %>>출발일</option>
                                    </select>
                                </td>
                                <td class="bin_pa" width="14%">
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td><input type="text" name="start_ymd" value="<%=start_ymd%>" class="datepicker" class="datepicker" style="width:85px;border:1px solid #C0C0C0;padding:0 0 0 5px; height:24px;border-radius:2px 0px 0px 2px;cursor:pointer;" readonly></td>
                                            <td><img src="/admin/images/top_calendar.png" border="0"></td>
                                            <td style="padding:0 5px;">~</td>
                                            <td><input type="text"  name="start_ymd2" value="<%=start_ymd2%>" class="datepicker" class="datepicker" style="width:85px;border:1px solid #C0C0C0;padding:0 0 0 5px; height:24px;border-radius:2px 0px 0px 2px;cursor:pointer;" readonly></td>
                                            <td><img src="/admin/images/top_calendar.png" border="0"></td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="bin_pa" width="8%">
                                    <select name="s_kind2" class="select_basic" style="width:100%;">
                                        <option value="N" <% If s_kind2 = "N" Then %>selected<% End If %>>예약자명</option>
                                        <option value="R" <% If s_kind2 = "R" Then %>selected<% End If %>>예약번호</option>
                                        <option value="G" <% If s_kind2 = "G" Then %>selected<% End If %>>상품명</option>
                                        <option value="H" <% If s_kind2 = "H" Then %>selected<% End If %>>휴대전화 뒷자리</option>
                                    </select>
                                </td>
                                <td class="bin_pa" width="20%"><input type="text" name="stext" value="<%=stext%>" class="input_basic" style="width:99%;"></td>
                                <td class="bin_pa" width="15%">
                                   <span style="padding:0 8px 0 0;"><img src="/admin/images/top_ser.png" border="0" onclick="sendit();" style="cursor:pointer;border-radius:2px;"></span>   
                                   <span><img src="/admin/images/top_list.png" border="0" onClick="location.href='reserve_list.asp'" style="cursor:pointer;border-radius:2px;"></span>
                                </td>
                                <td class="bin_pb" width="*%">
                                    <div align="right"><span class="button_a"><a href="excel_list.asp?start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&s_kind=<%=s_kind%>&s_kind2=<%=s_kind2%>&s_kind1=<%=s_kind1%>&s_kind3=<%=s_kind3%>&stext=<%=stext%>">자료다운받기</a></span></div>
                                </td>                                 
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    
        <div class="pb15"></div> 
        
        <div class="table_list">
            <table>
                <tr>
                    <td width="3%" class="top1">No</td>
                    <td width="7%" class="top2">예약번호</td>
                    <td width="6%" class="top2">예약자</td>
                    <td width="10%" class="top2">휴대전화번호</td>
                    <td width="*%" class="top2">프로그램 상품명</td>
                    <td width="6%" class="top2">출발일</td>
                    <td width="7%" class="top2">진행현황</td>
                    <td width="7%" class="top2">결제 포인트</td>
                    <td width="6%" class="top2">예약구분</td>
                    <td width="6%" class="top2">예약일</td>
                    <td width="4%" class="top2">삭제</td>
                </tr>
                <% 
                    bet_A = ( (gotopage-1 ) * pagesize ) +1
                    if bet_A< 0 then  bet_A=0 end if
                    bet_B = ( gotopage * pagesize ) 
                    
                    sql = " select * from (        "
                    sql = sql & " select Row_number() over(order by r.seq desc) as rownum ,  r.seq , r.good_num, r.reserve_code, r.g_kind , r.pc_tp ,r.res_nm , r.res_eng_nm_f, r.res_eng_nm_L ,r.res_hp1, r.res_hp2, r.res_hp3, r.res_email "
                    sql = sql & " ,r.res_amt, r.add_amt , r.dc_amt , r.prod_cd ,r.del_yn, r.ins_dt , r2.opt_day,r2.opt_nm,  g.title   "
                    sql = sql & " FROM  w_res_tck001 r inner join w_res_tckopt r2 on r.reserve_code=r2.reserve_code left outer join trip_gtck g ON r.good_num = g.num "
                    sql = sql & " WHERE r.del_yn='N' and r2.opt_tp='F'"
                    sql = sql& subsql
                    sql = sql & " )t "
                    sql = sql & " where t.rownum between '"&bet_A&"' and '"&bet_B&"' "
                    sql = sql & " order by t.seq desc  "
                    'response.write sql
                    
                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                    Rs.open sql,objConn ,3
                    
                    if Rs.eof or Rs.bof then
                    
                %>
                <tr>
                    <td class="bin" colspan="11">NO DATA</td>
                </tr>
                <%
                    Else
                
                        i = 1
                        r_cnt =1
                        Do until rs.eof 
                        
                            seq = Rs("seq")
                            good_num = Rs("good_num")
                            reserve_code = Rs("reserve_code")
                            
                            g_kind = Rs("g_kind")
                            Select case g_kind 
                                case "10" : gubun_nm ="데이투어"
        	                       case "20" : gubun_nm ="할인티켓"
        	                       case else : gubun_nm ="기타"
                            end select 
                            
                            pc_tp = Ucase(Rs("pc_tp"))
                            if pc_tp="P" then
                                pc_txt="인터넷"
                            else
                                pc_txt="모바일"
                            end if
                            
                            res_nm = Rs("res_nm")
                            res_eng_nm_f = Rs("res_eng_nm_f")
                            res_eng_nm_L = Rs("res_eng_nm_L")
                            
                            res_hp1 = Rs("res_hp1")
                            res_hp2 = Rs("res_hp2")
                            res_hp3 = Rs("res_hp3")  
                            res_hp = res_hp1&"-"&res_hp2&"-"&res_hp3
                            
                            res_email  = Rs("res_email") 
                            res_amt    = Rs("res_amt")
                            add_amt    = Rs("add_amt")
                            dc_amt     = Rs("dc_amt")
                            
                            prod_cd    = Rs("prod_cd")
                            prod_cd_nm = ch_procd_tnm(prod_cd)
                            Select Case prod_cd 
                                Case 0 : cls1 ="Acls"
                                Case 1 : cls1 ="Bcls"
                                Case 2 : cls1 ="Ccls"
                                Case 3 : cls1 ="Dcls"
                                Case 4 : cls1 ="Ecls"
                                Case 5 : cls1 ="Fcls"
                                Case 6 : cls1 ="Gcls"
                            End select
                            ins_dt = Left(Rs("ins_dt"),10)
                            
                            opt_day = Rs("opt_day")
                            opt_nm = Rs("opt_nm")
                            '  response.write opt_nm
                             
                            title = Rs("title")
                
                            '####################################################################add_amt
                            Dim dc_money ,tot_add_amt
                            tot_add_amt =0 
                            tot_add_amt = Cdbl(add_amt) - Cdbl(dc_amt)
                %> 
                <tr <% if i/2 = Int(i/2) Then %>bgcolor="#F9F9F9" <% Else %>bgcolor="#FFFFFF" <% End If %> onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';"  style="cursor:pointer;">
                    <td class="tob1"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=r_num%></span></a></td>
                    <td class="tob2"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=reserve_code%></span></a></td>
                    <td class="tob2"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=res_nm%></span></a></td>
                    <td class="tob2"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=res_hp%></span></a></td>                      
                    <td class="tob3"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=title%> (<%=opt_nm%>)</span></a></td>
                    <td class="tob2"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=opt_day%></span></a></td>
                    <td class="tob2"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=prod_cd_nm%></span></a></td>
                    <td class="tob2"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=FormatNumber(res_amt,0)%> CP</span></a></td> 
                    <td class="tob2"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=pc_txt%></span></a></td>
                    <td class="tob2"><a href="reserve_detail.asp?reserve_code=<%=reserve_code%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>&gotopage=<%=gotopage%>&s_kind=<%=s_kind%>&s_kind1=<%=s_kind1%>&s_kind2=<%=s_kind2%>&s_kind3=<%=s_kind3%>"><span class="<%=cls1%>"><%=ins_dt%></span></a></td> 
                    <td class="tob2"><% If prod_cd = "4" Then %><img src="/admin/images/ico_delete.png"  border="0" onClick="chk_del('<%=reserve_code%>')" style="cursor:pointer;"><% end if %></td>
                </tr>
                <%
                            Rs.movenext
                            r_num = r_num - 1
                            i=i+1

                       Loop

                    End If
                    
                    Rs.close : set Rs=nothing
                
                    objConn.Close   : Set objConn = Nothing
                %>
            </table>
        </div> 
            
        <% if r_cnt =1 then %>
            <div class="pb20"></div> 

            <div class="paginate1">
                <div align=center>
                    <% Call fn_goPage(gotopage,pagecount,pageblock,"reserve_list.asp?start_ymd="&start_ymd&"&start_ymd2="&start_ymd2, "&s_kind="&s_kind&"&stext="&stext&"&s_kind1="&s_kind1&"&s_kind2="&s_kind2&"&s_kind3="&s_kind3) %>
                </div>
            </div>
        <% end if %>
        
    </div> 
    
</body>
</html>


<script type="text/javascript">
<!-- 
    function sendit(){
        document.form1.submit();
    }
      
    function chk_del(r){
       
        answer = confirm("삭제 하시면 복구 할수 없습니다.\n삭제 하시겠습니까?");

        if(answer==true){
            location.href="reserve_del.asp?reserve_code="+r+"&gotopage=<%=gotopage%>&start_ymd=<%=start_ymd%>&start_ymd2=<%=start_ymd2%>";
        }else{
            return false;
        }
    }
//-->
</script> 


