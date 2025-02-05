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
    
    g_kind = Request("g_kind")
    good_cd = Request("good_cd")
    
    d_data = Request("d_data")
    arr_d_data = split(d_data,",")

    ss_yy = Request("ss_yy")
    ss_mm = Request("ss_mm")
    
    gotopage  = Request("gotopage")
%>



<!DOCTYPE html>
<html>
<head>
<title><%=g_kind_nm%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>

<body onload="posion_c();">

    <div class="pt15"></div>   

    <form name="dataform" method="post"  style="display:inline; margin:0px;">
    <input type="hidden" name="good_cd"   value="<%=good_cd%>" >
    <input type="hidden" name="ss_yy" value="<%=ss_yy%>" >
    <input type="hidden" name="ss_mm" value="<%=ss_mm%>" >
    <input type="hidden" name="g_kind" value="<%=g_kind%>" >
      
        <div class="table_list">
            <table>
                <tr>
                    <td width="9%" class="top1">No.</td>
                    <td width="*%" class="top2">투어시간</td>
                    <td width="11%" class="top2">전체 인원</td>
                    <td width="11%" class="top2">상품금액</td>
                    <td width="11%" class="top2">선택</td>
                </tr>
                <%
                    rsql = " SELECT seq, good_cd, nm_c, price , total_man, sub_tp, nat_cd FROM  trip_gtck_opt where del_yn='N' and sub_tp='F' and good_cd='"&good_cd&"' "
                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                    Rs.open rsql,objConn,3
                
                    If Rs.eof or Rs.bof then
                    Else
                        ii=0
                        DO until Rs.eof
                            
                            rr_seq = Rs("seq")
                            rr_nm_c = Rs("nm_c")
                            rr_nm_c = cutStr(rr_nm_c,80)
                
                            rr_price_1 = Rs("price")
                            if rr_price_1 ="" or isnull(rr_price_1) THEN
                                rr_price_1 = 0
                            end if
                  
                            rr_total_man = Rs("total_man")
                            if rr_total_man ="" or isnull(rr_total_man) THEN
                                rr_total_man = 0
                            end if
                  
  
                %>
                <tr bgcolor="#FFFFFF">
                    <td class="tob1"><%=ii+1%></td>
                    <td class="tob3">[<%=rr_seq%>]&nbsp;&nbsp;&nbsp;<%=rr_nm_c%></td>
                    <td class="tob2"><input type="text" name="rr_total_man" value="<%=rr_total_man%>"  style="width:70%;" class="input_basic"></td>
                    <td class="tob2"><input type="text" name="rr_price_1" value="<%=rr_price_1%>"  style="width:70%;" class="input_basic"></td>
                    <td class="tob2"><span class="checks"><input type="checkbox" name="rr_room_seq" value="<%=rr_seq%>" onclick="change_price('<%=rr_seq%>')" id="<%=rr_seq%>" class="only_check"><label for="<%=rr_seq%>">적용</label></span></td>
                </tr> 
                <%
                           Rs.movenext
                           ii= ii + 1
                        Loop
                    End if
                
                    Rs.close : Set Rs = nothing
                %>
            </table>
        </div>

        <div class="pt20"></div>  

        <div class="table_list">
            <table>
                <tr>
                    <td width="9%" class="top1" style="background: #D7ECFF;"><a href="javascript:;" onClick="toggle_del()"><img src="/admin/images/btn_all_select.gif" border="0"></a></td>
                    <td width="*%" class="top2" style="background: #D7ECFF;">투어시간</td>
                    <td width="11%" class="top2" style="background: #D7ECFF;">전체 인원</td>
                    <td width="11%" class="top2" style="background: #D7ECFF;">상품금액</td>
                    <td width="11%" class="top2" style="background: #D7ECFF;"><a href="javascript:;" onClick="toggle_magam()"><img src="/admin/images/btn_all_end.gif" border="0"></a></td>
                </tr>
                <%
                    For ii=0 to ubound(arr_d_data)
                
                       re_arr_d_date = Replace(arr_d_data(ii),"-","")
                
                       sql ="SELECT d.seq, d.room_seq ,d.good_cd, d.price_1, d.total_man, d.day, d.magam , o.nm_c  from w_tck_day d LEFT OUTER JOIN trip_gtck_opt AS o ON d.room_seq = o.seq "
                       sql = sql& "  where d.good_cd ="&good_cd&" and d.day = '"&re_arr_d_date&"' order by o.seq asc "
                   ' response.write sql
                    
                       Set Rs = Server.CreateObject("ADODB.RecordSet")
                       Rs.open sql,objConn,3
                %>
                <tr>
                    <td class="tob1" colspan="5" style="font-size:15px;font-weight:700;padding:0px 0px 0px 30px;text-align:left;"><%=ch_changeday(arr_d_data(ii))%><input type="hidden" name="opt_date" value="<%=re_arr_d_date%>"></td> 
                </tr>
                <%
                       If rs.eof or rs.bof then
                       Else
                           do until Rs.eof
                
                              r_seq = Rs("seq")
                              r_room_seq = Rs("room_seq")
                
                              r_price_1  = Rs("price_1")
                              if r_price_1 ="" or isnull(r_price_1) THEN
                                r_price_1 = 0
                              end if
                
                              r_total_man  = Rs("total_man")
                              if r_total_man ="" or isnull(r_total_man) THEN
                                r_total_man = 0
                              end if
               
                              r_nm = Rs("nm_c")
                
                              r_day      = Rs("day")
                              r_magam    = Ucase(Rs("magam"))
                                if r_magam="Y" then
                                    r_checked = "checked"
                                else
                                    r_checked = ""
                                end if
                
                %>
                <tr bgcolor="#FFFFFF">
                    <td class="tob1"><span class="checks" style="padding:0 0 0 8px;"><input type="checkbox" name="checkedcard" value="<%=r_seq%>"  id="<%=r_seq%>"><label for="<%=r_seq%>"></label></span></td> 
                    <td class="tob3">[<%=r_room_seq%>]&nbsp;<%=r_nm%><input type="hidden" name="opt_seq" value="<%=r_seq%>"></td>
                    <td class="tob2"><input type="text" name="d_total_man" value="<%=r_total_man%>" style="width:70%;border:1px solid #C0C0C0; padding:0 5px; height:26px; cursor:pointer; background-color:#EFF2FE; border-radius:2px;" class="<%=r_room_seq%>_1"> </td>
                    <td class="tob2"><input type="text" name="d_price_1" value="<%=r_price_1%>" style="width:70%;border:1px solid #C0C0C0; padding:0 5px; height:26px; cursor:pointer; background-color:#EFF2FE; border-radius:2px;" class="<%=r_room_seq%>_2"> </td>
                    <td class="tob2"><span class="checks" style="padding:0 0 0 8px;"><input type="checkbox" name="r_seq" value="<%=r_seq%>|<%=r_room_seq%>"  <%=r_checked%> id="<%=r_seq%>|<%=r_room_seq%>"><label for="<%=r_seq%>|<%=r_room_seq%>"></label></span><input type="hidden" name="chk_seq" value="<%=r_seq%>"  ></td> 
                </tr>
                <% 
                
                              Rs.movenext 
                           Loop
                       End if
                 
                   NEXT
                %>
                <tr>
                    <td class="bop1"><span class="button_a"><a href="javascript:deldata();">삭제</a></span></td>
                    <td class="bop2" colspan="3"></td>
                    <td class="bop2"><span class="button_a"><a href="javascript:fn_magam();">마감</a></span></td>
                </tr>
            </table>
        </div>
        
        <div class="pt25"></div> 
        
        <div align="center">
            <span class="button_b" style="padding:0px 4px;"><a href="javascript:sendit();">수정</a></span>
            <span class="button_b" style="padding:0px 4px;"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
        </div>
    </form>
    
