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
   
    
    g_kind   = Request("g_kind")
    If g_kind="" or isnull(g_kind) then
        response.write "<script language='javascript'>  "
        response.write "  alert('정확한 상품정보가 없습니다...');"
        response.write "  self.close();   "
        response.write "</script>  " 
        response.end
    End if
    
    good_num = Request("good_num")

    sql  =	" SELECT num, title, g_kind, s_area  FROM trip_gtck WHERE del_yn='N' and num='"&good_num&"' "
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Set Rs = objConn.execute(sql)
    If  Rs.eof  then
        response.write "<script language='javascript'>  "
        response.write "  alert('정확한 상품정보가 없습니다...');"
        response.write "  self.close();   "
        response.write "</script>  " 
        response.end
    Else
        g_num    = Rs("num")
        g_title  = Rs("title")
        g_g_kind = Rs("g_kind")
        g_s_area = Rs("s_area")
    End if
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>

<body>

    <div class="pb15"></div> 
    
    <form name="change_frm" method="post"  action="change_category_ok.asp"  >
    <input type="hidden" name="g_kind"  value="<%=g_kind%>" >
    <input type="hidden" name="good_num"  value="<%=good_num%>" >
    
        <div class="table_dan">
            <table width="100%">
                <tr>
                    <td width="25%" class="lop1">기존 카테고리</td>
                    <td width="*%" class="lop2">
                        <select name="now_category" id="now_category" style="width:200px;" class="select_basic" disabled>
                            <%
                                sql=" SELECT idx, g_kind, title FROM trip_gtck_city WHERE del_yn ='N' and g_kind='"&g_kind&"' "
                                Set Rs = Server.CreateObject("ADODB.RecordSet")
                                Set Rs = objConn.execute(sql)
                                
                                Do until Rs.eof
                                            
                                    nat_idx   = Rs("idx")
                                    nat_title = Rs("title")
                                
                                    Response.Write "<option value= """&nat_idx&""" "
                                
                                    If Trim(nat_idx)=Trim(g_s_area)  then
                                        Response.Write " selected"
                                    End if
                                
                                    Response.Write "  > "
                                
                                    Response.Write ""&nat_title&""
                                    Response.Write "</option>" 
                                
                                    Rs.MoveNext
                                Loop
                                
                                Rs.close  : set Rs=nothing
                                
                            %>
                        </select>
                    </td>
                </tr>
            </table>
            
            <div class="pb15"></div> 

            <table width="100%">
                <tr>
                    <td width="25%" class="lop1" style="background: #D7ECFF;">변경 카테고리</td>
                    <td width="*%" class="lop2">
                        <select name="change_cate"  id="change_cate" style="width:200px;" class="select_color">
                            <%
                                sql=" SELECT idx, g_kind,  title FROM trip_gtck_city WHERE del_yn ='N' and g_kind='"&g_kind&"' "
                                Set Rs = Server.CreateObject("ADODB.RecordSet")
                                Set Rs = objConn.execute(sql)
                                
                                Do until Rs.eof
                                
                                   nat_idx   = Rs("idx")
                                   nat_title = Rs("title")
                                
                                   Response.Write "<option value= """&nat_idx&""" "
                                
                                   Response.Write "  > "
                                
                                   Response.Write ""&nat_title&""
                                   Response.Write "</option>" 
                                
                                   Rs.MoveNext
                                Loop
                                
                                Rs.close  : set Rs=nothing
                            %>
                        </select>
                    </td>
                </tr>
            </table>
        </div> 
        
        <div class="pt25"></div>   
                
        <div align="center">
            <span class="button_b" style="padding:0px 4px;"><a onClick="sendit()">수정</a></span>
            <span class="button_b" style="padding:0px 4px;"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
        </div>

    </form>

</body>
</html>

<script type="text/javascript">
<!--
    function closeIframe(){
        parent.$('#chain_category').dialog('close');
        return false;
    }
    
    function sendit(){
        var f = document.change_frm;
        f.submit();
    }
//-->
</script>