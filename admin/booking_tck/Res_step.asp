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
       
        
    tbl = "trip_gtck"
    symbol = "￦"
    
    g_kind    = Request("g_kind")
    Select Case Ucase(g_kind)
        Case "10" : g_kind_nm ="데이투어" 
        Case "20" : g_kind_nm ="할인티켓"
        Case "30" : g_kind_nm ="차량/가이드"
        Case ELSE  : g_kind_nm ="기타"
    End select 

    good_num =  request("num")
    If good_num = "" then
        Response.write "<script language='javascript'>"
        Response.write " alert('등록된 상품이 없습니다.!!...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

    sql ="SELECT title ,exchange ,t_use from "&tbl&" where num="&good_num
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3

    If Rs.eof or Rs.bof then
        Response.write "<script language='javascript'>"
        Response.write " alert('등록된 상품이 없습니다.!!...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    Else
        r_title  = Rs("title")
        exchange = Rs("exchange")
        t_use    = Rs("t_use")
    End if

    Rs.close : Set Rs = Nothing
	

   


   
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
<style type="text/css">
    .ui-datepicker {font-size:15px;}
    .ui-datepicker select.ui-datepicker-month, 
    .ui-datepicker select.ui-datepicker-year { width: 70px;} 
</style>

<script type="text/javascript">
<!--
   $(function() {
      $( ".datepicker" ).datepicker({
           changeMonth: true,
           changeYear: true,
           monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
           monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
           dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
           numberOfMonths: 2,
           dateFormat:"yy-mm-dd" 
      });
    
   });
