
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
	alert("�������� �ʴ� �������Դϴ�.\n����������ȣ ����� ���, ���� �� ���� �����մϴ�.");
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
					alert("�˾��� ���ܵǾ� �ֽ��ϴ�!\r\n������ �������� �˾� ��� �� �ٽ� �۾��� �ּ���.")
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
			alert("�˾��� ���ܵǾ� �ֽ��ϴ�!\r\n������ �������� �˾� ��� �� �ٽ� �۾��� �ּ���.")
		
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
		alert("���������ʴ� OS App")
	}
}


function startProgress(){
}

function endProgress(){
}




