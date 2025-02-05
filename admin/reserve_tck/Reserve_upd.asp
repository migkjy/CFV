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
       
       
       
    reserve_code  = Request("reserve_code")
    If reserve_code = "" then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('주요인자오류'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if


    sql =" SELECT  r.seq , r.good_num, r.reserve_code, r.g_kind, r.res_nm,  r.res_eng_nm_f, r.res_eng_nm_L , r.res_hp1, r.res_hp2, r.res_hp3, r.res_email ,res_hotel , res_pick_place, res_pick_time"
    sql = sql &" FROM  w_res_tck001 r    "
    sql = sql &" WHERE r.reserve_code ='"&reserve_code&"'"

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3
    If Rs.eof or Rs.bof then
        Response.write "<script type='text/javascript'>"
        Response.write " alert(' 예약된내용이 없습니다.'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    Else
        r_seq = Rs("seq")
        good_num = Rs("good_num")
        reserve_code = Rs("reserve_code")
        g_kind = Rs("g_kind")

        res_nm = Rs("res_nm")
        res_eng_nm_F = Rs("res_eng_nm_F")
        res_eng_nm_L = Rs("res_eng_nm_L")
        res_hp1 = Rs("res_hp1")
        res_hp2 = Rs("res_hp2")
        res_hp3 = Rs("res_hp3")
        res_email = Rs("res_email")
        
        res_hotel = Rs("res_hotel")
        pick_place = Rs("res_pick_place")
        pick_time = Rs("res_pick_time")
     End if

     Rs.close : Set Rs = nothing
%>
 
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
</head>

<body>
	
	<div class="pt15"></div>
    
    <form method="post" name="res_form" action="reserve_upd_ok.asp" style="display:inline; margin:0px;"  >
    <input type="hidden" name="reserve_code" value="<%=reserve_code%>">
    <input type="hidden" name="g_kind" value="<%=g_kind%>">

        <div class="table_box">
            <table>
                <tr height="40">
                    <td class="lop1">예약번호</td>
                    <td class="lop2" colspan="3"><%=reserve_code%> </td>
                </tr>
                <tr height="40">
                    <td class="lob1" width="12%">한글명</td>
                    <td class="lob2" width="38%"><input type="text" name="res_nm" value="<%=res_nm%>" style="width:50%" class="input_color"></td>
                    <td class="lob3" width="12%">휴대전화</td>
                    <td class="lob2" width="*%">
                        <input type="text" name="res_hp1" value="<%=res_hp1%>" style="width:20%" maxlength="10" class="input_color"> -
                        <input type="text" name="res_hp2" value="<%=res_hp2%>" style="width:20%" maxlength="10" class="input_color"> -
                        <input type="text" name="res_hp3" value="<%=res_hp3%>" style="width:20%" maxlength="10" class="input_color">
                    </td>
                </tr>
                <tr height="40">
                    <td class="lob1">이메일</td>
                    <td class="lob2"><input type="text" name="res_email" value="<%=res_email%>" style="width:96%" maxlength="50" class="input_color"></td>
                    <td class="lob3">숙박호텔</td>
                    <td class="lob2"><input type="text" name="res_hotel"  value="<%=res_hotel%>" style="width:96%" maxlength="50" class="input_color"></td>
                </tr>
            </table>
        </div>
        
        <input type="hidden" name="res_eng_nm_F" value="<%=res_eng_nm_F%>">
        <input type="hidden" name="res_eng_nm_L" value="<%=res_eng_nm_L%>">
        
        <div class="pt25"></div> 
        
        <div align="center">
            <span class="button_b" style="padding:0px 4px;"><a href="javascript:sendit();">수정</a></span>
            <span class="button_b" style="padding:0px 4px;"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
        </div>
    </form>
    
</body>
</html> 

<%  
    objConn.close : Set objConn = nothing 
%>


<script language="javascript">
<!--
    function closeIframe(){
        parent.$('#chain_name').dialog('close');
        return false;
    }
    
    
    function sendit(){
    
        if(document.res_form.res_nm.value==""){
            alert("예약자 성명을 입력해주세요");
            return false;
        }
        
        if(document.res_form.res_hp1.value==""){
            alert("예약자 휴대전화번호를 입력해주세요");
            return false;
        }
        
        if(document.res_form.res_hp2.value==""){
            alert("예약자 휴대전화번호를 입력해주세요");
            return false;
        }
        
        if(document.res_form.res_hp3.value==""){
            alert("예약자 휴대전화번호를 입력해주세요");
            return false;
        }
        
        if(document.res_form.res_email.value==""){
            alert("예약자 이메일을 입력해주세요");
            return false;
        }
        
        document.res_form.submit();
    }
    

    function toUpCase(object){
        object.value = object.value.toUpperCase(); 
   }
//-->
</script>
 
        
