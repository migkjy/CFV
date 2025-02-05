<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<%
    Dim tbl
    Dim g_kind ,g_kind_nm
    Dim pageblock , pagesize ,gotopage
    Dim s_cont ,cont ,etc 

    tbl = "trip_notice"

    g_kind = Request("g_kind")
    If Trim(g_kind)="" or isnull(g_kind) then
         Response.write "<script type='text/javascript'>"
         Response.write " alert('접근하실수 없습니다...'); "
         Response.write " history.back();"
         Response.write " </script>	 "
         Response.end
    End if

    Select Case g_kind
	    Case "10":g_kind_nm="공지사항"
	    Case "20":g_kind_nm="페이지 등록"
    End Select

    pageblock = 10
    pagesize = Request("pagesize")
    gotopage = Request("gotopage")

    s_cont = Request("s_cont")
      s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
      cont = Replace(cont,"'","")

    if gotopage = "" then gotopage = 1 End if
    if pagesize = "" then pagesize = 15 End if


    '#################################검색부분#############################################
    If s_cont="" or isnull(s_cont) then
          s_cont2="title"
    Else
       Select Case Ucase(s_cont)
          Case "S": s_cont2="title"
          Case "C": s_cont2="con_tents"
       End Select
    End if 

    ans = " and " & s_cont2 & " like '%" & cont & "%' "
    
    
    OpenF5_DB objConn
    
    sql = "select count(num) as cnt from "&tbl
    sql = sql & " where del_yn='N' and g_kind='"&g_kind&"' "
    if cont <> "" then sql = sql&ans
     Set Rs = objConn.Execute(SQL)

    RecordCount = Rs(0)
    PageCount = int( (RecordCount - 1) / PageSize ) + 1

    if gotopage = "" then 
       gotopage = 1
    elseif Cint(gotopage) > Cint(PageCount) then
       gotopage = PageCount
    end If

    if gotopage=0 then gotopage=1 end if

    r_num = recordcount - Cint(pagesize) * Cint((gotopage-1) )

    CLOSERS RS
%> 

<!DOCTYPE html>
<html>
<head>
<title><%=g_kind_nm%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script language="JavaScript">
<!--
    var old_menu = '';
    function menuclick( submenu, cellbar)
    {
      if( old_menu != submenu ) {
        if( old_menu !='' ) {
          old_menu.style.display = 'none';
        }
        submenu.style.display = 'block';
        old_menu = submenu;
    
      } else {
        submenu.style.display = 'none';
        old_menu = '';
      }
    }
