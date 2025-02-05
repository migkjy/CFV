/**
 * @author : Jo Yun Ki (ddoeng@naver.com)
 * @version : 2.0.1
 * @since : 2015.11.03
 *
 * history
 * 
 * 1.0   (2015.11.03) : 
 * 2.0   (2016.05.23) : 모바일 메인 개편에 의한 수정 적용
 * 2.0.1 (2016.08.04) : openLoadPop(options) 에서 options 인자를 openSlidePop() 과 closeSlidePop() 에 두번째 인자로 전달하도록 수정
 *  
 */

(function (scope) {
    if (scope.DOTCOM !== undefined) return;



    //#overlayPanel 이 transform 클래스인 slideUp, slideDown 을 물고 있음 (아래서 위로 올라오는 팝업.. 항공, DOTCOM.openLoadPop 에서 사용)
    var DOTCOM = {
        //DOTCOM.setMask() flag 를 이용해 토글 하고, pop 이 #overlayPanel이 아니면 body .ui-page 안에 딤(#mask .mask) 추가
        //flag:Boolean - 딤 적용 유무
        //pop:Object - 인자로 넘기는 이유는 pop 안에 .innerScroller 를 컨트롤 스크롤로 지정 하기위함.. flag가 false 이거나 innerScroller 컨트롤 안할거면 필요 없음
        setMask : function (flag, pop) {
            if (flag) {
                if(pop !== '#overlayPanel'){
                    $('body .ui-page').append('<div id="mask" class="mask"></div>');

                    if (pop !== undefined) WDDO.setDisableEvent(pop.find('.innerScroller'));
                }
            } else {
                $('#mask').remove();

                WDDO.setEnableEvent($('body'));
            }
        },

        openLoadPop : function (options) {
            var pop,
                source,
                defaults = getDefaultOption(),
                opts = $.extend({}, defaults, options);



            function initEvent() {
                //팝업 내부 닫기버튼
                pop.on('click', '.closeOverlayPanel', function (e) {
                    var target = $(e.currentTarget);

                    if (opts.effect === 'slide') DOTCOM.closeSlidePop(pop, opts); //modify 2.0.1

                    pop.trigger('close.loadpop', opts); // $('body').on('open.loadpop', '#overlayPanel', function (e, data) { console.log(data); });
                });
            }

            function load() {
                $.ajax({
                    type: "GET",
                    url: opts.url,
                    dataType: "text",
                    success: function(data){
                        //console.log('success : ' + data);
                        source = data;

                        open();
                    },
                    error: function(xhr, option, error){
                        //console.log('xhr : ' + xhr + ', option : ' + option + ', error : ' + error);
                    }
                });
            }

            // html string 중에서 <script></script> 를 모두 제거
            function removeScriptTagFromHtmlStr(strHtml) {
                var scriptIdx = strHtml.indexOf('<script');
                while(scriptIdx > -1 ){
                    if( scriptIdx == 0 ){
                        strHtml = strHtml.substring(strHtml.indexOf('\</script\>') + 9);
                    }else{
                        strHtml = strHtml.substring(0,scriptIdx) + strHtml.substring(strHtml.indexOf('\</script\>') + 9);
                    }
                    scriptIdx = strHtml.indexOf('<script');
                }  
                return strHtml;
            }
        }
    };

    scope.DOTCOM = DOTCOM;
})(window);

/**
* Static variables for Mobile
*
* @author : Jo Yun Ki (ddoeng@naver.com)
* @version : 1.1.1
* @since : 2015.12.01
*
* history
*   1.1 (2015.12.16) : docWidht, docHeight 속성 추가 
*   1.1.1 (2016.02.12) : enableTouchEvent, disableTouchEvent 을 setEnableEvent, setDisableEvent 로 변경
*/

