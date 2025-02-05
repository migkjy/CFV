<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<%
  OpenF5_DB objConn
    			
    Response.Expires=0
    
    If Request("pageno")="" then
        PageNo = 1
    Else
        PageNo = CInt(Request("pageno"))
    End if
        
    If Request("startpage")="" then
        StartPage = 1
    Else
        StartPage = CInt(Request("startpage"))
    End if
        	
    s_frm = Request("s_frm")
    cont = Request("cont")
    
    s_cont = Request("s_cont")
    s_cont = Replace(s_cont,"'","") 
                
  


     sql = "select  num, send_name, send_hp, app_gubn, ins_dt, cu_nm_kor, cu_hp, cu_memid, del_yn from TB_sel_memo where app_gubn='1'"

    if s_cont ="S" then
       sql = sql & "  and send_name  like '%" & cont & "%'   or  cu_nm_kor like '%" & cont & "%'"
     end if  

     if s_cont ="C" then
       sql = sql & "  and send_hp  like '%" & cont & "%'   or  cu_hp like '%" & cont & "%'"
     end if  
  
   '  if cont <> "" then sql = sql & ans
     sql = sql & " order by ins_dt desc "
    ' response.write sql
     Set Rs = Server.CreateObject("ADODB.RecordSet")
     Rs.open sql,objConn,3
 
     rs_cnt = rs.RecordCount
     If rs_cnt > 0 then 
          Page_Count = 15
          rs.PageSize = Page_Count
          rs.AbsolutePage = PageNo
          Page_List = 10
     End If
  
%>

