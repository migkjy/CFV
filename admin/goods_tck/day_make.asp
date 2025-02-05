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

    gotopage  = Request("gotopage")

    good_cd = Request("good_cd")
    If good_cd = "" then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자 오류1...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if 
    
    g_kind = Request("g_kind")
    Select case g_kind 
        case "10" : g_kind_nm ="프로그램 상품관리"
        case "20" : g_kind_nm ="할인티켓"
        case "30" : g_kind_nm ="차량/가이드"
        case else : g_kind_nm ="기타"
    end select  
        
    sql = " Select num,  event_tp,  g_kind ,title  from trip_gtck  where num="&good_cd
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3

    If Rs.eof or Rs.bof then
   	   Response.write "<script language='javascript'>"
       Response.write " alert('주요인자전송에러!!...'); "
       Response.write " history.back();"
       Response.write " </script>	 "
       Response.end
    Else
        g_kind  = Rs("g_kind")
        g_title  = Rs("title")
    End if
     
    Rs.close :      Set Rs=nothing


    '#############################################################년월설정
    ss_yy = Request("ss_yy")
    If ss_yy="" or isnull(ss_yy) then
       ' ss_yy = Year(date)
        ss_yy = "2024"
    End if

    ss_mm = Request("ss_mm")
    If ss_mm="" or isnull(ss_mm) then
        ss_mm = "0"&Month(date)
        ss_mm = right(ss_mm,2)
    Else
        ss_mm = "0"&ss_mm
        ss_mm = right(ss_mm,2)
    End if
   ss_mm = "11"
    Select case ss_mm
        case "01","02" : ss_mm ="01"
        case "03","04" : ss_mm ="03"
        case "05","06" : ss_mm ="05"
        case "07","08" : ss_mm ="07"
        case "09","10" : ss_mm ="09"
        case "11","12" : ss_mm ="11"
    End select
 
    '#############################################################년월설정


%>

