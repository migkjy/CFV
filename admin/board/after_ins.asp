<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    tbl    = "trip_after"

    num      = Request("num")

    gotopage = Request("gotopage")
    s_cont   = Request("s_cont")
    s_cont   = Replace(s_cont,"'","") 
    cont     = Request("cont")
    cont     = Replace(cont,"'","")

    
    OpenF5_DB objConn
  
    If num <> "" then
        btn="수정"

        sql="select num ,user_nm ,title , con_tents ,img, img_w , img_h   from "&tbl&" where num="&num&" and del_yn='N' "
        Set Rs = objConn.Execute(sql)
    
        if Rs.eof or Rs.bof then
            Response.write "<script type='text/javascript'>"
            Response.write " alert('접근하실수 없습니다...'); "
            Response.write " history.back();"
            Response.write " </script>	 "
            Response.end
        else
            user_nm  = Rs("user_nm")
            title    = Rs("title")
            title   = Replace(title, """", "&#34;")
            
            con_tents= Rs("con_tents")
            t_img    = Rs("img")
            img_w    = Rs("img_w")
            if img_w > 200 then
                img_w =200
            end if

        end if

        CloseRs Rs
           
    Else
    	
        btn    ="등록"
        
    End if

    If user_nm="" then 
        user_nm = nm
    End if
%>

<!DOCTYPE html>
<html>
<head>
<title>발리 맛집</title>
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
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 발리 맛집</div>

        <form name="frmwrite" method="post" action="after_ins_ok.asp" enctype="multipart/form-data" style="display:inline; margin:0px;">
        <input type="hidden" name="num" value="<%=num%>">
        <input type="hidden" name="gotopage" value="<%=gotopage%>">
        <input type="hidden" name="s_cont" value="<%=s_cont%>">
        <input type="hidden" name="cont" value="<%=cont%>">

            <div class="table_box">
                <table>
                    <tr>
                        <td width="12%" class="lop1">작성자</td>
                        <td width="*%" class="lop2"><input type="text" name="writer" value="<%=user_nm%>" style="width:150px;" maxlength="10" class="input_color"></td>
                    </tr>
                    <% if Len(t_img)> 3 then %>
                    <tr>
                        <td class="lob1">등록 이미지</td>
                        <td class="lob5">
                            <table>
                                 <tr>
                                     <td width="220"><img src="/board/upload/after/<%=t_img%>" border="0" width="<%=img_w%>" valign="middle"></td>
                                     <td width="*"><span class="button_a"><a onclick="fn_filedel('<%=num%>','af')">삭제</a></span></td>
                                 </tr>
                            </table>
                        </td>
                    </tr>
                    <% end if %>
                    <tr>
                        <td class="lob1">이미지</td>
                        <td class="lob2"><input type="file" name="srcfile" onKeyPress="return false" style="width:800px;" class="input_file">&nbsp;&nbsp;용량:5M</td>
                    </tr>
                    <tr>
                        <td class="lob1">제 목</td>
                        <td class="lob2"><input type="text" name="title" value="<%=title%>" style="width:800px" maxlength="100" class="input_color"></td>
                    </tr>
                    <tr>
                        <td class="lob1">내 용</td>
                        <td class="lob5"><textarea name="ir_1" id="ir_1" style="width:1240px;height:500px; display:none;"><%=con_tents%></textarea></td>
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
        document.frmwrite.submit()
    }

    
    function fn_filedel(s,b){
        if(confirm("정말로 삭제하시겠습니까?")){
            location.href="img_del.asp?num="+s+"&tp="+b;
        }
    }
--> 
</script>