(function (scope) {
    if (scope.WDDO !== undefined) return;

    var WDDO = {
        browserWidth : 0,
        browserHeight : 0,
        docWidht : 0,
        docHeight : 0,
        scrollYpos : undefined,

        setEnableEvent : function (bt) {
            var backgroundTarget = (bt === undefined) ? $('body') : bt;

            //스크롤링 활성화
            if (backgroundTarget.data('overflowY') !== undefined) {
                backgroundTarget.css({
                    'overflow-y' : backgroundTarget.data('overflowY')
                }).removeData('overflowY');
            }

            //터치이벤트 한계체크 삭제
            backgroundTarget.off('touchstart.WDDO touchmove.WDDO');
        },

        setDisableEvent : function (st, bt) {
            var startY = 0;
            var scrollTarget;
            var backgroundTarget = (bt === undefined) ? $('body') : bt;

            //스크롤링 비활성화
            if (backgroundTarget.css('overflow-y') === 'hidden') return;

            backgroundTarget.data({
                'overflowY' : backgroundTarget.css('overflow-y')
            }).css({
                'overflow-y' : 'hidden'
            });

            //터치이벤트 한계체크
            backgroundTarget.on('touchstart.WDDO', function (e) {
                var touch = e.originalEvent.touches[0] || e.originalEvent.changedTouches[0];
                var target = $(e.target);
                var flag = (target.closest(st).length > 0);

                startY = touch.pageY;
                scrollTarget = (flag) ? $(st) : undefined;
            });

            backgroundTarget.on('touchmove.WDDO', function (e) {
                if (scrollTarget !== undefined) {
                    var touch = e.originalEvent.touches[0] || e.originalEvent.changedTouches[0];

                    var distance = touch.pageY - startY;    //이동거리
                    var max = maxScrollPos(scrollTarget);   //이동가능한 총 거리
                    var currentPos = getScrollPositions(scrollTarget); //현재 위치

                    //console.log(distance, currentPos, max);
                    if (distance > 0 && currentPos <= 0 ) {
                        //console.log('over up');

                        if (e.cancelable) e.preventDefault();
                    } else if (distance < 0 && max <= 0) {
                        //console.log('over down');

                        if (e.cancelable) e.preventDefault();
                    } else {

                    }
                } else {
                    if (e.cancelable) e.preventDefault();   
                }
            });

            function getScrollMax (target) {
                return target.prop('scrollHeight') - target.prop('clientHeight');
            }

            function getScrollPositions (target) {
                return target.scrollTop();
            }

            function maxScrollPos(target) {
                var target = typeof target == 'object' ? target : $(target);
                var max = getScrollMax(target);
                var pos = getScrollPositions(target);
                return max - pos;
            }
        }
    };

    scope.WDDO = WDDO;
})(window);

