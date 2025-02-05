<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->

<%
    OpenF5_DB objConn

    nat_cd = Trim(Request("nat_cd"))
    city = Trim(Request("city"))
    infor_cd = Trim(Request("infor_cd"))
    
    if infor_cd = "" then infor_cd = "02"
    	
    Select Case infor_cd 
        Case "01"  '호텔
            sql = " select idx,g_check,nm_kor, nm_eng,seq,point1,point2"
            sql = sql & " from TB_ti310  "
            infor_nm = "호텔 정보가"
            infor_title = "호텔명"
            
        Case "02"  '관광지
            sql = " select nm_kor, nm_eng,seq,point1,point2"
            sql = sql & " from TB_ti320   "
            infor_nm = "관광지 정보가"
            infor_title = "관광지명"
            
        Case "07"  '골프장
            sql = " select nm_kor, nm_eng,seq,point1,point2"
            sql = sql & " from TB_ti370 "
            infor_nm     = "골프장 정보가"
            infor_title = "골프장명"
        
        Case else  '관광지
            sql = " select nm_kor, nm_eng,seq,point1,point2"
            sql = sql & " from TB_ti320   "
            infor_nm = "관광지 정보가"
            infor_title = "관광지명"
    End Select
	
    sql = sql & " where  nat_cd = '"& nat_cd &"' "
    sql = sql & " and city_cd  = '"& city &"' "
    if infor_cd ="01" then
        sql = sql & "	  and del_yn  = 'N' "
    End if
   sql = sql & " order by nm_kor,Seq desc" 
    	set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3
    r_cnt = rs.RecordCount 
	
    p = 1
    k = 1
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
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
<script language="javascript" type="text/javascript" src="/admin/scripts/iframeResizer.contentWindow.min.js"></script>
</head>

