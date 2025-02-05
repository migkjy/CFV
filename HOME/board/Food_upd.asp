<!--#include virtual="/home/conf/config.asp" -->
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<% 
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>

<!DOCTYPE html>
<html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sm_logo.png">
	
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">

<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script type="text/javascript" src="/home/js/jquery.fancybox.pack.js?v=2.1.4"></script>
<link type="text/css" href="/home/js/jquery.fancybox.css?v=2.1.4" />

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>
<script type="text/javascript" src="/seditor/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">
        
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
        
            <div id="contBody">
                <div class="pt10"></div>
                <div class="infor_title">맛집 게시판</div>
                <div style="border-bottom:2px solid #000;"></div>
                
                
                <form name="form1" method="post" action="food_upd_ok.asp" enctype="multipart/form-data" style="display:inline; margin:0px;" >
                <input type="hidden" name="num"     value="<%=num%>">
                <input type="hidden" name="gotopage" value="<%=gotopage%>">
        
                    <div class="board_write">
                        <table>
                            <colgroup>
    		                    <col width="15%" />
    		                    <col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>작성자</th>
                                    <td><input type="text" name="writer" value="<%=user_nm%>" style="width:250px;" maxlength="20" /></td>
                                </tr>
                                <tr>
                                    <th>제목</th>
                                    <td><input type="text" name="title" value="<%=title%>" style="width:80%;" maxlength="80" /></td>
                                </tr>
                                <tr>
                                    <th>썸네일 이미지등록</th>
                                    <td><input type="file" name="srcfile" style="width:99%;" /></td>
                                </tr>
                                <% if Len(t_img)> 3 then %>
                                <tr>
                                    <th>등록된 이미지</th>
                                    <td><img src="/board/upload/after/<%=t_img%>" border="0" width="100" id="img_test2" valign="middle"></td>
                                </tr>
                                 <% End if %>
                            </tbody>
                        </table>
                     <font color="red">
                      ※ 작성TIP<br>
                      게시글을 먼저 작성하신 후 마지막으로 오른쪽에 있는 "사진" 버튼을 활용하여 이미지를 첨부해주세요!<br>
                     이미지를 여러장 첨부하실 경우에는 "사진" 버튼을 활용하여 한장씩 한장씩 순차적으로 올려 주셔야 합니다. </font>
                        <div style="padding:15px 0 0 0;">
                            <textarea name="ir_1" id="ir_1" style="width:100%;height:600px; display:none;"><%=con_tents%></textarea>
                        </div>
                        
                    </div>
    
                   <div class="board_btn_w">
                       <ul class="btn_r">
                           <li><a href="food_list.asp?gotopage=<%=gotopage%>">목록</a></li>		
                           <li class="color"><a onclick="inputok();" style="cursor:pointer;">수정</a></li>		
                       </ul>
                   </div>
            
                    <div class="pt50"></div>
                </form>

            </div>
            
        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>
    
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