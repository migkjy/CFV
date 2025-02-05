<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

  OpenF5_DB objConn
  
    g_seq = Request("g_seq")
    file_path ="board/upload/tck"
    'tp    = Ucase(Request("tp"))
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script language="javascript" src="Script_Upload.js"></script>

<script language="javascript">
    function fnImgDisplay(strImg,strSeq,strFileName){	
        parent.document.imgChange.src	= strImg; 
        parent.document.frm.p_seq.value=strSeq;
        parent.document.frm.re_mark.value=$("#remark_"+strSeq).val();
    }
</script>

<script type="text/javascript">
<!--
    $("input[name='dp_order'").blur(function() {  
        $("input[name='dp_order']").each(function() {
            alert($(this).val());
        });
    });
//-->
</script>
</head>

<body>

    <form name="frm" method="post" action="" style="display:inline; margin:0px;">
    <input type="hidden" name="g_seq" value="<%=g_seq%>">
	
        <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
            <%
            
                sql =" select top 30 p_seq, g_seq, tp, file_img, p_remark, disp_seq from ex_good_photo  where g_seq="&g_seq&"   "
                sql = sql & " order by disp_seq asc, p_seq asc  "
            
                Set Rs = Server.CreateObject("ADODB.RecordSet")
                Set Rs = objConn.Execute(Sql)
                
                If rs.eof or rs.bof then
            %>
            <tr> 
                <td height="280" align="center">등록된 이미지가 없습니다.</td>
            </tr> 
            <% 
                Else
                    i=1
                    Do until Rs.EOF
                        r_cnt =1  
                        p_seq = Rs("p_seq")
                        g_seq = Rs("g_seq")
            
                        disp_seq = Rs("disp_seq")
                        
                        file_img = Rs("file_img")
                        p_remark  = Rs("p_remark")
                        if p_remark="" or isnull(p_remark) then
                            p_remark = Replace(p_remark,chr(13)&chr(10),"<br>")
                        end if
                       
                        if i MOD 2 = 1 then  response.write "<tr>"	
            %>
                <td width="140" style="padding: 0 0 15px 0;"><a onClick="fnImgDisplay('/<%=file_path%>/<%=g_seq%>/<%=file_img%>','<%=p_seq%>','<%=file_img%>')" style='cursor:pointer' ><img src="/<%=file_path%>/<%=g_seq%>/<%=file_img%>" border=0 Name="outImg"  width="125"></a></td> 
                <td width="*" style="padding: 0 0 20px 0;">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                            <td height="26">순서 :</td>
                            <td width="5"></td>
                            <td><input type="text" name="dp_order" value="<%=disp_seq%>"  style="width:50px" onblur="fn_dporder('<%=p_seq%>',this.value)" class="input_color"></td>
                        </tr>    	
                        <tr> 
                            <td height="26">설명 :</td>
                            <td width="5"></td>
                            <td><%=p_remark%><input type="hidden" name="remark"  id="remark_<%=p_seq%>" value="<%=p_remark%>"></td>
                        </tr>
                    </table>
                </td>
                <%
                          Rs.movenext
                          i = i + 1
                           
                      loop
                
                      Rs.close  : Set Rs = nothing
                
                      If i MOD 2 = 1 then
                          Response.WRITE "</tr>"
                      elseif i MOD 2= 0 THEN
                          Response.write "<td width=140></td><td width=330></td></tr>"
                      end if
                
                End if
            %>
        </table>
    
    </form>

</body>
</html>

<% 
    objConn.close   : Set objConn = nothing
%>

<script type="text/javascript">
<!--
    function fn_dporder(s,n){
        location.href="img_number.asp?g_seq=<%=g_seq%>&p_seq="+s+"&dp_seq="+n;
    }
//-->
</script>
    