</body>
</html> 

<% 
    objConn.close  : Set objConn = nothing
%>
    
<script type="text/javascript">
<!--
    function closeIframe(){
        parent.$('#chain_day_cost').dialog('close');
        return false;
    }


    function toggle_del(){
        $("input[name=checkedcard]").each(function(){
            if(this.checked){
                this.checked = false;
            } else  {
                this.checked = true;
            }
        });
        
        var res = [];
        var i =0;
        
        $("input[name=checkedcard]:checked").each(function(){ 
            res.push(this.value);
            i++;
        });
    }


    function toggle_magam(){
        $("input[name=r_seq]").each(function(){
            if(this.checked){
                this.checked = false;
            } else  {
                this.checked = true;
            }
        });
        
        var res = [];
        var i =0;
        
        $("input[name=r_seq]:checked").each(function(){ 
            res.push(this.value);
            i++;
        });
    }

    
    function sendit(){
        document.dataform.action="day_cost_ok.asp?s_tp=U"
        document.dataform.submit();
    }

    
    function fn_magam(){
        var res = [];
        var i =0;
        
        $("input[name=r_seq]:checked").each(function(){ 
            res.push(this.value);
            i++;
        });

        document.dataform.action="day_cost_ok.asp?s_tp=M&del_seq="+res+"&d_data=<%=d_data%>";
        document.dataform.submit();
    }

    
    function deldata(){
        var res = [];
        var i =0;

        $("input[name=checkedcard]:checked").each(function(){ 
            res.push(this.value);
            i++;
        });

        if (res.length<1 ) {
            alert("선택된 출발일이  없습니다.");
            return false;
        }else{

            document.dataform.action="day_cost_ok.asp?s_tp=D&del_seq="+res;
            document.dataform.submit();
        }
    }


    function change_price(s){
        var radButtons = document.getElementsByName('rr_room_seq'); 
        var radButtons1 = document.getElementsByName('rr_price_1'); 
        var radButtons2 = document.getElementsByName('rr_price_2');
        var radButtons3 =document.getElementsByName('rr_price_3');

        var checked = "";

        for(var i = 0; i < radButtons.length; i++){ 

            if(radButtons[i].checked){ 
                checked1 = radButtons1[i].value; 
                checked2= radButtons2[i].value; 
                checked3= radButtons3[i].value; 
            }

        }

        $('.'+s+'_1').val(checked1);
        $('.'+s+'_2').val(checked2);
        $('.'+s+'_3').val(checked3);

        alert("선택번호 ["+s+"] 금액으로 적용 되었습니다.");
        $('.only_check' ).prop( 'checked', false );
    }
//-->
</script>

<script type="text/javascript">
<!--
    function posion_c(){ 
        var x,y; 
        if (self.innerHeight) {
            x = (screen.availWidth - self.innerWidth) / 2; 
            y = (screen.availHeight - self.innerHeight) / 2; 
        }else if (document.documentElement && document.documentElement.clientHeight) {
            x = (screen.availWidth - document.documentElement.clientWidth) / 2; 
            y = (screen.availHeight - document.documentElement.clientHeight) / 2; 
        }else if (document.body) {
            x = (screen.availWidth - document.body.clientWidth) / 2; 
            y = (screen.availHeight - document.body.clientHeight) / 2; 
        } 
        window.moveTo(x,y); 
    } 
//-->
</script> 

<%
    Function ch_changeday(byval s_procd)
    
        If Len(s_procd)=8 then
            s_change_day = Left(s_procd,4)&"-"&Mid(s_procd,5,2)&"-"&Right(s_procd,2)
        Else
            s_change_day = s_procd
        End if
	
        ch_changeday = s_change_day

 End Function 
%>