//-->
</script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=g_kind_nm%></div>


        <form name="res_form" method="post" action="res_step_ok.asp" style="display:inline; margin:0px;" >
        <input type="hidden" name="good_num" id="good_num"  value="<%=good_num%>">
        <input type="hidden" name="g_kind" value="<%=g_kind%>"> 
        <input type="hidden" name="tmp_day" id="tmp_day"  value="">
        <input type="hidden" name="tot_opt_seq"  id="tot_opt_seq"  value="">
        <input type="hidden" name="all_good_data"  id="all_good_data"  value="">
        <input type="hidden" name="all_opt_data"  id="all_opt_data"  value="">

            <div class="table_box">
                <table width="100%">
                    <tr>
                        <td class="lop1" width="12%"><font color="#FF0000">*</font> 한글명</td>
                        <td class="lop2" width="34%"><input type="text" name="res_nm" style="width:150px" maxlength="40" class="input_basic">  </td>
                        <td class="lop3" width="12%"><font color="#FF0000">*</font> 영문명</td>
                        <td class="lop2" width="*%"><input type="text" name="res_nm_eng_F" style="width:150px" maxlength="30" class="input_basic" onKeyUp="toUpCase(this)"> / <input type="text" name="res_nm_eng_L" style="width:250px" maxlength="40" class="input_basic" onKeyUp="toUpCase(this)"></td>
                    </tr>
                    
                      
                    
                    <tr>
                        <td class="lob1"><font color="#FF0000">*</font> 휴대전화</td>
                        <td class="lob2">
                            <input type="text" name="res_hp1" id="res_hp1" value="<%=res_hp1%>"  style="width:70px" maxlength="3"class="input_basic"> - 
                            <input type="text" name="res_hp2" id="res_hp2" value="<%=res_hp2%>" style="width:100px" maxlength="4" class="input_basic"> - 
                            <input type="text" name="res_hp3" id="res_hp3"  value="<%=res_hp3%>" style="width:100px" maxlength="4"class="input_basic">
                        </td>
                        <td class="lob3"><font color="#FF0000">*</font> 이메일</td>
                        <td class="lob2">
                            <input type="text" size="16" name="emailhead" value="<%=res_email%>" style="width:25%" maxlength="30" onKeyUp="LowerCase(this)" class="input_basic"> @
                            <input type="text" name="emaildomain" value="<%=email2%>" style="width:30%" maxlength="40" onKeyUp="LowerCase(this)" class="input_basic" onFocus="setEmailEnable(document.res_form.emailcode,document.res_form.emaildomain)">
                            <span class="kp03"></span>
                            <select name="emailcode"  style="width:20%;" class="select_basic" onChange="setEmailcode(document.res_form.emaildomain,document.res_form.emailcode,document.res_form.emailcode.selectedIndex)">
                                <option value="0"> 선택하세요 </option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="hotmail.com">hotmail.com</option>
                                <option value="msn.com" >msn.com</option>
                                <option value="yahoo.com">yahoo.com</option>
                                <option value="yahoo.co.kr">yahoo.co.kr</option>
                                <option value="naver.com">naver.com</option>
                                <option value="daum.net">daum.net</option>
                                <option value="9"> 직접입력 </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="lob1" style="background: #D7ECFF;"><font color="#FF0000">*</font> 숙박호텔</td>
                        <td class="lob2" colspan="3"><input type="text" name="res_hotel" id="res_hotel" style="width:300px;" maxlength="80" class="input_basic"></td>
                    </tr>
                </table>
            </div>



            <div class="pt25"></div> 

            <div class="table_dan">
                <table width="100%">
                    <tr>
                        <td class="lop1" width="12%">상품명</td>
                        <td class="lop2" width="*%"><%=r_title%></td>
                    </tr>
                    <tr>
                        <td class="loc1"><font color="#FF0000">*</font> 선택일자</td>
                        <td class="lob2">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><input type="text" name="s_ymd" id="s_ymd" class="datepicker" maxlength="10" style="width:100px;border:1px solid #C0C0C0;padding:0 0 0 5px; height:24px;border-radius:2px 0px 0px 2px;cursor:pointer;" readonly></td>
                                    <td><img src="/admin/images/top_calendar.png" border="0"></td>
                                    <td><span style="color: #FF0000; font-size:12px; padding:0 0 0 10px;">마감일자 적용 안됩니다.</span></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="loc1"><font color="#FF0000">*</font> 필수선택</td>
                        <td class="lob2">
                            <select name="cal_step2" id="cal_step2" class="select_basic" >
                                <option value="" onChange="all_close();" >선택</option>
                                <%
                                    sql = " SELECT seq, good_cd, nm_c , price,total_man from trip_gtck_opt s2 where del_yn='N' and s2.use_yn='Y' and s2.good_cd="&good_num&" and sub_tp='F' order by sunseo asc,seq asc"
                                  'response.write sql
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open sql,objConn,3
                                                            
                                    If Rs.eof or Rs.bof then
                                    Else
                                        ii=1
                                        Do until Rs.eof
                            
                                            op_seq = Rs("seq")
                                         
                                            op_good_cd= Rs("good_cd")
                                            op_nm_c   = Rs("nm_c")
                            
                                            op_price1  = Rs("price")
                                            if op_price1="" or isnull(op_price1) then
                                                op_price1=0
                                            end if
                                           
                            
                                          '  op_total_man  = Rs("total_man")
                                           ' if op_total_man="" or isnull(op_total_man) then
                                             '   op_total_man=0
                                           ' end if
                                            
                                            
                                %>
                                <option value="<%=op_seq%>||<%=op_price1%>||<%=op_nm_c%>"><%=op_nm_c%></option>
                                <%
                                        Rs.movenext
                                        Loop
                            
                                    End if
                                %>
                            </select> 
                        </td>
                    </tr>
                   
                    <tr>
                        <td class="loc1">선택정보</td> 
                        <td class="loc2"><div id="sel_opt_price"></div></td>
                    </tr>
                  
                </table>
            </div>

            <div class="pt25"></div> 

            <div class="table_dan">
                <table width="100%">
                    <tr>
                        <td class="lop1" width="12%" class="lob1">요청사항</td>
                        <td class="lop3" width="*%" class="lob1"><textarea name="res_remark" rows="10" style="width:100%" onfocus="this.select()" class="textarea_basic"><%=res_remark%></textarea></td>
                    </tr>
                </table> 
            </div>

            <div class="pt25"></div>   
                
            <div align="center">
               <span class="button_b" style="padding:0px 4px"><a onclick="res_tck();return false;">예약</a></span> 
                <span class="button_b" style="padding:0px 4px"><a onclick="history.back();return false;">취소</a></span> 
            </div>

        </form>
    </div>
        
