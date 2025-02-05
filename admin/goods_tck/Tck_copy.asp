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
    g_kind = Request("g_kind")
    s_area = Request("s_area")

    num = Request("num")
    If num = "" then
        Response.write "<script language='javascript'>"
        Response.write " alert('주요인자전송에러!!...'); "
        Response.write " self.close();"
        Response.write " </script>	 "
        Response.end
    End if


    sql=" Select num,  event_tp, title, eng_title,  good_tip, tot_day , g_kind, s_area, remark1, remark2, remark3, remark4 , emp_nm, emp_email, del_yn, ins_dt from trip_gtck where num="&num
    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3

    If Rs.eof or Rs.bof then
        Response.write "<script language='javascript'>"
        Response.write " alert('등록된 상품이 없습니다!!...'); "
        Response.write " self.close();"
        Response.write " </script>	 "
        Response.end
    Else
        event_tp  = Rs("event_tp")
        title     = Rs("title")
        eng_title = Rs("eng_title")
        good_tip  = Rs("good_tip")
        emp_nm    = Rs("emp_nm")
        emp_email = Rs("emp_email")
	    
        g_kind = Rs("g_kind")
        Select Case Ucase(g_kind)
            Case "10" : g_kind_nm = "프로그램 상품복사" : g_txt_1 = "투어시간" : g_txt_2 = "최소출발"
            Case "20" : g_kind_nm = "할인티켓 상품복사" : g_txt_1 = "이용시간" : g_txt_2 = "상품 TIP"
        End select

        s_area    = Rs("s_area")

        tot_day   = Rs("tot_day")
        d_day0    = Left(tot_day,1)
        d_day1    = Mid(tot_day,2,1)
        d_day2    = Mid(tot_day,3,1)
        d_day3    = Mid(tot_day,4,1)
        d_day4    = Mid(tot_day,5,1)
        d_day5    = Mid(tot_day,6,1)
        d_day6    = Mid(tot_day,7,1)

        remark1   = Rs("remark1")
        remark2   = Rs("remark2")
        remark3   = Rs("remark3")
        remark4   = Rs("remark4")
    End if

    Rs.close : Set Rs=nothing
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
<script type="text/javascript" src="/seditor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<body>
	
    <div style="padding:10px 0px 40px 0px;">

        <form name="form1" method="post"  action="tck_copy_ok.asp"  style="display:inline; margin:0px;" >
        <input type="hidden" name="num"      value="<%=num%>"   >
        <input type="hidden" name="g_kind"   value="<%=g_kind%>"   >
        <input type="hidden" name="s_area"   value="<%=s_area%>"   >
        
            <div class="table_dan">
                <table width="100%">
                    <tr>
                        <td class="lop1">프로그램 상품명</td>
                        <td class="lop2" colspan="3"><input name="title" type="text" value="<%=title%>" style="width:70%;" maxlength="100" class="input_basic"></td>
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
                                    End if
                                %>
                            </select>
                        </td>
                        <td width="12%" class="lob3">이벤트 타입</td>
                        <td width="*%" class="lob2">
                            <table width="100%">
                                <tr>
                                    <td width="25"><input type="radio" name="event_tp" value="A" <% if event_tp = "A" then response.write "checked" end if %> class="radio_basic"></td>
                                    <td width="40">NO</td>
                                    <td width="25"><input type="radio" name="event_tp" value="B" <% if event_tp = "B" then response.write "checked" end if %> class="radio_basic"></td>
                                    <td width="40">추천</td>
                                    <td width="25"><input type="radio" name="event_tp" value="C" <% if event_tp = "C" then response.write "checked" end if %> class="radio_basic"></td>
                                    <td width="*">특가</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="lob1">출발요일</td>
                        <td class="lob2">
                            <span class="checks"><input type="checkbox" name="day_0" id="day_0" value="0" <% if d_day0="Y" then %>checked<% end if %>><label for="day_0">일</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_1" id="day_1" value="1" <% if d_day1="Y" then %>checked<% end if %>><label for="day_1">월</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_2" id="day_2" value="2" <% if d_day2="Y" then %>checked<% end if %>><label for="day_2">화</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_3" id="day_3" value="3" <% if d_day3="Y" then %>checked<% end if %>><label for="day_3">수</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_4" id="day_4" value="4" <% if d_day4="Y" then %>checked<% end if %>><label for="day_4">목</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_5" id="day_5" value="5" <% if d_day5="Y" then %>checked<% end if %>><label for="day_5">금</label></span>
                            <span class="prl10"></span>
                            <span class="checks"><input type="checkbox" name="day_6" id="day_6" value="6" <% if d_day5="Y" then %>checked<% end if %>><label for="day_6">토</label></span>
                        </td>
                        <td class="lob3">통화</td>
                        <td class="lob2">
                            <select name="exchange" style="width:100px;" class="select_basic">
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
                        <td class="lob2"><input type="text" name="eng_title" value="<%=eng_title%>"  style="width:80%;" maxlength="100" tabindex="3" class="input_basic"></td>
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
                                    <td width="7%" class="line_a">No.</td>
                                    <td width="15" class="line_a">투어시간</td>
                                    <td width="15%" class="line_a">상품금액</td>
                                    <td width="*%" class="line_b"></td>
                                </tr>
                                <%
                                    sql = " SELECT seq, good_cd, nm_c, price, sub_tp  from  trip_gtck_opt s2 where del_yn='N' and s2.good_cd="&num&"  and sub_tp='F'  order by sunseo asc, seq asc"
                                    Set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open sql,objConn,3
                                    
                                    If Rs.eof or Rs.bof then
                                    Else
                                    	
                                        ii=1
                                        Do until Rs.eof
                                            
                                            s_seq    = Rs("seq")
                                            s_good_cd= Rs("good_cd")
                                            s_nm_c   = Rs("nm_c")
                                
                                            s_price1  = Rs("price")
          
                                
                                            s_sub_tp  = Rs("sub_tp")
                                %>
                                <tr id="price_<%=ii%>">
                                    <td class="line_e"><%=ii%></td>
                                    <td class="line_c"><input type="text" name="add_nm_c" value="<%=s_nm_c%>" style="width:90px;"  maxlength="11" class="input_basic"></td>
                                    <td class="line_c"><input type="text" name="add_price" value="<%=s_price1%>" style="width:90px;" class="input_basic"></td>
                                    <td class="line_g"><input type="hidden" name="add_sub_tp" value="<%=s_sub_tp%>"><input type="hidden" name="o_num" value="<%=s_seq%>"></td>
                                </tr>
                                <%
                                            Rs.movenext
                                            ii = ii+1
                                        Loop
                                
                                    End if
                                
                                    Rs.close : Set Rs = nothing
                                %>
                            </table>
                        </td>
                    </tr>
                    
                    <%
                         If num <> "" then
                             sql = " SELECT  idx, good_cd, nm_sub, del_yn from trip_gtck_sub s3 where s3.good_cd="&num&" and del_yn='N' order by idx asc"
                             Set Rs = Server.CreateObject("ADODB.RecordSet")
                             Rs.open sql,objConn,3
                    
                             If Rs.eof or Rs.bof then
                             Else
                    %>
                    <tr>
                        <td class="loc1">선택 시간</td>
                        <td class="loc2">
                            <table width="100%">
                                <tr>
                                    <td width="7%" class="line_a">No.</td>
                                    <td width="*%" class="line_b" style="padding:0 0 0 255px;text-align:left;">구분</td>
                                </tr>
                                <%         	
                                             ii=1
                                             Do until Rs.eof
                                                 w_idx      = Rs("idx")
                                                 w_good_cd  = Rs("good_cd")
                                                 w_nm_sub   = Rs("nm_sub")
                                %>
                                <tr id="sub_price_<%=ii%>">
                                    <td class="line_e"><%=ii%></td>
                                    <td class="line_d" style="padding:0 20px;text-align:left;"><input type="text" name="sub_nm"  value="<%=w_nm_sub%>" style="width:50%;" class="input_basic"></td>
                                </tr>
                                <%
                                             Rs.movenext
                                             ii = ii+1
                                             Loop
                                %>
                            </table>
                        </td>
                    </tr>
                    <%
                             End if
                             Rs.close : Set Rs = nothing
                             
                         End if
                    %>
        
                    <%
                        sql = " SELECT seq, good_cd, nm_c,  price, sub_tp  from  trip_gtck_opt s2 where del_yn='N' and  s2.good_cd="&num&"  and sub_tp='S'  order by sunseo asc, seq asc"
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Rs.open sql,objConn,3
                                                 
                        If Rs.eof or Rs.bof then
                        Else
                    %>
        
                    <tr>
                        <td class="loc1">추가 선택</td>
                        <td  class="loc2">
                            <table width="100%">
                                <tr>
                                    <td width="7%" class="line_a">No.</td>
                                    <td width="*%" class="line_a" style="padding:0 0 0 255px;text-align:left;">구분</td>
                                    <td width="15%" class="line_b">금액</td>
                                </tr>
                                <%
                                    ii=1
                                    Do until Rs.eof
                
                                        s_seq     = Rs("seq")
                                        s_good_cd = Rs("good_cd")
                                        s_nm_c    = Rs("nm_c")
                
                                        s_price1  = Rs("price")
                                            
                                        s_sub_tp  = Rs("sub_tp")
                                %>
                                <tr  id="price_<%=ii%>">
                                    <td class="line_e"><%=ii%></td>
                                    <td class="line_c"><input type="text" name="add_nm_c" value="<%=s_nm_c%>" style="width:100%;" class="input_basic"></td>
                                    <td class="line_d" style="padding:0 20px;"><input type="text" name="add_price" value="<%=s_price1%>" style="width:100%;" class="input_basic"></td>
                                </tr>

                                <input type="hidden" name="add_sub_tp"   value="<%=s_sub_tp%>">
                                <input type="hidden" name="o_num" value="<%=s_seq%>">
                                <%
                                        Rs.movenext
                                    ii = ii+1
                                    Loop
                                %>
                            </table>
                        </td>
                        <td width="*%"  valign="top" bgcolor="#FFFFFF"><input type="hidden" name="add1_cnt"  id="add1_cnt"  value="0" >&nbsp;</td>
                    </tr>
        
                    <%
                        End if
                        Rs.close : Set Rs = nothing
                    %>
                </table>
            </div>
                
            <div class="pt25"></div> 
            
            <div align="center">
                <span class="button_b" style="padding:0px 4px;"><a onClick="sendit();">상품복사</a></span>
                <span class="button_b" style="padding:0px 4px;"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
            </div> 
        
            <div class="pt25"></div> 
            
            <div class="table_con">
                <table>
                    <tr>
                        <td width="12%" class="lop1">상품소개</td>
                        <td width="*%" class="lop2"><textarea name="ir_1" id="ir_1" style="width:100%;height:500px;display:none;"><%=remark1%></textarea></td>
                    </tr>
                    <tr>
                        <td class="lob1">여행스토리</td>
                        <td class="lob2"><textarea name="ir_2" id="ir_2" style="width:100%;height:900px;display:none;"><%=remark2%></textarea></td>
                    </tr>
                    <tr>
                        <td class="lob1">준비물</td>
                        <td class="lob2"><textarea name="ir_3" id="ir_3" style="width:100%;height:600px;display:none;"><%=remark3%></textarea></td>
                    </tr>
                    <tr>
                        <td class="lob1">유의사항</td>
                        <td class="lob2"><textarea name="ir_4" id="ir_4" style="width:100%;height:300px;display:none;"><%=remark4%></textarea></td>
                     </tr>
                </table>
            </div>
            
            <div class="pt25"></div> 
            
            <div align="center">
                <span class="button_b" style="padding:0px 4px;"><a onClick="sendit();">상품복사</a></span>
                <span class="button_b" style="padding:0px 4px;"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
            </div> 
        
        </form>
        
    </div>
    
</body>
</html> 

<script type="text/javascript">
<!--
    function closeIframe(){
        parent.$('#chain_copy').dialog('close');
        return false;
    }
 
 
    function sendit(){
        <% For i=1 to 4 %>
            oEditors.getById["ir_<%=i%>"].exec("UPDATE_CONTENTS_FIELD", []); 
            document.getElementById("ir_<%=i%>").value =document.getElementById("ir_<%=i%>").value;
        <% Next %>
        document.form1.submit();
    }
 
    var oEditors = [];
    <% For i=1 to 4 %>
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "ir_<%=i%>",
            sSkinURI: "/seditor/SmartEditor2Skin_good.asp?i=<%=i%>",	
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
