<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"


    OpenF5_DB objConn

    tbl = "trip_gtck"
    g_kind = Request("g_kind")
    
    Select Case Ucase(g_kind)
        Case "10" : g_kind_nm = "프로그램 상품관리"
        Case "20" : g_kind_nm = "할인티켓 상품관리"
    End select

    pagesize  = Request("pagesize")
    gotopage  = Request("gotopage")

    s_cont = Request("s_cont")
    s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
    cont = Replace(cont,"'","")

    if gotopage = "" then gotopage = 1 end if
    if pagesize  = "" then pagesize = 20 end if


   '검색부분
    ans = "   and  ( title like '%" & cont & "%' )   "
   
    If m_chk <> "" then
        Select case m_chk 
            case "pm" : ans2 =  " and (SUBSTRING(re_comd,2, 1) = 'Y') "
            case "ps" : ans2 =  " and (SUBSTRING(re_comd,3, 1) = 'Y') "
            case "pb" : ans2 =  " and (SUBSTRING(re_comd,2, 2) = 'YY') "
            case "mm" : ans2 =  " and (m_comd = 'Y') "
            case else : ans2 =  ""
        End select
    End if
    
    '페이지
    sql = "select count(num) as cnt from "&tbl
    sql = sql & " where del_yn ='N'  and g_kind='"&g_kind&"'    "
    if cont <> ""  then sql = sql & ans
    if m_chk <> "" then sql = sql & ans2

    set Rs = Server.CreateObject("ADODB.RecordSet")
    Set Rs = objConn.Execute(sql)
   
    RecordCount = Rs(0)
    PageCount = int( (RecordCount - 1) / PageSize ) + 1
   
    if gotopage = "" then 
        gotopage = 1
    elseif cint(gotopage) > cint(PageCount) then
        gotopage = PageCount
    end If

    if gotopage=0 then gotopage=1 end if

    t_num = recordcount - cint(pagesize) * cint((gotopage-1) )
    Rs.close : Set Rs=nothing
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
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=g_kind_nm%></div>

        <form name="s_frm" method="post" action="tck_list.asp" style="display:inline; margin:0px;">
        <input type="hidden" name="g_kind" value="<%=g_kind%>">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:1px solid #C0C0C0;height:40px;">
                <tr>
                    <td>
                        <table  width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="bin_pa" width="130" align="center">
                                    <select name="s_cont" class="select_basic" style="width:100%;">
                                        <option value="S" <% if s_cont = "S" then %>selected<% end if %>>프로그램 상품명</option>
                                    </select>
                                </td>
                                <td class="bin_pa" width="430" align="center"><input type="text" name="cont" value="<%=cont%>" class="input_basic" style="width:97%;"></td>
                                <td class="bin_pa" width="150" align="center">
                                    <span style="padding:0 8px 0 0;"><img src="/admin/images/top_ser.png" border="0" onclick="chk_frm();" style="cursor:pointer;border-radius:2px;"></span>   
                                    <span><img src="/admin/images/top_list.png" border="0" onClick="location.href='tck_list.asp?g_kind=<%=g_kind%>'" style="cursor:pointer;border-radius:2px;"></span>
                                </td>
                                <td class="bin_pa" width="150" align="center">
                                    <select name="m_chk" onchange="fn_m_chk(this.value);" class="select_basic" style="width:100%;">
                                        <option value=""  <% if m_chk = "" then %>selected<% end if %>>홈페이지</option>
                                        <option value="mm" <% if m_chk = "mm" then %>selected<% end if %>>등록</option>
                                        <!--
                                        <option value="pm" <% if m_chk = "pm" then %>selected<% end if %>>메인추천</option>
                                        <option value="ps" <% if m_chk = "ps" then %>selected<% end if %>>BEST</option>
                                        <option value="pb" <% if m_chk = "pb" then %>selected<% end if %>>메인+BEST</option>
                                        -->
                                    </select>
                                </td>
                                <td class="bin_pa" width="100" align="center"><span class="button_a"><a href="tck_ins.asp?g_kind=<%=g_kind%>">상품등록</a></span></td>
                                <td class="bin_pa" width="*" align="center"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>

        <div class="pb15"></div> 

        <form name="form1" method="post" action="tck_list.asp" style="display:inline; margin:0px;">
        <input type="hidden" name="check_all" value="0">
        <input type="hidden" name="g_kind" value="<%=g_kind%>">
    
            <div class="table_list">
                <table>
                    <tr>
                        <td width="4%" class="top1">No.</td>
                        <td width="4%" class="top2">복사</td>
                        <td width="4%" class="top3">등록</td>
                        <td width="4%" class="top3">순서</td>
                        <td width="6%" class="top2">지역</td>
                        <td width="6%" class="top2">이벤트타입</td>
                        <td width="*%" class="top2">상품명</td>
                        <!--<td width="5%" class="top2">예약</td>-->
                        <td width="5%" class="top2">출일일</td>
                        <td width="5%" class="top2">이미지</td>
                        <td width="4%" class="top2">통화</td>
                        <td width="5%" class="top2">카테고리</td>
                        <td width="5%" class="top2">삭제</td>
                    </tr>
                    <%
                        sql ="SELECT TOP  "&pagesize&"  "
                        sql = sql & " a.event_tp , a.num , a.title ,a.g_kind, a.s_area , a.emp_nm, a.emp_email ,a.exchange , a.re_comd  , a.m_comd ,  a.sunseo   "
                        sql = sql & " ,(SELECT title FROM trip_gtck_city c WHERE c.idx = a.s_area  )  AS sub_area_nm "
                        sql = sql & "  from "&tbl&" a "  
                        sql = sql & "  where a.num not in "
                        sql = sql & " (select top " & ((gotopage-1) * pagesize) &" a.num " 
                        sql = sql & " from "&tbl&" a "
                        sql = sql & " where a.del_yn='N' and g_kind='"&g_kind&"'"
                        
                        if cont <> "" then sql = sql & ans
                        if m_chk <> "" then sql = sql & ans2
                        
                        sql = sql & "      order by  a.g_kind asc ,a.num desc ) "
                        sql = sql & " and a.del_yn='N'  and g_kind='"&g_kind&"'"
                        
                        if cont <> "" then  sql = sql &  ans
                        if m_chk <> "" then sql = sql & ans2
                        sql = sql & " order by a.g_kind asc , a.num desc "
                        
                        Set Rs = Server.CreateObject("ADODB.RecordSet")
                        Set Rs = objConn.Execute(Sql)
                        
                        If rs.eof or rs.bof then
                        rcnt=0
                    %>
                    <tr>
                        <td class="bin" colspan="14">NO DATA</td>
                    </tr>	 
                    <%
                        Else
                    
                            rcnt=1
                            i=1
                            Do until Rs.EOF
                    
                                event_tp  = Rs("event_tp")
                                Select Case Ucase(event_tp)
                                    Case "A" : event_nm ="NO "
                                    Case "B" : event_nm ="추천"
                                    Case "C" : event_nm ="특가"
                                End select
                    
                                r_num = Rs("num")
                                r_title = Rs("title")
     
                                r_g_kind = Rs("g_kind")
                                r_s_area = Rs("s_area")
                                
                                r_exchange  = Rs("exchange")
                                Select Case Ucase(r_exchange)
                                    Case "10" : exchange_nm ="CP"
                                    Case "20" : exchange_nm ="$"
                                    Case "30" : exchange_nm ="$"
                                End select
                                
                                r_recomd   = Rs("re_comd")
                    
                                '####################################################
                                r_home = Left(r_recomd,1)
                                If r_home="Y" then
                                    r_home_chk = "checked"
                                Else
                                    r_home_chk =  ""
                                End if
                    
                                r_main = mid(r_recomd,2,1)
                                If r_main="Y" then
                                    r_main_chk = "checked"
                                Else
                                    r_main_chk =  ""
                                End if
                    
                                r_sub = Right(r_recomd,1)
                                If r_sub="Y" then
                                    r_sub_chk = "checked"
                                Else
                                    r_sub_chk =  ""
                                End if
                                '####################################################

                                r_sunseo = Trim(Rs("sunseo"))
                                sub_area_nm= Trim(Rs("sub_area_nm"))
                    %>
                    <tr <% if i/2 = Int(i/2) Then %>bgcolor="#F9F9F9" <% Else %>bgcolor="#FFFFFF" <% End If %> onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                        <td class="tob1"><%=t_num%></td>
                        <td class="tob2"><a href="javascript:fn_copy('<%=r_num%>','<%=g_kind%>')"><img src="/admin/images/ico_copy.png" border="0"></a></td>
                        <td class="tob2"><span class="checks" style="padding:0 0 0 8px;"><input type="checkbox" name="home_chk" onclick="fn_chk('H','<%=r_num%>')" <%=r_home_chk%> id="home_<%=r_num%>"><label for="home_<%=r_num%>"></label></span></td>
                        <td class="tob2"><input type="text" name="sunseo" value="<%=r_sunseo%>" style="width:50%" class="input_color"><input type="hidden" name="num" value="<%=r_num%>"></td>
                        <td class="tob2"><a href="tck_view.asp?num=<%=r_num%>&g_kind=<%=g_kind%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>"><%=sub_area_nm%></a></td>
                        <td class="tob2"><a href="tck_view.asp?num=<%=r_num%>&g_kind=<%=g_kind%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>"><%=event_nm%></a></td>
                        <td class="tob3"><a href="tck_view.asp?num=<%=r_num%>&g_kind=<%=g_kind%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>"><%=r_title%></a></td>
                        <!--<td class="tob2"><a href="/admin/booking_tck/res_step.asp?num=<%=r_num%>&g_kind=<%=r_g_kind%>"><img src="/admin/images/ico_booking.png" border="0"></a></td>-->
                        <td class="tob2"><a href="day_make.asp?good_cd=<%=r_num%>&g_kind=<%=g_kind%>&gotopage=<%=gotopage%>"><img src="/admin/images/ico_chuga.png" border="0"></a></td><!-- 출발일-->
                        <td class="tob2"><a href="#" onclick="javascript:fn_img('<%=r_num%>','<%=r_title%>');return false;"><img src="/admin/images/ico_ok.png" border="0"></a></td><!--이미지-->
                        <td class="tob2"><a href="tck_view.asp?num=<%=r_num%>&g_kind=<%=g_kind%>&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>"><%=exchange_nm%></a></td>
                        <td class="tob2"><img src="/admin/images/ico_modify.png" border="0" onclick="fn_category('<%=r_num%>')" style="cursor:pointer;"></td><!--변경-->
                        <td class="tob2"><img src="/admin/images/ico_delete.png" border="0" onclick="fn_del('<%=r_num%>')" style="cursor:pointer;"></td><!--삭제-->
                    </tr>
                    <%
                    
                               Rs.movenext
                    	         i=i+1
                    	         t_num = t_num - 1
                    	    Loop
                    
                      End if
                    
                      Rs.close : Set Rs = nothing
                    
                    %>
                    <tr>
                        <td class="tof1" colspan="3"></td>
                        <td class="tof2"><img src="/admin/images/ico_modify.png" border="0" onclick="sendit()" style="cursor:pointer;"></td>
                        <td  class="tof2" colspan="8"></td>
                    </tr>
                </table>

                <% If rcnt=1 then %>
                    <div class="pb20"></div> 
                    <div class="paginate1">
                        <div align=center>
                            <% goPage gotopage,pagecount,"tck_list.asp?g_kind="&g_kind,"&s_cont="&s_cont&"&cont="&cont&"&m_chk="&m_chk %>
                        </div>
                    </div>
                <% End if %>
            </div>
        </form>
        
    </div>
    