</body>
</html>


<script type="text/javascript">
<!--
    $(document).ready(function() {

        $("#cal_step2").on('change', function() {

            var s_ymd = $("#s_ymd").val();
            if (s_ymd.length !=10){
                alert("정확한 날짜를 선택해 주시기 바랍니다.");
                $('#cal_step2').find('option:first').attr('selected', 'selected');

            }else{

                document.getElementById("all_good_data").value="";
                document.getElementById("all_opt_data").value="";
                
                var sel_txt = $("#cal_step2").val();
                var s_value   = sel_txt.split('||');
               
                var data_txt1 = s_value[0];
                var data_txt2 = s_value[1];
                var data_txt3 = s_value[2];
               

                $.ajax({
                    type: "POST",
                    url: "ticket_price.asp",
                    data: "good_num=<%=good_num%>&s_ymd="+s_ymd+"&room_seq="+data_txt1,
                    success: function(data) {

                        var res_data = data.split('|');
                        var ad_price = res_data[0];
                           var ch_price = res_data[1];
                        var add_size = document.getElementsByName("qty_ad").length;
                        
                        html =  "<div id='"+ s_ymd + '_'+add_size+ "'>"
                        html += "    <div style='padding:10px 20px;'>"
                        html += "        <table border='0' cellspacing='0' cellpadding='0'>"
                        html += "            <tr>"
                        html += "                <td width='90px;'>· "+ s_ymd + "</td>"
                        html += "                <td width='*;'><span onclick=\"all_close();\" style='cursor:pointer;'><i class='xi-close-square xi-2x'></i></span></td>"
                        html += "            </tr>"
                        html += "        </table>"
                        html += "        <div style='padding:5px 0px 8px 0;'>· "+ data_txt3 + "</div>"
                        html += "        <div style='padding:5px 0px 8px 0;'>·예약가능 "+ ch_price + "</div>"
                        html += "        <table border='0' cellspacing='0' cellpadding='0'>"
                        html += "            <tr>"
                        html += "                <td width='50px;'>· 성인</td>"
                        html += "                <td width='130px;'>"
                        html += "                    <table border='0' cellspacing='0' cellpadding='0'>"
                        html += "                        <tr>"
                        html += "                            <td></td>"
                        html += "                            <td style='padding:0 5px;'><input name='qty_ad' size='3' class='tck_plus2' maxlength='4' value='1' readonly/></td>"
                        html += "                            <td></td>"
                        html += "                        </tr>"
                        html += "                    </table>"
                        html += "                </td>"
                        html += "                <td width='*;'>￦" + ad_price  + "<input type='hidden' name='ad_price' value='"+ ad_price + "'  size='5' maxlength='4'></td> "
                        html += "            </tr>"
                        html += "            <tr>"
                        html += "                <td></td>"
                        html += "                <td></td>"
                        html += "            </tr>"
                        html += "        </table>"
                        html += "    </div>"
                        html += "    <div id='"+ s_ymd + "_opt"+"'></div>"
                        html += "</div>"
                        document.getElementById("tot_opt_seq").value=data_txt1;
                        $("#sel_opt_price").empty();
                        $("#sel_opt_price").append(html);
                      //  $("#s_ymd").val('');
                        $('#cal_step2').find('option:first').attr('selected', 'selected');
                        document.getElementById("tmp_day").value=s_ymd;
                    }
                });
            }
        });
    });
 
    $(document).ready(function() {

        $("#cal_opt").on('change', function() {
            var tmp_day = document.getElementById("tmp_day").value;
             
            var opt_sel_txt = $("#cal_opt").val();
             
            var o_value     = opt_sel_txt.split('||');
               
            var opt_txt1 = o_value[0];
            var opt_txt2 = o_value[1];
            var opt_txt3 = o_value[2];
            
            var add_opt_size = document.getElementsByName("qty_opt").length;
            var sel_seq = document.getElementById("tot_opt_seq").value;
 
            //var temp_ad= tmp_day+"_opt_"+sel_seq;
            var temp_ad= tmp_day+"_opt_"+opt_txt1;

            var find_1 = $('#'+temp_ad);
            if( $(find_1).length > 0 ){
                alert("동일한 옵션이 있습니다.");
            }else{
            
                if (tmp_day.length !=10 ){
                    alert("필수항목을 선택하세요");
                    $('#cal_opt').find('option:first').attr('selected', 'selected');
               	  
                }else{
               
                    html ="<div id='"+ tmp_day + '_opt_'+opt_txt1+ "'>"
            
                    html += "    <div style='border-top:1px solid #C0C0C0;'></div>"
                    html += "    <div style='padding:10px 20px;'>"
                    html += "        <table border='0' cellspacing='0' cellpadding='0'>"
                    html += "            <tr>"
                    html += "                <td width='*;'>· "+ opt_txt3 + "</td>"
                    html += "                <td width='10px;'></td>"
                    html += "                <td width='23px;'><span onclick= add_opt_del('"+ tmp_day + '_opt_'+opt_txt1+ "') style='cursor:pointer;'><i class='xi-close-square xi-2x'></i></span></td>"
                    html += "            </tr>"
                    html += "         </table>"
                    
                    html += "        <table border='0' cellspacing='0' cellpadding='0'>"
                    html += "            <tr>"
                    html += "                <td width='50px;'>· 수량</td>"
                    html += "                <td width='130px;'>"
                    html += "                    <table border='0' cellspacing='0' cellpadding='0'>"
                    html += "                        <tr>"
                    html += "                            <td><input type='button' value=' + ' class='tck_plus1' onclick=\"add_opt('"+ add_opt_size + "');\"></td>"
                    html += "                            <td style='padding:0 5px;'><input name='qty_opt' id='qty_opt' class='tck_plus2' size='3' maxlength='4' value='0' /></td>"
                    html += "                            <td><input type='button' value=' - ' class='tck_plus1' onclick=\"del_opt('"+ add_opt_size + "');\"></td>"
                    html += "                        </tr>"
                    html += "                    </table>"
                    html += "                </td>"
                    html += "                <td width='*;'>￦" + opt_txt2 + "<input type='hidden'  name='qty_opt_price'  value= '"+ opt_txt2 +  "' size='5' maxlength='4' /><input type=\"hidden\" name=\"qty_opt_seq\"  value=\""+ opt_txt1 +"\" size='5' /></td>"
                    html += "            </tr>"
                    html += "            <tr>"
                    html += "                <td></td>"
                    html += "                <td></td>"
                    html += "                <td><div id='opt_amt_"+add_opt_size+ "' style='color:#0000FF;font-weight:700;'>￦0</div></td>"
                    html += "            </tr>"
                    html += "        </table>"
                    html += "    </div>"
                    html += "</div>"
                    
                    $("#"+tmp_day+"_opt").append(html);
                    $('#cal_opt').find('option:first').attr('selected', 'selected');
                    
       	  	       //var divArr = $("[id$='_add_opt']"); 
                }

            } 

        });

    });

