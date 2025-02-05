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
 
    g_kind    = Request("g_kind")
    Select Case Ucase(g_kind)
        Case "10" : g_kind_nm = "프로그램 상품관리" : g_txt_1 = "투어시간" : g_txt_2 = "최소출발"
        Case "20" : g_kind_nm = "할인티켓 상품관리" : g_txt_1 = "이용시간" : g_txt_2 = "상품 TIP"
    End select

    num = Request("num")

    gotopage  = Request("gotopage")
    s_cont    = Request("s_cont")
    cont = Request("cont")


    If num <> "" then

        sql=" Select num,  event_tp, title,  eng_title , good_tip, g_kind, s_area , tot_day , exchange , t_use, remark1, remark2, remark3, remark4,  emp_nm, emp_email from "&tbl&" where num="&num
        Set Rs = Server.CreateObject("ADODB.RecordSet")
        Rs.open sql,objConn ,3
   
        if Rs.eof or Rs.bof then
            Response.write "<script language='javascript'>"
            Response.write " alert('주요인자전송에러!!...'); "
            Response.write " history.back();"
            Response.write " </script>	 "
            Response.end
        else
            event_tp = Rs("event_tp")
            title = Rs("title")
            eng_title = Rs("eng_title")
            good_tip = Rs("good_tip")

            g_kind = Rs("g_kind")
            s_area = Rs("s_area")

            tot_day = Rs("tot_day")
            d_day0 = Left(tot_day,1)
   	        d_day1 = Mid(tot_day,2,1)
   	        d_day2 = Mid(tot_day,3,1)
   	        d_day3 = Mid(tot_day,4,1)
   	        d_day4 = Mid(tot_day,5,1)
   	        d_day5 = Mid(tot_day,6,1)
   	        d_day6 = Mid(tot_day,7,1)
   	        
   	        exchange  = Rs("exchange")
   	        t_use     = Rs("t_use")
            
   	        remark1 = Rs("remark1")
   	        remark2 = Rs("remark2")
   	        remark3 = Rs("remark3")
   	        remark4 = Rs("remark4")
            
   	        emp_nm = Rs("emp_nm")
   	        emp_email = Rs("emp_email")
        end if
     
        Rs.close :      Set Rs=nothing
     
        btn="수정"


    Else

        event_tp ="A" 
        t_use    ="N" 

        d_day0   = "Y"
        d_day1   = "Y"
        d_day2   = "Y"
        d_day3   = "Y"
        d_day4   = "Y"
        d_day5   = "Y"
        d_day6   = "Y"
        
        btn ="등록"
    
    End if


    If user_nm = "" then 
        user_nm = cu_nm_kor
    End if
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
<script type="text/javascript" src="/seditor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=g_kind_nm%></div>

        <form name="form1" method="post" action="tck_ins_ok.asp"  style="display:inline; margin:0px;" >
        <input type="hidden" name="g_kind" value="<%=g_kind%>"   >
        <input type="hidden" name="num" value="<%=num%>"   >
        <input type="hidden" name="gotopage" value="<%=gotopage%>"   >
        <input type="hidden" name="s_cont" value="<%=s_cont%>"   >
        <input type="hidden" name="cont" value="<%=cont%>"   >

            <div class="table_dan">
                <table width="100%">
                    <tr>
                        <td class="lop1">프로그램 상품명</td>
                        <td class="lop2" colspan="3"><input name="title" type="text" value="<%=title%>" style="width:500px;" maxlength="100" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td width="12%" class="lob1">카테고리</td>
                        <td width="38%" class="lob2">
                            <select name="sub_cd" style="width:200px;" class="select_basic">
                                <%
                                    sql = " SELECT  TOP (200) idx, g_kind,  title, sunseo, del_yn FROM trip_gtck_city where g_kind='"&g_kind&"' "
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open sql,objConn,3
                                         
                                    If Rs.eof or Rs.bof then
                                    Else
                                    
                                        ii=1
                                        Do until Rs.eof
                                            
                                            c_idx = Rs("idx")
                                            c_title = Rs("title")
                                %>
                                <option value="<%=c_idx%>" <% if Trim(c_idx)=Trim(s_area)   then response.write "selected" end if %> ><%=c_title%></option>
                                <%
                                        Rs.movenext
                                        Loop
                                        
                                    End If
                                %>
                            </select>
                        </td>
                        <td width="12%" class="lob3">이벤트 타입</td>
                        <td width="*%" class="lob2">
                            <table width="100%">
                                <tr>
                                    <td width="25"><input type="radio" name="event_tp" value="A" <% if event_tp="A" then response.write "checked" end if %> class="radio_basic"></span>
                                    <td width="40" style="padding:0 0 4px 0;">NO</td>
                                    <td width="25"><input type="radio" name="event_tp" value="B" <% if event_tp="B" then response.write "checked" end if %> class="radio_basic"></span>
                                    <td width="40" style="padding:0 0 4px 0;">추천</td>
                                    <td width="25"><input type="radio" name="event_tp" value="C" <% if event_tp="C" then response.write "checked" end if %> class="radio_basic"></span>
                                    <td width="*" style="padding:0 0 4px 0;">특가</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="lob1">출발요일</td>
                        <td class="lob2">
                            <span class="checks"><input type="checkbox" name="day_0" id="day_0" value="0" <% if d_day0="Y" then response.write "checked" end if %>><label for="day_0">일</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_1" id="day_1" value="1" <% if d_day1="Y" then response.write "checked" end if %>><label for="day_1">월</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_2" id="day_2" value="2" <% if d_day2="Y" then response.write "checked" end if %>><label for="day_2">화</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_3" id="day_3" value="3" <% if d_day3="Y" then response.write "checked" end if %>><label for="day_3">수</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_4" id="day_4" value="4" <% if d_day4="Y" then response.write "checked" end if %>><label for="day_4">목</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_5" id="day_5" value="5" <% if d_day5="Y" then response.write "checked" end if %>><label for="day_5">금</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_6" id="day_6" value="6" <% if d_day6="Y" then response.write "checked" end if %>><label for="day_6">토</label></span>
                        </td>
                        <td class="lob3">통화</td>
                        <td class="lob2">
                            <select name="exchange" style="width:50px;" class="select_basic">
                                <option value="10" <% if Trim(exchange)="10" then response.write "selected" end if %> >CP</option>
                            </select>
                         </td>	
                    </tr>
                    <tr>
                        <td class="lob1">정원</td>
                        <td class="lob2"><input type="text" name="emp_email" value="<%=emp_email%>" style="width:60px;" maxlength="3" class="input_basic"></td>
                        <td class="lob3"><%=g_txt_2%></td>
                        <td class="lob2"><input type="text" name="emp_nm" value="<%=emp_nm%>" style="width:60px;" maxlength="3" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="lob1">출발요일</td>
                        <td class="lob2"><input type="text" name="good_tip" value="<%=good_tip%>" style="width:80%;" maxlength="100" class="input_basic"></td>
                        <td class="lob3"><%=g_txt_1%></td>
                        <td class="lob2"><input type="text" name="eng_title" value="<%=eng_title%>"  style="width:80%;" maxlength="100" class="input_basic"></td>
                    </tr>
                </table>
            </div>
        
            <div class="pt15"></div> 
            
            <div class="table_dan">
                <table width="100%" style="border-top:1px solid #C0C0C0;">
                    <tr>
                        <td width="12%" class="loc1">선택사항</td>
                        <td width="*%" class="loc2">
                            <table width="100%">
                                <tr>
                                    <td width="5%" class="line_a">No.</td>
                                    <td width="10%" class="line_a">투어시간</td>
                                    <td width="10%" class="line_a">전체 인원</td>
                                    <td width="10%" class="line_a">상품금액</td>
                                    <td width="10%" class="line_a" style="background: #E7E7EF;">순서</td>
                                    <td width="10%" class="line_a" style="background: #E7E7EF;">사용유무</td>
                                    <td width="10%" class="line_a" style="background: #E7E7EF;"><img src="/admin/images/btn_plus.gif" border="0" style="cursor:pointer" id="new_add"><img src="/admin/images/btn_minus.gif" border="0"style="cursor:pointer" id="new_del"></td>
                                    <td width="*" class="line_b" style="background: #E7E7EF;">&nbsp;</td>
                                </tr>
                                <%
                                    If num <> "" then
                                        sql = " SELECT seq, good_cd, nm_c,  price,total_man ,sunseo ,use_yn from trip_gtck_opt s2 where del_yn='N' and  s2.good_cd="&num&" and sub_tp='F'  order by sunseo asc ,seq asc"
                                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                                        Rs.open sql,objConn,3
                                    
                                        If Rs.eof or Rs.bof then
                                        Else
        
                                            ii=1
                                            Do until Rs.eof
                                               
                                               s_seq = Rs("seq")
                                               s_good_cd = Rs("good_cd")
                                               s_nm_c = Rs("nm_c")
                                               s_total_man = Rs("total_man")
                                               s_price1 = Rs("price")
                                               s_sunseo = Rs("sunseo")
                                               s_use_yn = Rs("use_yn")
                                %>
                                <tr id="price_<%=ii%>">
                                    <td class="line_e"><%=ii%></td>
                                    <td class="line_e"><input type="text" name="add_nm_c" value="<%=s_nm_c%>" style="width:90px;"  maxlength="11" class="input_basic"></td>
                                    <td class="line_e"><input type="text" name="add_total_man" value="<%=s_total_man%>" style="width:60px;;" class="input_basic"></td>
                                    <td class="line_e"><input type="text" name="add_price" value="<%=s_price1%>" style="width:60px;;" class="input_basic"></td>
                                    <td class="line_e"><input type="text" name="add_sunseo"  value="<%=s_sunseo%>" style="width:60px;;" class="input_basic"></td>
                                    <td class="line_e">
                                        <select name="add_useyn" style="width:90px;;" class="select_basic">
                                            <option value="Y" <% if s_use_yn="Y" then response.write "selected" end if %> >사용</option>
                                            <option value="N" <% if s_use_yn="N" then response.write "selected" end if %> >미사용</option>
                                        </select>
                                    </td>
                                    <td class="line_e"><span class="button_c"><a onClick="fn_daydel('<%=ii%>','<%=s_seq%>','10')">삭제</a></span><input type="hidden" name="o_num" value="<%=s_seq%>"></td>
                                    <td class="line_d"></td>
                                </tr>
                                <%
                                                Rs.movenext
                                                ii = ii+1
                                             Loop
                                    
                                         End if
                                         Rs.close : Set Rs = nothing
                                         
                                    End if
                                %>
                            </table>
                                    
                            <table id="new_table" width="100%"></table>
                        </td>
                    </tr>
           
                  
                </table>
            </div>
        
            <div class="pt25"></div> 
            
            <div align="center">
                <span class="button_b" style="padding:0px 4px;"><a onClick="sendit();"><%=btn%></a></span>
                <span class="button_b" style="padding:0px 4px;"><a onClick="location.href='tck_list.asp?g_kind=<%=g_kind%>'">목록</a></span>
            </div> 
        
            <div class="pt25"></div> 
            
            <div class="table_con">
                <table>
                    <tr>
                        <td width="12%" class="lop1">상품소개</td>
                        <td width="*%" class="lop2"><textarea name="ir_1" id="ir_1" style="width:1240px;height:500px;display:none;"><%=remark1%></textarea></td>
                    </tr>
                    <tr>
                        <td class="lob1">여행스토리</td>
                        <td class="lob2"><textarea name="ir_2" id="ir_2" style="width:1240px;height:900px;display:none;"><%=remark2%></textarea></td>
                    </tr>
                    <tr>
                        <td class="lob1">준비물</td>
                        <td class="lob2"><textarea name="ir_3" id="ir_3" style="width:1240px;height:600px;display:none;"><%=remark3%></textarea></td>
                    </tr>
                    <tr>
                        <td class="lob1">유의사항</td>
                        <td class="lob2"><textarea name="ir_4" id="ir_4" style="width:1240px;height:300px;display:none;"><%=remark4%></textarea></td>
                     </tr>
                </table>
            </div>
            
            <div class="pt25"></div> 
             
            <div align="center">
                <span class="button_b" style="padding:0px 4px;"><a onClick="sendit();"><%=btn%></a></span>
                <span class="button_b" style="padding:0px 4px;"><a onClick="location.href='tck_list.asp?g_kind=<%=g_kind%>'">목록</a></span>
            </div> 
        </form>
    </div>

