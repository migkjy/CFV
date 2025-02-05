<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<%
    cont_cd = Trim(Request("cont_cd"))
    nat_op  = Trim(Request("nat_op"))

    OpenF5_DB objConn

    If cont_cd = "" then cont_cd = "1"
    if nat_op = ""  then nat_op = "ALL"
    
    sql  = " select cd, cd_nm from TB_ba001 "
    sql = sql & "  where cd_fg = 'cont'"
    sql = sql & "  and del_fg = 'N'" 
    sql = sql & "  and cd = '" & cont_cd & "'"
    set RsSub = Server.CreateObject("ADODB.RecordSet")
    RsSub.open sql,objConn,3
    
    if not RsSub.Eof then
        na_txt = RsSub("cd_nm")
        CloseRs RsSub
    end if

    lowfg="#ECF9FF"
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

    <div style="padding:10px 0px 50px 0px;">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 국가/도시코드</div>
        
        <form name="nat_info" method="post" action="nat_list.asp" style="display:inline; margin:0px;">
    	
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
                <tr>
                    <td>
                        <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="bin_pa" width="60%">
                                    <select name="cont_cd" onchange="nat_search()" class="select_basic" style="width:100%;">         
                                        <%
                                            sql  = " select cd, cd_nm from TB_ba001 "
                                            sql = sql & "  where cd_fg = 'cont'"
                                            sql = sql & "  and del_fg = 'N'" 
                                            set RsSub = Server.CreateObject("ADODB.RecordSet")
                                            RsSub.open sql,objConn,3
                                        
                                            if not RsSub.Eof then
                                                Do While Not RsSub.eof 
                                                    cd = RsSub("cd")
                                                    cd_nm = RsSub("cd_nm")
                                        %>
                                        <option value="<%=cd%>" <% if cont_cd = cd then %>selected<% end if %>><%=cd_nm%></option>         
                                        <%
                                                RsSub.MoveNext
                                                Loop
                                            end if
                                            
                                            RsSub.close
                                            set RsSub = nothing
                                        %>   
                                    </select>
                                </td>
                                <td class="bin_pb" width="*%">
                                    <select name="nat_op" onchange="del_yn()" class="select_basic" style="width:100%;">
                                        <option value="ALL" <% if nat_op = "ALL" then %> selected <% end if %>>전체</option>
                                        <option value="N" <% if nat_op = "N" then %> selected <% end if %>>등록</option>
                                        <option value="Y" <% if nat_op = "Y" then %> selected <% end if %>>미등록</option>
                                    </select>
                                </td>
                             </tr>
                        </table>
                    </td>
                </tr>
            </table>
                    
            <div class="pb15"></div>
            
            <div class="table_list">
                <table>
                    <tr>
                        <td width="18%" class="top1">대륙</td>
                        <td width="13%" class="top2">코드 (2자리)</td>
                        <td width="27%" class="top2">국가명</td>
                        <td width="*" class="top2">영문명</td>
                        <td width="10%" class="top2">등록</td>
                    </tr>
                    <%
                        sql = " select nat_cd, cont_cd, nm_eng, nm_kor, del_yn"
                        sql = sql & "	from TB_ti100  "
                        if nat_op = "ALL" then
                            sql = sql & " where cont_cd = '"& cont_cd &"' order by nat_cd  "
                        elseif nat_op = "N" then
                            sql = sql & " where cont_cd = '"& cont_cd &"' and del_yn= 'N' order by nat_cd  "
                        elseif nat_op = "Y" then  
                            sql = sql & " where cont_cd = '"& cont_cd &"' and del_yn='Y'  order by nat_cd  "
                        end if
                        
                        set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open sql,objConn,3
                            
                        If Rs.EOF or Rs.BOF then
                    %> 
                    <tr>
                        <td class="bin" colspan="5">NO DATA</td>
                    </tr>
                    <%
                        Else
                            Do While Not Rs.eof 	
                                nat_cd = Rs("nat_cd")
                                cont_cd = Rs("cont_cd")
                                nm_eng = Rs("nm_eng")
                                nm_kor = Rs("nm_kor")
                                del_yn = Rs("del_yn")
                    %> 
                    <tr bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                        <td class="tob1"><%=na_txt%></td>
                        <td class="tob2"><a onclick="nat_cd_mody('<%=na_txt%>','<%=nat_cd%>');return false;" style="cursor:pointer;"><%=nat_cd%></a></td>
                        <td class="tob2"><a href="city_list.asp?nat_cd=<%=nat_cd%>&nm_kor=<%=nm_kor%>" target="city"><%=nm_kor%></a></td>
                        <td class="tob2"><%=nm_eng%></td>
                        <td class="tob2"><span class="checks" style="padding:0 0 0 8px;"><input type="checkbox" name="del_yn<%=nat_cd%>" id="<%=nat_cd%>" onClick="nat_del_yn('<%=nat_cd%>')" <% if del_yn = "N" then %>checked<% end if %>><label for="<%=nat_cd%>"></label></span></td>
                    </tr>
                    <%			
                            rs.MoveNext
                            Loop
                        End if
                        
                        CloseRs Rs
                    %> 
                </table>
            </div>

            <div class="pt25"></div>   
                
            <div align="center">
                <span class="button_b" style="padding:0px 4px"><a onclick="goLink();return false;" style="cursor:pointer;">국가등록</a></span> 
                <span class="button_b" style="padding:0px 4px"><a onClick="location.reload()">새로고침</a></span> 
            </div>
            
        </form>
    </div>
 
    <iframe src="about:blank" name="basket" id="basket" width="0" height="0" style="display:none"></iframe>
        
</body>
</html>

<div id="chain_schedule28k" title="국가정보수정"></div>
<div id="chain_schedule27k" title="국가등록"></div>

<%
	CloseF5_DB objConn
%>


<script language="javascript">
<!--
    function nat_search(){
        document.nat_info.submit();
    }

    function del_yn(){
        document.nat_info.submit();
    }

    function nat_del_yn(n){
        url =  "nat_delyn.asp?nat_cd="+n;
        basket.location.href=url;
    }

    
     //국가도시수정
    function nat_cd_mody(n,m){
        var _url28k = "nat_modify.asp?na_txt="+n+"&nat_cd="+m;
        $("#chain_schedule28k").html('<iframe id="modalIframeId28k" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId28k").attr("src",_url28k);    	 
    }
    $(document).ready(function(){
        $("#chain_schedule28k").dialog({
         autoOpen: false,
         modal: true,
            width: 500,
            height: 340
        });
    });
    
    
    function goLink(){
        var _url27k = "nat_input.asp?na_txt=<%=na_txt%>&cont_cd=<%=cont_cd%>";
        $("#chain_schedule27k").html('<iframe id="modalIframeId27k" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId27k").attr("src",_url27k);    	 
    }
    $(document).ready(function(){
        $("#chain_schedule27k").dialog({
         autoOpen: false,
         modal: true,
            width: 500,
            height: 340
        });
    });
--> 
</script>


