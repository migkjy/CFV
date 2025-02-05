
function isSupportStorage() {
	try {
			sessionStorage.setItem("INPRIVATE", "CHECK");
			sessionStorage.removeItem("INPRIVATE");
			return true;
	} catch (exception) {
		return false;
	}
}

function announceStorageWarning() {
	alert("지원하지 않는 브라우저입니다.\n개인정보보호 모드일 경우, 해제 후 접속 가능합니다.");
	setTimeout(function() {
		if (location.pathname != "/") {
			location.href="/";
		}
	}, 2000);
}

$(document).ready(function() {
	setLink();
});

function setLink() {
	$("a[link='simple']").unbind("click").click(function(event) {
	
		if (!isSupportStorage()) {
			announceStorageWarning();
			return;
		}
		


		if ($(this).attr("external")!="Y") {
			location.href = $(this).attr("url");
		} else {
			if (isApp=="Y")	{
				if (isIos=="Y")	{
					document.location = "movePage?" + $(this).attr("url");
				} else if (isAndroid=="Y") {
					window.htmlEventHandler.movePage($(this).attr("url"));
				} else {
					window.open($(this).attr("url"));
				}
			} else {
				var browser = window.open($(this).attr("url"));
				if(!browser)
					alert("팝업이 차단되어 있습니다!\r\n브라우저 설정에서 팝업 허용 후 다시 작업해 주세요.")
			}
		}
	});

}

function anchorExternal(url, name) {
	if (isApp=="Y")	{
		if (isIos=="Y")	{
			document.location = "movePage?" + url;
		} else if (isAndroid=="Y") {
			window.htmlEventHandler.movePage(url);
		} else {
			window.open(url);
		}
	} else {
		if (name!=undefined) {	
			var browser = window.open(url, name);
		} else {
			var browser = window.open(url);
		}
		if(!browser)
			alert("팝업이 차단되어 있습니다!\r\n브라우저 설정에서 팝업 허용 후 다시 작업해 주세요.")
		
	}
}

function banner(url){
	if (isIos=="Y")	{
		document.location = "movePage?" + url;
		event.preventDefault();
		return;
	} else if (isAndroid=="Y") {
		window.htmlEventHandler.movePage(url);
		event.preventDefault();
		return;
	} else {
		alert("지원하지않는 OS App")
	}
}


function startProgress(){
}

function endProgress(){
}




