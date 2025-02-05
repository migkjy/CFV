<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="DynamicTree.css" /> 
<script type="text/javascript" src="ie5.js"></script>
<script type="text/javascript" src="DynamicTree.js"></script>

<script language="javascript" type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script language="javascript" type="text/javascript" src="/admin/scripts/iframeResizer.contentWindow.min.js"></script>

<script language=javascript> 
    n = document.layers 
    ie = document.all 
    function hide() { 
        if (ie || n) { 
            if (n) document.Load.visibility = "hidden" 
            else Load.style.visibility = "hidden" 
        } 
    } 
</script> 
</head>

<body onload="hide()">

    <script language=javascript> 
        if(ie || n) document.write('<div id="Load" style="position:absolute;width:100%;height:100%;top:0;left:0;background-color:#E0E4E8;z-index:5"><font color=#FFFFFF>..</font></div>') 
    </script> 
    
     <div style="padding:10px 0px 50px 0px;">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 지역정보</div>
        
        <div style="padding:20px;background-color:#FFF;border:1px solid #C0C0C0;">
            <div class="DynamicTree">
                <div class="top"><i class="xi-qr-code xi-x"></i> 지역선택</div>
                <div class="wrap" id="tree">
                    <%
                        OpenF5_DB objConn
                        
                        sql = " exec proc_TB_ba001_cd_cdnm 'cont'" 
                        set aux1_Rs = Server.CreateObject("ADODB.RecordSet")
                        aux1_Rs.open sql,objConn,3
                        
                        If not aux1_rs.EOF Then
                            Do While Not aux1_Rs.eof 
                            	
                                cd = aux1_rs("cd")
                                cd_nm = aux1_rs("cd_nm")
                    %>
                         <div class="folder"><a href="#"><%=cd_nm%></a>
                         <%
                            sql = " exec proc_ti100_nat_cd_nm_kor '" &cd& "'"
                            set Rs = Server.CreateObject("ADODB.RecordSet")
                            Rs.open sql,objConn,3
                            
                            If not rs.EOF Then
                                Do While Not Rs.eof 
                                	
                                    nat_cd = Rs("nat_cd")
                                    nm_kor = Rs("nm_kor")
                        %>
                            <div class="folder"><a href="nat_detail.asp?nat_cd=<%=nat_cd%>" target="data_ev001_2"><%=nm_kor%></a>
                            <%
                                sql = " exec proc_ti200_nat_cd_city_cd_nm_kor '" &nat_cd& "'"
                                set rs_city = Server.CreateObject("ADODB.RecordSet")
                                rs_city.open sql,objConn,3 
                               
                                If not rs_city.EOF Then        
                                    Do While Not rs_city.eof       
                                    	
                                        nat_cd = rs_city("nat_cd")
                                        city_cd = rs_city("city_cd")
                                        nm_kor_city = rs_city("nm_kor")
                            %>
                                 <div class="doc"><a href="area_detail.asp?nat_cd=<%=nat_cd%>&city=<%=city_cd%>" target="data_ev001_2"><%=nm_kor_city%></a></div>
                            <%  
                                    rs_city.MoveNext
                                    Loop
                                End if
                               
                                CloseRs rs_city
                            %>
                        </div>
                        <%  
                                Rs.MoveNext
                                Loop
                            End if
                            
                            CloseRs Rs
                        %>
                    </div>
                    <%  
                            aux1_rs.MoveNext
                            Loop
                        End if
                                                  
                        CloseRs aux1_rs
                        CloseF5_DB objConn
                    %>
                </div>
            </div>
        </div>
        
    </div>
    
</body>
</html>

<script type="text/javascript">
    var tree = new DynamicTree("tree");
    tree.init();
</script>