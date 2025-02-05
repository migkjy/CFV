
var GnbNav={		
	$header_navigation_wrap: null,
	$header_navi: null,
	$int_header_navi_length: null,

	Init: function() {
		//초기화 var oThis = this;
		var oThis = this;		
	
		oThis.$header_navigation_wrap = $("div.header_navigation_wrap");	
		oThis.$header_navi = oThis.$header_navigation_wrap.find("ul.header_navi");		
		
		//메뉴 위치 변경
		oThis.setMenuNav();

		//서브메뉴
		oThis.menulSlideEvent();

	},
		
	setMenuNav: function() {
		var oThis = this;			
		var int_normal_menu_height = 60;
		var int_over_menu_height = 60;
		var int_navi_length = oThis.$header_navi.find("li.header_navi_cate").length;
		var topHeaderHeight = BannerTop.$top_banner_wrap.height() + Header.$header_wrap.height();
				
		if ( $(document).scrollTop() <= topHeaderHeight ){			

			oThis.$header_navigation_wrap.css({'top': ( topHeaderHeight - ($(document).scrollTop()+oThis.$header_navi.height()) ) +'px', 'opacity': 1, 'height': int_normal_menu_height +'px', 'line-height': int_normal_menu_height +'px'});			
			oThis.$header_navi.css({'height': int_normal_menu_height +'px', 'line-height': int_normal_menu_height +'px'});
			oThis.$header_navi.css({'width': '1350px'});

			oThis.$header_navi.find("li.header_navi_cate").css({'height': int_normal_menu_height +'px', 'line-height': int_normal_menu_height +'px'});
			oThis.$header_navi.find("li.header_navi_cate").find("a:first").css({'height': int_normal_menu_height +'px', 'line-height': int_normal_menu_height +'px'});
			oThis.$header_navi.find("li.header_navi_cate, li.header_navi_cate a, li.header_navi_cate ul").css({'width': ((oThis.$header_navi.width() - (int_navi_length + 1)) / int_navi_length) +'px'});			
			oThis.$header_navi.find("li.header_navi_cate").find("ul").css({'top': int_normal_menu_height +'px'});				
	
		}else{					

			oThis.$header_navigation_wrap.css({'top': 0, 'opacity': 0.9, 'height': int_over_menu_height +'px', 'line-height': int_over_menu_height +'px'});			
			oThis.$header_navi.css({'height': int_over_menu_height +'px', 'line-height': int_over_menu_height +'px'});
			oThis.$header_navi.css({'width': '1350px'});			

			oThis.$header_navi.find("li.header_navi_cate").css({'height': int_over_menu_height +'px', 'line-height': int_over_menu_height +'px'});
			oThis.$header_navi.find("li.header_navi_cate").find("a:first").css({'height': int_over_menu_height +'px', 'line-height': int_over_menu_height +'px'});
			oThis.$header_navi.find("li.header_navi_cate, li.header_navi_cate a, li.header_navi_cate ul").css({'width': ((oThis.$header_navi.width() - (int_navi_length + 1)) / int_navi_length) +'px'});			
			oThis.$header_navi.find("li.header_navi_cate").find("ul").css({'top': int_over_menu_height +'px'});		
			
		}

	},

	menulSlideEvent: function() {		
		var oThis = this;	

		$('.header_navi li').bind({
			'mouseover focusin':function(){
				var intSubMenuCnt = $(this).children('ul').children('li').length;
				var intSubMenuHeight = (intSubMenuCnt * 36) + 0;

				$(this).children('ul').stop().animate({height: intSubMenuHeight +"px"},300);
			},'mouseout focusout':function(){
				$(this).children('ul').stop().animate({height: "0"},100);
			}
		});
	},

}

$(window).scroll(function(){
	GnbNav.setMenuNav();	
});