$(document).ready(function () {
    //공통 스와이프
    initSwiper();

    //공통 Event
    initEvent();

    //공통 UI
    initHeader();
    initLnb();
    initTopBtn();

    //컨텐츠 Script
    initSearch();   //통합검색 - 구버전 메뉴 포함

    //공통 기본형 swiper
    function initSwiper() {
        $('.global-swiper').each(function (idx) {
            var swiper = new Swiper($(this), {
                pagination: $(this).find('.swiper-pagination'),
                loop: (($(this).find('.swiper-slide').length > 1) ? true : false),
                preloadImages: false,
                lazyLoadingInPrevNext: true,
                lazyLoading: true
            });
        });
    }

    //이벤트 초기화
    function initEvent() {
        try {
            $(document).on('scroll.dotcom', function (e) {
                try {
                    WDDO.scrollYpos = (document.documentElement.scrollTop !== 0) ? document.documentElement.scrollTop : document.body.scrollTop;
                } catch (e) {}
            }).triggerHandler('scroll.dotcom');

            $(window).on('resize.dotcom', function (e) {
                if (WDDO.browserWidth === $(window).width() && WDDO.browserHeight === $(window).width()) return false;
                WDDO.browserWidth = $(window).width();
                WDDO.browserHeight = $(window).height();

                resize();
            }).triggerHandler('resize.dotcom');

            $('.scrollTop').on('click.dotcom', function (e) {
                $(window).scrollTop(0);
            });

        } catch (e) {}
    }
    
    //해더 GNB 영역
    function initHeader() {
         //common.js 와 중복 방지 //common.js 에서 사용한 innerScroller 변수가 있고 #gnb 에 siwper-continer 클래스가 없으면 구버전으로 간주하여 아래 로직 사용 안함
        if (typeof innerScroller !== 'undefined' && ($('#gnb').length > 0 && !$('#gnb').hasClass('swiper-container'))) return;

        //기존 버튼 액션 삭제
        $('#btnMenu').off('click');
        $('#btnMyhome').off('click');

        var oldTotalMenu = $('#menuPanel'); //신규 개편 토탈메뉴
        var TotalMenu = $('#menuPanel02');  //이전 구버전 토탈메뉴
        var contentWrapper = $('#wrap');    //컨텐츠 전체 컨테이너



        //전체메뉴 열기
        $('#btnMenu').on('click.dotcom', function (e) {
            //신규 전체메뉴
            if (TotalMenu.length > 0) {
                TotalMenu.find('.innerScroller').scrollTop(0); //스크롤 상단으로 초기화
                TotalMenu.css('display', 'block');

                setTimeout(function () {
                    TotalMenu.addClass('open');
                }, 5);
                contentWrapper.addClass('slideLeft'); //뒤 컨텐츠 밀림
            } else {
            //구버전
                oldTotalMenu.addClass('slideIn'); //메뉴 등장
                contentWrapper.addClass('slideLeft'); //뒤 컨텐츠 밀림
            }

            DOTCOM.setMask(true, TotalMenu); //마스킹
            
            //닫기
            $('#mask, .closeSlide').one('click.dotcom', function (e) {
                //신규 전체메뉴
                if (TotalMenu.length > 0) {
                    TotalMenu.removeClass('open');
                    contentWrapper.removeClass('slideLeft'); //뒤 컨텐츠 밀림 돌아오기
                } else {
                //구버전
                    oldTotalMenu.removeClass('slideIn'); //메뉴 복귀
                    contentWrapper.removeClass('slideLeft'); //뒤 컨텐츠 밀림 돌아오기
                }

                DOTCOM.setMask(false);

                e.preventDefault();
            });

            e.preventDefault();
        });

        //닫히는 모션 끝나면 숨기기
        TotalMenu.on('transitionend webkitTransitionEnd', function (e) {
            if (!TotalMenu.hasClass('open')) {
                TotalMenu.css('display', 'none');
            }
        });

        function matrixToArray(str){
            return str.split( '(')[ 1].split( ')')[ 0].split( ',') ;
        };


    }

    //로케이션 네비게이션 바
    function initLnb() {
        var swiper = new Swiper('#gnb', {
            slidesPerView: 'auto',
            simulateTouch: false,
            spaceBetween: 0,
            freeMode: true,
            /*resistanceRatio: 0,*/
            wrapperClass: 'gnb-wrapper',
            slideClass: 'gnb-slide',
            onInit: function () {
                $('#gnb').addClass('nextShadow');
            },
            onProgress: function (data, progress) {
                if (progress <= 0) {
                    $('#gnb').removeClass('prevShadow').addClass('nextShadow');
                } else if (progress >= 1) {
                    $('#gnb').removeClass('nextShadow').addClass('prevShadow');
                } else {
                    $('#gnb').addClass('nextShadow prevShadow');
                }
            }
        });

        $('#gnb').on('click', '> ul > li > a', function (e) {
            var target = $(e.currentTarget);
            var idx = target.parent().index();

            $('#gnb').changeAct(idx);

            e.preventDefault();
        });

        //활성화 변경 jQuery 확장
        if ($.fn.changeAct === undefined) {
            $.fn.changeAct = function (idx) {
                if (this.is('nav#gnb')) {
                    this.find('> ul > li').removeClass('on').eq(idx).addClass('on');

                    if (this.hasClass('swiper-container')) {
                        var swiper = this[0].swiper; //인스턴트 반환

                        swiper.slideTo(Math.max(idx - 1, 0)); //왼쪽에 그림자 때문에 첫번째로 이동하면 가리므로 활성화 idx -1 로 slideTo()
                    }
                }
            };
        }
    }

    //홈, 패키지, 국내여행 - 오른 하단 플로팅메뉴 탑버튼
    function initTopBtn() {
        var topBtn = $('#topBtn01');
        var quickObj = $('.quickDimBox');

        if (topBtn.length === 0) return;
        
        var footer = $('.newFoot');
		if (footer.height() == null) {
			footer  = $("#copyrightArea");
		}

        var fHeight = footer.height();
        var topBtnAreaHeight = /*topBtn.height()*/47 + parseInt(topBtn.css('bottom'));

        $(window).on('scroll.topbtn', function(e) {
            $(window).trigger('scroll.dotcom');

            var st = WDDO.scrollYpos;
            var scrollPosition = $(window).height() + st;

            //브라우저 높이 + 스크롤위치 > 하단 영역 + 동동이상단부터 여백높이
            if (st <= 0 || WDDO.browserHeight + st > footer.offset().top + topBtnAreaHeight) {
                topBtn.removeClass('on');
                quickObj.removeClass("topPosi");
            } else {
                topBtn.addClass('on');
                quickObj.addClass("topPosi");
            }
        });
    }

    //컨텐츠 : 검색
    function initSearch() {



        //통합검색 카테고리 탭
        var totalSearchCategoryTab = new WTab();
        totalSearchCategoryTab.init({target: $('.categoryBox > ul.cateTab > li > a'), onTag: 'li', onlyOpen: false, onChange: function (obj) {
            var idx = obj.idx;
            var ul = $('.categoryBox > ul.cateTab');
            var li = ul.find('> li');
            var content = ul.nextAll('div');

            li.not(':eq(' + idx + ')').removeClass('on');

            var isOpen = (li.filter('.on').length > 0);

            if (isOpen) {
                ul.addClass('open');
                content.hide().eq(idx).show();
            } else {
                ul.removeClass('open');
                content.hide();
            }
        }});
    }

    // 리사이즈
    function resize(){
        // 좌우측 메뉴 Resize
        $('#menuPanel .innerScroller').css('height', WDDO.browserHeight);
        $('#userPanel .innerScroller').css('height', WDDO.browserHeight);

        //$('#menuPanel02').css('transform' , 'translateX(' + (($('.mask').length > 0) ? 100 : 0) + '%)' );
    }
});

