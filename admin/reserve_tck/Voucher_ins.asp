<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->


<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    
       OpenF5_DB objConn 
    
    tbl = "w_res_tck001"

    reserve_code  = Request("reserve_code")
    If reserve_code="" or isnull(reserve_code) then
        Response.write "<script type='text/javascript'>"
        Response.write " alert(' 예약된내용이 없습니다.'); "
        Response.write " self.close();"
        Response.write " </script>"
        Response.end
    End if

    g_kind = Request("g_kind")
    
    reserve_gubun ="30"
    symbol="￦"
    
    '###################################################################################
    start_ymd  = Request("start_ymd")
    start_ymd2 = Request("start_ymd2")


    sql =" SELECT  r.seq , r.good_num, r.reserve_code, r.res_nm, r.res_pick_time , v_vaucher_no ,v_remark, v_issue_date , v_detail "
    sql = sql &" ,r.ins_dt , g.title"
    sql = sql &" FROM  w_res_tck001 r left outer join trip_gtck g ON r.good_num = g.num   "
    sql = sql &" WHERE r.reserve_code ='"&reserve_code&"'"

    Set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn ,3

       r_seq        = Rs("seq")
       good_num     = Rs("good_num")
       reserve_code = Rs("reserve_code")

       res_nm       = Rs("res_nm")

       res_pick_time= Rs("res_pick_time")

       v_vaucher_no = Rs("v_vaucher_no")
       v_remark     = Rs("v_remark")
       v_issue_date = Rs("v_issue_date")
       v_detail     = Rs("v_detail")
       
       title        = Rs("title")

    Rs.close : Set Rs = nothing


    m_sql =" SELECT num, reserve_code, opt_seq ,opt_day from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N')  and opt_tp='F'"
    Set Rs = Server.CreateObject("ADODB.RecordSet")
        
    Rs.open m_sql,objConn ,3
    if Rs.eof or Rs.bof then
        s_day = ""
    else
        s_day = Rs("opt_day")
    end if
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
<script type="text/javascript" src="/seditor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<body>
	
    <div class="pt15"></div>

    <form name="frmwrite" method="post" action="voucher_ins_ok.asp"  style="display:inline; margin:0px;">
    <input type="hidden" name="reserve_code" value="<%=reserve_code%>">
    <input type="hidden" name="mod_tp" value="<%=mod_tp%>">

        <div class="table_box">
            <table>
                <tr>
                    <td width="15%" class="lop1" style="font-weight:700;">이름</td>
                    <td width="35%" class="lop2">
                        <%
                            d_sql = "select idx , d_age, d_gender, d_nm, d_eng_f, d_eng_L, d_birth from w_res_tck002 where reserve_code='"&reserve_code&"' "
                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                            Rs.open d_sql,objConn,3
                            
                            If Rs.eof then
                            Else
                                i=0
                                Do until Rs.eof
                            
                                    d_num = Rs("idx")
                                    d_age = Ucase(Rs("d_age"))
                                        Select Case d_age
                                            Case "A" : age_nm ="Adult"
                                            Case "C" : age_nm ="Child"
                                            Case "I" : age_nm ="Infant"
                                        End select
                                    d_gender   = Ucase(Rs("d_gender"))
                                        Select Case d_gender
                                            Case "M" : gender_nm ="M"
                                            Case "F" : gender_nm ="F"
                                        End select
                            
                                    d_nm     = Rs("d_nm")
                                    d_eng_F  = Rs("d_eng_F")
                                    d_eng_L  = Rs("d_eng_L")
                                    d_birth  = Rs("d_birth")
                        
                        %>
                        <%=d_nm%>&nbsp;&nbsp;(<%=gender_nm%>)
                        <%
                                    Rs.MoveNext
                                    i=i+1
                        
                                Loop
                        
                            End if
                        %>
                    </td>
                    <td width="15%" class="lop3" style="font-weight:700;">인원</td>
                    <td width="*%" class="lop2">
                        <%
                            m_sql =" SELECT num, reserve_code, opt_day ,opt_time,  opt_seq, opt_nm,  opt_ad_cnt, opt_ad_price  "
                            m_sql = m_sql &" from w_res_tckopt where reserve_code='"&reserve_code&"' AND (opt_cancd='N') and opt_tp='F'"
                        
                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                            Rs.open m_sql,objConn ,3
                            If Rs.eof or Rs.bof then
                            Else
                                Do until Rs.eof
                        
                                    s_num      = Rs("num")
                                    s_opt_seq  = Rs("opt_seq")
                                    s_opt_nm   = Rs("opt_nm")
                        
                                    s_ad_cnt   = Rs("opt_ad_cnt")
             
                        %>
                            <%=FormatNumber(s_ad_cnt,0)%>명</div>                                
                            <input type="hidden" name="s_num" value="<%=s_num%>"  >
                        <%
                                Rs.movenext
                                Loop
                           End if
                        %>
                    </td>
                </tr>
                <tr>
                    <td class="lob1" style="font-weight:700;">투어명</td>
                    <td class="lob2" colspan="3"><%=title%></td>
                </tr>
                <tr>
                    <td class="lob1" style="font-weight:700;">투어일</td>
                    <td class="lob2"><%=s_day%></td>
                    <td class="lob3" style="font-weight:700;">선택시간</td>
                    <td class="lob2"><%=res_pick_time%></td> 
                </tr>
                <tr>
                    <td class="lop1" style="font-weight:700;">픽업장소</td>
                    <td class="lop2"><input type="text" name="vaucher_no" value="<%=v_vaucher_no%>" style="width:100%" maxlength="40" class="input_color"></td>
                    <td class="lob3" style="font-weight:700;">소요시간</td>
                    <td class="lob2"><input type="text" name="v_issue_date" value="<%=v_issue_date%>" style="width:100%" maxlength="20" class="input_color"></td>
                </tr>

                <tr>
                    <td class="lob1" style="font-weight:700;">Remark</td>
                    <td class="lob5" colspan="3"><textarea name="v_remark" style="width:100%; height:150px;" class="textarea_basic"><%=v_remark%></textarea></td>
                </tr>
            </table>
        </div> 
        
        <div class="pt20"></div> 
                    
        <div class="table_box">
            <table>
                <tr>
                    <td width="15%" class="lop1" style="font-weight:700;">투어 안내사항</td>
                    <td width="*%" class="lop4"><textarea name="ir_1" id="ir_1" style=" height:300px; display:none;"><%=v_detail%></textarea></td>
                </tr>
            </table>
        </div> 

        <div class="noprint" align="center" style="padding:25px 0 30px 0;">
            <span class="button_b" style="padding:0px 4px;"><a onclick="chk_frm();">등록</a></span>
            <span class="button_b" style="padding:0px 4px"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
        </div>
        
    </form>
    
</body>
</html>

<script language="javascript">
<!--
    function closeIframe(){
        parent.$('#chain_vaucher').dialog('close');
        return false;
    }
-->
</script> 
        

<script type="text/javascript">
<!--
    var oEditors = [];
    
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ir_1",
        sSkinURI: "/seditor/SmartEditor2Skin.html",	
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
    
    
    function chk_frm(){
        if(document.frmwrite.vaucher_no.value==""){
            alert("바우처 번호을 입력하세요.");
            document.frmwrite.vaucher_no.focus();
            return false;
        }
        oEditors.getById["ir_1"].exec("UPDATE_CONTENTS_FIELD", []);
        document.frmwrite.submit();
    }
--> 
</script>