</body>
</html> 

<script type="text/javascript">
<!--
     function sendit(){
         <% For i=1 to 4 %>
         oEditors.getById["ir_<%=i%>"].exec("UPDATE_CONTENTS_FIELD", []); 
         document.getElementById("ir_<%=i%>").value =document.getElementById("ir_<%=i%>").value;
         <% next %>

         document.form1.submit();
     }
 
 
    $(function() {

        $("#new_add").on("click",function() {
            var n_room ="";
            n_room=                 "<tr>"
            n_room= n_room+"    <td width='5%' class='line_e'></td>"
            n_room= n_room+"    <td width='10%' class='line_e'><input type=text name=\"add_nm_c\" style='width:90px;'  maxlength='11'  class='input_color'></td>"
            n_room= n_room+"    <td width='10%' class='line_e'><input type=text name=\"add_total_man\" style='width:60px;' class='input_color'></td>"
            n_room= n_room+"    <td width='10%' class='line_e'><input type=text name=\"add_price\" style='width:60px;' class='input_color'></td>"
            n_room= n_room+"    <td width='10%' class='line_e'><input type=text name=\"add_sunseo\" value='20' style='width:60px;' class='input_color'></td>"
            n_room= n_room+"    <td width='10%' class='line_e'><select name=\"add_useyn\" style='width:90px;' class='select_color'><option value=Y>사용</option><option value=N>미사용</option></select></td>"
            n_room= n_room+"    <td width='10%' class='line_e'><input type=\"hidden\" name=\"o_num\" value=''></td>"
            n_room= n_room+"    <td width='*%' class='line_d'>&nbsp;</td>"
            n_room= n_room+"</tr>"
            $("#new_table").append(n_room);
        });

        $("#new_del").on("click",function() {
            if ($("#new_table tr").size()==0) {
                alert(" === 더이상 삭제불가 ===");
            }else{
                $("#new_table tr:last").remove();
            }
        });

       
    });


    function fn_daydel(n,i,g){
        if(confirm('삭제하시겠습니까?')){	
            $.ajax({
                type: "POST",
                url: "opt_del.asp",
                data: "good_num=<%=num%>&seq="+i+"&gubun="+g,
                success: function(data) {
         	
                    if (data==0){
            
                        if (g==10){
                            $('#price_'+n).remove(); 
                        }else if(g==20){
                            $('#opt_'+n).remove(); 
                        }else{
                            $('#sub_price_'+n).remove(); 
                        }
                        alert('데이타 삭제처리 되었습니다..');

                    }else{
                        alert('데이타 삭제처리 불가..');
                    }
                },
                error : function() {
                    alert('데이타 삭제가 실패했습니다.. \n\n다시 시도해 주시기 바랍니다.');
                }
         
            });

        }else{
            return false;
        }
	  
    }
   
 
    var oEditors = [];
    <% For i=1 to 4 %>
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ir_<%=i%>",
        sSkinURI: "/seditor/SmartEditor2Skin_good.asp?tp=<%=i%>",	
        htParams : {
            bUseToolbar : true,	
            bUseVerticalResizer : false,
            bUseModeChanger : true,
            fOnBeforeUnload : function(){
            }
        },
        	fOnAppLoad : function(){
        },
        fCreator: "createSEditor2"
    });
    <% Next %>
//-->
</script>