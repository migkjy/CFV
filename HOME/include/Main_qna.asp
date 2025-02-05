
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <colgroup>
        <col width="*;">
        <col width="20%;">
    </colgroup>
    <tbody>
        <%
            tbl ="trip_qna"
            
            sql = "SELECT TOP 5 num ,title ,secret ,ins_dt from "&tbl&" where del_yn='N' and ref_level =0  ORDER BY num DESC "
            Set Rs = objConn.Execute(Sql)
            if NOt (Rs.eof or Rs.bof) then
                k=1
                Do Until Rs.Eof              
                  num = Rs("num")
                  title = Rs("title")
                  secret = Lcase(Rs("secret"))
                  ins_dt = left(Rs("ins_dt"),10)
                  check_new = datediff("d",left(now,10),ins_dt)
        %>
        <tr height="30">
            <td>
                <% if secret="y" then %>
                    <span class="com_main3"><a onclick="fn_pass('/home/board/common_pa.asp?num=<%=num%>&f_ts=qna_view');return false;" style="cursor:pointer;"><%=title_cutting(title,40)%></a></span>
                    <span class="com_main3" style="color:#999"><i class="xi-lock-o"></i></span>
                    <% if check_new=0 then %>
                        <span style="color:#FF0000"><i class="xi-new"></i></span>
                    <% end if %>
                <% else %>
                    <span class="com_main3"><a href="/home/board/qna_view.asp?num=<%=num%>"><%=title_cutting(title,45)%></a></span>
                <% end if %>
            </td>
            <td class="com_main4"><%=ins_dt%></td>
        </tr>
        <%
                    k = k+1
                    Rs.Movenext
                Loop
            End if
                
            CloseRs Rs
        %>     
    </tbody>  
</table>
    
    
<div id="pop_password" title="비밀번호"></div>
<script language="javascript">
    function fn_pass(_url1){
        $("#pop_password").html('<iframe id="modalIframeId1" width="100%" height="200px" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="no" />').dialog("open");
        $("#modalIframeId1").attr("src",_url1);
    }
    $(document).ready(function(){
        $("#pop_password").dialog({
            autoOpen: false,
            modal: true,
            width: 400,
            height: 270
        });
    });
</script>