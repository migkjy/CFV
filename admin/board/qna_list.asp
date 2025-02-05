<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    tbl = "trip_qna"

    Select Case g_kind
	    Case "10":g_kind_nm="문의 게시판"
	    Case "20":g_kind_nm="견적문의"
    End Select


    gotopage = Request("gotopage")


    s_cont = Request("s_cont")
      s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
      cont = Replace(cont,"'","")

    num = Request("num")

    pageblock      = 10
    if gotopage  = "" then gotopage = 1 end if
    if pagesize  = "" then pagesize = 15 end if

    '#################################검색부분#############################################
    if s_cont="" or isnull(s_cont) then
       s_cont2="title"
    else
       Select Case Ucase(s_cont)
          Case "S": s_cont2="title"
          Case "N": s_cont2="user_nm"
          Case "C": s_cont2="con_tents"
       End Select
    End if 

    ans = " and " & s_cont2 & " like '%" & cont & "%' "



    OpenF5_DB objConn

    sql = "select count(num) as cnt from "&tbl
    sql = sql & " where del_yn='N' and ref_level ='0' "
    if cont <> "" then sql = sql & ans

    Set Rs = objConn.Execute(Sql)

    RecordCount = Rs(0)

    PageCount = int( (RecordCount - 1) / PageSize ) + 1

    if gotopage = "" then 
       gotopage = 1
    elseif cint(gotopage) > cint(PageCount) then
       gotopage = PageCount
    end If

    if gotopage=0 then gotopage=1 end if

    r_num = recordcount - cint(pagesize) * cint((gotopage-1) )

    CLOSERS RS
%> 

