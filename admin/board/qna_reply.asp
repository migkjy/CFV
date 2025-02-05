<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    tbl = "trip_qna"
 
    num    = Request("num")
        if num =""  or isnull(num)  then
           Response.write "<script language='javascript'>"
           Response.write " alert('주요인자오류!!!'); "
           Response.write " history.back();"
           Response.write " </script>	 "
           Response.end
        End if 

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

    sql =" select a.num , a.user_id , a.user_nm , a.email ,a.title ,a.con_tents ,a.hit ,a.ref ,a.ref_level ,a.deep ,a.ins_dt "
    sql = sql & "  from "&tbl&" a where num=" &num&" and del_yn='N'"
    Set Rs = objConn.Execute(Sql)

    if Rs.eof or Rs.bof then
       Response.write "<script language='javascript'>"
       Response.write " alert('접근하실수 없습니다...'); "
       Response.write " history.back();"
       Response.write " </script>	 "
       Response.end
    Else

       num       = Rs("num")
       User_nm   = Rs("user_nm")
       title     = Rs("title")
       email     = Rs("email")

       con_tents = Rs("con_tents")
       if not isnull(con_tents) or con_tents <> "" then
           con_tents = Replace(con_tents,chr(13)&chr(10),"<br>")
       end if

       ref       = Rs("ref")
       ref_level = Rs("ref_level")
       deep      = Rs("deep")
       ins_dt    = Rs("ins_dt")

    End if

    CLOSERS RS
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

        <form name="form1" method="post"  action="qna_ins_ok.asp" style="display:inline; margin:0px;" >
        <input type="hidden" name="num" value="<%=num%>" >
        <input type="hidden" name="ref" value="<%=ref%>" >
        <input type="hidden" name="ref_level" value="<%=ref_level%>" >
        <input type="hidden" name="deep" value="<%=deep%>" >
        <input type="hidden" name="g_kind" value="<%=g_kind%>" >
        <input type="hidden" name="gotopage" value="<%=gotopage%>" >
        <input type="hidden" name="s_cont" value="<%=s_cont%>" >
        <input type="hidden" name="cont" value="<%=cont%>" >
        <input type="hidden" name="res_tp" value="<%=res_tp%>" >

            <div class="table_box">
                <table>
                    <tr>
                        <td width="12%" class="lop1">질문자</td>
                        <td width="*%" class="lop2"><%=User_nm%></td>
                    </tr>
                    <tr>
                        <td class="lop1">질문내용</td>
                        <td class="lob5"><%=con_tents%></td>
                    </tr>
                    <tr>
                        <td class="cop1">작성자</td>
                        <td class="cop2"><input type="text" name="writer" value="<%=nm%>" style="width:150px;" maxlength="10" class="input_color"></td>
                    </tr>
                    <tr>
                        <td class="cop1">제 목</td>
                        <td class="lop2"><input type="text" name="title" value="답변입니다." style="width:800px" maxlength="100" class="input_color"></td>
                    </tr>
                    <tr>
                        <td class="cop1">답변내용</td>
                        <td class="lob5"><textarea name="content" style="width:1100px; height:400px;" class="textarea_basic"></textarea></td>
                    </tr>
                </table>
            </div>

            <div class="pt25"></div>   
            
            <div align="center">
                <span class="button_b" style="padding:0px 4px"><a onclick="inputok();">등록</a></span>
                <span class="button_b" style="padding:0px 4px"><a href="qna_list.asp?gotopage=<%=gotopage%>&res_tp=<%=res_tp%>">취소</a></span>
            </div>

        </form>
        
    </div>
    
</body>
</html>

<%
    CloseF5_DB objConn 
%>


<script language="javascript">
<!--
    function inputok(){
        if (document.form1.writer.value==""){
            alert("모든 항목을 입력해 주세요.");
            return false;
        }
    
        if (document.form1.title.value==""){
            alert("모든 항목을 입력해 주세요.");
            return false;
        }
    
        if (document.form1.content.value==""){
            alert("모든 항목을 입력해 주세요.");
            return false;
        }
    
        if(document.form1.title.value.substr(0,1) == " " || document.form1.writer.value.substr(0,1) == " "){
            alert("'글쓴이'와 '제목' 항목의 첫글자에는 \n공백문자를 넣을 수 없습니다.");
            return false;
        }
        
        document.form1.submit();
    }
//-->
</script>
