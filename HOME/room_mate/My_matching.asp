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
        response.write "</script>                             " 
        response.end
    End if
    
    
    OpenF5_DB objConn
    			
    Response.Expires=0
    
    send_hp =  Request("send_hp")
    
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
        	

    sql = "select  num, cu_hp, cu_nm_kor  from TB_sel_memo where send_hp = '"&send_hp&"' and app_gubn = '0' and del_yn='N' "
    sql = sql & " order by num desc "
     'response.write sql
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3
 
    rs_cnt = rs.RecordCount
    If rs_cnt > 0 then 
        Page_Count = 20
        rs.PageSize = Page_Count
        rs.AbsolutePage = PageNo
        Page_List = 10
    End if
%>

<!DOCTYPE html>
<html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
</head>

<body>
	
	<form name="form1" method="post"style="display:inline; margin:0px;">
	
        <div class="pt15"></div>
        <div style="border-top:1px solid #000; "></div> 
        <div class="matc_list">
            <table>
                <% If rs_cnt = 0 then %>
                <tr>
                    <td width="10%" class="top1">No</td>
                    <td width="*%" class="top2">한글명</td>
                    <td width="40%" class="top2">휴대전화번호</td>
                    <td width="17%" class="top2">매칭</td>
                </tr>
                <tr>
                    <td class="tob3" colspan="5">회원이 존재하지 않습니다.</td>
                </tr>
                <%
                        response.end
                    End if 
                %>
                <tr>
                    <td width="10%" class="top1">No</td>
                    <td width="*%" class="top2">한글명</td>
                    <td width="40%" class="top2">휴대전화번호</td>
                    <td width="17%" class="top2">매칭</td>
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
                         cu_nm_kor	=rs("cu_nm_kor")
                         cu_hp =rs("cu_hp")
                %>
                <tr>
                    <td class="tob1"><%=k%></td>
                    <td class="tob2"><%=cu_nm_kor%></td>
                    <td class="tob2">OOO︎ - OOOO - <%=right(cu_hp,4)%></td>
                    <td class="tob2"><a onClick="g_check('<%=cu_hp%>')";return false;" style="cursor:pointer;"><span class="matc_ok">승인</span></a></td>
                </tr>
                <%
                        n=n-1
                        rs.MoveNext
                      
                    Next
                %>
            </table>
        </div>
        
        <!--
        <div class="paginate2">
            <% If rs.PageCount > Page_List then %>
                <% if StartPage <> 1 then %>
                    <a href="my_matching.asp?pageno=<%=StartPage-Page_List%>&startpage=<%=StartPage-Page_List%>" class="direction">이전</a>&nbsp;&nbsp;
                <% else %>
                    <span class='direction'><<</span>&nbsp;&nbsp;
                <% end if %>
		        		
                <% For CurrentPage = StartPage to StartPage+Page_List-1%>
                    <%
                        if CurrentPage > rs.PageCount then 
                            exit for 
                        else if CurrentPage = PageNo then
                    %>
                        <strong><%=CurrentPage%></strong>&nbsp;&nbsp;
                        <% else %> 
                            <a href="my_matching.asp?pageno=<%=CurrentPage%>&startpage=<%=StartPage%>"><%=CurrentPage%></a>&nbsp;&nbsp;
                        <% end if %>
                    <% end if %>        
                <% Next %>
		    		
                <% if ((StartPage\Page_List) <> (rs.PageCount\Page_List)) then %>
                    <% if CurrentPage > rs.PageCount then %>
                        <span class="direction">>></span>
                    <% else %>
                        <a href="my_matching.asp?pageno=<%=CurrentPage%>&startpage=<%=CurrentPage%>" class="direction">다음</a>
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
                    <a href="my_matching.asp?pageno=<%=CurrentPage%>"><%=CurrentPage%></a>&nbsp;&nbsp;
                <% 	
                        end if
                    Next
                %>
                <span class="direction">>></span>
            <% End if %>
        </div>
        -->
    
       <div class="pt15"></div>
       <div class="board_btn_s">
            <ul class="btn_r">
                <li><a onclick="javascript:self.closeIframe();return false;" style="cursor:pointer;">닫기</a></li>		
            </ul>
        </div>
       <iframe name="ifmchk_frmk" id="ifmchk_frmk" src="about:blank"  allowTransparency=true width="0" height="0" marginwidth="0" marginheight="0" vspace="0" scrolling="yes" frameborder="0" framespacing="0" frameborder="0"></iframe>
   
    </form>
 
</body>
</html>

<script language="javascript">
<!--
    function closeIframe(){
        parent.$('#chain_maching').dialog('close');
        return false;
    }
    
    function g_check(k){
        var	f = document.form1;
        var urlk = "my_check.asp?cu_hp="+k
        //alert (urlk);
        f.action = urlk;
        //  f.target = "ifmchk_frmk";
        f.submit();
    }    
//-->
</script> 
