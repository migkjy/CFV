/* Common.js */

/*
ASP에서 Request.QueryString와 동일한 기능
--------------------------------------------
*/
var Request = {
    QueryString: function(paramName) {
        /// <summary>
        /// 현재 페이지의 QueryString을 리턴
        /// </summary>
        /// <param name="paramName" type="String">
        /// QueryString 이름
        /// </param>
        /// <returns type="String" />
        var returnValue = "";
        var currentAddr = unescape(location.href);
        var parameters = (currentAddr.slice(currentAddr.indexOf("?") + 1, currentAddr.length)).split("&");
        var paramValue;

        for (var i = 0; i < parameters.length; i++) {
            paramValue = parameters[i].split("=")[0];

            if (paramValue.toUpperCase() == paramName.toUpperCase()) {
                returnValue = parameters[i].split("=")[1];
                break;
            }
        }

        return returnValue;
    }
};

/*
특정문자열을 지정된 문자열로 변환
--------------------------------------
VBScript의 replace 내장함수와 동일
--------------------------------------
*/
function replace(string, text, by) {
    if (!string) return false;

    var strLength = string.length, txtLength = text.length;

    if ((strLength == 0) || (txtLength == 0)) {
        return string;
    }

    var i = string.indexOf(text);

    if ((!i) && (text != string.substring(0, txtLength))) {
        return string;
    }

    if (i == -1) {
        return string;
    }

    var newstr = string.substring(0, i) + by;

    if (i + txtLength < strLength) {
        newstr += replace(string.substring(i + txtLength, strLength), text, by);
    }

    return newstr;
}

/*
SQL Injection 방지용
*/
function clearInjection(s) {
    var checkStr = new Array("<", ">", "&", "\"", "'", "%", "!", ";");

    if (!s) return "";

    for (var i = 0; i < checkStr.length; i++) {
        s = replace(s, checkStr[i], "");
    }

    return s;
}

/*
요소의 절대값 위치 구하기 - IE전용
--------------------------------------------------------
TEXTAREA에 입력된 값의 제한바이트를 체크
만약 허용된 크기보다 작으면 true, 크면 false로 리턴
--------------------------------------------------------
*/
function getXY(el) {
    //el은 문서에 포함되어 있어야 하고, 화면에 보여야 함.
    if (el.parentNode == null || el.style.display == "none") {
        return false;
    }

    var parent = null;
    var pos = [];
    var box;

    pos = [el.offsetLeft, el.offsetTop];
    parent = el.offsetParent;

    //offsetLeft와 offsetTop을 최상위 offsetParent까지 반복적으로 더함
    if (parent != el) {
        while (parent) {
            pos[0] += parent.offsetLeft;
            pos[1] += parent.offsetTop;
            parent = parent.offsetParent;
        }
    }

    if (el.parentNode) {
        parent = el.parentNode;
    }
    else {
        parent = null;
    }

    //body또는 html이외의 부모 노드 중에 스크롤되어 있는 영역이 있다면 알맞게 처리
    while (parent && parent.tagName != "BODY" && parent.tagName != "HTML") {
        pos[0] -= parent.scrollLeft;
        pos[1] -= parent.scrollTop;

        if (parent.parentNode) {
            parent = parent.parentNode;
        }
        else {
            parent = null
        }
    }

    return { left: pos[0], top: pos[1] };
}


