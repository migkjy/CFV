<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    tbl =  "trip_qna"
    num = Request("num")

    Select Case g_kind
	    Case "10":g_kind_nm="문의 게시판"
	    Case "20":g_kind_nm="견적문의"
    End Select

    gotopage = Request("gotopage")
    
    s_cont = Request("s_cont")
    s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
    cont = Replace(cont,"'","")


    OpenF5_DB objConn


    If num <> "" then
        btn="수정"

        Sql = "SELECT num, user_id, user_nm, title , con_tents ,ins_dt FROM "&tbl&" WHERE num = "&num&" and del_yn='N'  "
        Set Rs = objConn.Execute(Sql)
           
            if Rs.eof or Rs.bof then
                Response.write "<script type='text/javascript'>"
                Response.write " alert('접근하실수 없습니다...'); "
                Response.write " history.back();"
                Response.write " </script>	 "
                Response.end
            Else
                num     = Rs("num")
                user_id = Rs("user_id")
                user_nm = Rs("user_nm")
                title   = Rs("title")
                con_tents = Rs("con_tents")
                ins_dt = left(Rs("ins_dt"),10)
            End if 

        
        CLOSERS RS

    Else
        btn ="등록"
        user_nm = cu_nm_kor
        secret  ="Y"
    End if
%>

<!DOCTYPE html>
<html>
<head>
<title>문의 게시판</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 문의 게시판</div>

        <form name="form1" method="post" action="qna_ins_ok.asp"  style="display:inline; margin:0px;" >
        <input type="hidden" name="num" value="<%=num%>">
        <input type="hidden" name="g_kind" value="<%=g_kind%>">
        <input type="hidden" name="gotopage" value="<%=gotopage%>">
        <input type="hidden" name="s_cont" value="<%=s_cont%>">
        <input type="hidden" name="cont" value="<%=cont%>">
        <input type="hidden" name="res_tp" value="<%=res_tp%>">

            <div class="table_box">
                <table>
                    <tr>
                        <td width="12%" class="lop1">작성자</td>
                        <td width="*%" class="lop2"><input type="text" name="writer" value="<%=user_nm%>" style="width:150px;" maxlength="10" class="input_color"></td>
                    </tr>
                    <tr>
                        <td class="lop1">제 목</td>
                        <td class="lop2"><input type="text" name="title" value="<%=title%>" style="width:800px" maxlength="100" class="input_color"></td>
                    </tr>
                    <tr>
                        <td class="lop1">내 용</td>
                        <td class="lob5"><textarea name="content" style="width:1100px; height:400px;" class="textarea_basic"><%=con_tents%></textarea></td>
                    </tr>
                </table>
            </div>
            
            <div class="pt25"></div>   
            
            <div align="center">
                <span class="button_b" style="padding:0px 4px"><a onclick="inputok();"><%=btn%></a></span>
                <span class="button_b" style="padding:0px 4px"><a href="qna_list.asp?gotopage=<%=gotopage%>&res_tp=<%=res_tp%>">취소</a></span>
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
    function inputok(){
        if (document.form1.writer.value==""){
            alert("작성자을 입력해 주세요.");
		return false;
        }

        if (document.form1.title.value==""){
            alert("제목을 입력해 주세요.");
            return false;
        }

        if (document.form1.content.value==""){
            alert("내용을 입력해 주세요.");
            return false;
        }

        if(document.form1.content.value.substr(0,1) == " " || document.form1.writer.value.substr(0,1) == " "){
            alert("'글쓴이'와 '제목' 항목의 첫글자에는 \n공백문자를 넣을 수 없습니다.");
            return false;
        }

        document.form1.submit();
    }
//-->
</script>