/********************************************************************************************/
/****************************************** Method ******************************************/
/********************************************************************************************/

/*!
 * @author : Jo Yun Ki (ddoeng@naver.com)
 * @version : 2.0
 * @since : 2015.11.09
 *
 * history
 *
 * 1.2   (2015.12.10) : setNext(), setPrev(), opts.onClass 추가 
 * 1.2.1 (2015.12.11) : getOptions() 추가
 * 1.3   (2016.04.18) : opts.onlyOpen = true 기본값 고정, otps.contentSelector 추가
 * 2.0   (2016.05.16) : init()시 opts.selector 가 없어도 초기화 될수 있도록 수정
 *
 ********************************************************************************************
 ******************************************* WTab *******************************************
 ********************************************************************************************
 *
 * var instance = new WTab();
 * instance.init(options);                   //초기화
 *
 * @param options    ::: 설정 Object 값
 *
 * options
 *   target:Object = $('selector')           //텝 메뉴 버튼 jQuery Object
 *   selector:String = 'li > a'              //on() 두번째 인자의 셀렉터
 *   onTag:String = 'li'                     //on 클래스를 적용 할 태그 셀렉션 String
 *   onClass:String = 'on'                   //on 클래스 명
 *   onlyOpen:Boolean = true                 //비 중복 활성화 유무
 *   content:Object = $('selector')          //적용할 컨텐츠 jQuery Object
 *   contentSelector:String = ''             //content 에 대한 세부 셀렉터
 *   onChange:Function = fun(event)          //텝 변경 콜백함수
 *   onChangeParams:Array = []               //텝 변경 콜백함수 인자
 *   behavior:Boolean = false                //기본 비헤이비어 삭제 유무, 기본은 막음
 *
 * method
 *   .setCloseAll()                          //모두 닫기
 *   .setOpen(idx)                           //열기
 *   .setCallback(change, param)             //콜백 설정
 *   .setNext()                              //다음
 *   .setPrev()                              //이전
 *   .getOptions()                           //옵션객체 반환
 */