<!DOCTYPE html>
<html>
<head>
<title><%=g_kind_nm%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/scripts/jquery-ui.css">
<script type="text/javascript" src="/admin/scripts/jquery-ui.js"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=g_kind_nm%> </div>

        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="height:38px;">
                        <tr>
                            <td class="bin_pa" style="font-size:15px;font-weight:500; padding:0 20px 0 20px;"><%=g_title%></td>
                            <td class="bin_pa"  align="center"><span class="button_a"><a href="tck_ins.asp?num=<%=good_cd%>&g_kind=<%=g_kind%>">상품수정</a></span></td>
                            <td class="bin_pb" ><span class="button_a"><a href="tck_list.asp?g_kind=<%=g_kind%>&gotopage=<%=gotopage%>">목록</a></span></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div class="pt15"></div>   

        <form name="frm_price" method="post"  style="display:inline; margin:0px;" >
        <input type="hidden" name="good_cd" id="good_cd" value="<%=good_cd%>">
        <input type="hidden" name="g_kind"  id="g_kind" value="<%=g_kind%>">
        <input type="hidden" name="ss_yy"   id="ss_yy" value="<%=ss_yy%>">
        <input type="hidden" name="ss_mm"   id="ss_mm" value="<%=ss_mm%>">
    
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="50%" valign="top">
                        <div class="table_list">
                            <table>
                                <tr>
                                    <td width="7%" class="top1">번호</td>
                                    <td width="*%" class="top2">투어시간</td>
                                    <td width="11%" class="top2">전체 인원</td>
                                    <td width="11%" class="top2">상품금액</td>
                                    <td width="9%" class="top2"><span class="checks"><input type="checkbox" name="new_room" onclick="toggle_sel()" id="all_change"><label for="all_change">전체</label></span></td>
                                </tr>
                                <%
                                    rsql = " SELECT  seq, good_cd,  nm_c, price,total_man  from trip_gtck_opt R1 where R1.good_cd= "&good_cd&" and sub_tp='F'  AND ( del_yn = 'N') "
                                
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open rsql,objConn,3
                                    
                                    If Rs.eof or Rs.bof then
                                    Else
                                    	
                                        DO until Rs.eof
                                            
                                            seq = Rs("seq")
                                            opt_nm  = Rs("nm_c")
                                    
                                            opt_price_1 = Rs("price")
                                            if opt_price_1="" or isnull(opt_price_1) then
                                                opt_price_1 =0 
                                            end if
                                    
                                            opt_total_man = Rs("total_man")
                                            if opt_total_man="" or isnull(opt_total_man) then
                                                opt_total_man=0 
                                            end if
                                          
                                %>
                                <tr bgcolor="#FFFFFF">
                                    <td class="tob1"><%=seq%></td>
                                    <td class="tob3"><%=opt_nm%></td> 
                                    <td class="tob2"><input type="text" name="u_total_man" value="<%=opt_total_man%>" style="width:80%" maxlength="10" class="input_basic"></td>
                                    <td class="tob2"><input type="text" name="u_price_1" value="<%=opt_price_1%>" style="width:80%" maxlength="10" class="input_basic"></td>
                                    <td class="tob2"><span class="checks"><input type="checkbox" name="checked_room" value="<%=seq%>" id="<%=seq%>"><label for="<%=seq%>">선택</label></span></td>
                                </tr> 
                                <%
                                        Rs.movenext
                                        Loop
                                
                                    End if
                                
                                    Rs.close : Set Rs = nothing
                                %>
                            </table>
                        </div>
                    </td>
                    <td width="1%"></td>
                    <td width="*%" valign="top">
                        <div class="table_list">
                            <table>
                                <tr>
                                    <td width="12%" class="top1" style="background: #D7ECFF;">년도별</td>
                                    <td width="*%" class="top2" style="background: #D7ECFF;">월별</td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td class="tob1">
                                        <select name="yy" id="yy" style="width:80%;" class="select_basic">
                                            <% For kk=2024 to 2034 %>
                                              <option value="<%=kk%>"><%=kk%>년</option>
                                            <% Next %>
                                        </select>
                                    </td>
                                    <td class="tob3"  style="padding:10px 20px;">
                                        <% For ii= 1 to 12 %>
                                            <span class="checks"><input type="checkbox" name="mm_box" value="<%=ii%>" id="<%=ii%>_moon"><label for="<%=ii%>_moon"><%=ii%>월</label></span>&nbsp;&nbsp;&nbsp;&nbsp;
                                        
                                        <% Next %>
                                        <div class="pb15"></div>
                                        <span class="checks"><input type="checkbox" name="mm_box_all" id="all_year" onclick="toggle_mm()"><label for="all_year">전체 월 선택</label></span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>

            <div class="pt25"></div> 
        
            <div align="center">
                <span class="button_b" style="padding:0px 4px;"><a onclick="make_price('<%=r_seq%>')">출발일 생성</a></span>
                <span class="button_b" style="padding:0px 4px;"><a onClick="make_del();">출발일 삭제</a></span>
            </div>

            <div class="pt35"></div> 
                
            <script type="text/javascript">
            <!--
                $(document).ready(function(){
                    tkt_value('<%=seq%>','<%=ss_yy%>','<%=ss_mm%>' );
                });

                var ss_yy = document.getElementById("ss_yy").value;
                var ss_mm = document.getElementById("ss_mm").value;

                function tkt_value(g,y,m) {
                    var ss_yy = y;
                    var ss_mm = m;
                    var good_cd = document.getElementById("good_cd").value;
                    
                    document.getElementById("ss_yy").value =ss_yy;
                    document.getElementById("ss_mm").value =ss_mm;
            
                    var param = "good_cd="+good_cd+"&ss_yy="+ss_yy+"&ss_mm="+ss_mm;

                    $.ajax({
                        url:"step_calendar.asp", 
                        type :"post", 
                        data :param, 
                        dataType : "html", 
                        success : function(response) { 
                            $('#calendar_one').html(response); 
                        }, 
                        error : function(xhr, status, error) { 
                            alert(xhr+" "+ status); 
                            alert("에러가 발생했습니다."); 
                        } ,
                        beforeSend: function() {
                            $('#ajax_indicator').show().fadeIn('fast');
                        },
                        complete: function() {
                            $('#ajax_indicator').fadeOut();
                        }
                       
                    }); 
                }


                function fn_loc(s,y,m) {
                    var seq = s;
                    var ss_yy = y;
                    var ss_mm = m;

                    document.getElementById("good_cd").value =s;
                    document.getElementById("ss_yy").value =ss_yy;
                    document.getElementById("ss_mm").value =ss_mm;

                    var param = "good_cd="+s+"&ss_yy="+ss_yy+"&ss_mm="+ss_mm;
                    $.ajax({ 
                        url:"step_calendar.asp", 
                        type :"post", 
                        data :param, 
                        dataType : "html", 
                        success : function(response) { 
                            $('#calendar_one').html(response); 
                        }, 
                        error : function(xhr, status, error) { 
                            alert(xhr+" "+ status); 
                            alert("에러가 발생했습니다."); 
                        } ,
                        beforeSend: function() {
                            $('#ajax_indicator').show().fadeIn('fast');
                        },
                        complete: function() {
                            $('#ajax_indicator').fadeOut();
                        }
                        
                    }); 
                }   
            //-->
            </script>

            <div id="ajax_indicator" style="display:none">
                <p style="text-align:center; left:45%; top:45%; position:absolute;"><img src="/admin/images/loading.gif" /></p>
            </div>
            <div id="calendar_one" style="width:100%" ></div>

            <iframe name="ifmchk_frm" id="ifmchk_frm" width="0" height="0" marginwidth="0" marginheight="0"  scrolling="yes" style="display:none;" ></iframe>
            
        </form>
        
    </div>
            
