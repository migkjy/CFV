<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<%
    OpenF5_DB objConn
    			
    			    
    Dim Sql, Rs, ecnt
    Dim num, gotopage, pagesize, Sql_where, Sql_order, totalcnt, Sql_cnt, cnt, code
    
    num = Request("num")
    pagesize = Request("pagesize")
    gotopage = Request("gotopage")
    select1 = Request("select1")
    select2 = Request("select2")
    select3 = Request("select3")
    cont = Request("cont")
    sex = request("sex")
    
    	
    if gotopage = "" then gotopage = 1 end if
    if pagesize = "" then pagesize = 20 end if
    if num = "" then num = 0 end if
    

    
    if cont <> "" Then
        if select1 = "1" then
            Sql_where = str_where_query(Sql_where, "memid", cont, "like")
        elseif select1 = "2" then
            Sql_where = str_where_query(Sql_where, "kname", cont, "like")
        elseif select1 = "3" then
            Sql_where = str_where_query(Sql_where, "htel", cont, "like")
        end if
    end if
    
    
    
    Sql_cnt = "TB_member "&Sql_where
    totalcnt = list_totalcnt(Sql_cnt)
    if select3 = "1" then
        Sql_order = order_query(Sql_order, "num", "DESC")
    elseif select3 = "2" then
        Sql_order = order_query(Sql_order, "memcnt", "DESC")
    else 
        Sql_order = order_query(Sql_order, "num", "ASC")
    end if
    
    Sql = list_query("TB_member", Sql_where, Sql_order, gotopage, pagesize)
    'response.write sql
    Set Rs = objConn.Execute(Sql)
    ecnt = 0 

%>