<!DOCTYPE html>
<html>
<head>
<title>문의 게시판</title>
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
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 문의 게시판</div>
       
        <form name="s_frm" method="post" action="qna_list.asp"  style="display:inline; margin:0px;" >
        <input type="hidden" name="g_kind" value="<%=g_kind%>">  
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
                <tr>
                    <td>
                        <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                               <td class="bin_pa" width="130px">
                                   <select name="s_cont" class="select_basic" style="width:100%;">
                                       <option value="C" <% if s_cont = "C" then %>selected<% end if %>>내용</option>
                                       <option value="S" <% if s_cont = "S" then %>selected<% end if %>>제목</option>
                                       <option value="N" <% if s_cont = "N" then %>selected<% end if %>>작성자</option>
                                   </select>
                               </td>
                               <td class="bin_pa" width="400px"><input type="text" name="cont" value="<%=cont%>"class="input_basic" style="width:99%;"></td>
                               <td class="bin_pb" width="*%">
                                   <span style="padding:0 8px 0 0;"><img src="/admin/images/top_ser.png" border="0" onclick="chk_frm();" style="cursor:pointer;border-radius:2px;"></span>   
                                   <span style="padding:0 8px 0 0;"><img src="/admin/images/top_list.png" border="0" onClick="location.href='qna_list.asp'" style="cursor:pointer;border-radius:2px;"></span>
                                   <span><img src="/admin/images/top_ok.png" border="0" onClick="location.href='qna_ins.asp'" style="cursor:pointer;border-radius:2px;"></span>
                               </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        
        <div class="pb15"></div> 

        <form name="form1" method="post" action="qna_list.asp" style="display:inline; margin:0px;">
        <input type="hidden" name="g_kind"   value="<%=g_kind%>">
        <input type="hidden" name="check_all" value="0">

            <% 
                sql ="SELECT TOP  "&pagesize&"  "
                sql = sql & " a.num ,  a.user_id , a.user_nm , a.res_hp1 ,a.res_hp2 ,a.res_hp3  ,a.email ,a.title ,a.con_tents , ref, ref_level , deep , a.pwd , a.hit , a.ins_dt "
                sql = sql & " ,(SELECT COUNT(num) FROM "& tbl&" k WHERE a.num = k.ref AND k.del_yn='N' AND k.ref_level > 0)  AS repl_cnt "
                sql = sql & " from "&tbl&" a "
                sql = sql & " where a.num not in "
                sql = sql & " (select top " & ((gotopage-1) * pagesize) &" a.num " 
                sql = sql & " from "&tbl&" a "
                sql = sql & " where a.del_yn='N' and a.ref_level='0'" 
                
                if cont <> "" then sql = sql & ans
                sql = sql & "   order by a.num desc) "
                sql = sql & " and a.del_yn='N' and a.ref_level='0'"
                
                if cont <> "" then  sql = sql &  ans
                sql = sql & " order by  a.num desc "
                Set Rs = objConn.Execute(Sql)
            %>
            <div class="table_list">
                <table>
                    <tr>
                        <td width="100px" class="top1"><span class="checks" style="padding:0 0 0 8px;"><input type="checkbox" name="checkedcard" id="all_chk" value="0" onclick="toggleCheck();"><label for="all_chk"></label></span></td>
                        <td width="100px" class="top2">번호</td>
                        <td width="100px" class="top2">추천</td>
                        <td width="*%" class="top2">제목</td>
                        <td width="100px" class="top2">처리</td>
                        <td width="130px" class="top2">작성자</td> 
                        <td width="130px" class="top2">등록일</td>
                        <td width="100px" class="top2">조회</td>
                    </tr>
                </table>
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
                            user_nm = Rs("user_nm") 
                            
                            res_hp1 = Rs("res_hp1") 
                            res_hp2 = Rs("res_hp2") 
                            res_hp3 = Rs("res_hp3") 
                            tot_hp = res_hp1&"-"&res_hp2&"-"&res_hp3
                            
                            email = Rs("email")
                            title = Rs("title")
                
                            con_tents = Rs("con_tents")
                            if con_tents <>"" then
                                con_tents = Replace(con_tents,chr(13)&chr(10),"<br>")	
                            end if
                
                            ref = Rs("ref")
                            ref_level = Rs("ref_level")
                            deep = Rs("deep")
                            pwd = Rs("pwd")
                            hit = Rs("hit")
                
                            ins_dt = Left(Rs("ins_dt"),10)
                            check_new = Datediff("d",left(now,10),ins_dt)
                
                            repl_cnt = Rs("repl_cnt")
                            if repl_cnt<>0 then
                                repl_ans="완료"
                            else 
                                repl_ans="접수"
                            end if
                %>
                    <table>
                        <tr <% if i/2 = Int(i/2) Then %>bgcolor="#F9F9F9" <% Else %>bgcolor="#FFFFFF" <% End If %>  onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                            <td width="100px" class="tob1"><span class="checks" style="padding:0 0 0 8px;"><input type="checkbox" name="checkedcard" value="<%=num%>" id="<%=num%>"><label for="<%=num%>"></label></span></td>
                            <td width="100px" class="tob2"><%=r_num%></td>
                            <td width="100px" class="tob2"><iframe name="disp_<%=num%>" src="iframe_check.asp?num=<%=num%>&re_comd=<%=re_comd%>&tb_cd=qn" width="18" height="18" frameborder=0 hspace=0 vspace=0 scrolling=no></iframe></td>
                            <td width="*%" class="tob4" onclick="menuclick(submenu<%=i%>,bar<%=i%>);" style="cursor:pointer;">
                                <%=title%>
                                <% if secret ="Y" then%>
                                    <span style="color:#888; padding:0 0 0 10px;"><i class="xi-lock xi-x"></i></span>
                                <% End if %>
                                <% if check_new=0 then %>
                                    <span style="color:#FF0000; padding:0 0 0 10px;"><i class="xi-newxi-x"></i></span>
                                <% End if %>
                            </td>
                            <td width="100px" class="tob2"><%=repl_ans%></td>
                            <td width="130px" class="tob2"><%=user_nm%></td>
                            <td width="130px"  class="tob2"><%=ins_dt%></td>
                            <td width="100px" class="tob2"><%=hit%></td>
                        </tr>
                    </table>

                    <div  id="bar<%=i%>">
                        <div id="submenu<%=i%>" style="display: none;">
                            <table>
                                <tr bgcolor="#FFFFFF">
                                    <td width="100px" class="tob1"></td>
                                    <td width="100px" class="tob2"></td>
                                    <td width="100px" class="tob2"></td>
                                    <td width="*%" class="tob4">
                                    	<div style="padding:15px 0px 0px 0px;"><i class="xi-call xi-x"></i> <%=tot_hp%>&nbsp;&nbsp;&nbsp;&nbsp;<i class="xi-mail xi-x"></i> <%=email%>&nbsp;&nbsp;&nbsp;&nbsp;<i class="xi-lock xi-x"></i> <%=pwd%></div> 
                                    	<div style="padding:15px 0px 0px 0px;font-weight:500;font-size:16px;">질문내용</div> 
                                    	<div style="padding:8px 0px 25px 0px;"><%=con_tents%></div> 
                                    	<div align="center">
                                            <span class="button_b" style="padding:0px 2px"><a href="qna_reply.asp?num=<%=num%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>">답변</a></span>
                                            <span class="button_b" style="padding:0px 2px"><a onclick="modify('<%=num%>')">수정</a></span>
                                    	</div>
                                    	<div class="pb30"></div> 
                                    </td>
                                    <td width="100px" class="tob2"></td>
                                    <td width="130px" class="tob2"></td>
                                    <td width="130px"  class="tob2"></td>
                                    <td width="100px" class="tob2"></td>
                                </tr>
                                <%   
                                    sql2 = " select  num, user_nm,user_id, title,con_tents, email, ref, ref_level, deep ,ins_dt  "
                                    sql2 = sql2 & " from  "&tbl&" "
                                    sql2 = sql2 & " where ref = " & num
                                    sql2 = sql2 & " and del_yn = 'N' and ref_level > 0 "
                                    sql2 = sql2 & " order by ref_level asc"
                
                                    Set Rs1 = objConn.Execute(sql2)
                
                                    IF NOT (rs1.eof or rs1.bof) then
                                        k=1
                                        Do until Rs1.EOF
                
                                            r1_num = Rs1("num") 
                                            r_content = Rs1("con_tents")
                                                if r_content <>"" then
                                                    r_content = Replace(r_content,chr(13)&chr(10),"<br>")	
                                                end if
                                
                                            r_user_nm = Rs1("user_nm") 
                                %>
                                <tr>
                                    <td width="100px" class="tob1"></td>
                                    <td width="100px" class="tob2"></td>
                                    <td width="100px" class="tob2"></td>
                                    <td width="*%" class="tob4">
                                        <div style="padding:15px 0px 0px 0px;font-weight:500; font-size:16px;">답변내용</div> 
                                        <div style="padding:8px 0px 25px 0px;"><%=r_content%></div> 
                                        <div align="center">
                                            <span class="button_b" style="padding:0px 2px"><a onclick="modify('<%=r1_num%>')">수정</a></span>
                                            <span class="button_b" style="padding:0px 2px"><a onclick="del('<%=r1_num%>')">삭제</a></span>
                                        </div>
                                        <div class="pb30"></div> 
                                    </td>
                                    <td width="100px" class="tob2"></td>
                                    <td width="130px" class="tob2"></td>
                                    <td width="130px"  class="tob2"></td>
                                    <td width="100px" class="tob2"></td>
                                </tr> 
                                <%
                                            Rs1.movenext
                                            k=k+1
                
                                        loop
                
                                    End if
                                    Rs1.close : Set Rs1 = nothing
                                %>
                            </table>
                        </div>
                    </div>
                <%
                
                            Rs.movenext
                            i=i+1
                        r_num = r_num - 1
                        Loop
                
                    End if
                
                    CloseRs Rs
                %>
                
                <% If rcnt=1 then %>
                    <div class="pb20"></div> 
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="100px" align="center"><span class="button_b"><a href="javascript:deleteMailList();">삭제</a></span></td>
                            <td align="center">
                                <div class="paginate1">
                                    <div align=center>
                                        <% Call fn_goPage(gotopage,pagecount,pageblock,"qna_list.asp", "&s_cont="&s_cont&"&cont="&cont) %>
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


    function modify(n){
        location.href="qna_ins.asp?num="+n+"&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>";
    }


    function del(n){
        if(confirm("정말로 삭제하시겠습니까?")){
            location.href="qna_del.asp?num="+n+"&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>";
        }
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
                document.form1.action = "relation_del.asp?asp_file=qna_list&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>&cartseq="+res;
                document.form1.submit();
            }else{
                location.href="qna_list.asp?gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>";
                return false;
            }

        }

    }
//-->
</script>