<body>

    <!--
    <table border="0" cellspacing="0" cellpadding="0"  >
        <tr> 
            <td><% if infor_cd ="02" then %><img src="images/tab_1_on.png" border="0"><% else %><a href="area_detail_infor.asp?nat_cd=<%=nat_cd%>&city=<%=city%>&infor_cd=02" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','images/tab_1_on.png',1)"><img src="images/tab_1_off.png" border="0" name="Image1" id="Image1"></a><% end if %></td>
            <td width="5"></td>
            <td><% if infor_cd ="01" then %><img src="images/tab_2_on.png" border="0"><% else %><a href="area_detail_infor.asp?nat_cd=<%=nat_cd%>&city=<%=city%>&infor_cd=01" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','images/tab_2_on.png',2)"><img src="images/tab_2_off.png" border="0" name="Image2" id="Image2"></a><% end if %></td>
            <td width="5"></td>
            <td><% if infor_cd ="07" then %><img src="images/tab_3_on.png" border="0"><% else %><a href="area_detail_infor.asp?nat_cd=<%=nat_cd%>&city=<%=city%>&infor_cd=07" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','images/tab_3_on.png',3)"><img src="images/tab_3_off.png" border="0" name="Image3" id="Image3"></a><% end if %></td>
        </tr>
    </table>
    -->
    <div class="pt10"></div>  
    
    <form name="frmWrite" method="post" style="display:inline; margin:0px;">
        <div class="table_list">
            <table>
                <tr>
                    <td width="5%" class="top1">No,</td>
                    <td width="32%" class="top2"><%=infor_title%></td>
                    <td width="*%" class="top2">영문명</td>
                    <td width="8%" class="top2">지도</td>
                    <td width="8%" class="top2">이미지</td>
                    <td width="8%" class="top2">수정</td>
                    <td width="8%" class="top2">삭제</td>
                </tr>
                <% 
                    If Rs.EOF or Rs.BOF then
                %>
                    <tr>
                        <td style="text-align:center; border-left:1px solid #C0C0C0; border-right:1px solid #C0C0C0; border-bottom:1px solid #C0C0C0;color:#888;height:40px;background: #FFF;" colspan="7">NO DATA</td>
                    </tr>
                <%
                    Else
                    	
                        Do while Not Rs.eof 
                        	
                            img_path = ""
                	    
                            if infor_cd="01" then
                                idx   = Trim(Rs("idx")) '순서
                                if idx="" or isnull(idx)  then
                                    idx="0"
                                end if
                                g_check = Trim(Rs("g_check")) '상품등록
                            end if	    
                	    
                            nm_kor = Trim(Rs("nm_kor"))
                            nm_eng = Trim(Rs("nm_eng"))	
                            seq = Trim(Rs("seq"))
                            point1 = Trim(Rs("point1"))
                            point2 = Trim(Rs("point2"))
                %>
                    <a name="info<%=k%>">
                        <% Select Case infor_cd %>
                        <% Case "02"   '관광지 %>
                            <script language="javascript">
                                function go_del<%=seq%>(){
                                    if(confirm("<%=nm_kor%>을(를) 정말로 삭제하시겠습니까?")){
                                        window.location.href="process.asp?admin_action=tour_del&seq=<%=seq%>&nat_cd=<%=nat_cd%>&city=<%=city%>";
                                    }
                                }
                            </script>
                            <tr bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                                <td class="tob1"><%=k%></td>
                                <td class="tob3"><a onclick="tour_pop(<%=seq%>);return false;" style="cursor:pointer;"><%=nm_kor%></a></td>
                                <td class="tob3"><a onclick="tour_pop(<%=seq%>);return false;" style="cursor:pointer;"><%=nm_eng %></a></td>                              																																																	
                                <% if point1 <> "" and not isNull("point1") and point2 <> "" and not isNull("point2") then %>
                                <td class="tob2"><span class="button_a"><a href="javascript:google_map('<%=seq%>','<%=infor_cd%>');">위치</a></span></td>   
                                <% else %>
                                <td class="tob2"></td>
                                <% end if %>
                                <td class="tob2"><span class="button_a"><a href="javascript:fn_search_img('02','<%=seq%>','<%=nat_cd%>','<%=city%>');">등록</a></span></td>   
                                <td class="tob2"><span class="button_a"><a onclick="tour_modify(<%=seq%>);return false;">수정</a></span></td>  
                                <td class="tob2"><span class="button_a"><a onClick="go_del<%=seq%>();return false">삭제</a></span></td>  
                            </tr>

                        <% Case "01"   '호텔 %>
                            <% g_check = Trim(Rs("g_check")) %>
                            <script language="javascript">
                                function go_del<%=seq%>(){
                                    if(confirm("<%=nm_kor%>을(를) 정말로 삭제하시겠습니까?")){
                                        window.location.href="process.asp?admin_action=hotel_del&seq=<%=seq%>&nat_cd=<%=nat_cd%>&city=<%=city%>";   
                                    }
                                }
                            </script>
                            <tr bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                                <td class="tob1"><%=k%></td>   
                                <td class="tob3">
                                    <table>
                                        <tr>
                                             <!--<td width="20" style="padding:2px 3px 0 0;"><input type="checkbox" name="g_check<%=seq%>" value="<%=seq%>" <% if g_check = "1" then %>checked<% end if %> onClick="g_check('g','<%=seq%>','n')"  class="check_basic"></td>-->
                                             <td width="*"><a onclick="hotel_pop(<%=seq%>);return false;" style="cursor:pointer;"><%=nm_kor%></a></td>
                                         </tr>
                                     </table>
                                </td>
                                <td class="tob3"><a onclick="hotel_pop(<%=seq%>);return false;" style="cursor:pointer;"><%=nm_eng%></a></td>
                                <% if point1 <> "" and not isNull("point1") and point2 <> "" and not isNull("point2") then %>
                                <td class="tob2"><span class="button_a"><a href="javascript:google_map('<%=seq%>','<%=infor_cd%>');">위치</a></span></td> 
                                <% else %>
                                <td class="tob2"></td>
                                <% end if %>
                                <td class="tob2"><span class="button_a"><a href="javascript:fn_search_img('01','<%=seq%>','<%=nat_cd%>','<%=city%>');">등록</a></span></td>   
                                <td class="tob2"><span class="button_a"><a onclick="hotel_modify(<%=seq%>);return false;">수정</a></span></td>  
                                <td class="tob2"><span class="button_a"><a onClick="go_del<%=seq%>();return false">삭제</a></span></td>  
                            </tr>
                        
                        <% Case "07"   '골프장 %>
                            <script language="javascript">
                                function go_del<%=seq%>(){
                                    if(confirm("<%=nm_kor%>을(를) 정말로 삭제하시겠습니까?")){
                                        window.location.href="process.asp?admin_action=golf_del&seq=<%=seq%>&nat_cd=<%=nat_cd%>&city=<%=city%>";
                                    }
                                }
                            </script>
                            <tr bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                                <td class="tob1"><%=k%></td>   
                                <td class="tob3"><a onclick="golf_pop(<%=seq%>);return false;" style="cursor:pointer;"><%=nm_kor%></a></td>
                                <td class="tob3"><a onclick="golf_pop(<%=seq%>);return false;" style="cursor:pointer;"><%=nm_eng%></a></td>
                                <% if point1 <> "" and not isNull("point1") and point2 <> "" and not isNull("point2") then %>
                                <td class="tob2"><span class="button_a"><a href="javascript:google_map('<%=seq%>','<%=infor_cd%>');">위치</a></span></td> 
                                <% else %>
                                <td class="tob2"></td>
                                <% end if %>
                                <td class="tob2"><span class="button_a"><a href="javascript:fn_search_img('07','<%=seq%>','<%=nat_cd%>','<%=city%>');">등록</a></span></td>   
                                <td class="tob2"><span class="button_a"><a onclick="golf_modify(<%=seq%>);return false;">수정</a></span></td>  
                                <td class="tob2"><span class="button_a"><a onClick="go_del<%=seq%>();return false">삭제</a></span></td>  
                            </tr>	
                        <% End Select %>
                    </a>

                <% 
                            k = k + 1
                            rs.MoveNext
                        Loop
                        
                    End if
                
                    CloseRs Rs  
                %>
            </table>
        </div>

        <div class="pt25"></div>   
                
        <div align="center">
            <% Select Case infor_cd %> 
                <% Case "02" %>
                    <span class="button_b"><a href="javascript:tour_make();">관광지 등록</a></span> 
                <% Case "01" %>
                    <span class="button_b"><a onClick="javascript:hotel_make();">호텔 등록</a></span> 
                <% Case "07" %>
                    <span class="button_b"><a onClick="javascript:golf_make();">골프장 등록</a></span> 
            <% End Select %>
        </div>
        <div style="padding:500px 0 0 0"></div> 

        <iframe name="ifmchk_frm" id="ifmchk_frm" src="about:blank"  allowTransparency=true width="0" height="0" marginwidth="0" marginheight="0" vspace="0" scrolling="yes" frameborder="0" framespacing="0" frameborder="0"></iframe>
    </form>

    <div id="chain_schedule_img" title="이미지등록"></div>
    
    <div id="chain_tour_make" title="관광지 정보 등록"></div>
    <div id="chain_tour_modify" title="관광지 정보 수정"></div>
    <div id="chain_tour_pop" title="관광지 정보"></div>
    
    <div id="chain_hotel_make" title="호텔 정보 등록"></div>
    <div id="chain_hotel_modify" title="호텔 정보 수정"></div>
    <div id="chain_hotel_pop" title="호텔 정보"></div>

    <div id="chain_golf_make" title="골프장 정보 등록 "></div>
    <div id="chain_golf_modify" title="골프장 정보 수정"></div>
    <div id="chain_golf_pop" title="골프장 정보"></div>
    