var WTab = (function ($) {
    var wddoObj = function (options) {
        var scope,
            content,
            opts,
            defaults = getDefaultOption(),
            init = function (options) {
                opts = $.extend(defaults, options);

                if (opts.target.length > 0 && opts.target.data('scope') === undefined) {
                    if (opts.target.data('scope') === undefined) opts.target.data('scope', scope);

                    initLayout();
                    initEvent();
                }
            };

        function getDefaultOption() {
            return {
                target : $($.fn),
                selector : '',
                onTag : 'li',
                onClass : 'on',
                onlyOpen : true,
                behavior : false,
                content : $($.fn),
                contentSelector : '',
                onChange : undefined,
                onChangeParams : []
            };
        }
         
        function initLayout() {

        }

        function initEvent() {
            if (opts.selector === '') {
                opts.target.on('click.toggle', btnListener);    
            } else {
                opts.target.on('click.toggle', opts.selector, btnListener);
            }
            
            function btnListener(e) {
                var target = $(e.currentTarget);

                addIdx();

                content = getSelector(opts.content, opts.contentSelector); //add 1.3

                //버튼의 고유 idx 를 얻어 content 갯수가 많으면 해당 content.eq(idx) 로 찾기 위함
                var idx = parseInt(target.data('toggle-idx'));

                //opts.onTag 가 'a' 이면 target 이 활성화 태그이고 아니면 부모중 지정한 opts.onTag 찾아 교체
                var onTag = (opts.onTag === 'a') ? target : target.closest(opts.onTag);

                //console.log("onTag.hasClass('on')" , onTag.hasClass('on'));
                //console.log("opts.onlyOpen" , opts.onlyOpen);
                if (onTag.hasClass(opts.onClass)) {
                    //열려있는 것 클릭 시 
                    if (opts.onlyOpen) {
                        //하나만 활성화, 닫지 않음

                    } else {
                        //동시 활성화, 닫음 
                        btnOff(idx);
                        close(idx);
                    }
                } else {
                    //닫혀있는 것 클릭 시 
                    if (opts.onlyOpen) {
                        //하나만 활성화, 열려있는 것 모두 닫고 열기
                        btnOff();
                        close();
                        btnOn(idx);
                        open(idx);
                    } else {
                        //동시 활성화, 열려있는 것 유지
                        btnOn(idx);
                        open(idx)
                    }
                }

                if (opts.onChange !== undefined) opts.onChange.apply(this, [{target: target, idx: idx, content: content.eq(idx), params: opts.onChangeParams}]);
                opts.target.trigger('change.toggle', [{target: target, idx: idx, content: content.eq(idx), params: opts.onChangeParams}]);

                if (!opts.behavior) {
                    e.preventDefault();
                    e.stopPropagation();    
                }
            }
        }

        //어려 다른 형제 태그와 섞여 있어도 고유의 idx 지정
        function addIdx() {
            getSelector(opts.target, opts.selector).each(function (idx) {
                $(this).data('toggle-idx', idx);
            });
        }

        //selector 가 없으면 target 그대로 반환 
        function getSelector(target, selector) {
            return (selector !== '' && selector !== undefined) ? target.find(selector) : target;
        }

        //버튼 활성화
        function btnOn(idx) {
            var target = (idx === undefined) ? getSelector(opts.target, opts.selector) : getSelector(opts.target, opts.selector).eq(idx);
            var onTag = (opts.onTag === 'a') ? target : target.closest(opts.onTag);

            onTag.addClass(opts.onClass);
        }

        //버튼 비활성화
        function btnOff(idx) {
            var target = (idx === undefined) ? getSelector(opts.target, opts.selector) : getSelector(opts.target, opts.selector).eq(idx);
            var onTag = (opts.onTag === 'a') ? target : target.closest(opts.onTag);

            onTag.removeClass(opts.onClass);
        }
        
        //컨텐츠 열기
        function open(idx) {
            var target = (idx === undefined) ? getSelector(opts.content, opts.contentSelector) : getSelector(opts.content, opts.contentSelector).eq(idx);

            target.show();
        }

        //컨텐츠 닫기
        function close(idx) {
            var target = (idx === undefined) ? getSelector(opts.content, opts.contentSelector) : getSelector(opts.content, opts.contentSelector).eq(idx);
            
            target.hide();
        }

        //idx를 증감 한계치 안으로 반환
        function checkIdx(idx) {
            return Math.max(Math.min(idx, getSelector(opts.target, opts.selector).length - 1), 0);
        }
        
        return {
            init: function (options) {
                scope = this;

                init(options);
            },

            setCloseAll: function () {
                btnOff();
                close();
            },

            setOpen: function (idx) {
                btnOn(idx);
                open(idx);
            },

            setCallback: function (change, param) {
                opts.onChange = change;
                if (param !== undefined) opts.onChangeParams = param;
            },

            setNext: function () {
                var currentIdx = parseInt(getSelector(opts.target, opts.selector).closest('.' + opts.onClass).data('toggle-idx'));
                var nextIdx = checkIdx(currentIdx + 1);

                if (!isNaN(currentIdx)) getSelector(opts.target, opts.selector).eq(nextIdx).trigger('click.toggle');
            },

            setPrev: function () {
                var currentIdx = parseInt(getSelector(opts.target, opts.selector).closest('.' + opts.onClass).data('toggle-idx'));
                var prevIdx = checkIdx(currentIdx - 1);

                if (!isNaN(currentIdx)) getSelector(opts.target, opts.selector).eq(prevIdx).trigger('click.toggle');
            },

            getOptions: function () {
                return opts;
            }
        };
    };

    return wddoObj;
}(jQuery));

//get instance
if (jQuery.fn.getInstance === undefined) jQuery.fn.getInstance = function () { return this.data('scope'); };



