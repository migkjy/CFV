/****************************************************************************************************************/

(function($) {

 var jqueryeFfect = function(element, options){
   var settings = $.extend({}, $.fn.jqueryeffect.defaults, options); //초반 셋팅값 가져오기
     var vars = {
            currentSlide: 0,
            oldSlide: 0,
            currentImage: '',
			totalSlides: 0,
            randAnim: '',
            running: false,
            paused: false,
            stop: false
        };

       var slider = $(element);		

	   $("a",slider).css({opacity:0, 'z-index':'1'});
       $(".prev",slider).css({"margin-top": (slider.height() - $(".prev",slider).height())/2 + "px", 'z-index':'20'});
	   $(".next",slider).css({"margin-top": (slider.height() - $(".next",slider).height())/2 + "px","margin-left" : (slider.width() - $(".next",slider).width()) + "px" ,'z-index':'20'});
	   $(".num",slider).css({"margin-top": (slider.height() - ($(".num",slider).height() + 5)) + "px","margin-left" : (slider.width() - ($(".num",slider).width() + 5)) + "px" ,'z-index':'20'});
	   var slideroffset = slider.offset(); //메인div위치값 
	    slider.find('a').each(function() {
			vars.totalSlides++;
		});    
	        
 
					
      
			

    vars.currentSlide =Math.floor(Math.random() * vars.totalSlides);
    vars.oldSlide = vars.currentSlide;
	 $(".num",slider).html("<span class='curr'>" + (vars.currentSlide + 1) + "</span>/<span class='total'>" + vars.totalSlides + "</span>");      
	 //초기셋팅
    $("a",slider).eq(vars.currentSlide).css({opacity:1});

	 var timer = 0;
	  timer = setInterval(function(){ imgeffectRun(slider, settings, false); }, settings.pauseTime);




	var imgeffectRun = function(slider, settings, nudge){
            if(vars && (vars.currentSlide == vars.totalSlides - 1)){ 
				settings.lastSlide.call(this);
			}
            if((!vars || vars.stop) && !nudge) return false;
			settings.beforeChange.call(this);
			vars.currentSlide++;
			
			if(vars.currentSlide == vars.totalSlides){ 
				vars.currentSlide = 0;
				settings.slideshowEnd.call(this);
			}
			 $(".num",slider).html("<span class='curr'>" + (vars.currentSlide + 1) + "</span>/<span class='total'>" + vars.totalSlides + "</span>");  	
			//돌아온값이 0일때 결정
			if(vars.currentSlide < 0) vars.currentSlide = (vars.totalSlides - 1);
			$("a",slider).eq(vars.oldSlide).animate({opacity : 0, "z-index" : 1}, settings.animSpeed);	
		    $("a",slider).eq(vars.currentSlide).animate({opacity : 1, "z-index" : 10}, settings.animSpeed);	
		 

		 vars.oldSlide = vars.currentSlide;

	}


   //오버설정
slider.hover(function(){
                vars.paused = true;
                clearInterval(timer);
                timer = '';              
				$(".prev", slider).animate({opacity : 1}, 340);
			    $(".next", slider).animate({opacity : 1}, 340);
				$(".num", slider).animate({opacity : 1}, 340);
            }, function(){
                vars.paused = false;
				$(".prev", slider).animate({opacity : 1}, 340);
			    $(".next", slider).animate({opacity : 1}, 340);
				$(".num", slider).animate({opacity : 1}, 340);         
				if(timer == '' && !settings.manualAdvance){
					timer = setInterval(function(){   imgeffectRun(slider,  settings, false);	}, settings.pauseTime);

				}
            });
	
   $(".prev", slider).click(function(){
		vars.currentSlide = vars.currentSlide -2;
        imgeffectRun(slider,  settings, false);
   });
   $(".next", slider).click(function(){
	      imgeffectRun(slider,  settings, false);
   });
   settings.afterLoad.call(this);
	return this;
	 };


  
 $.fn.jqueryeffect = function(options) {
    //데이터 로딩셋팅
        return this.each(function(key, value){
            var element = $(this);
			
			 jqueryeFfect($(element), options);
        });

	};

//Default settings
	$.fn.jqueryeffect.defaults = {
		animSpeed: 1000, //이벤트 속도
		fadeSpeed: 3000, //페이드 속도
		pauseTime: 4000, //대기시간
		startSlide: 0,
		titOverColor:"#e71818",   //타이틀가로
		titOutColor:"#fdf9f0",
		titletop : 5,   //타이틀높이
		pauseOnHover: true,
		beforeChange: function(){},
		afterChange: function(){},
		slideshowEnd: function(){},
        lastSlide: function(){},
        afterLoad: function(){}
	};
	
	$.fn._reverse = [].reverse;

})(jQuery);

