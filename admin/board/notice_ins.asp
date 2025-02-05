<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    tbl = "trip_notice"

    g_kind       = Request("g_kind")
    If Trim(g_kind)="" or isnull(g_kind) then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('접근하실수 없습니다...'); "
        Response.write " history.back();"
        Response.write " </script>	 "
        Response.end
    End if

    Select Case g_kind
        Case "10":g_kind_nm="공지사항"
        Case "20":g_kind_nm="페이지 등록"
        Case "30":g_kind_nm="채용공고"
    End Select


    num = Request("num")
    pagesize = Request("pagesize")
    gotopage = Request("gotopage")

    s_cont   = Request("s_cont")
    s_cont   = replace(s_cont,"'","''")
    cont = Request("cont")
    cont = replace(cont,"'","''")

    
    OpenF5_DB objConn
  
    If num <> "" then
        btn="수정"

        sql="select num , user_nm, title , con_tents from "&tbl&" where num="&num
        Set Rs = objConn.Execute(sql)

        if Rs.eof or Rs.bof then
            Response.write "<script type='text/javascript'>"
            Response.write " alert('주요인자전송에러!!...'); "
            Response.write " history.back();"
            Response.write " </script>	 "
            Response.end
        else
            user_nm   = Rs("user_nm")
            title     = Rs("title")
            con_tents = Rs("con_tents")
                if not isnull(con_tents) or con_tents <> "" then
                    con_tents = CheckWordre(con_tents)
                end if
        end if

        CloseRs Rs

    Else
        btn="등록"
    End if

    If user_nm="" then 
        user_nm = nm
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
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/seditor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=g_kind_nm%></div>
    
        <form name="frmwrite" method="post" action="notice_ins_ok.asp" style="display:inline; margin:0px;">
        <input type="hidden" name="g_kind" value="<%=g_kind%>">
        <input type="hidden" name="num"    value="<%=num%>">

            <div class="table_box">
                <table>
                    <tr>
                        <td width="12%" class="lop1">작성자</td>
                        <td width="*%" class="lop2"><input type="text" name="writer" value="<%=user_nm%>" style="width:150px;" maxlength="10" class="input_color"></td>
                    </tr>
                    <tr>
                        <td class="lob1">제 목</td>
                        <td class="lob2"><input type="text" name="title" value="<%=title%>" style="width:800px" maxlength="100" class="input_color"></td>
                    </tr>
                    <tr>
                        <td class="lob1">내 용</td>
                        <td class="lob5"><textarea name="ir_1" id="ir_1" style="width:1240px;height:550px; display:none;"><%=con_tents%></textarea></td>
                    </tr>
                </table>
            </div>
            
            <div class="pt25"></div>   
            
            <div align="center">
                <span class="button_b" style="padding:0px 4px"><a onclick="chk_frm();"><%=btn%></a></span>
                <span class="button_b" style="padding:0px 4px"><a onClick="history.back();return false;">취소</a></span>
            </div>

        </form>
        
    </div>
    
</body>
</html>

<%
    CloseF5_DB objConn 
%>        

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
        if(document.frmwrite.writer.value==""){
            alert("작성자를 입력하세요.");
            document.frmwrite.writer.focus();
            return false;
        }
	
        if(document.frmwrite.title.value==""){
            alert("제목을 입력하세요.");
            document.frmwrite.title.focus();
            return false;
        }
  
        oEditors.getById["ir_1"].exec("UPDATE_CONTENTS_FIELD", []);
        document.frmwrite.submit();
    }
--> 
</script>