// t: current time, b: begInnIng value, c: change In value, d: duration
jQuery.easing.jswing=jQuery.easing.swing;jQuery.extend(jQuery.easing,{def:"easeOutQuad",swing:function(e,f,a,h,g){return jQuery.easing[jQuery.easing.def](e,f,a,h,g)},easeInQuad:function(e,f,a,h,g){return h*(f/=g)*f+a},easeOutQuad:function(e,f,a,h,g){return -h*(f/=g)*(f-2)+a},easeInOutQuad:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f+a}return -h/2*((--f)*(f-2)-1)+a},easeInCubic:function(e,f,a,h,g){return h*(f/=g)*f*f+a},easeOutCubic:function(e,f,a,h,g){return h*((f=f/g-1)*f*f+1)+a},easeInOutCubic:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f+a}return h/2*((f-=2)*f*f+2)+a},easeInQuart:function(e,f,a,h,g){return h*(f/=g)*f*f*f+a},easeOutQuart:function(e,f,a,h,g){return -h*((f=f/g-1)*f*f*f-1)+a},easeInOutQuart:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f*f+a}return -h/2*((f-=2)*f*f*f-2)+a},easeInQuint:function(e,f,a,h,g){return h*(f/=g)*f*f*f*f+a},easeOutQuint:function(e,f,a,h,g){return h*((f=f/g-1)*f*f*f*f+1)+a},easeInOutQuint:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f*f*f+a}return h/2*((f-=2)*f*f*f*f+2)+a},easeInSine:function(e,f,a,h,g){return -h*Math.cos(f/g*(Math.PI/2))+h+a},easeOutSine:function(e,f,a,h,g){return h*Math.sin(f/g*(Math.PI/2))+a},easeInOutSine:function(e,f,a,h,g){return -h/2*(Math.cos(Math.PI*f/g)-1)+a},easeInExpo:function(e,f,a,h,g){return(f==0)?a:h*Math.pow(2,10*(f/g-1))+a},easeOutExpo:function(e,f,a,h,g){return(f==g)?a+h:h*(-Math.pow(2,-10*f/g)+1)+a},easeInOutExpo:function(e,f,a,h,g){if(f==0){return a}if(f==g){return a+h}if((f/=g/2)<1){return h/2*Math.pow(2,10*(f-1))+a}return h/2*(-Math.pow(2,-10*--f)+2)+a},easeInCirc:function(e,f,a,h,g){return -h*(Math.sqrt(1-(f/=g)*f)-1)+a},easeOutCirc:function(e,f,a,h,g){return h*Math.sqrt(1-(f=f/g-1)*f)+a},easeInOutCirc:function(e,f,a,h,g){if((f/=g/2)<1){return -h/2*(Math.sqrt(1-f*f)-1)+a}return h/2*(Math.sqrt(1-(f-=2)*f)+1)+a},easeInElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k)==1){return e+l}if(!j){j=k*0.3}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}return -(g*Math.pow(2,10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j))+e},easeOutElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k)==1){return e+l}if(!j){j=k*0.3}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}return g*Math.pow(2,-10*h)*Math.sin((h*k-i)*(2*Math.PI)/j)+l+e},easeInOutElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k/2)==2){return e+l}if(!j){j=k*(0.3*1.5)}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}if(h<1){return -0.5*(g*Math.pow(2,10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j))+e}return g*Math.pow(2,-10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j)*0.5+l+e},easeInBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}return i*(f/=h)*f*((g+1)*f-g)+a},easeOutBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}return i*((f=f/h-1)*f*((g+1)*f+g)+1)+a},easeInOutBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}if((f/=h/2)<1){return i/2*(f*f*(((g*=(1.525))+1)*f-g))+a}return i/2*((f-=2)*f*(((g*=(1.525))+1)*f+g)+2)+a},easeInBounce:function(e,f,a,h,g){return h-jQuery.easing.easeOutBounce(e,g-f,0,h,g)+a},easeOutBounce:function(e,f,a,h,g){if((f/=g)<(1/2.75)){return h*(7.5625*f*f)+a}else{if(f<(2/2.75)){return h*(7.5625*(f-=(1.5/2.75))*f+0.75)+a}else{if(f<(2.5/2.75)){return h*(7.5625*(f-=(2.25/2.75))*f+0.9375)+a}else{return h*(7.5625*(f-=(2.625/2.75))*f+0.984375)+a}}}},easeInOutBounce:function(e,f,a,h,g){if(f<g/2){return jQuery.easing.easeInBounce(e,f*2,0,h,g)*0.5+a}return jQuery.easing.easeOutBounce(e,f*2-g,0,h,g)*0.5+h*0.5+a}});

