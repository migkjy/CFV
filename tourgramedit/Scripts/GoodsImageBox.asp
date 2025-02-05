<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<% session.CodePage = "949" %>



 <script language="javascript">
/* 게시판용 이미지박스 */
var ImageBox = {
    $box: null,
    $listBox: null,
    $formItem: null,
    $currentItem: null,
    work: null,
    editor: null,
    editorID: null,
    action: null,
    insertOK: null,
    notHideBtn: null, /* 해당 이미지 버튼박스 숨기기여부 체크 */

    init: function(editor, editorID) {
        this.$box = $("#ImageBox");
        this.$listBox = this.$box.find("ul");
        this.work = "";
        this.editor = editor;
        this.editorID = editorID;
        this.action = "/tourgramedit/html/EditorImageBoxOK.asp?num=<%=num%>";

        var oThis = this;
        var $frm = this.$box.find("form");

        this.$formItem = $frm.find("div.Box");

        var formOption = {
            beforeSubmit: function() {
                oThis.$formItem.eq(0).hide();
                oThis.$formItem.eq(1).show();
                oThis.insertOK = false;
                return true;
            },

            success: function(data) {
                oThis.result(data);
            },

            clearForm: true
        }

        $frm.submit(
            function() {
                $(this).ajaxSubmit(formOption);
                return false;
            }
        );

        this.getList()
    },

    result: function(resultCode) {
        var resultMsg = "";

        resultCode = parseInt(resultCode);
     //   alert(resultCode);
        this.$formItem.eq(0).show();
        this.$formItem.eq(1).hide();

        switch (resultCode) {
            case 1:
                this.insertOK = true;
                this.getList();
                return false;
                break;
            case 2:
                resultMsg = "이미지 파일만 저장할 수 있습니다.";
                break;
            default:
                resultMsg = "오류가 발생했습니다. 잠시 후 다시 시도해주세요.";
                break;
        }

        alert(resultMsg);
    },

    disabledForm: function(tag) {
        if (tag) {
            this.$formItem.eq(1).html("이미지 작업중");
            this.$formItem.eq(0).hide();
            this.$formItem.eq(1).show();
        }
        else {
            this.$formItem.eq(1).html("<img src=\"../images/ajax-loader.gif\" width=\"16\" height=\"16\" alt=\"Loading\" />&nbsp;&nbsp;파일을 서버에 저장중입니다.");
            this.$formItem.eq(0).show();
            this.$formItem.eq(1).hide();
        }
    },

    imageCounter: function() {
        var imgCount = this.$listBox.find("li").length;
        $("#ImageBoxStatus").find("strong").text(imgCount);
    },

    getList: function() {
        var oThis = this;

        $.ajax({
            beforeSend: function() {
                oThis.disabledForm(true);
                oThis.$listBox.addClass("Loading");
                oThis.$listBox.html("<img src=\"../Images/ajax-loader.gif\" width=\"16\" height=\"16\" alt=\"Loading\" />&nbsp;&nbsp;이미지목록을 작성중입니다.");
            },

            success: function(XMLHttpRequest) {
                oThis.disabledForm(false);
                oThis.prtList(XMLHttpRequest);
            },

            type: "GET",
            url: oThis.action,
            data: ""
        });
    },

    prtList: function(XMLHttpRequest) {
        if (!XMLHttpRequest) return false;
        var $items = $(XMLHttpRequest).find("file");

        if ($items.length > 0) {
            var $li, $img, oThis = this;
            this.$listBox.empty();
            this.$listBox.removeClass("Loading");

            $items.each(
                function(seq) {
                    $li = $(document.createElement("li"));
                    $img = $(document.createElement("img"));
                    $img.attr("idx", $(this).attr("idx"));
                    $img.attr("src", "/tourgramedit/Data/GoodsImageBox/" + $(this).text());
                    $img.attr("width", 575);
                    $img.attr("height", 344);
                    $img.attr("class", $(this).attr("width") + "|" + $(this).attr("height") + "|" + $(this).attr("size") + "|" + $(this).attr("date"));
                    $li.append($img);
                    oThis.$listBox.append($li);

                    //Event Binding
                    $img.bind("click", function() { oThis.insert(this); });
                    $img.bind("mouseenter", function() { $(this).parent().addClass("Focus"); oThis.showBtn(this); });
                    $img.bind("mouseleave", function() { $(this).parent().removeClass("Focus"); oThis.hideBtn(); });

                    if (oThis.insertOK) {
                        if (seq == 0) $img.trigger("click");
                    }
                }
            );
        }
        else {
            this.$listBox.html("저장된 이미지가 없습니다.");
        }

        this.imageCounter();
    },

    showBtn: function(el) {
        if (!el) return false;
        if (el.tagName.toUpperCase() != "IMG") return false;

        var pos = $(el).offset();
        var oThis = this;

        if (this.$box.find(".imageBoxBtn").length == 0) {
            var $btn = $("<div class=\"imageBoxBtn\" style=\"position:absolute; left:0; top:0; z-index:40;\"><img style=\"cursor:pointer;\" src=\"../images/btn_delCircle.gif\" alt=\"삭제\" /></div>");
            $btn.find("img").bind("click", function() { oThis.del(); });
            $btn.find("img").bind("mouseenter", function() { window.clearTimeout(oThis.notHideBtn); oThis.notHideBtn = null; });
            $btn.find("img").bind("mouseleave", function() { oThis.hideBtn(); });
            this.$box.append($btn);
        }

        if (this.notHideBtn) {
            window.clearTimeout(this.notHideBtn);
            this.notHideBtn = null;
        }

        this.$currentItem = $(el);
        this.$box.find(".imageBoxBtn").css({ "left": (pos.left + 563) + "px", "top": (pos.top - 10) + "px" });
        this.$box.find(".imageBoxBtn").show();
    },

    hideBtn: function() {
        if (!this.notHideBtn)
            this.notHideBtn = window.setTimeout("ImageBox.hideBtn()", 500);
        else
            this.$box.find(".imageBoxBtn").fadeOut();
    },

    insert: function(el) {
        if (!el) return false;
        if (el.tagName.toUpperCase() != "IMG") return false;

        insertHTML = "<p><img src=\"" + $(el).attr("src") + "\" alt=\"\" /></p>";

        if (this.editor) {
            this.editor.getById[this.editorID].exec("PASTE_HTML", [insertHTML]);
        }
    },

    del: function() {
        if (!this.$currentItem) return false;
        if (this.$currentItem.length == 0) return false;

        if (window.confirm("선택하신 항목을 삭제합니다. 계속하려면 확인을 중지하려면 취소를 누르세요.")) {
            this.$box.find(".imageBoxBtn").hide();

            var oThis = this;

            $.ajax({
                beforeSend: function() {
                    oThis.work = "D";
                },

                success: function(data) {
                    oThis.delResult(data);
                },

                error: function() {
                    alert("서버와 통신중 오류가 발생했습니다. 잠시후 다시 시도해주세요.");
                    oThis.work = "";
                },

                type: "POST",
                url: oThis.action,
                data: "ino=" + oThis.$currentItem.attr("idx")
            });
        }
    },

    delResult: function(resultCode) {
        var errMsg;
        resultCode = parseInt(resultCode);

        this.work = "";

        switch (resultCode) {
            case 1:
                this.$currentItem.parent().remove();
                this.$currentItem = null;
                this.imageCounter();
                return false;
                break;
            case 2:
                errMsg = "이미지정보를 찾을 수 없습니다.";
                break;
            default:
                errMsg = "오류가 발생했습니다.";
                break;
        }

        alert(errMsg);
    }
};
 </script>
 </body>
</html>