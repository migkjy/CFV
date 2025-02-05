<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    OpenF5_DB objConn 
    
    res_tp = Request("res_tp")  '프로그램/ 호텔 구분
    If res_tp="" then
        Response.write "<script  type='text/javascript'>"
        Response.write " alert('접근하실수 없습니다...'); "
        Response.write " self.close();"
        Response.write " </script>	 "
        Response.end
    End if

    res_cd = Request("res_cd")
    If res_cd="" then
        Response.write "<script  type='text/javascript'>"
        Response.write " alert('접근하실수 없습니다...'); "
        Response.write " self.close();"
        Response.write " </script>	 "
        Response.end
    End if

    
    idx = Request("idx")

    gotopage = Request("gotopage")
    s_cont = Request("s_cont")
    s_cont = Replace(s_cont,"'","")

    cont = Request("cont")
    cont = Replace(cont,"'","")
      
    emp_no =Request("emp_no")
    
    

    If idx <> "" then
    
        btn="수정"
    
        sql="select  idx, res_cd, user_nm, user_id, con_tents from res_dat where idx="&idx&" and del_yn='N' "
        Set Rs = objConn.Execute(sql)
    
        if Rs.eof or Rs.bof then
            Response.write "<script  type='text/javascript'>"
            Response.write " alert('접근하실수 없습니다...'); "
            Response.write " self.close();"
            Response.write " </script>	 "
            Response.end
        else
            user_nm  = Rs("user_nm")
            con_tents= Rs("con_tents")
        end if
    
    Else
        btn="등록"
    End if

    If user_nm="" then 
        user_nm = m_name
    End if
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
    
    <form name="frmwrite" method="post" action="dat_write_ok.asp"  style="display:inline; margin:0px;">
    <input type="hidden" name="res_tp" value="<%=res_tp%>">
    <input type="hidden" name="res_cd" value="<%=res_cd%>">
    <input type="hidden" name="emp_no" value="<%=emp_no%>">
    <input type="hidden" name="idx" value="<%=idx%>">
        
        <div class="table_box">
            <table>
                <tr>
                    <td width="15%" class="lop1">작성자</td>
                    <td width="*%" class="lop2"><input type="text" name="writer" value="<%=nm%>" style="width:150px;" maxlength="10" class="input_basic"></td>
                </tr>
                <tr>
                    <td class="lob1">내용</td>
                    <td class="lob5"><textarea name="ir_1" id="ir_1" style="width:100%;height:280px; display:none;""><%=con_tents%></textarea> </td>
                </tr>
            </table>
        </div> 

        <div class="noprint" align="center" style="padding:25px 0 30px 0;">
            <span class="button_b" style="padding:0px 4px;"><a onclick="chk_frm();"><%=btn%></a></span>
            <span class="button_b" style="padding:0px 4px"><a onclick="javascript:self.closeIframe();return false;">닫기</a></span>
        </div>
        
    </form>
    
</body>
</html>

<script language="javascript">
<!--
    function closeIframe(){
        parent.$('#chain_memo').dialog('close');
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
   		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
   		fOnBeforeUnload : function(){
   			
   		}
   	}, //boolean
   	fOnAppLoad : function(){
   		//예제 코드
   	},
   	fCreator: "createSEditor2"
   });



   function chk_frm(){
   
      if(document.frmwrite.writer.value==""){
          alert("작성자를 입력하세요.");
          document.frmwrite.writer.focus();
          return false;
      }
   
      oEditors.getById["ir_1"].exec("UPDATE_CONTENTS_FIELD", []);
      document.frmwrite.submit()
   }
--> 
</script>



