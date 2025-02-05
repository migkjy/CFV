(function($) {
	
	var m2Selects = [];
	$.fn.m2Select = function(options) {
		return this.each(function() {
			m2Selects.push(new $ss(this, options));
		});
	};
	var defaults = {
			skin	:	"<li><div class='posRight'><a href='#' class='btnTypeSb'>검색</a></div></li>" 
	};
	$.m2Select = function(obj, options) {
		this.select = $(obj);
		this.settings = $.extend({}, defaults,  options || {});
		this.setup();
	};
	
	// Shortcut
	var $ss = $.m2Select;	
	$ss.fn = $ss.prototype = {};	
	$ss.fn.extend = $.extend;
	$ss.fn.extend({
		setup : function(){
			this.title();
			this.list();
			this.Event();
			this.addkeyEvent();
		},
		title : function(){
			var self = this;
				//self.select.css({'opacity' : 0});
				self.select.hide();
				$(".selectList[nNum='" + self.select.attr("nNum") + "']").remove();
				var	nNum = 1+Math.floor( Math.random()*10000000000000000000000 );
				self.select.attr("nNum", nNum);		
				var selectTitle = $("option[selected='selected']",self.select).text()?$("option[selected='selected']",self.select).text():$("option:first",self.select).text();
				self.select.after('<div class="selectList" nNum="' + nNum + '"><a class="' + self.select.attr("class") + '" >' + selectTitle + '</a><ul nNum="' + nNum + '" style="width:' + (self.select.width())+ 'px"></ul></div>');
			
		},
		list : function(){
			var self = this;
			$("option", self.select).each(function() {
				$(".selectList>ul[nNum='" + self.select.attr("nNum") + "']").append("<li ><a href='#' val='" + $(this).val() + "'>" + $(this).text() + "</a></li>");
			});
			
		},
		addkeyEvent : function(){
			var self = this;
			if(self.select.attr("addKey") == "true"){
				$(".selectList[nNum='" + self.select.attr("nNum") + "']>ul").append(self.settings.skin);			
			}			
		},
		Event : function(){
			var self = this;
			$(".selectList>a", self.select.parent()).on("click", function(e){
				var pos = $(".selectList[nNum='" + self.select.attr("nNum") + "']").position();
				if((pos.top + $(".selectList[nNum='" + self.select.attr("nNum") + "']>ul").height()) > ($(window).height() + $(window).scrollTop())){
					$(this).parent().find("ul").css({'margin-top':  -(($(".selectList[nNum='" + self.select.attr("nNum") + "']>ul").height() + $(".selectList[nNum='" + self.select.attr("nNum") + "']").height())) +'px'})
				}
				$(this).parent().find("ul").show()
				$(this).addClass("active");
			});
			$(".selectList", self.select.parent()).on("mouseleave", function(e){
				$(this).parent().find("ul").delay(2000).hide();
				$(this).parent().find("a:first").removeClass("active");
			});
			$(".selectList>ul>li>a", self.select.parent()).on("click", function(e){
				$(this).parent().parent().parent().find("a:first").html($(this).html()).removeClass("active");
				$(this).parent().parent().parent().find("ul").delay(2000).hide();
				$("option",self.select).attr("selected", false);
				$("option[value='" + $(this).attr("val") + "']",self.select).attr("selected", true);
				self.select.change();
			});
		}
	});
		
})(jQuery);

$(document).on("ready", function(){
	//$(".btnSelectTean2").m2Select();
});