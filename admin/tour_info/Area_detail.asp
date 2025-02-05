<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
 <script type="text/javascript" language="javascript" src="/admin/scripts/jquery.iframeResizer.min.js"></script>
<script type="text/javascript" src="/webnote/webnote.js"></script>
<script type="text/javascript">
<!--
    webnote_config = {
        attach_proc: "/webnote/webnote_attach.asp",
        delete_proc: "/webnote/webnote_delete.asp",
        allow_dndupload: true,
        allow_dndresize: true	
    }
//-->
</script>
</head>

<body>
	
    <div style="padding:47px 0px 50px 15px;">
    	
        <%
            OpenF5_DB objConn
            
            nat_cd = Request("nat_cd")
            city = Request("city")
            
            sql = " select a.nm_kor, a.nm_eng, b.description "
            sql = sql & " from TB_ti200 a LEFT OUTER JOIN   TB_ti210 b  ON a.nat_cd = b.nat_cd and  a.city_cd = b.city_cd "
            sql = sql & " where a.nat_cd = '"& nat_cd &"' "
            sql = sql & " and a.city_cd  = '"& city &"' "
           'response.write sql 
            set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sql,objConn,3
            
            If not rs.EOF Then
        %>
    
            <form name="info_frm" method="post" style="display:inline; margin:0px;">
            <input type="hidden" name="admin_action" value="info_city">
            <input type="hidden" name="nat_cd" value="<%=nat_cd%>">
            <input type="hidden" name="city_cd" value="<%=city%>">
            
                <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #C0C0C0;height:42px;">
                    <tr>
                        <td>
                            <table width="100%" border="0">
                                <tr>
                                    <td width="50%" class="f_sujet">■ <%=Rs("nm_kor")%> (<%=Rs("nm_eng")%>)</td>
                                    <td width="*%" align="right" style="padding:0 20px 0 0;"><span class="button_a"><a onclick="javascript:open_win00('https://www.google.co.kr/maps');return false;">구글좌표찾기</a></span></td>
                                </tr>
                            </table>
                        </td>
                     </tr>
                </table>

                <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-left:1px solid #C0C0C0;border-right:1px solid #C0C0C0;border-bottom:1px solid #C0C0C0;">
                    <tr>
                        <td bgcolor="#FFFFFF" style="padding:10px 0px 10px 10px;">
                            <% if Rs("description") <> "" or not isNull(Rs("description")) then %>
                                <textarea name="description" id="description" style="width:99%; border:1px solid #B1BE82; height:600px;" editor="webnote" tools="deny:images,superscript,subscript,strikethrough,emoticon,fullscreen,lineheight,indent,outdent,increase,decrease"><%= Replace(Rs("description"),Chr(13)&Chr(10),"")%></textarea>	
                            <% else %>
                                <textarea name="description" id="description" style="width:99%; border:1px solid #B1BE82; height:600px;" editor="webnote" tools="deny:images,superscript,subscript,strikethrough,emoticon,fullscreen,lineheight,indent,outdent,increase,decrease"><%=description%></textarea>
                            <% end if %>
                        </td>
                    </tr>
                </table>

                <div class="mgb10"></div>  

                <div align="center" style="padding:25px 0 0px 0;">
                    <span style="padding:0px 4px"><input type=image src="/admin/images/icon_write.png" border="0" style="cursor:point" onClick="info_frm_chk(this.form);return false;"></span>
                    <span style="padding:0px 4px"><input type=image src="/admin/images/icon_modify.png" border="0" style="cursor:point" onClick="chk_frm(this.form);return false;"></a></span>
                    <span style="padding:0px 4px"><input type=image src="/admin/images/icon_delete.png" border="0" style="cursor:point" onclick="del_frm(this.form);return false;"></a></span>
                </div>

                <div class="pb15"></div>
            
                <script language="javascript">
                    function info_frm_chk(frm){ 
                        var str;
                        str = document.info_frm.description.value;
                    
                        if(str == "") {
                            alert("도시정보를 입력해야 합니다.");
                            return true;
                        }
                        if(confirm("도시정보를 등록하시겠습니까?")){
                            frm.action="process.asp";
                            frm.submit();
                        }
                    }
                    
                    function chk_frm(frm){
                        if(confirm("도시정보를 수정하시겠습니까?")){
                            frm.action="process.asp?admin_action=info_city_modify";
                            frm.submit()
                        }
                    }
                    
                    function del_frm(frm){
                        if(confirm("도시정보를 삭제하시겠습니까?")){
                            frm.action="process.asp?admin_action=info_city_del";
                            frm.submit()
                        }
                    }
                </script>
            </form>
        	      
        	      
        <% Else %>
            왼쪽 지역을 선택하세요
        <%
            End If
        
            CloseRs Rs 
            CloseF5_DB objConn 
        %>
        
        <iframe src="area_detail_infor.asp?nat_cd=<%=nat_cd%>&city=<%=city%>" width="100%" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" id="data_ev001_2" name="data_ev001_2"></iframe>
    </div>
    
</body>
</html>


<script language="JavaScript" type="text/JavaScript">
    function open_win00(win11){
        window.open(win11,'new61','width=1200px,height=800,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no')
    }
</script>

<script type="text/javascript">
    $('iframe').iFrameSizer({
        log : true,
        autoResize : true,
        contentWindowBodyMargin: 0, 
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