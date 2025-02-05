﻿<!--#include virtual="/admin/conf/config.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
 
    OpenF5_DB objConn

    seq = Trim(Request("seq"))

    sql =       " select seq,nat_cd,city_cd,nm_kor,nm_eng,place,addr,grade,room,tel,fax,url,traffic,detail,base_intro,room_intro,unit_intro,rest_intro,point1,point2 "
    sql = sql & "	from TB_ti310  "
    sql = sql & "	    where seq = '"& seq &"' "
	
    set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3
    
    If not rs.EOF Then
       seq  = Rs("seq")
       nat_cd = Rs("nat_cd")
       city_cd  = Rs("city_cd")
       nm_kor = Rs("nm_kor")
       nm_eng = Rs("nm_eng")
       place  = Rs("place")
    
       addr = Rs("addr")
       grade  = Rs("grade")
       room = Rs("room")
       tel  = Rs("tel")
       fax  = Rs("fax")
       url  = Rs("url")
    
       traffic  = Rs("traffic")
       detail = Rs("detail")
       base_intro = Rs("base_intro")
       room_intro = Rs("room_intro")
       unit_intro = Rs("unit_intro")
       rest_intro = Rs("rest_intro")
    
       point1 = Rs("point1") 
       point2 = Rs("point2")
    end if
    CloseRs Rs


    sql = " select nm_kor "
    sql = sql & " from TB_ti100  "
    sql = sql & " where nat_cd = '"& nat_cd &"' "
	
    set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3
    
    If not rs.EOF Then
        nat_nm_kor = Rs("nm_kor")
    end if
    CloseRs Rs


    sql = " select nm_kor "
    sql = sql & " from TB_ti200  "
    sql = sql & " where nat_cd = '"& nat_cd &"' and city_cd= '"& city_cd &"'"
	
    set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3
    
    If not rs.EOF Then
        city_nm_kor = Rs("nm_kor")
    end if
    CloseRs Rs
%>

<!DOCTYPE html>
<html>
<head>
<title><%=title1%></title>
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

    <form name="hotel_modify" method="post" style="display:inline; margin:0px;">
    <input type="hidden" name="admin_action" value="hotel_modify">
    <input type="hidden" name="seq" value="<%=seq%>">

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
                    <td class="lob1">호텔명</td>
                    <td class="lob2" colspan="3"><input type="text" name="nm_kor" value="<%=nm_kor%>" maxlength="50" style="width:99%" class="input_color"></td>
                </tr>
                <tr>
                    <td class="lob1">영문명</td>
                    <td class="lob2" colspan="3"><input type="text" name="nm_eng" value="<%=nm_eng%>" maxlength="50" style="width:99%" class="input_color"></td>
                </tr>
                <tr>
                    <td class="lob1">주소</td>
                    <td class="lob2" colspan="3"><input type="text" name="addr" value="<%=addr%>" maxlength="100" style="width:99%" class="input_color"></td>
                </tr>
                <tr>
                    <td class="lob1">호텔등급</td>
                    <td class="lob2">
                        <select name="grade" class="select_basic" style="width:150px;">
                            <% 
                                sql = " exec proc_TB_ba001_cd_cdnm 'NETG'" 
                                set aux1_Rs = Server.CreateObject("ADODB.RecordSet")
                                aux1_Rs.open sql,objConn,3
                                If not aux1_rs.EOF Then
                                
                                Do While Not aux1_Rs.eof 
                                cd = aux1_rs("cd")
                                cd_nm = aux1_rs("cd_nm")
                            %>
                            <option value="<%=cd%>" <%if grade = cd then%>selected<%end if%>><%=cd_nm%></option>
                            <%  
                                aux1_rs.MoveNext
                                Loop
                                end if
                                
                                CloseRs aux1_rs
                            %>
                        </select>
                    </td>
                    <td class="lob1">체크인/아웃</td>
                    <td class="lob2"><input type="text" name="url" maxlength="100" style="width:98%" value="<%=url%>" class="input_color"></td>
                </tr>
                 <tr>
                    <td class="lob1">호텔소개<br><font color="#FF0000">이미지 삽입 금지</font></td>
                    <td class="lob5" colspan="3"><textarea name="detail" id="detail" style="width:845px; height:200px;" editor="webnote" tools="deny:images,superscript,subscript,strikethrough,emoticon,fullscreen,lineheight,indent,outdent,increase,decrease,table"><%=detail%></textarea></td>
                </tr>
                <!--
                <tr>
                    <td class="lob1">전화번호</td>
                    <td class="lob2"><input type="text" name="tel" style="width:100%" value="<%=tel%>" maxlength="50" class="input_color"> </td>
                    <td class="lob1">>팩스번호</td>
                    <td class="lob2"><input type="text" name="fax" style="width:100%" value="<%=fax%>" maxlength="50" class="input_color"></td>
                </tr>
                -->
                <tr>
                    <td class="lob1">상세정보</td>
                    <td class="lob5" colspan="3"><textarea name="room_intro" id="room_intro" style="width:845px; height:400px;" editor="webnote" tools="deny:images,superscript,subscript,strikethrough,emoticon,fullscreen,lineheight,indent,outdent,increase,decrease,table"><%=room_intro%></textarea></td>
                </tr>
                <tr>
                    <td class="lob1">구글좌표</td>
                    <td class="lob2" colspan="3"><input type="text" name="point1" style="width:30%" value="<%=point1%>" class="input_color"> - <input type="text" name="point2" style="width:30%" value="<%=point2%>" class="input_color"></td>
                </tr>
            </table>
        </div>

        <div align="center" style="padding:25px 0 0px 0;">
            <span class="button_b" style="padding:0px 4px"><a onClick="hotel_frm_chk();return false;">수정</a></span>
            <span class="button_b" style="padding:0px 4px"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
        </div>

    </form>
    
</body>
</html>
       
<script language="Javascript1.2">
<!-- //
    function closeIframe(){
        parent.$('#chain_hotel_modify').dialog('close');
        return false;
    }   

    function hotel_frm_chk(){ 
        var frm = document.hotel_modify;
        if(confirm("호텔 정보를 수정하시겠습니까?")){
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

