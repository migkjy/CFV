<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
    OpenF5_DB objConn

    newwin = 1

    sql = "SELECT * FROM newwin WHERE no="&newwin
    
    set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3,1

     r_content = RS("newwin")
%>
    
<!DOCTYPE html>
<html>
<head>
<title>팝업관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/seditor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 팝업관리</div>

        <form name="form" method="post" action="popup.asp" style="display:inline; margin:0px;">
            <div class="table_box">
                <table>
                    <tr>
                        <td class="lop1" width="12%">내 용</td>
                        <td class="lop4" width="*%"><textarea name="ir_1" id="ir_1" style="width:1168px;height:550px; display:none;"><%=r_content%></textarea></td>
                    </tr>
                    <tr>
                        <td class="lob1">사이즈</td>
                        <td width="*%" class="lob2">
                            <span>WIDTH<span>
                            <span style="padding:0px 20px 0px 10px;"><input type="text" name="width" value="<%=RS("width")%>"  size="10" maxlength="3" class="input_color" onblur = CheckNumber(this)></span>
                            <span>HEIGHT<span>
                            <span style="padding:0px 20px 0px 10px;"><input  type="text" name="height" value="<%=RS("height")%>"size="10" maxlength="3" class="input_color" onblur = CheckNumber(this)></span>
                            <span class="checks"><input type="checkbox" name="status" id="status_check" value="Y" <% if RS("pop")="Y" then %> checked <% end if %>><label for="status_check">팝업창 적용</label></span>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="pt25"></div>   
            
            <div align="center">
                <span class="button_b"><a onclick="javascript:pop_check();">수정</a></span>
            </div>
        </form>
        
    </div>
    
</body>
</html>
 
<%
    CloseRs RS 
    CloseF5_DB objConn
%>

<script language="javascript">
<!--
    	function CheckNumber(fl) 
    	{
    		t = fl.value ;
    	
    		for(i=0;i<t.length;i++) 
    		if (t.charAt(i)<'0' || t.charAt(i)>'9') {
    			alert("숫자만 입력해주세요.") ;
    			fl.value="";
    			fl.focus() ;
    			return false ;
    		}
    	}

//-->
</script>

<script type="text/javascript">
<!--
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ir_1",
        sSkinURI: "/seditor/SmartEditor2Skin.html",	
        htParams : {
            bUseToolbar : true,	
            bUseVerticalResizer : false,
            bUseModeChanger : true,
            fOnBeforeUnload : function(){
			
            }
        }, 
            fOnAppLoad : function(){
        },
        fCreator: "createSEditor2"
    });

    
    function pop_check(){
        if (document.form.width.value == ""){
            alert("가로길이를 넣어주세요.");
            document.form.width.focus();
        }
        else if (document.form.height.value == ""){
            alert("세로길이를 넣어주세요.");
            document.form.height.focus();
        }
        else
    			
        oEditors.getById["ir_1"].exec("UPDATE_CONTENTS_FIELD", []);
        document.form.submit();
    }
//-->
</script>

