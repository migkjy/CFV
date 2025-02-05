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
<script language="javascript" type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script language="javascript" type="text/javascript" src="/admin/scripts/iframeResizer.contentWindow.min.js"></script>
</head>

<body>

    <div style="padding:47px 0px 50px 15px;">

        <% nat_cd = Request("nat_cd") %>
        <form name="info_frm" method="post" style="display:inline; margin:0px;">
        <input type="hidden" name="admin_action" value="info_make">
        <input type="hidden" name="nat_cd" value="<%=nat_cd%>">
        <%
            OpenF5_DB objConn
            sql =        " select a.nm_kor, a.nm_eng, b.description "
            sql = sql & "    from TB_ti100 a LEFT OUTER JOIN  TB_ti110 b  ON a.nat_cd = b.nat_cd "
            sql = sql & "	    where a.nat_cd = '"& nat_cd &"' "
            sql = sql & "	    order by  b.nat_cd, b.desc_cd	"	
            set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sql,objConn,3
            
            If not rs.EOF Then
            description = Rs("description")
        %>

            <table  width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #C0C0C0;height:42px;">
                <tr>
                    <td class="f_sujet">■ <%=Rs("nm_kor")%> (<%=Rs("nm_eng")%>) </td>
                 </tr>
            </table>
        
            <div class="pb15"></div>


            <%
                if description <> "" or not isNull (description) then
                    description= Replace(Rs("description"),Chr(13)&Chr(10),"<br>")
            %>   
                <!--
                <table width="100%" border="0" cellpadding="10" cellspacing="1" bgcolor="#C0C0C0">
                    <tr>
                        <td bgcolor="#FFFFFF"><textarea name="description" id="description" style="width:700px; border:1px solid #B1BE82; height:400px; font-size:9pt"> <%=description%></textarea>	<script language="JSCript"> if(bitUseEditor) {Editor_New_Generate('description');} </script></td>
                    </tr>
                </table>
                
                <div class="mgb10"></div>  
                
                <table width="620" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                <tr>
                                    <td><input type=image src="../images/bo_ok.gif" border="0" hspace="3" style="cursor:pointer;" onClick="info_frm_chk(this.form);return false;"></td>
                                    <td><input type=image src="../images/bo_su.gif" border="0" hspace="3" style="cursor:pointer;" onClick="chk_frm(this.form);return false;"></td>
                                    <td><input type=image src="../images/bo_de.gif" border="0" hspace="3" style="cursor:pointer;" onclick="del_frm(this.form);return false;"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                -->
                <div style="padding:20px;height:400px;background-color:#FFF;border:1px solid #C0C0C0;">
                    왼쪽 지역을 선택하세요.1
                </div>
            <% Else %>
                <!--
                <table width="100%" border="0" cellpadding="10" cellspacing="1" bgcolor="#C0C0C0">
                    <tr>
                        <td bgcolor="#FFFFFF"><textarea name="description" id="description" style="width:920px; border:1px solid #B1BE82; height:400px; font-size:9pt"><%=description%></textarea>	<script language="JSCript"> if(bitUseEditor) {Editor_New_Generate('description');} </script> </td>
                    </tr>
                </table>  
                
                <div class="mgb10"></div>  
                
                <table width="620" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                <tr> 
                                    <td><input type=image src="../images/bo_ok.gif" border="0" hspace="3" style="cursor:pointer;" onClick="info_frm_chk(this.form);return false;"></td>
                                    <td><input type=image src="../images/bo_su.gif" border="0" hspace="3" style="cursor:pointer;" onClick="chk_frm(this.form);return false;"></td>
                                    <td><input type=image src="../images/bo_de.gif" border="0" hspace="3" style="cursor:pointer;" onclick="del_frm(this.form);return false;"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                -->
                <div style="padding:20px;height:400px;background-color:#FFF;border:1px solid #C0C0C0;">
                    왼쪽 도시구분을 선택하세요.
                </div>
            <% End if %>

          
        <% Else %>
            <div style="padding:20px;height:400px;background-color:#FFF;border:1px solid #C0C0C0;">
                왼쪽 국가구분을 선택하세요.
            </div>
            
        <%
            End If
                
            CloseRs Rs 
            CloseF5_DB objConn 
        %>
    </form>

</body>
</html>

<script language="javascript">
    function info_frm_chk(frm){ 
        var str;
        str = document.info_frm.description.value;
    
        if(str == "") {
            alert("국가정보를 입력해야 합니다.");
            return true;
        }
     
        if(confirm("국가정보를 등록하시겠습니까?")){
            frm.action="process.asp";
            frm.submit();
        }
    }
    
    function chk_frm(frm){
        if(confirm("국가정보를 수정하시겠습니까?")){
            frm.action="process.asp?admin_action=info_modify";
            frm.submit()
        }
    }
    
    function del_frm(frm){
        if(confirm("국가정보를 삭제하시겠습니까?")){
            frm.action="process.asp?admin_action=info_nat_del";
            frm.submit()
        }
    }
</script>