/*
컬러박스
*/
var PaletteBox = {
    $box: null,
    $target: null,

    createBox: function() {
        var colorString = "ff0000,ff6c00,ffaa00,ffef00,a6cf00,009e25,00b0a2,0075c8,3a32c3,7820b9,ef007c,000000,252525,464646,636363,7d7d7d,9a9a9a," +
            "ffe8e8,f7e2d2,f5eddc,f5f4e0,edf2c2,def7e5,d9eeec,c9e0f0,d6d4eb,e7dbed,f1e2ea,acacac,c2c2c2,cccccc,e1e1e1,ebebeb,ffffff," +
            "e97d81,e19b73,d1b274,cfcca2,cfcca2,61b977,53aea8,518fbb,6a65bb,9a54ce,e573ae,5a504b,767b86,00ffff,00ff00,a0f000,ffff00," +
            "951015,6e391a,785c25,5f5b25,4c511f,1c4827,0d514c,0d514c,2b285f,2b285f,721947,721947,721947,00aaff,0000ff,0000ff,ff00ff";

        var colorList = colorString.split(",");
        var $ul, $li, oThis = this;

        this.$box = $(document.createElement("div"));
        this.$box.attr("id", "PaletteBox");
        $("body").append(this.$box);

        $ul = $(document.createElement("ul"));
        this.$box.append($ul);

        for (var i = 0; i < colorList.length; i++) {
            $li = $(document.createElement("li"));
            $li.html("<button style=\"background-color:#" + colorList[i] + "\" title=\"#" + colorList[i] + "\" type=\"button\"></button>");
            $ul.append($li);
        }

        //event binding
        this.$box.find("button").each(
            function() {
                $(this).bind("click", function() { oThis.insert(this); });
            }
        );
    },

    open: function(el) {
        if (!el) return false;
        if (!this.$box) this.createBox();

        this.$target = $(el);

        //속성창 위치설정, 선택한 항목의 중간으로 표시
        var pos;

        //IE는 위치값 별도의 함수로 가져오기
        if ($.browser.msie)
            pos = getXY(el);
        else
            pos = $(el).offset();

        this.$box.css({ "left": pos.left, "top": pos.top });
        this.$box.show("fast");
    },

    insert: function(el) {
        if (!el) return false;

        var selectColor = $(el).attr("title");
        var $span = this.$target.prev();
        var $input = $span.prev();

        $span.css("color", selectColor);
        $input.val(selectColor);

        //호출창관련 이벤트 강제호출
        $input.trigger("blur");

        this.$box.hide("fast");
    }
};

/*
강조박스
*/
var HighlightBox = {
    $box: null,
    editor: null,
    editorID: null,

    init: function(editor, editorID) {
        this.$box = $("#HighlightBox");
        this.editor = editor;
        this.editorID = editorID;

        var oThis = this;

        //event binding
        this.$box.find("select").bind("change", function() { oThis.previewUpdate(); });
        this.$box.find("input").bind("blur", function() { oThis.previewUpdate(); });
    },

    open: function(el) {
        if (!el) return false;

        //속성창 위치설정, 선택한 항목의 중간으로 표시
        var pos;

        //IE는 위치값 별도의 함수로 가져오기
        if ($.browser.msie)
            pos = getXY(el);
        else
            pos = $(el).offset();

        var boxWidth = this.$box.width();
        var boxHeight = this.$box.height();

        pos.left = pos.left - ((boxWidth - $(el).width()) / 2);

        this.$box.css({ "left": pos.left, "top": pos.top, "height": 0 });
        this.$box.show().animate({ height: boxHeight, top: pos.top - boxHeight + 10 });
    },

    previewUpdate: function() {
        var $div = this.$box.find("div");
        var $inputs = this.$box.find("input");
        var borderWidth = this.$box.find("select option:selected").val() + "px";

        $div.css({ "borderWidth": borderWidth,
            "borderColor": $inputs.eq(0).val(),
            "color": $inputs.eq(1).val(),
            "backgroundColor": $inputs.eq(2).val()
        });
    },

    insert: function() {
        if (!this.editor) return false;

        var $inputs = this.$box.find("input");
        var borderWidth = this.$box.find("select option:selected").val();
        var selectHtml = this.editor.getById[this.editorID].getSelection().toHTMLString();
      

        if (selectHtml == "") selectHtml = "여기에 내용을 입력하세요";

        var insertHTML = "<div style=\"" +
            "width:90%; " +
            "height:auto;" +
            "margin:5px auto; " +
            "padding:10px; " +
            "border-style:solid; " +
            "border-width:" + borderWidth + "px; " +
            "border-color:" + $inputs.eq(0).val() + "; " +
            "color:" + $inputs.eq(1).val() + "; " +
            "background-color:" + $inputs.eq(2).val() + "\">" + selectHtml + "</div>";

        this.editor.getById[this.editorID].exec("PASTE_HTML", [insertHTML]);
        this.close();
    },

    close: function() {
        this.$box.fadeOut("slow");
    }
};
