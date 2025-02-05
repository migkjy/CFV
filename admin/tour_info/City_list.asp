<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<%
    nat_cd  = Trim(Request("nat_cd"))
    nm_kor  = Trim(Request("nm_kor"))
%>

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
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
</head>

<body>

    <div style="padding:47px 0px 50px 15px;">
        
        <form name="frmWrite" method="post" style="display:inline; margin:0px;">
        	
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:42px;">
                <tr>
                    <td class="f_sujet">■ <%=nm_kor%></td>
                 </tr>
            </table>
        
            <div class="pb15"></div>
            
            <div class="table_list">
                <table>
                    <tr>
                        <td width="10%" class="top1">No.</td>
                        <td width="16%" class="top2">코드 (3자리)</td>
                        <td width="32%" class="top2">도시명</td>
                        <td width="32%" class="top2">영문명</td>
                        <td width="*"%" class="top2">등록</td>
                    </tr>   
                    <%
                        OpenF5_DB objConn
                        
                        sql = " exec proc_ti200_nat_cd_city_cd_nm_kor_yn '" &nat_cd& "'"
                        set rs_city = Server.CreateObject("ADODB.RecordSet")
                        rs_city.open sql,objConn,3 
                        
                        If not rs_city.EOF Then        
                            Do While Not rs_city.eof       
                                
                                nat_cd = trim(rs_city("nat_cd"))
                                city_cd = trim(rs_city("city_cd"))
                                nm_kor_city = rs_city("nm_kor")
                                nm_eng_city = rs_city("nm_eng")
                                del_yn = rs_city("del_yn")
                                
                                disp_grade = trim(rs_city("disp_grade"))
                                if disp_grade="" or isnull(disp_grade)  then
                                    disp_grade="0"
                                end if
                    %>   
                    <tr bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                        <td class="tob1"><input type="text" name="idx<%=city_cd%>" value="<%=disp_grade%>"  onblur="g_check('c','<%=city_cd%>', document.frmWrite.idx<%=city_cd%>.value)" style="width:70%"  maxlength="5" OnKeyPress="num_only()" class="input_color"></td>
                        <td class="tob2"><a onclick="city_modi('<%=nat_cd%>','<%=city_cd%>');return false;" style="cursor:pointer;"><%=city_cd%></a></td>
                        <td class="tob2"><%=nm_kor_city%></td>
                        <td class="tob2"><%=nm_eng_city%></td>
                        <td class="tob2"><span class="checks" style="padding:0 0 0 8px;"><input type="checkbox" name="del_yn<%=city_cd%>" id="<%=city_cd%>" <% if del_yn = "N" then %>checked<% end if %> onClick="city_del_yn('<%=city_cd%>')"><label for="<%=city_cd%>"></label></span></td>
                    </tr>
                    <%  
                        	rs_city.MoveNext
                        	Loop
                        	
                        Else
                    %>
                    <tr>
                        <td class="bin" colspan="5"><% if nat_cd<>"" then %>등록된 도시가 없습니다.<% else %>왼쪽 국가명을 클릭하세요<% end if %></td>
                    </tr>
                    <%
                        End if	
                        
                        CloseRs rs_city
                        CloseF5_DB objConn
                    %>
                </table>
            </div>

            <% if nat_cd<>"" then%>
                <div class="pt25"></div>   
                
                <div align="center">
                    <span class="button_b" style="padding:0px 4px"><a onclick="goLink();return false;" style="cursor:pointer;">도시등록</a></span> 
                    <span class="button_b" style="padding:0px 4px"><a onClick="location.reload()">새로고침</a></span> 
                </div>
            <% end if %>
            
            <iframe src="about:blank" name="basket" id="basket" width="0" height="0" style="display:none"></iframe>
          
        </form>
    </div>

         
</body>
</html>

<div id="chain_schedule28k" title="도시정보수정"></div>
<div id="chain_schedule27k" title="도시등록"></div>   
    
<script language=javascript> 
<!--
    function city_del_yn(n){
        url =  "city_delyn.asp?city_cd="+n;
        basket.location.href=url;
    }

    function g_check(gt,n,t){
        var	f = document.frmWrite;
        var url = "g_check.asp?gtp="+gt+"&city_cd="+n+"&idx_v="+t
    
        f.action = url;
        f.target = "basket";
        f.submit();
    }
    
    function num_only(){
        if((event.keyCode<48) || (event.keyCode>57)){
            event.returnValue=false;
        }
    }


     //국가도시수정
    function city_modi(n,m){
        var _url28k = "city_modify.asp?nat_cd="+n+"&city_cd="+m;
        $("#chain_schedule28k").html('<iframe id="modalIframeId28k" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId28k").attr("src",_url28k);    	 
    }
    $(document).ready(function(){
        $("#chain_schedule28k").dialog({
         autoOpen: false,
         modal: true,
            width: 700,
            height: 340
        });
    });

   
    function goLink(){
        var _url27k = "city_input.asp?nat_cd=<%=nat_cd%>";
        $("#chain_schedule27k").html('<iframe id="modalIframeId27k" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId27k").attr("src",_url27k);    	 
    }
    $(document).ready(function(){
        $("#chain_schedule27k").dialog({
         autoOpen: false,
         modal: true,
            width: 700,
            height: 340
        });
    });
--> 
</script>

