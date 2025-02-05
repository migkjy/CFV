<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"

    OpenF5_DB objConn

    Dim objMem ,query_mem
    
    If emp_no = "" Or em_pass = ""  Then
        Call Alert_Window_Location("로그인 하지 않으셨거나 회원님의 정보를 확인할 수 없습니다.\n다시 로그인 하여주세요.\n\n","/admin/login.asp")
        Response.End
    End if

    query_mem = "Select emp_no,dept_cd,em_pass,email,nm,tell,handphone from TB_em001 where emp_no = '"& Request.cookies("emp_no") &"'"

    Set objMem = objConn.Execute(query_mem)
    If objMem.eof and objMem.bof then
        Call Alert_Window_Location("회원님의 정보를 확인할 수 없습니다.\n다시 로그인 하여주세요.\n\n","/admin/login.asp")
        Response.End
    Else
        emp_no = objMem("emp_no")
        Response.Cookies("dept_cd") =objMem("dept_cd")
        em_pass = objMem("em_pass")
        email = objMem("email")
        nm = objMem("nm")
        tell = objMem("tell")
        handphone     = objMem("handphone")
    End if

    objMem.close  : Set objMem = Nothing
%>

<!DOCTYPE html>
<html>
<head>
<title><%=title1%> 투어그램</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">
<script type="text/javascript" src="/admin/scripts/common.js"></script>
<link rel="stylesheet" href="/admin/js/jquery-ui.css" />
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
</head>


<style>
  #tabs {
    margin-top: 1em;
}
#tabs li .ui-icon-close {
    float: left;
    margin: 0.4em 0.2em 0 0;
    cursor: pointer;
}
#add_tab {
    cursor: pointer;
}
.iframe-container {
    position: relative;
    overflow: hidden;
    padding-top: 43%; /* 16:9 aspect ratio */
}
.iframe-container iframe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border: none;
}
</style>

<script>
    $(function () {
        var tabsInfo = JSON.parse(localStorage.getItem("tabsInfo")) || {};
        var tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>",

        tabCounter = Object.keys(tabsInfo).length;
    
         var tabs = $("#tabs").tabs({
            activate: function(event, ui) {
                localStorage.setItem("activeTab", ui.newPanel.attr("id"));
            }
         });
    
         var tab_id = 0;
         if (tabCounter == 0) {
             tab_id = 1;
             addTab();
         } else {
             tab_id = Object.keys(tabsInfo).sort(
                 function (a, b) {
                     return b.split("-")[1] - a.split("-")[1];
                 }
             )[0].split("-")[1];
             tab_id = Number(tab_id) + 1;
         }
    
    
         function addTab() {
             var tabsInfo = JSON.parse(localStorage.getItem("tabsInfo")) || {};
             var tabCount = Object.keys(tabsInfo).length;
   
             var seqTabs = $("#tabs .ui-tabs-nav li").length;
             
             if (seqTabs >= 10) {
                 alert("10개 이상의 탭을 만들 수 없습니다");
                 return;
             }
    
    
             if (tab_id === 1) {
                 var label = "Tab " + tab_id,
                 id = "tabs-" + tab_id,
                 li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label)),
                 tabContentHtml = "<div class='iframe-container'> <iframe src='main.asp' name='tab-frame'></iframe></div>";
                
                 }
   
             if (tab_id !== 1) {
                 var label = "Tab " + tab_id,
                 id = "tabs-" + tab_id,
                 li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label)),
                 tabContentHtml = "<div class='iframe-container'> <iframe src='bin_page.html' name='tab-frame'></iframe></div>";
             }
   
   
             if (tab_id === 1) {
                 li.find("span.ui-icon-close").hide();
             }
      
             $("#tabs").find(".ui-tabs-nav").append(li);
             $("#tabs").append("<div id='" + id + "'><p>" + tabContentHtml + "</p></div>");
             $("#tabs").tabs("refresh");
             tabs.find('a[href="#' + id + '"]').trigger("click");
             tabsInfo[id] = { label: label, content: tabContentHtml };
             tab_id++;
         }
         
         
         for (var id in tabsInfo) {
             var label = tabsInfo[id].label;
             var tabContentHtml = tabsInfo[id].content;
             var li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label));
             $("#tabs").find(".ui-tabs-nav").append(li);
             $("#tabs").append("<div id='" + id + "'><p>" + tabContentHtml + "</p></div>");
         }
         $("#tabs").tabs("refresh");
  
         var activeTabId = localStorage.getItem("activeTab");
         if (activeTabId) {
             tabs.find('a[href="#' + activeTabId + '"]').trigger("click");
         }


         $("#add_tab").button().click(function () {
             addTab();
             var numTabs = $("#tabs .ui-tabs-nav li").length;
             if (numTabs > 1) {
                 // 텝이 1개 이상인 경우 닫기 버튼을 보여줌
                 $("#tabs .ui-tabs-nav li span.ui-icon-close").show();
             }
         });

         tabs.delegate("span.ui-icon-close", "click", function () {
             var panelId = $(this).closest("li").remove().attr("aria-controls");
             $("#" + panelId).remove();
             tabs.tabs("refresh");

             var tabsInfo = JSON.parse(localStorage.getItem("tabsInfo")) || {};
             delete tabsInfo[panelId];
             localStorage.setItem("tabsInfo", JSON.stringify(tabsInfo));

             var numTabs = $("#tabs .ui-tabs-nav li").length;
             if (numTabs === 1) {
                 // 텝이 1개인 경우 닫기 버튼을 숨김 처리
                 $("#tabs .ui-tabs-nav li span.ui-icon-close").hide();
             }
             else if ($(this).parent().is(":last-child")) {
                 // 마지막 텝인 경우 닫기 버튼을 숨김 처리
                 $(this).hide();
             }
         });

         $("#wrapper a").each(function(o) {
              $(this).on("click", function() {
             		var target_url = $(this).data("url");
             		var activeTabId = localStorage.getItem("activeTab");
             		if (activeTabId) {
             		    $("#tabs").find("#" + activeTabId).find("iframe").attr("src", target_url);
             		    var title = '';
             		    $("#tabs").find("#" + activeTabId).find("iframe").on("load", function() {
             		        title = $("#tabs").find("#" + activeTabId).find("iframe").contents().find("title").html();
             		        $("#tabs").find("li[aria-controls='"+ activeTabId +"']").find("a").html(title);
             		    });
             		}
             });
         });
    });
</script>
</head>

<body>
	
    <div id="wrapper"><!--#include virtual="/admin/main/Top_menu.asp"--></div>

    <div id="tabs">
	    <ul><span id="add_tab" style="font-size:16px;"><i class="xi-plus xi-x"></i></span></ul>
    </div>

</body>
</html>