<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    tbl = "trip_faq"

    num = Request("num")
    
    pagesize   = Request("pagesize")
    gotopage = Request("gotopage")
    s_cont = Request("s_cont")
    s_cont = replace(s_cont,"'","''")
    cont = Request("cont")
    cont = replace(cont,"'","''")
    
    
    OpenF5_DB objConn

    If num <> "" then
        btn="수정"
        
        sql="select num , user_nm, title , con_tents  from "&tbl&" where num="&num
        Set Rs = objConn.Execute(sql)
    
        if Rs.eof or Rs.bof then
            Response.write "<script type='text/javascript'>"
            Response.write " alert('주요인자전송에러!!...'); "
            Response.write " history.back();"
            Response.write " </script>	 "
            Response.end
        else
            user_nm = Rs("user_nm")
            title   = Rs("title")
            con_tents  = Rs("con_tents")
        end if

        CloseRs Rs
      
    Else
        btn    ="등록"
        user_nm = nm
    End if
%>

<!DOCTYPE html>
<html>
<head>
<title>자주묻는질문</title>
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
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 자주묻는질문</div>

        <form name="form1" method="post"  action="faq_ins_ok.asp"  style="display:inline; margin:0px;" >
        <input type="hidden" name="num"    value="<%=num%>">

            <div class="table_box">
                <table>
                    <tr>
                        <td width="12%" class="lop1">작성자</td>
                        <td width="*%" class="lop2"><input type="text" name="writer" value="<%=user_nm%>" style="width:150px;" maxlength="10" class="input_color"></td>
                    </tr>
                    <tr>
                        <td class="lob1">질문</td>
                        <td class="lob2"><input type="text" name="title" value="<%=title%>" style="width:800px" maxlength="100" class="input_color"></td>
                    </tr>
                    <tr>
                        <td class="lob1">답변</td>
                        <td class="lob5"><textarea name="ir_1" id="ir_1" style="width:1168px;height:550px; display:none;"><%=con_tents%></textarea></td>
                    </tr>
                </table>
            </div>
            
            <div class="pt25"></div>   
            
            <div align="center">
                <span class="button_b" style="padding:0px 4px"><a onclick="inputok();"><%=btn%></a></span>
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


    function inputok(){
        if (document.form1.writer.value==""){
            alert("작성자를 입력해 주세요.");
            return false;
        }

        if (document.form1.title.value==""){
            alert("질문을 입력해 주세요.");
            return false;
        }
	 
        if(document.form1.title.value.substr(0,1) == " " || document.form1.writer.value.substr(0,1) == " "){
            alert("'글쓴이'와 '제목' 항목의 첫글자에는 \n공백문자를 넣을 수 없습니다.");
            return false;
        }
        
        oEditors.getById["ir_1"].exec("UPDATE_CONTENTS_FIELD", []);
        document.form1.submit();
    }
//-->
</script>