//-->
</script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=g_kind_nm%></div>

        <form name="s_frm" method="post" action="notice_list.asp" style="display:inline; margin:0px;" >
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
                <tr>
                    <td>
                        <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                               <td class="bin_pa" width="130px">
                                   <select name="s_cont" class="select_basic" style="width:100%;">
                                       <option value="S" <% if s_cont = "S" then %>selected<% end if %>>제목</option>
                                       <option value="C" <% if s_cont = "C" then %>selected<% end if %>>내용</option>
                                   </select>
                               </td>
                               <td class="bin_pa" width="400px"><input type="text" name="cont" value="<%=cont%>"class="input_basic" style="width:99%;"></td>
                               <td class="bin_pb" width="*%">
                                   <span style="padding:0 8px 0 0;"><img src="/admin/images/top_ser.png" border="0" onclick="chk_frm();" style="cursor:pointer;border-radius:2px;"></span>   
                                   <span style="padding:0 8px 0 0;"><img src="/admin/images/top_list.png" border="0" onClick="location.href='notice_list.asp?g_kind=<%=g_kind%>'" style="cursor:pointer;border-radius:2px;"></span>
                                   <% If g_kind = "10" then%>
                                       <span><img src="/admin/images/top_ok.png" border="0" onClick="location.href='notice_ins.asp?g_kind=<%=g_kind%>'" style="cursor:pointer;border-radius:2px;"></span>
                                   <% End if  %>
                               </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        
        <div class="pb15"></div> 

        <form name="form1" method="post" action="notice_list.asp" style="display:inline; margin:0px;" >
        <input type="hidden" name="check_all"  value="0">
        <input type="hidden" name="g_kind" value="<%=g_kind%>">

            <%
                sql ="SELECT TOP  "&pagesize&"  "
                sql = sql & " a.num, a.user_id, a.user_nm , a.title ,a.re_comd ,a.con_tents ,a.hit ,a.ins_dt "
                sql = sql & " from "&tbl&" a "  
                sql = sql & " where a.num not in "
                sql = sql & "  (select top " & ((gotopage-1) * pagesize) &" a.num " 
                sql = sql & "    from "&tbl&"    a   "
                sql = sql & "   where a.del_yn='N' and g_kind='"&g_kind&"'  "
                
                If cont <> "" then sql = sql & ans
                sql = sql & "   order by a.num desc)"
                sql = sql & " and a.del_yn='N'  and g_kind='"&g_kind&"'  "
               
                If cont <> "" then  sql = sql &  ans
                sql = sql & "  order by  a.num desc "
                Set Rs = objConn.Execute(SQL)
            %>
            <div class="table_list">
                <% If g_kind = "10" then%>
                    <table>
                        <tr>
                            <td width="100px" class="top1"><span class="checks" style="padding:0 0 0 8px;"><input type="checkbox" name="checkedcard" id="all_chk" value="0" onclick="toggleCheck();"><label for="all_chk"></label></span></td>
                            <td width="100px" class="top2">번호</td>
                            <td width="100px" class="top2">추천</td>
                            <td width="*%" class="top2">제목</td>
                            <td width="130px" class="top2">작성자</td> 
                            <td width="130px" class="top2">등록일</td>
                            <td width="100px" class="top2">조회</td>
                        </tr>
                    </table>
                <% Else %>
                     <table>
                        <tr>
                            <td width="100px" class="top1">번호</td>
                            <td width="*%" class="top2">제목</td>
                            <td width="130px" class="top2">작성자</td> 
                            <td width="130px" class="top2">등록일</td>
                        </tr>
                    </table>
                <% End if  %>
                
                <%
                    If rs.eof or rs.bof then
                    rcnt=0
                %>
                    <table>
                        <tr>
                            <td class="bin">등록된 내용이 없습니다</td>
                        </tr>
                    </table>
                <%
                    Else
                
                       rcnt=1
                       i=1
                       Do until Rs.EOF
                
                           num = Rs("num")
                           user_nm   = Rs("user_nm")
                           title = Rs("title")
                           con_tents = Rs("con_tents")
                
                           ins_dt = left(Rs("ins_dt"),10)
                           hit = Rs("hit")
                           check_new = datediff("d",left(now,10),ins_dt)
                           re_comd = Rs("re_comd")
                %>
                <% If g_kind = "10" then%>
                    <table>
                        <tr <% if i/2 = Int(i/2) Then %>bgcolor="#F9F9F9" <% Else %>bgcolor="#FFFFFF" <% End If %>  onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                            <td width="100px" class="tob1"><span class="checks" style="padding:0 0 0 8px;"><input type="checkbox" name="checkedcard" value="<%=num%>" id="<%=num%>"><label for="<%=num%>"></label></span></td>
                            <td width="100px" class="tob2"><%=r_num%></td>
                            <td width="100px" class="tob2"><iframe name="disp_<%=seq%>" id="disp_<%=seq%>" src="iframe_check.asp?num=<%=num%>&re_comd=<%=re_comd%>&tb_cd=no" width="18" height="18" frameborder=0 hspace=0 vspace=0 scrolling=no></iframe></td>
                            <td width="*%" class="tob4" onclick="menuclick(submenu<%=i%>,bar<%=i%>);" style="cursor:pointer;">
                                <%=title%>
                                <% if check_new=0 then %>
                                    <span style="color:#FF0000; padding:0 0 0 10px;"><i class="xi-new xi-x"></i></span>
                                <% End if %>
                            </td>
                            <td width="130px" class="tob2"><%=user_nm%></td>
                            <td width="130px"  class="tob2"><%=ins_dt%></td>
                            <td width="100px" class="tob2"><%=hit%></td>
                        </tr>
                    </table>
                                             
                    <div id="bar<%=i%>">
                        <div id="submenu<%=i%>" style="display: none;">
                            <table>
                                <tr bgcolor="#FFFFFF">
                                    <td width="100px" class="tob1"></td>
                                    <td width="100px" class="tob2"></td>
                                    <td width="100px" class="tob2"></td>
                                    <td width="*%" class="tob4">
                                        <div style="padding:15px 0px 25px 0px;"><%=con_tents%></div> 
                                        <div align="center">
                                            <span class="button_b" style="padding:0px 2px"><a onClick="modify('<%=num%>','<%=g_kind%>');return false;">수정</a></span>
                                            <span class="button_b" style="padding:0px 2px"><a onClick="del('<%=num%>','<%=g_kind%>');return false;">삭제</a></span>
                                        </div>
                                        <div class="pb30"></div> 
                                    </td>
                                    <td width="130px" class="tob2"></td>
                                    <td width="130px"  class="tob2"></td>
                                    <td width="100px" class="tob2"></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                <% Else %>
                    <table>
                        <tr <% if i/2 = Int(i/2) Then %>bgcolor="#F9F9F9" <% Else %>bgcolor="#FFFFFF" <% End If %>  onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                            <td width="100px" class="tob1"><%=r_num%></td>
                            <td width="*%" class="tob4" onclick="menuclick(submenu<%=i%>,bar<%=i%>);" style="cursor:pointer;">
                                <%=title%>
                                <% if check_new=0 then %>
                                    <span style="color:#FF0000; padding:0 0 0 10px;"><i class="xi-new xi-x"></i></span>
                                <% End if %>
                            </td>
                            <td width="130px" class="tob2"><%=user_nm%></td>
                            <td width="130px"  class="tob2"><%=ins_dt%></td>
                        </tr>
                    </table>
                                             
                    <div id="bar<%=i%>">
                        <div id="submenu<%=i%>" style="display: none;">
                            <table>
                                <tr bgcolor="#FFFFFF">
                                    <td width="100px" class="tob1"></td>
                                    <td width="*%" class="tob4">
                                        <div style="padding:15px 0px 25px 0px;"><%=con_tents%></div> 
                                        <div align="center">
                                            <span class="button_b" style="padding:0px 2px"><a onClick="modify('<%=num%>','<%=g_kind%>');return false;">수정</a></span>
                                        </div>
                                        <div class="pb30"></div> 
                                    </td>
                                    <td width="130px" class="tob2"></td>
                                    <td width="130px"  class="tob2"></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                <% End if  %>
                
                <%
                            Rs.movenext
                            i = i+1
                        r_num = r_num - 1
                        Loop
                            
                    End if 
                            
                    CloseRs Rs
                %>

                <% If rcnt=1 then %>
                    <div class="pb20"></div> 
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="100px" align="center"><% If g_kind = "10" then%><span class="button_b"><a href="javascript:deleteMailList();">삭제</a></span><% End if  %></td>
                            <td align="center">
                                <div class="paginate1">
                                    <div align=center>
                                        <% Call fn_goPage(gotopage,pagecount,pageblock,"notice_list.asp?g_kind="&g_kind, "&s_cont="&s_cont&"&cont="&cont) %>
                                    </div>
                                </div>
                            </td>
                            <td width="100px"></td>
                        </tr>
                    </table>
                <% End if %>

          </div>
          
        </form>
     
    </div>
    
