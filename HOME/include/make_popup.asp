<%
    OpenF5_DB objConn	
	newwin = 1

	sql = "SELECT * FROM newwin WHERE no="&newwin
    Set Rs = objConn.Execute(Sql)
	
	if not RS.EOF then 
	dia_pop = RS("pop")
	width   = RS("width")
	height  = RS("height")
	content = rs("newwin") 
	end if
%>

<% if dia_pop="Y" then %>
    <script language="JavaScript" type="text/JavaScript">
        function setCookie( name, value, expiredays ) { 
            var todayDate = new Date(); 
                todayDate.setDate( todayDate.getDate() + expiredays ); 
                document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
            } 
        
        function closeWin() { 
            if ( document.notice_form.chkbox.checked ){ 
                setCookie( "maindiv", "done" , 1 ); 
            } 
            document.all['divpop'].style.visibility = "hidden";
        }
    </script>
    
    <div id="divpop" style="width:100%;height:auto;background:url('/images/main/pop_bg.png');position:absolute;z-index:1000;visibility:hidden;">
        <div style="padding:260px 0px 3480px 0px;">
            <div align="center">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td><div class="pup_img"><%=content%></div></td>
                    </tr>
                    <tr height="45">
                        <td align="center">	
                            <form name="notice_form" style="display:inline; margin:0px;">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="70%"style="padding:0px 0px 0px 1px"><span class="checks"><input type="checkbox" name="chkbox" id="chkbox" value="checkbox"><label for="chkbox"><span style="color:#FFFFFF; font-size:15px;">다시보지 않기</span></label></span></td>
                                        <td width="*%" style="padding:0px 10px 0px 0px" align="right"><a href="javascript:closeWin();"><img src="/images/main/close.png" border="0"></a></td>
                                    </tr>
                                </table>
                            </form>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    
    <script language="Javascript">
        cookiedata = document.cookie;    
        if ( cookiedata.indexOf("maindiv=done") < 0 ){      
            document.all['divpop'].style.visibility = "visible";
            } 
            else {
                document.all['divpop'].style.visibility = "hidden"; 
        }
    </script>

<%
	end if
    CloseRs Rs 
    CloseF5_DB objConn  
%>