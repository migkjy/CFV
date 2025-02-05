<!--#include virtual="/admin/conf/config.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
 
    OpenF5_DB objConn
    
    nat_cd = Trim(Request("nat_cd"))
    city_cd = Trim(Request("city_cd"))
    
    sql = " select nm_kor "
    sql = sql & " from TB_ti100  "
    sql = sql & " where nat_cd   = '"& nat_cd &"' "
    	
    set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3
    
    If not rs.EOF Then
        nat_nm_kor = Rs("nm_kor")
    End if
    CloseRs Rs
    
    sql = " select nm_kor "
    sql = sql & " from TB_ti200  "
    sql = sql & " where nat_cd   = '"& nat_cd &"' and city_cd= '"& city_cd &"'"
    	
    set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3
    
    If not rs.EOF Then
        city_nm_kor = Rs("nm_kor")
    End if
    
    CloseRs Rs
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/webnote/webnote.js"></script>
<script type="text/javascript">
<!--
    webnote_config = {
        attach_proc: "/webnote/webnote_attach.asp",
        delete_proc: "/webnote/webnote_delete.asp",
        allow_dndupload: true,
        allow_dndresize: true	
    }
//-->
</script>
</head>

<body>

    <form name="golf_make" method="post" style="display:inline; margin:0px;">
    <input type="hidden" name="admin_action" value="golf_make">
    <input type="hidden" name="nat_cd" value="<%=nat_cd%>">
    <input type="hidden" name="city_cd" value="<%=city_cd%>">

        <div class="pt15"></div> 
        <div class="table_dan">
            <table width="100%">
                <tr>
                    <td width="120" class="lop1">국가</td>
                    <td width="360" class="lop2"><%=nat_nm_kor%></td>
                    <td width="120" class="lop1">도시</td>
                    <td width="*%" class="lop2"><%=city_nm_kor%></td>
                </tr>
                <tr>
                    <td class="lob1">골프장명</td>
                    <td class="lob2"><input type="text" name="nm_kor" style="width:99%"  maxlength="50" class="input_color"></td>
                    <td class="lob1">영문명</td>
                    <td class="lob2"><input type="text" name="nm_eng" style="width:99%"  maxlength="50" class="input_color"></td>
                </tr>
                <tr>
                    <td class="lob1">주소</td>
                    <td class="lob2" colspan="3"><input type="text" name="addr" style="width:99%"  maxlength="100"class="input_color"></td>
                </tr>
                <tr>
                    <td class="lob1">전화번호</td>
                    <td class="lob2"><input type="text" name="tel" style="width:50%"  maxlength="20" class="input_color"> </td>
                    <td class="lob1">팩스번호</td>
                    <td class="lob2"><input type="text" name="fax" style="width:50%" maxlength="20" class="input_color"></td>
                </tr>
                <tr>
                    <td class="lob1">홀</td>
                    <td class="lob2"><input type="text" name="hole" style="width:30%" maxlength="10" class="input_color"> </td>
                    <td class="lob1">파</td>
                    <td class="lob2"><input type="text" name="par" style="width:30%"maxlength="10" class="input_color"></td>
                </tr>
                <tr>
                    <td class="lob1">총야드</td>
                    <td class="lob2"><input type="text" name="tot_yard" style="width:30%" maxlength="10" class="input_color"> </td>
                    <td class="lob1">홈페이지</td>
                    <td class="lob2"><input type="text" name="url" style="width:100%" maxlength="50" class="input_color"></td>
                </tr>
                <tr>
                    <td class="lob1">골프장소개<br><font color="#FF0000">이미지 삽입 금지</font></td>
                    <td class="lob5" colspan="3"><textarea name="detail" id="detail" style="width:845px; height:250px;" editor="webnote" tools="deny:images,superscript,subscript,strikethrough,emoticon,fullscreen,lineheight,indent,outdent,increase,decrease,table"><%=detail%></textarea></td>
                </tr>
                <tr>
                    <td class="lob1">상세정보</td>
                    <td class="lob5" colspan="3"><textarea name="traffic" id="traffic" style="width:845px; height:400px;" editor="webnote" tools="deny:images,superscript,subscript,strikethrough,emoticon,fullscreen,lineheight,indent,outdent,increase,decrease,table"><%=traffic%></textarea></td>
                </tr>
                <tr>
                    <td class="lob1">구글좌표</td>
                    <td class="lob2" colspan="3"><input type="text" name="point1" style="width:30%" class="input_color"> - <input type="text" name="point2" style="width:30%" class="input_color"></td>
                </tr>
            </table>
        </div>

        <div align="center" style="padding:25px 0 0px 0;">
            <span class="button_b" style="padding:0px 4px"><a onClick="golf_frm_chk();return false;">등록</a></span>
            <span class="button_b" style="padding:0px 4px"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
        </div>

    </form>
    
</body>
</html>
        

<script language="Javascript1.2">
<!-- //
    function closeIframe(){
        parent.$('#chain_golf_make').dialog('close');
        return false;
    }       
           
    function golf_frm_chk(){ 
        var frm = document.golf_make;
        if(confirm("골프장정보를 등록하시겠습니까?")){
            frm.action="process.asp";
            frm.target = 'selfWin';
            window.name = 'selfWin';
            frm.submit();
        }
    }
// -->
</script>

<%
    CloseF5_DB objConn
%>   
