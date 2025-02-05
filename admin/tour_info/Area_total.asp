<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<!DOCTYPE html>
<html>
<head>
<title>지역정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" language="javascript" src="/admin/scripts/jquery.iframeResizer.min.js"></script>
</head>
<body>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>                    
            <td width="15%" valign="top"><iframe src="area_menu.asp" width="99%" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" id="data_ev001_1" name="data_ev001_1"></iframe></td>
            <td width="*%" valign="top"><iframe src="nat_detail.asp" width="99%" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" id="data_ev001_2" name="data_ev001_2"></iframe></td>
        </tr>
    </table>
    
</body>
</html>

<script type="text/javascript">
    $('iframe').iFrameSizer({
        log : true,
        autoResize : true,
        contentWindowBodyMargin: 700, 
        doHeight : true,
        doWidth : false,
        enablePublicMethods : false,
        interval : 0, 
        scrolling : false,
        callback : function(messageData){
            $('p#callback').html(
                ' <b>Frame ID:</b> '    + messageData.iframe.id +
                ' <b>Height:</b> '     + messageData.height +
                ' <b>Width:</b> '      + messageData.width + 
                ' <b>Event type:</b> ' + messageData.type
            );
        }
    });
</script>
