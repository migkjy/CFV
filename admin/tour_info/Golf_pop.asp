<!--#include virtual="/admin/conf/config.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
 
    OpenF5_DB objConn

    seq = Trim(Request("seq"))

	sql = " select seq,nat_cd,city_cd,nm_kor,nm_eng,addr,tel,fax,dgn_nm,open_dd,url,place,traffic,detail,hole,par,tot_yard,point1,point2 "
	sql = sql & " from TB_ti370  "
	sql = sql & " where seq   = '"& seq &"' "
	
    set Rs = Server.CreateObject("ADODB.RecordSet")
    Rs.open sql,objConn,3
    
    If not rs.EOF Then
        seq = Rs("seq")
        nat_cd = Rs("nat_cd")
        city_cd = Rs("city_cd")
        nm_kor = Rs("nm_kor")
        nm_eng = Rs("nm_eng")
        addr = Rs("addr")
        tel  = Rs("tel")
        fax = Rs("fax")
        dgn_nm = Rs("dgn_nm")
        open_dd = Rs("open_dd")
        url = Rs("url")

        place = Rs("place")
        traffic = Rs("traffic")
        detail = Rs("detail")
        hole = Rs("hole")
        par = Rs("par")
        tot_yard = Rs("tot_yard")
        point1 = Rs("point1")
        point2 = Rs("point2")
    End if
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
</head>

<body>

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
                <td class="lob2"><%=nm_kor%></td>
                <td class="lob1">영문명</td>
                <td class="lob2"><%=nm_eng%></td>
            </tr>
            <% if addr <> "" then %>
            <tr>
                <td class="lob1">주소</td>
                <td class="lob2" colspan="3"><%=addr%></td>
            </tr>
            <% end if %>
            <tr>
                <td class="lob1">전화번호</td>
                <td class="lob2"><%=tel%></td>
                <td class="lob1">팩스번호</td>
                <td class="lob2"><%=fax%></td>
            </tr>
            <tr>
                <td class="lob1">홀</td>
                <td class="lob2"><%=hole%></td>
                <td class="lob1">파</td>
                <td class="lob2"><%=par%></td>
            </tr>
            <tr>
                <td class="lob1">총야드</td>
                <td class="lob2"><%=tot_yard%></td>
                <td class="lob1">홈페이지</td>
                <td class="lob2"><%=url%></td>
            </tr>
            <tr>
                <td class="lob1">골프장소개</td>
                <td class="lob4" colspan="3"><%=detail%></td>
            </tr>
            <tr>
                <td class="lob1">상세정보</td>
                <td class="lob4" colspan="3"><%=traffic%></td>
            </tr>
            <tr>
                <td class="lob1">구글좌표</td>
                <td class="lob2" colspan="3"><%=point1%> - <%=point2%></td>
            </tr>
        </table>
    </div>
    
    <div align="center" style="padding:25px 0 0px 0;">
        <span class="button_b"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
    </div>

</body>
</html>

<%
    CloseF5_DB objConn
%>   

<script language="Javascript1.2">
<!-- //
    function closeIframe(){
        parent.$('#chain_golf_pop').dialog('close');
        return false;
    }   
// -->
</script>