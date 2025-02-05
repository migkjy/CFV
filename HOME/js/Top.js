var BannerTop = {
	$top_banner_wrap: null,	

	Init: function() {
		//초기화
		var oThis = this;
		
		oThis.$top_banner_wrap = $("div.top_banner_wrap");

		oThis.$top_banner_wrap.find(".btn_top_banner_close").bind("click", function(){ oThis.close(); });
	},

	close: function() {
		var oThis = this;
		var int_reset_menu_pos = null;
		var int_reset_banner_right_pos = null;

		//top banner 숨김
		oThis.$top_banner_wrap.stop().animate({'height': '0'}, 1000);
		oThis.$top_banner_wrap.find("div.top_banner").stop().animate({'height': '0'}, 1000);
		
	}
}

$(document).ready(function(){
		BannerTop.Init();
});

var Header={	
	$header_wrap: null,

	Init: function() {
		//초기화
		var oThis = this;		

		oThis.$header_wrap = $("div.header_wrap");


		GnbNav.Init();		
	},

}

$(document).ready(function() {
	Header.Init();
});	