</body>
</html>

<%
    CloseF5_DB objConn 
%>

<script type="text/javascript">
<!--
    function chk_frm(){
        if (document.s_frm.cont.value==""){
            alert("검색어를  입력해 주세요.");
            return false;
        }
        document.s_frm.submit();
    }


    function del(n,k){
        if(confirm("정말로 삭제하시겠습니까?")){
            location.href="notice_del.asp?num="+n+"&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>&g_kind=<%=g_kind%>";
        }
    }

   
    function modify(n,k){
        location.href="notice_ins.asp?num="+n+"&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>&g_kind=<%=g_kind%>";
    }
    

    function toggleCheck(){
        $("input[name=checkedcard]").each(function(){
            if(this.checked){
                this.checked = false;
                $( '#all_chk' ).prop( 'checked', false );
            } else  {
                this.checked = true;
                $( '#all_chk' ).prop( 'checked', true );
            }
        });

        var res = [];
        var i =0;

        $("input[name=checkedcard]:checked").each(function(){ 
            if (this.value!=0) { 
                res.push(this.value);
                i++;
            }
        });
    }

    
    function deleteMailList(){
        var res = [];
        var i =0;

        $("input[name=checkedcard]:checked").each(function(){ 
            if (this.value!=0) { 
                res.push(this.value);
                i++;
            }
        });

        if(res==""){
            alert(" 선택하여 주십시오");
        }else{
            if(confirm("정말로 삭제하시겠습니까?\n삭제하시면 복구가 불가합니다")){
                document.form1.action = "relation_del.asp?asp_file=notice_list&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>&g_kind=<%=g_kind%>&cartseq="+res;
                document.form1.submit();
            }else{
                location.href="notice_list.asp?gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>&g_kind=<%=g_kind%>";
                return false;
            }

        }

    }

--> 
</script>