</body> 
</html>

<div id="chain_day_cost" title="일자별 금액수정"></div>
        
<script type="text/javascript">
<!--
    function change_room_seq(r_seq){
        document.getElementById("room_seq").value = r_seq;
        tkt_value();
    }
             
                    
    function toggle_mm(){
        $("input[name=mm_box]").each(function(){
            if(this.checked){
                this.checked = false;
            }else  {
                this.checked = true;
            }
        });
    }


    function make_price(g){
        var good_cd = document.getElementById("good_cd").value;
        var make_yy = document.getElementById("yy").value;

        var checkLength = document.getElementsByName("u_price_1").length;

        var data_seq = [];
        var all_plus_data="";

        for(var i=0; i< checkLength; i++){
            if(document.getElementsByName("checked_room")[i].checked==true){
                checked_room =document.getElementsByName("checked_room")[i].value;
                               
                //n_price =document.getElementsByName("net_price")[i].value;
                u_price_1 =document.getElementsByName("u_price_1")[i].value;
                u_total_man =document.getElementsByName("u_total_man")[i].value;
                

                all_plus_data = checked_room+"|"+u_price_1+"^"+u_total_man;
                data_seq.push(all_plus_data);
            }
        }

        var mm_seq   = [];
        var j =0;

        $("input[name=mm_box]:checked").each(function(){ 
            mm_seq.push(this.value);
        });

        if ($("input[name=checked_room]:checked").length == 0) {
            alert("상품금액을 선택하시기 바랍니다.");
        }else if(make_yy ==""){  
            alert("생성시 해당년도을 선택해 주십시요!");
        }else{
            document.frm_price.action = "day_make_add.asp?good_cd="+good_cd+"&data_seq="+data_seq+"&yy="+make_yy+"&mm_seq="+mm_seq;
            document.frm_price.target = "ifmchk_frm";
            document.frm_price.submit();
        }
    }


    function make_del(){
        var good_cd = document.getElementById("good_cd").value;
        var make_yy = document.getElementById("yy").value;
        var checkLength = document.getElementsByName("u_price_1").length; 

        var data_seq = [];
        var all_plus_data="";

        for(var i=0; i< checkLength; i++){
            if(document.getElementsByName("checked_room")[i].checked==true){
                checked_room =document.getElementsByName("checked_room")[i].value;
 
                //n_price =document.getElementsByName("net_price")[i].value;
                //u_price =document.getElementsByName("u_price")[i].value;
                //all_plus_data = checked_room+"|"+n_price+"|"+u_price;
                
                all_plus_data = checked_room;
                data_seq.push(all_plus_data);
            }
        }

        var mm_seq   = [];
        var j =0;

        $("input[name=mm_box]:checked").each(function(){ 
            mm_seq.push(this.value);
        });

        if ($("input[name=checked_room]:checked").length == 0) {
            alert("선택된 상품금액이 없습니다.\n정확한 금액을 선택해 주십시오!");
        }else if(make_yy ==""){  
            alert("삭제시 해당년도을 선택해 주십시요.");
        }else{
            document.frm_price.action = "day_make_del.asp?good_cd="+good_cd+"&data_seq="+data_seq+"&yy="+make_yy+"&mm_seq="+mm_seq;
            document.frm_price.target = "ifmchk_frm";
            document.frm_price.submit();
        }
    }


    function fn_day_cost(s){
        var good_cd = document.getElementById("good_cd").value;
        var make_yy = document.getElementById("yy").value;
        var checkLength = document.getElementsByName("checkedcard").length; 

        var data_seq = [];
        var all_plus_data="";
            
        var  ss_yy = document.getElementById("ss_yy").value;
        var  ss_mm = document.getElementById("ss_mm").value;
            
        for(var i=0; i< checkLength; i++){
            if(document.getElementsByName("checkedcard")[i].checked==true){
                checked_room =document.getElementsByName("checkedcard")[i].value;
                data_seq.push(checked_room);
            }
        }

        if (data_seq.length<1 ) {
            alert("선택된 출발일이 없습니다.\n출발일을 선택해 주십시오!");
            return false;	
        }else{

            var _urlk = "day_cost.asp?ss_yy="+ss_yy+"&ss_mm="+ss_mm+"&good_cd="+good_cd+"&d_data="+data_seq;
            //alert(_urlk);
            $("#chain_day_cost").html('<iframe id="modalIframeId2" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
            $("#modalIframeId2").attr("src",_urlk);
        
        }
    } 
              
    $(document).ready(function(){
        $("#chain_day_cost").dialog({
            autoOpen: false,
            modal: true,
            width: 900,
            height: 770
        });

    });


    function toggle_sel(){
        $("input[name=checked_room]").each(function(){
            if(this.checked){
                this.checked = false;
            } else  {
                this.checked = true;
            }
        });
    }
//-->
</script>

<%
    objConn.close  : Set objConn = nothing
%>