<!DOCTYPE html>
<html>
<head>
<title>룸메이트 매칭현황</title>
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
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 룸메이트 매칭현황</div>

        <form name="form1" method="post"style="display:inline; margin:0px;">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
                <tr>
                    <td>
                        <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                               <td class="bin_pa" width="130px">
                                    <select name="s_cont" class="select_basic" style="width:100%;">
                                        <option value="S" <% if s_cont = "S" then %>selected<% end if %>>한글명</option>
                                        <option value="C" <% if s_cont = "C" then %>selected<% end if %>>휴대전화 뒷자리</option>
                                    </select>
                               </td>
                               <td class="bin_pa" width="400px"><input type="text" name="cont" value="<%=cont%>"class="input_basic" style="width:99%;"></td>
                               <td class="bin_pb" width="*%">
                                   <span style="padding:0 8px 0 0;"><img src="/admin/images/top_ser.png" border="0" onclick="chk_frm();" style="cursor:pointer;border-radius:2px;"></span>   
                                   <span style="padding:0 8px 0 0;"><img src="/admin/images/top_list.png" border="0" onClick="location.href='matching_list.asp'" style="cursor:pointer;border-radius:2px;"></span>
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
                <% If rs_cnt = 0 then %>
                <tr>
                    <td width="6%" class="top1" rowspan="2">No</td>
                    <td width="30%" class="top2" colspan="2">매칭 받은사람</td>
                    <td width="30%" class="top2" colspan="2">매칭 보낸사람</td>
                    <td width="10%" class="top2" rowspan="2">매칭</td>
                    <td width="15%" class="top2" rowspan="2">매칭 신청일</td>
                    <td width="*%" class="top2" rowspan="2">취소</td>
                </tr>
                <tr>
                    <td width="14%" class="top2">한글명</td>
                    <td width="16%" class="top2">휴대전화번호</td>
                    <td width="14%" class="top2">한글명</td>
                    <td width="16%" class="top2">휴대전화번호</td>
                </tr>
                <tr>
                    <td class="tob1" colspan="8" style="padding:200px 0;">등록된 데이터가 없습니다.</td>
                </tr>
                <%
                        response.end
                    End if 
                %>
                <tr>
                    <td width="6%" class="top1" rowspan="2">No</td>
                    <td width="30%" class="top2" colspan="2">매칭 받은사람</td>
                    <td width="30%" class="top2" colspan="2">매칭 보낸사람</td>
                    <td width="10%" class="top2" rowspan="2">매칭</td>
                    <td width="15%" class="top2" rowspan="2">매칭 신청일</td>
                    <td width="*%" class="top2" rowspan="2">취소</td>
                </tr>
                <tr>
                    <td width="14%" class="top2">한글명</td>
                    <td width="16%" class="top2">휴대전화번호</td>
                    <td width="14%" class="top2">한글명</td>
                    <td width="16%" class="top2">휴대전화번호</td>
                </tr>
                <%
                    if rs.PageCount = PageNo then
			                      
                    ListLoop = rs_cnt Mod rs.PageSize
			                      
                    if ListLoop = 0 then ListLoop = rs.PageSize 
                    else 
                        ListLoop = rs.PageSize
                    end if
		                        
                    n = rs_cnt - (pageno-1) * rs.PageSize 
                          
                                
                    For k = 1 to ListLoop
                            
                        knum =rs("num")
                        send_name =rs("send_name")
                        send_hp =rs("send_hp")
                        app_gubn =rs("app_gubn")
                        ins_dt =rs("ins_dt")
                        k_cu_nm_kor =rs("cu_nm_kor")
                        k_cu_hp =rs("cu_hp")
                        k_cu_memid =rs("cu_memid")                       
                %>
                <tr>
                    <td class="tob1"><%=k%></a></td>
                    <td class="tob2"><%=send_name%></td>
                    <td class="tob2"><%=send_hp%></td>
                    <td class="tob2"><%=k_cu_nm_kor%></td>
                    <td class="tob2"><%=k_cu_hp%></td>
                    <td class="tob2">확정</td>
                    <td class="tob2"><%=ins_dt%></td>
                    <td class="tob2"><a onClick="g_check('<%=knum%>')";return false;" style="cursor:pointer;"><img src="/admin/images/top_bk_2.png" border="0"></a></td>
                </tr>
                <%
                        n=n-1
                        rs.MoveNext
                  
                    Next
                %>
            </table>
        </div> 
        
        <div class="pb20"></div> 
        
        <div class="paginate1">
            <% If rs.PageCount > Page_List then %>
                <% if StartPage <> 1 then %>
                    <a href="matching_list.asp?pageno=<%=StartPage-Page_List%>&startpage=<%=StartPage-Page_List%>&s_cont=<%=s_cont%>&cont=<%=cont%>" class="direction">이전</a>&nbsp;&nbsp;
                <% else %>
                    <span class='direction'>이전</span>&nbsp;&nbsp;
                <% end if %>
		        		
                <% For CurrentPage = StartPage to StartPage+Page_List-1 %>
                    <%          
                        if CurrentPage > rs.PageCount then 
                            exit for 
                        else if CurrentPage = PageNo then
                    %>
                        <strong><%=CurrentPage%></strong>&nbsp;&nbsp;
                        <% else %> 
                            <a href="matching_list.asp?pageno=<%=CurrentPage%>&startpage=<%=StartPage%>&s_cont=<%=s_cont%>&cont=<%=cont%>"><%=CurrentPage%></a>&nbsp;&nbsp;
                        <% end if %>
                    <% end if %>        
                <% Next %>
		    		
                <% if ((StartPage\Page_List) <> (rs.PageCount\Page_List)) then %>
                    <% if CurrentPage > rs.PageCount then %>
                        <span class="direction">다음</span>
                    <% else %>
                        <a href="matching_list.asp?pageno=<%=CurrentPage%>&startpage=<%=CurrentPage%>&s_cont=<%=s_cont%>&cont=<%=cont%>" class="direction">다음</a>
                    <% end if %>
                <% else %>
                    <span class="direction">다음</span>
                <% end if %>
        
            <% Else %>
                <span class='direction'>이전</span>&nbsp;&nbsp;
                <% 
                    For CurrentPage = StartPage to rs.PageCount
                        if CurrentPage = PageNo then 
                %>
                    <strong><%=CurrentPage%></strong>&nbsp;&nbsp;
                <% else %>
                    <a href="matching_list.asp?pageno=<%=CurrentPage%>&s_cont=<%=s_cont%>&cont=<%=cont%>"><%=CurrentPage%></a>&nbsp;&nbsp;
                <% 	
                        end if
                    Next
                %>
                <span class="direction">다음</span>
            <% End if %>
        </div>
    </form>
    </div>
        
</body>
</html>
<script language="javascript">
<!--
  
    
   function chk_frm(){
      if (document.form1.cont.value==""){
        alert("검색어를  입력해 주세요.");
        return false;
      }
      document.form1.submit();
    }
    
     function g_check(k){
        var	f = document.form1;
        var urlk = "g_check.asp?knum="+k
      //  alert (urlk);
        f.action = urlk;
          f.target = "ifmchk_frm";
        f.submit();
    }    
//-->
</script> 

<%
    CloseF5_DB objConn 
%>


<iframe name="ifmchk_frm" id="ifmchk_frm" src="about:blank"  allowTransparency=true width="0" height="0" marginwidth="0" marginheight="0" vspace="0" scrolling="no" frameborder="0" framespacing="0" frameborder="0"></iframe>