</body>
</html>

<%
	CloseF5_DB objConn
%>

<script language="javascript">
<!--
    function g_check(gt,n,t){
        var	f = document.frmWrite;
        var url = "g_check.asp?gtp="+gt+"&seq="+n+"&idx_v="+t
        
        f.action = url;
        f.target = "ifmchk_frm";
        f.submit();
    }

    function MM_swapImgRestore() { //v3.0
        var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
    }
    
    function MM_preloadImages() { //v3.0
        var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
        var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
        if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
    }
    
    function MM_findObj(n, d) { //v4.0
        var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
        d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
        if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
        for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
        if(!x && document.getElementById) x=document.getElementById(n); return x;
    }
    
    function MM_swapImage() { //v3.0
        var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
        if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
    }

    //구글 찾기
    function open_win0(win1){
        window.showModalDialog(win1,'','dialogwidth:1200px;dialogheight:800px;center:yes;px;scroll:yes;status:no;');
    }


    //이미지등록
    function fn_search_img(r,s,n,c){
        var _url7j = "/cs/img_up.asp?info="+r+"&seq="+s+"&nat="+n+"&city="+c;
        $("#chain_schedule_img").html('<iframe id="modalIframeId27j" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId27j").attr("src",_url7j);
    }
    $(document).ready(function(){
        $("#chain_schedule_img").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });

    
    //관광지 등록
    function tour_make(){
        var _url1 = "tour_make.asp?nat_cd=<%=nat_cd%>&city_cd=<%=city%>";
        $("#chain_tour_make").html('<iframe id="modalIframeId1" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId1").attr("src",_url1);
    }
    $(document).ready(function(){
        $("#chain_tour_make").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });
    
    //관광지 수정
    function tour_modify(s){
        var _url2 = "tour_modify.asp?seq="+s;
        $("#chain_tour_modify").html('<iframe id="modalIframeId2" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId2").attr("src",_url2);
    }
    $(document).ready(function(){
        $("#chain_tour_modify").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });

    //관광지 보기
    function tour_pop(s){
        var _url3 = "tour_pop.asp?seq="+s;
        $("#chain_tour_pop").html('<iframe id="modalIframeId3" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId3").attr("src",_url3);
    }
    $(document).ready(function(){
        $("#chain_tour_pop").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });



    //호텔 등록
    function hotel_make(){
        var _url4 = "hotel_make.asp?nat_cd=<%=nat_cd%>&city_cd=<%=city%>";
        $("#chain_hotel_make").html('<iframe id="modalIframeId4" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId4").attr("src",_url4);
    }
    $(document).ready(function(){
        $("#chain_hotel_make").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });

    //호텔 수정
    function hotel_modify(s){
        var _url5 = "hotel_modify.asp?seq="+s;
        $("#chain_hotel_modify").html('<iframe id="modalIframeId5" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId5").attr("src",_url5);
    }
    $(document).ready(function(){
        $("#chain_hotel_modify").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });

    //호텔 보기
    function hotel_pop(s){
        var _url6 = "hotel_pop.asp?seq="+s;
        $("#chain_hotel_pop").html('<iframe id="modalIframeId6" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId6").attr("src",_url6);
    }
    $(document).ready(function(){
        $("#chain_hotel_pop").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });
  
    
    
    //골프장 등록
    function golf_make(){
        var _url7 = "golf_make.asp?nat_cd=<%=nat_cd%>&city_cd=<%=city%>";
        $("#chain_golf_make").html('<iframe id="modalIframeId7" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId7").attr("src",_url7);
    }
    $(document).ready(function(){
        $("#chain_golf_make").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });

    //골프장 수정
    function golf_modify(s){
        var _url8 = "golf_modify.asp?seq="+s;
        $("#chain_golf_modify").html('<iframe id="modalIframeId8" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId8").attr("src",_url8);
    }
    $(document).ready(function(){
        $("#chain_golf_modify").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });

    //골프장 보기
    function golf_pop(s){
        var _url9 = "golf_pop.asp?seq="+s;
        $("#chain_golf_pop").html('<iframe id="modalIframeId9" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId9").attr("src",_url9);
    }
    $(document).ready(function(){
        $("#chain_golf_pop").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 640
        });
    });




        
    function google_map(h_code,info_cd) {
        var url = "/admin/google_map/google_map.asp?h_code=" + h_code + "&info_cd=" + info_cd ;
        window.open(url,'','left=50, top=50, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, width=1200, height=658"');
    }    

//-->
</script>