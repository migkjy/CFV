<!--#include virtual="/home/conf/config.asp"--> 
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->


<% 
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
 
    If memid = "" Or pwd = "" Or memnum = ""  Then
        response.write "<script language='javascript'>  "
        Response.write " alert('로그인정보없습니다..'); "
        Response.write " self.close();"
        response.write "</script> " 
        response.end
    End if
      
    OpenF5_DB objConn
    			
    Response.Expires=0
  
  
          sql = " SELECT  room_group  FROM TB_member where memid= '"&memid&"' "
                    Set Rs = objConn.Execute(sql)
                    room_group_k  = Trim(Rs("room_group"))
                    Rs.close  : Set Rs = nothing
                    
                    
    
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
                
  
    If s_cont="" or isnull(s_cont) then
        s_cont2="kname"
    Else
        Select Case Ucase(s_cont)
            Case "S": s_cont2="kname"
            Case "C": s_cont2="memid"
        End Select
     End if 

     ans = " and " & s_cont2 & " like '%" & cont & "%' "

     sql = "select  num, memid,  kname,htel,room_group from TB_member where room_group='"&room_group_k&"' and htel<>'"&cu_htel&"' and kname not in('youngmoon', 'wsjang', 'jinwoojung', 'seyounoh', 'klyoulpark', 'wildflower', 'dyer')"
     'sql = "select  num, memid,  kname,htel from TB_member"
     if cont <> "" then sql = sql & ans
     sql = sql & " order by num desc "
    ' response.write sql
     Set Rs = Server.CreateObject("ADODB.RecordSet")
     Rs.open sql,objConn,3
 
     rs_cnt = rs.RecordCount
     If rs_cnt > 0 then 
          Page_Count = 7
          rs.PageSize = Page_Count
          rs.AbsolutePage = PageNo
          Page_List = 4
     End If
%>

<!DOCTYPE html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />
<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">

<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
<script type="text/javascript" language="javascript" src="/mobile/js/jquery-2.2.3.min.js"></script>
</head>

<body>
	
	<div class="pt5"></div>

	<div style="font-size:0.69em;">
	   대규모 인원의 객실배정 및 예약으로 인하여 객실 배정은 2인 1실로 운영하고 있습니다.<br>
	   신청을 하지 않으신 분은 미 신청자 내에서 임의로 룸메이트배정을 도와드릴 예정이니 참고 부탁 드립니다.
	   룸메이트는 같은 <strong>"팀"strong> 구성원 별로 신청해 주셔야 합니다.<br>
	   eg) A팀 선택 구성원과 B팀 구성원 룸메이트 배정 불가