</body>
</html>

<div id="chain_copy" title="상품복사"></div>
<div id="chain_img" title="이미지 등록"></div>
<div id="chain_category" title="카테고리 수정"></div>

<% 
    objConn.close : Set objConn = nothing
%>

<script type="text/javascript">
<!--
    function fn_copy(n,g){
        var _url = "tck_copy.asp?num="+n+"&g_kind="+g;
        $("#chain_copy").html('<iframe id="modalIframeId" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId").attr("src",_url);
    }
    $(document).ready(function(){
        $("#chain_copy").dialog({
            autoOpen: false,
            modal: true,
            width: 1300,
            height: 770
        });
    });

    	function fn_img(s,t) {
        var _url1 = "/admin/good_img/file_ins.asp?tp=T&g_seq="+s+"&title="+t;
        $("#chain_img").html('<iframe id="modalIframeId1" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId1").attr("src",_url1);
    }
    $(document).ready(function(){
        $("#chain_img").dialog({
            autoOpen: false,
            modal: true,
            width: 1000,
            height: 770
        });
    });

  function fn_category(n){
        var _url2 = "change_category.asp?g_kind=<%=g_kind%>&good_num="+n;
        $("#chain_category").html('<iframe id="modalIframeId2" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
        $("#modalIframeId2").attr("src",_url2);
    }
    $(document).ready(function(){
        $("#chain_category").dialog({
            autoOpen: false,
            modal: true,
            width: 600,
            height: 340
        });
    });


    function chk_frm(){
        document.s_frm.submit();
    }

    function fn_del(n){
        if(confirm("삭제하시면 복구가 불가합니다.\n삭제 하시겠습니까?")){
            location.href="tck_del.asp?num="+n+"&g_kind=<%=g_kind%>";
        }
    }

    function fn_chk(n,s){
        var param ="tp="+n+"&num="+s;
        $.ajax({
            type: "POST",
            url: "main_chk.asp",
            data: param,
            success: function(data) { },
            error : function() {
                alert('데이타 전송이 실패했습니다.\n다시 시도해 주시기 바랍니다.');
            }
        });
    }

    function sendit(){
        document.form1.action="sunseo_ok.asp?nat_cd=<%=nat_cd%>&s_area=<%=s_area%>";
        document.form1.submit();
    }

    function fn_m_chk(d){
        document.form1.action="tck_list.asp?nat_cd=<%=nat_cd%>&s_area=<%=s_area%>&m_chk="+d;
        document.form1.submit();
    }


    function change_area(v){
        var nat_cd = document.getElementById("g_kind").value;
        document.s_frm.action = "tck_list.asp?g_kind="+g_kind+"&s_area="+v;
        document.s_frm.submit();
    }  
//-->
</script>