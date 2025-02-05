<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    Response.AddHeader	"Expires","0"
%>

<!DOCTYPE html>
<html>
<head>
<title>상품코드</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 상품코드 관리</div>

        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" id="bottom_table">
            <tr> 
                <td width="*%">
                    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="top" id="left_table"><iframe name="ifmLeft" id="ifmLeft" src="base.asp"  allowTransparency=true width="100%" height="100%" marginwidth="0" marginheight="0" vspace="0" scrolling="no" frameborder="0" framespacing="0" frameborder="0"></iframe></td>
                        </tr>
                    </table>
                </td>
                <td width="1%"></td>
                <td width="63%">
                    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="top" id="main_table"><iframe name="ifmMain" id="ifmMain" src="base_contents.asp"  allowTransparency=true width="100%" height="100%" marginwidth="0" marginheight="0" vspace="0" scrolling="no" frameborder="0" framespacing="0" frameborder="0"></iframe></td>
                        </tr>
                    </table>
                </td>		
            </tr>
        </table>
        
    </div>
        
</body>
</html>
    
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
 <script type="text/javascript" language="javascript" src="/admin/scripts/jquery.iframeResizer.min.js"></script>

    <script type="text/javascript">
        $('iframe').iFrameSizer({
            log                    : true,  // For development
            autoResize             : true,  // Trigering resize on events in iFrame
            contentWindowBodyMargin: -3,     // Set the default browser body margin style (in px)
            doHeight               : true,  // Calculates dynamic height
            	doWidth                : false, // Calculates dynamic width
            enablePublicMethods    : false,  // Enable methods within iframe hosted page 
            interval               : 0,     // interval in ms to recalculate body height, 0 to disable refreshing
            scrolling              : false, // Enable the scrollbars in the iFrame
            callback               : function(messageData){ // Callback fn when message is received
                $('p#callback').html(
                    ' <b>Frame ID:</b> '    + messageData.iframe.id +
                    ' <b>Height:</b> '     + messageData.height +
                    ' <b>Width:</b> '      + messageData.width + 
                    ' <b>Event type:</b> ' + messageData.type
                );
            }
        });
    </script>