<br>
	   
	   현재 나의 팀: <%=room_group_k%> 팀	   
	</div>
	<div class="pt10"></div>
        <div style="border-top:1px solid #EAEAEA; "></div> 
	<div class="pt10"></div>

    <form name="form1" method="post" action="matching.asp "  style="display:inline; margin:0px;">
        
        <div class="matc_list">
            <table>
                <tr>
                    <td width="30%">
                        <select name="s_cont" class="ser_select" style="width:100%;">
                            <option value="S" <% if s_cont = "S" then %>selected<% end if %>>한글명</option>
                            <option value="C" <% if s_cont = "C" then %>selected<% end if %>>이메일</option>
                        </select>
                    </td>
                    <td width="2%"></td>
                    <td width="*%"><input type="text" name="cont" value=""<%=cont%>" style="width:80%;" class="ser_input"></td>
                    <td width="2%"></td>
                    <td width="20%"><div class="ser_ok"><a onclick="chk_frm();"><span style="color:#FFFFFF;">검색</span></a></div></td>
            
                </tr>
            </table>
        </div>

        <div class="pt15"></div> 
        
        <div style="border-top:2px solid #000; "></div> 
        <div class="matc_list">
            <table>
                 <%  If  (Rs.eof or Rs.bof) then   %>
                <tr>
                    <td width="17%" class="top1">No</td>
                    <td width="*%" class="top2">한글명</td>
                    <td width="25%" class="top2">이메일</td>
                    <td width="20%" class="top2">매칭</td>
                    <td width="16%" class="top2">비고</td>
                </tr>
                <tr>
                    <td class="tob3" colspan="5">회원이 존재하지 않습니다.</td>
                </tr>
               <%
                  else
                %>
                <tr>
                    <td width="17%" class="top1">No</td>
                    <td width="*%" class="top2">한글명</td>
                    <td width="25%" class="top2">이메일</td>
                    <td width="20%" class="top2">매칭</td>
                    <td width="16%" class="top2">비고</td>
                </tr>
                <%
                   if rs.PageCount = PageNo then
			                      
                    ListLoop = rs_cnt Mod rs.PageSize
			                      
                    if ListLoop = 0 then ListLoop = rs.PageSize 
                    else 
                        ListLoop = rs.PageSize
                    end if
		                        
                    n = rs_cnt - (pageno-1) * rs.PageSize 
                    ny = (pageno - 1) * rs.PageSize + 1 
                                
                    For k = 1 to ListLoop
                            
                        knum =rs("num")
                        memid =rs("memid")
                        kname =rs("kname")
                        htel =rs("htel")
                        room_group  =rs("room_group")
                         
                        cntSql = "select count(*) from TB_sel_memo where send_hp = '"&htel&"' and app_gubn = '0' and del_yn='N'"
                        Set cntRs = Server.CreateObject("ADODB.RecordSet")
                        cntRs.open cntSql,objConn
                        if cntRs.eof or cntRs.bof then
                            me_Cnt = 0
                        else
                            me_Cnt = cntRs(0)
                        end if
                        CloseRs cntRs
                             
                             
                        ' cntSql = "select cu_nm_kor,cu_hp  from TB_sel_memo where (send_hp = '"&htel&"' or  cu_hp  = '"&htel&"')  and app_gubn = '1' and del_yn='N'"
                        ' Set cntRs = Server.CreateObject("ADODB.RecordSet")
                        ' cntRs.open cntSql,objConn
                        ' if not cntRs.eof or not cntRs.bof then
                                 
                        ' cu_hp_hp =cntRs("cu_hp")
                        ' end if
                        ' CloseRs cntRs
                             
                             
                        cntSql = "select count(*) from TB_sel_memo where (send_hp = '"&htel&"' or  cu_hp  = '"&htel&"') and app_gubn = '1' and del_yn='N'"
                        ' response.write  cntSql &"<br>"
                        Set cntRs = Server.CreateObject("ADODB.RecordSet")
                        cntRs.open cntSql,objConn
                        if cntRs.eof or cntRs.bof then
                            fixme_Cnt = 0
                        else
                            fixme_Cnt = cntRs(0)
                        end if
                        CloseRs cntRs
                        
                        if fixme_Cnt >= 1 then
                            cls1 ="color:#FF5001;"
                        else
                            cls1 ="color:#000;"
                        end if
                %>
                <tr>
                    <td class="tob1"><span style="<%=cls1%>"><%=ny%></span></td>
                    <td class="tob2"><span style="<%=cls1%>"><%=kname%></span></td>
                    <td class="tob2"><span style="<%=cls1%>"><%=memid%></span></td>
                    <% if fixme_Cnt >= 1 then %>
                    <td class="tob2"><span class="matc_end">확정</span></td>
                    <% else %>
                    <td class="tob2"><a onClick="g_check('<%=knum%>')";return false;" style="cursor:pointer;"><span class="matc_ok">신청</span></a></td>
                    <% end if %>
                    <td class="tob2"><span style="<%=cls1%>"><%=room_group%>팀</span></td>
                </tr>
                <%
                        n=n-1
                        ny=ny+1                        
                        rs.MoveNext
                      
                    Next
                %>
                 <%
                       ' response.end
                    End if 
                %>
            </table>
        </div>
        
        <div class="paginate3">
            <% If rs.PageCount > Page_List then %>
                <% if StartPage <> 1 then %>
                    <a href="matching.asp?pageno=<%=StartPage-Page_List%>&startpage=<%=StartPage-Page_List%>&s_cont=<%=s_cont%>&cont=<%=cont%>" class="direction">이전</a>&nbsp;&nbsp;
                <% else %>
                    <span class='direction'><<</span>&nbsp;&nbsp;
                <% end if %>
		        		
                <% For CurrentPage = StartPage to StartPage+Page_List-1 %>
                    <%          
                        if CurrentPage > rs.PageCount then 
                            exit for 
                        else if CurrentPage = PageNo then
                    %>
                        <strong><%=CurrentPage%></strong>&nbsp;&nbsp;
                        <% else %> 
                            <a href="matching.asp?pageno=<%=CurrentPage%>&startpage=<%=StartPage%>&s_cont=<%=s_cont%>&cont=<%=cont%>"><%=CurrentPage%></a>&nbsp;&nbsp;
                        <% end if %>
                    <% end if %>        
                <% Next %>
		    		
                <% if ((StartPage\Page_List) <> (rs.PageCount\Page_List)) then %>
                    <% if CurrentPage > rs.PageCount then %>
                        <span class="direction">>></span>
                    <% else %>
                        <a href="matching.asp?pageno=<%=CurrentPage%>&startpage=<%=CurrentPage%>&s_cont=<%=s_cont%>&cont=<%=cont%>" class="direction">다음</a>
                    <% end if %>
                <% else %>
                    <span class="direction">>></span>
                <% end if %>
        
            <% Else %>
                <span class='direction'><<</span>&nbsp;&nbsp;
                <% 
                    For CurrentPage = StartPage to rs.PageCount
                        if CurrentPage = PageNo then 
                %>
                    <strong><%=CurrentPage%></strong>&nbsp;&nbsp;
                <% else %>
                    <a href="matching.asp?pageno=<%=CurrentPage%>&s_cont=<%=s_cont%>&cont=<%=cont%>"><%=CurrentPage%></a>&nbsp;&nbsp;
                <% 	
                        end if
                    Next
                %>
                <span class="direction">>></span>
            <% End if %>
        </div>

        <div class="board_btn_s">
            <ul class="btn_r">
                <li class="gray"><a href="matching.asp">목록</a></li>	
                <li><a onclick="javascript:self.closeIframe();return false;" style="cursor:pointer;">닫기</a></li>		
            </ul>
        </div>
        
       

    </form>
 
</body>
</html>

<script language="javascript">
<!--
    function closeIframe(){
        parent.$('#pop_matching').dialog('close');
        return false;
    }
    
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
        //alert (urlk);
        f.action = urlk;
        //  f.target = "ifmchk_frmk";
        f.submit();
    }    
//-->
</script> 
