
	    $(document).ready(function(){
		    /* 추천여행 */
		    $(".gridL.sliderkit.carousel-demo2").sliderkit({
		        auto:false,
		        shownavitems:4,
		        scroll:1,
		        mousewheel:false,
		        circular:false,
		        start:3
		    });

	    });

	    $(document).ready(function(){
		/* ############################################################################################ */
		/* 메인 슬라이드 */
		/* ############################################################################################ */
		    var film_roll = new FilmRoll({
		    configure_load : true ,
		    container      : '#film_roll' ,
		    height         : 645 ,
		    interval       : 5000 ,
		    pager          : false,
		    prev           : '.slide_prev',
		    next           : '.slide_next'

		});
		
		$(".controlbox > .control > ul > li:eq(1)").addClass("bgNone");
    
		$('#film_roll').on('film_roll:moving', function(event) {
		    $(".controlbox > .control > ul > li").removeClass("on");
		    $(".controlbox > .control > ul > li:eq("+film_roll.index+")").addClass("on");

		    // 인근 배경 컨트롤
		    $(".controlbox > .control > ul > li").removeClass("bgNone");
		    $(".controlbox > .control > ul > li").eq( film_roll.index + 1 ).addClass("bgNone");
		});
    
		$(".controlbox > .control > ul > li").each(function(){
		    var tab_index = $(this).index();
    
		    $(this).click(function() {
		        $(".controlbox > .control > ul > li").removeClass("on");
		        $(this).addClass("on");
		        film_roll.moveToIndex(tab_index);
    
		        // 인근 배경 컨트롤
		        $(".controlbox > .control > ul > li").removeClass("bgNone");
		        $(".controlbox > .control > ul > li").eq( tab_index + 1 ).addClass("bgNone");
    
		        return false;
		    })
		});
		$(".controlbox > .control > ul > li:first-child").addClass("on"); //버튼 on 초기화
		});

		$(document).ready(function(){
	    	
    
	    /* 추천여행 */
	    $(".gridL.sliderkit.carousel-demo2").sliderkit({
	        auto:true,
	        autospeed:3000,
	        shownavitems:4,
	        scroll:1,
	        mousewheel:false,
	        circular:true,
	        start:3
	    });    	
	    });