//-->
</script>


    
<script language="JavaScript">
<!--
    function add_ad(s) {
    	
        var add_size = document.getElementsByName("qty_ad").length;
       
         
        for(var i=0;i < parseInt(add_size) ;i++){
 
            var curr_ad_cnt = document.getElementsByName("qty_ad")[i].value;
       	  	 
            if (curr_ad_cnt >=0) {
                var new_curr_ad_cnt = parseInt(curr_ad_cnt)+ 1;
                document.getElementsByName("qty_ad")[i].value=new_curr_ad_cnt;
            }
        }
        good_amt();
    }


   
    

    function del_ad(s) {

        var add_size = document.getElementsByName("qty_ad").length;
    
        for(var i=0;i < parseInt(add_size) ;i++){
 
            var curr_ad_cnt = document.getElementsByName("qty_ad")[i].value;
       	  	   	  	 
            if (curr_ad_cnt >0) {
                var new_curr_ad_cnt = parseInt(curr_ad_cnt)- 1;
                document.getElementsByName("qty_ad")[i].value=new_curr_ad_cnt;
            }
        }
        good_amt();
    }



    function del_ch(s) {
        var add_size = document.getElementsByName("qty_ad").length;
    
        for(var i=0;i < parseInt(add_size) ;i++){
 
            var curr_ch_cnt = document.getElementsByName("qty_ch")[i].value;
       	  	   	  	 
            if (curr_ch_cnt >0) {
                var new_curr_ch_cnt = parseInt(curr_ch_cnt)- 1;
                document.getElementsByName("qty_ch")[i].value=new_curr_ch_cnt;
            }
        }
        good_amt();
    }


   

    function good_amt(){ 
    	       
        var ad_cnt   = 1;
        var ad_price = document.getElementsByName("ad_price")[0].value;

     

        var good_amt=0;
        good_amt = parseInt(ad_cnt) *parseInt(ad_price) ;

        var price_amt =parseInt(good_amt) ;
        var price_amt2 =fn_comma(price_amt);
        var insTag = "<div style='font-weight:700;'>￦"+price_amt2+"</div>" ;
    
        $("#good_amt").html(insTag);
 

        var good_data="";
        var good_id    = document.getElementById("good_num").value; 
        var qty_ad_val = document.getElementsByName("qty_ad")[0].value


        good_data = good_id+"|"+qty_ad_val;

        var data_seq = [];
        var add_opt_size = document.getElementsByName("qty_opt").length;
        var tot_opt_amt =0;
    

    
        for(var i=0;i < parseInt(add_opt_size) ;i++){
       	
            var opt_seq = document.getElementsByName("qty_opt_seq")[i].value;
            var opt_cnt = document.getElementsByName("qty_opt")[i].value;
            var opt_price = document.getElementsByName("qty_opt_price")[i].value;
         
            all_opt_data = opt_seq+"|"+opt_cnt;
            data_seq.push(all_opt_data);
    
            var opt_amt=0;
            opt_amt = parseInt(opt_cnt) *parseInt(opt_price) ;
         
            tot_opt_amt = parseInt(tot_opt_amt) + parseInt(opt_amt) ;

        }

        document.getElementById("all_good_data").value=good_data;
        document.getElementById("all_opt_data").value=data_seq;
    
        var total_price_amt =0;
        var total_price_amt = parseInt(good_amt) + parseInt(tot_opt_amt) ;
        var total_price_amt2 =fn_comma(total_price_amt);
    
        var tot_amtTag = "<div style='font-weight:700;'>￦"+total_price_amt2+"</div>" ;
        $(".sum_amt").html(tot_amtTag);

    }


    function add_opt(s) {
    
        var add_opt_size = document.getElementsByName("qty_opt").length;
    
        for(var i=0;i < parseInt(add_opt_size) ;i++){
    
            if (s==i) {
            	
                var curr_cnt = document.getElementsByName("qty_opt")[i].value;
                
                if (curr_cnt >=0) {
                    var new_curr_cnt = parseInt(curr_cnt)+ 1;
                    document.getElementsByName("qty_opt")[i].value=new_curr_cnt;
                }
    
                var opt_cnt = document.getElementsByName("qty_opt")[i].value;
                var opt_price = document.getElementsByName("qty_opt_price")[i].value;
    
       	  	
                var opt_amt=0;
                opt_amt = parseInt(opt_cnt) *parseInt(opt_price) ;
    
                var price_amt =parseInt(opt_amt) ;
                var price_amt2 =fn_comma(price_amt);
                var insTag = "<div style='font-weight:700;'>￦"+price_amt2+"</div>" ;
                $("#opt_amt_"+s).html(insTag);
            }
    
        }
        good_amt();
    }


    function del_opt(s) {
        var add_opt_size = document.getElementsByName("qty_opt").length;
    	 
        for(var i=0;i < parseInt(add_opt_size)+1 ;i++){
    
            if (s==i) {
            	
                var curr_cnt = document.getElementsByName("qty_opt")[i].value;
                
                if (curr_cnt >=1) {
                    var new_curr_cnt = parseInt(curr_cnt)- 1;
                    document.getElementsByName("qty_opt")[i].value=new_curr_cnt;
                }
     
                var opt_cnt = document.getElementsByName("qty_opt")[i].value;
                var opt_price = document.getElementsByName("qty_opt_price")[i].value;
    
                var opt_amt=0;
                opt_amt = parseInt(opt_cnt) *parseInt(opt_price) ;
    
                var price_amt =parseInt(opt_amt) ;
                var price_amt2 =fn_comma(price_amt);
                var insTag = "<div style='font-weight:700;'>￦"+price_amt2+"</div>" ;
                $("#opt_amt_"+s).html(insTag);
            }
    
        }
        good_amt();
    }


    function add_opt_del(d) {
        $('#'+d).remove();
        alert("추가선택이 삭제 되었습니다.");
        $('#cal_step2').find('option:first').attr('selected', 'selected');
        $('#cal_step2').find('option:first').attr('selected', 'selected');
        good_amt();
    }


    function all_close() {
        $("#sel_opt_price").empty();
        $('#cal_step2').find('option:first').attr('selected', 'selected');
        $('#cal_step2').find('option:first').attr('selected', 'selected');
        alert("필수선택이 삭제 되었습니다.");
      //  $('.sum_amt').html('<div>￦ 0</div>');
       $("#cal_step2").val('');
    }


    function fn_comma(num){
        var len, point, str;

        num = num + "";
        point = num.length % 3 ;
        len = num.length;
        str = num.substring(0, point);

        while (point < len) {
            if (str != "") str += ",";
            str += num.substring(point, point + 3);
            point += 3;
        }

        return str;
    }

    
    function setEmailcode(setObject,selectObject,index) {
        setObject.value = selectObject[index].text;
        if (selectObject.value == "0" || selectObject.value == "9") {
            alert("정확한 메일주소를 선택해 주십시오");
            setObject.focus();
        }else{
            setObject.blur();
        }
    }


    function setEmailEnable(emailcodeObject,ipmenu2Object) {
        if (emailcodeObject.value == "0" || emailcodeObject.value == "9") {
            ipmenu2Object.value = "";
            ipmenu2Object.focus();
        } else  {
            ipmenu2Object.blur();
        }
    }


    function res_tck(){
       
       if(res_form.res_nm.value == ""){
            		alert("한글명을 입력해 주세요.");
            		res_form.res_nm.focus();
            		return false;
            	}
    
      if(res_form.res_hp1.value == ""){
            		alert("핸드폰 입력해 주세요.");
            		res_form.res_hp1.focus();
            		return false;
            	}
            	
      if(res_form.res_hp2.value == ""){
            		alert("핸드폰 입력해 주세요.");
            		res_form.res_hp2.focus();
            		return false;
            	}
            	
      if(res_form.res_hp3.value == ""){
            		alert("핸드폰 입력해 주세요.");
            		res_form.res_hp3.focus();
            		return false;
            	}
        document.res_form.submit();

    }


    function toUpCase(object){
        object.value = object.value.toUpperCase(); 
    }
//-->
</script>



<%
	Function fnWriteOption(byVal count)
		For i = 1 to count
			fnWriteOption = fnWriteOption & "<option value="&i&">" & i & "</option>" & vbCrLf
		Next
	End Function
%>