<!DOCTYPE html>
<html>
<head>
<title><%=fnTitle(cd)%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
<style type="text/css">
    .bcls {color:#000000;}
    .gcls {color:#00901B;}
    .ycls {color:#888888;}
</style>
</head>

<body>
 
    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=fnTitle(cd)%></div>

           <form name="form1"  id="form11" method="post"   onkeypress="if(event.keyCode==13){form1.submit();}" style="display:inline; margin:0px;">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
                <tr>
                	 
                    <td>
                        <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
        
                               
                                <td class="bin_pa" width="9%">
                                    <select name="select1" class="select_basic" style="width:100%;">
                                        <option value="2" <% if select1 = "2" then %>selected<% end if %>>닉네임</option>
                                        <option value="1" <% if select1 = "1" then %>selected<% end if %>>아이디(이메일)</option>
                                        <option value="3" <% if select1 = "3" then %>selected<% end if %>>휴대전화번호</option>
                                    </select>
                                </td>
                                <td class="bin_pa" width="20%"><input type="text" name="cont"value="<%=cont%>" class="input_basic" style="width:99%;"></td>
                                <td class="bin_pb" width="*%">
                                   <span style="padding:0 8px 0 0;"><img src="/admin/images/top_ser.png" border="0" onclick="submit();" style="cursor:pointer;border-radius:2px;"></span>   
                                   <span><img src="/admin/images/top_list.png" border="0" onClick="location.href='member_list.asp'" style="cursor:pointer;border-radius:2px;"></span>
                                </td>
                            </tr>
                        </table>
                    </td>
                
                </tr>
            </table>

            <div class="pb15"></div> 
      
            <div class="table_list">
                <table>
                    <tr>
                        <td width="5%" class="top1">No</td>
                        <td width="14%" class="top2">닉네임</td>
                        <td width="*%" class="top2">아이디(이메일)</td>
                        <td width="14%" class="top2">휴대전화번호</td>
                    <!--        <td width="8%" class="top2">생년월일</td>
                    <td width="5%" class="top2">성별</td>-->
                        <td width="14%" class="top2">보유 포인트</td>
                        <td width="14%" class="top2">가입일</td>
                        <td width="14%" class="top2">그룹</td>
                       <!-- <td width="13%" class="top3">트래블월렛(계좌번호)</td>      
                        <td width="8%" class="top3">e-티켓</td>      
                        <td width="6%" class="top3">여권정보</td>      -->
                    </tr>
                    <%
                        formnum = totalcnt-(pagesize*(gotopage-1))
                        i = 1
                        Do until Rs.EOF
                            ecnt =1 
                            
                              m_htel = Rs("htel")
                          
                                 f_htel= left(m_htel,3)
       	                       s_htel= mid(m_htel,4,4)
       	                       r_htel= right(m_htel,4)
                          
                          
                          
                           	m_birthday = Rs("birthday")
                            ent_year= left(m_birthday,4)
       	                  ent_month= mid(m_birthday,6,2)
       	                   ent_day= right(m_birthday,2)
                          
                          
                          
                            sql2 = "select sum(use_money) from TB_save_money where tot_htel = '"&Rs("htel")&"' and  can_yn='N'"
                            Set Rs2 = Server.CreateObject("ADODB.RecordSet")
                            Rs2.open sql2,objConn,3
                            If Rs2.eof or Rs2.bof then
                            Else
                                pay_point = Rs2(0)
                                if isNull(pay_point) then pay_point = 0 end if
                            End if
    		                    
                            CloseRs Rs2 
                            air_pdf_yn = Rs("air_pdf_yn")
                            air_FileName  = Trim(Rs("air_FileName"))
                            total_point = int(Rs("point")) - int(pay_point)
                    %>
                    <tr bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';" style="cursor:pointer;"  class="<%=cls1%>">
                        <td class="tob1" onclick="location.href='member_view.asp?num=<%=Rs("num")%>';"><%=formnum%></td>
                        <td class="tob2" onclick="location.href='member_view.asp?num=<%=Rs("num")%>';"><%=Rs("kname")%></td>
                        <td class="tob2" onclick="location.href='member_view.asp?num=<%=Rs("num")%>';"><%=Rs("memid")%></td>
                        <td class="tob2" onclick="location.href='member_view.asp?num=<%=Rs("num")%>';"><%=f_htel%>-****-<%=r_htel%></td>
                        <!--<td class="tob2" onclick="location.href='member_view.asp?num=<%=Rs("num")%>';"><%=ent_year%>-<%=ent_month%>-**</td>
                        <td class="tob2" onclick="location.href='member_view.asp?num=<%=Rs("num")%>';"><%=Rs("gender")%></td>-->
                        <td class="tob2" onclick="location.href='member_view.asp?num=<%=Rs("num")%>';"><%=formatnumber(total_point,0)%> ⓟ</td>
                        <td class="tob2" onclick="location.href='member_view.asp?num=<%=Rs("num")%>';"> <%=Rs("memdate")%></td>
                        <td class="tob2"><input type="text" name="idx<%=Rs("num")%>" value="<%=Rs("room_group")%>" onblur="g_check('<%=Rs("num")%>', document.form1.idx<%=Rs("num")%>.value);toUpCase(this)" size="2"  maxlength="1"  class="input_color"> </td>
                      <!--  <td class="tob2" onclick="location.href='member_view.asp?num=<%=Rs("num")%>';"><%=Rs("account_number")%></td>
                        <td class="tob2">
                            <% if air_pdf_yn = "1" then%>
                                <span style="padding:0 7px 0 0;"><a href="/upload/acc_excel/<%=air_FileName%>" target="_blank"><img src="/admin/images/ico_view_c.png" border="0"></a></span>
                            <% end if %>
                            <span><a href="javascript:fn_evoa('<%=Rs("htel")%>');"><img src="/admin/images/ico_ok.png" border="0"></a></span>
                        </td>
                        <td class="tob2">
                            <%
                                Sql = "SELECT SessionID FROM W_GoodsImageBox where SessionID='"&Rs("htel")&"' and delok='False'"
                                Set Rs1 = objConn.Execute(sql) 
                                if  not Rs1.EOF or  not Rs1.BOF then
                            %>
                                <span<a onclick="fn_pass('<%=Base64_Encode(Rs("htel"))%>');return false;"><img src="/admin/images/ico_view_c.png" border="0"></a></span> 
                            <% else %>
                            <span><a onclick="fn_pass('<%=Base64_Encode(Rs("htel"))%>');return false;"><img src="/admin/images/ico_ok.png" border="0"></a></span> 
                            <%
                                    Rs1.close
                                    Set Rs1 = nothing
                                end if
                            %> 
                        </td>-->
                    </tr>
                    <%
                            Rs.movenext
                            i = i + 1
                            formnum = formnum - 1
                            
                        loop 
                        
                        CloseRs Rs
                    %>
                    <% if ecnt = 0 then %>
                    <tr>
                        <td class="bin" colspan="12">회원이 존재하지 않습니다.</td>
                    </tr>
                    <% end if %>
                </table>
            </div> 

            <div class="pt15"></div>   

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="30%" style="text-align:left;padding:0 10px;"><%list_line_control 20, 40, 10%></td>
                    <td width="*%">
                        <div class="pt15"></div>   
                        <div align="center">
                         
                            <span class="button_b" style="padding:0px 4px"><a href="member_list.asp">목록</a></span> 
                            <span class="button_b" style="padding:0px 4px"><a href="javascript:fn_member();">엑셀 회원등록</a></span>
                            <span class="button_b" style="padding:0px 4px"><a href="member_excel_from.asp">엑셀 양식</a></span> 
                        </div>
                    </td>
                    <td width="30%" style="text-align:right;padding:0 10px;"><% list_paging gotopage, pagesize, totalcnt %></td>
                </tr>
            </table>
          
        </form>
    </div>

</body>
</html>

<div id="chain_member" title="엑셀 회원등록"></div>
<div id="chain_evoa_pop" title="항공권등록"></div>
 <div id="chain_pass" title="여권등록"></div>
<%
    CloseF5_DB objConn 
%>
 

<script language="javascript">  
<!-- 
   
      function toUpCase(object){
        	object.value = object.value.toUpperCase(); //toLowerCase 소문자
        }

  
       
   
   
   //여권등록
    function fn_pass(k){
        var _urlpass = "/tourgramedit/Html/ScheduleAdd.asp?num="+k;
        $("#chain_pass").html('<iframe id="modalIframeIdpass" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeIdpass").attr("src",_urlpass);
    }
    $(document).ready(function(){
        $("#chain_pass").dialog({
            autoOpen: false,
            modal: true,
            width: 650,
            height: 770
        });
    });
  
   
    function fn_evoa(r){
        var _url7yy = "view_pdf_up.asp?tot_hp="+r;
        $("#chain_evoa_pop").html('<iframe id="modalIframeId27yy" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId27yy").attr("src",_url7yy);
    }
    $(document).ready(function(){
        $("#chain_evoa_pop").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 400
        });
    }); 

    function page(n){
        if (n=="1"){
            document.form1.gotopage.value = parseInt(document.form1.gotopage.value) - 1; 
        }else if (n=="2"){
            document.form1.gotopage.value = parseInt(document.form1.gotopage.value) + 1;
        }
        document.form1.submit();
    }
	 
    function pagesetting(){
      //  document.form1.action = "member_list.asp";
        document.form1.gotopage.value = 1
        document.form1.submit();
    }

   
    
 //엑셀
    function fn_member(){
        var _url11 = "member_excel_up.asp";
        $("#chain_member").html('<iframe id="modalIframeId11" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId11").attr("src",_url11);
    }
    $(document).ready(function(){
        $("#chain_member").dialog({
            autoOpen: false,
            modal: true,
            width: 800,
            height: 350
        });
    }); 
    
  function g_check(n,t){
    	var	fk   = document.form1;

        //alert(t);
    	var urlk = "g_check.asp?num="+n+"&idx_v="+t
    	//alert(urlk);
    	fk.action = urlk;
    	fk.target = "ifmchk_frm";
    
    	fk.submit();
    
    }      
--> 


</script> 
<iframe name="ifmchk_frm" id="ifmchk_frm" src="about:blank"  allowTransparency=true width="0" height="0" marginwidth="0" marginheight="0" vspace="0" scrolling="yes" frameborder="0" framespacing="0" frameborder="0"></iframe>        