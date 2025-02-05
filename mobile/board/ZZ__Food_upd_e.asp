<!--#include virtual="/home/conf/config.asp" -->
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->   

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private" 
%>    

<!DOCTYPE html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />

<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sm_logo.png">
<meta property="og:description" content="<%=GLOBAL_NM%>">
<meta name="description" content="<%=GLOBAL_NM%>">
<meta name='keywords' content="<%=GLOBAL_NM%>">

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="shortcut icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">
<link rel="apple-touch-icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">

<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner1.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner2.css">

<script type="text/javascript" language="javascript" src="/mobile/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/slick.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/swiper.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/common.js"></script>

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />
<script type="text/javascript" src="/seditor/js/HuskyEZCreator_e.js" charset="utf-8"></script>

</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">
    	
        <!--#include virtual="/mobile/include/left_menu.asp"-->
        <!--#include virtual="/mobile/include/top_menu.asp"-->

        <div class="best_main3">
        	
            <div class="infor_title">맛집 게시판</div>
            <div style="border-bottom:2px solid #000;"></div>
        
            <%
                tbl = "trip_after"
            
                num = Request("num")
                if Trim(num)="" or isnull(num) then
                    Response.write "<script type='text/javascript'>"
                    Response.write " alert('주요인자전송에러!'); "
                    Response.write " history.back();"
                    Response.write " </script>	 "
                    Response.end
                end if
               
                gotopage = Request("gotopage")
                s_cont = Request("s_cont")
                s_cont = Replace(s_cont,"'","") 
                cont = Request("cont")
                cont = Replace(cont,"'","")
            
                password = Request.form("password")
            
                OpenF5_DB objConn
            
                Sql = " select user_nm, title, con_tents,  img , img_w, img_h , pwd , hit ,ins_dt  FROM "&tbl&" WHERE num = "&num&" and del_yn='N' "
                Set Rs = objConn.Execute(Sql)
                 
                user_nm  = Rs("user_nm")
                title    = Rs("title")
                con_tents= Rs("con_tents")
            
                t_img = Rs("img")
                img_w = Rs("img_w")
                if img_w > 1170 then
                    img_w ="1170"
                End if
                img_h = Rs("img_h")
            
                pwd = Rs("pwd")
                ins_dt = Rs("ins_dt")
                hit = Rs("hit")
            
                CloseRs Rs
            
                if pwd <> password then
                    Response.write "<script type='text/javascript'>"
                    Response.write " alert('비밀번호를 입력해 주십시오.'); "
                    Response.write " history.back();"
                    Response.write " </script>	 "
                    Response.end
                End if
            %>
                
            <form name="form1" method="post" action="food_upd_ok.asp" enctype="multipart/form-data" style="display:inline; margin:0px;" >
            <input type="hidden" name="num"     value="<%=num%>">
            <input type="hidden" name="gotopage" value="<%=gotopage%>">
                <div class="board_write"> 
                    <table>
                        <colgroup>
                            <col width="24%">
                            <col width="*">
                        </colgroup>
                        <tbody>  
                            <tr>
                                <td class="typ1">작성자</td>
                                <td class="typ2"><input type="text" name="writer" style="width:50%;" value="<%=user_nm%>" maxlength="20" class="input_basic" /></td>
                            </tr>
                            <tr>
                                <td class="typ3">제목</td>
                                <td class="typ4"><input type="text" name="title" value="<%=title%>" style="width:100%;" maxlength="80" class="input_basic" /></td>
                            </tr>
                            <% If Len(t_img)> 3 then %>
                            <tr>
                                <td class="typ3">이미지</td>
                                <td class="typ4"><img src="/board/upload/after/<%=t_img%>" border="0" width="50%" id="img_test2"></td>
                            </tr>
                            <% End if %>
                            <tr height="54">
                                <td class="typ3">이미지등록</td>
                                <td class="typ4"><input type="file" name="srcfile" style="width:100%;" class="input_file" /></td>
                            </tr>
                        </tbody>
                    </table>
                       
                    <div><textarea name="ir_1" id="ir_1" style="width:100%;height:400px; display:none;"><%=con_tents%></textarea></div>
                </div>
                
                <div class="board_btn_q">
                    <ul class="btn_r">
                        <li><a href="food_list.asp?gotopage=<%=gotopage%>">목록</a></li>	
                        <li class="color"><a onclick="inputok();">수정</a></li>		
                    </ul>
                </div>
            </form>
            
            <% CloseF5_DB objConn %>

        </div> 

        <!--#include virtual="/mobile/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

<script type="text/javascript">
<!--
   
    var oEditors = [];
    
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ir_1",
        sSkinURI: "/seditor/SmartEditor2Skin_e.html",	
        htParams : {
          bUseToolbar : true,	
          bUseVerticalResizer : false,
          bUseModeChanger : true,
          fOnBeforeUnload : function(){
    
          }
        }, //boolean
        fOnAppLoad : function(){
          //예제 코드
        },
        fCreator: "createSEditor2"
    });
    
    function inputok(){
    
       if (document.form1.writer.value=="" ) {
           alert("작성자를 입력해 주세요.");
           return false;
       }
       
       if (document.form1.title.value=="" ){ 
           alert("제목을 입력해 주세요.");
           return false;
       }
    
       if(document.form1.title.value.substr(0,1) == " " || document.form1.writer.value.substr(0,1) == " "){
           alert("작성자와 제목의 첫글자에는\n공백문자를 넣을 수 없습니다.");
           return false;
       }
     oEditors.getById["ir_1"].exec("UPDATE_CONTENTS_FIELD", []);
       document.form1.submit();
    
    }
//-->
</script>
