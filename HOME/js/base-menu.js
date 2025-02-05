
// top nav position fixed
$(window).scroll(function() {
  var _top1 = $(document).scrollTop();
  
  if(_top1 > 40){
    $('#global_nav').css({"position":"fixed", "top":"0px"});
    $(".btn_scroll_top").show();
  }
  else {
    $('#global_nav').css({"position":"relative"});
    $(".btn_scroll_top").hide();
  }
});

// goto page top
$(function() {
  $(".btn_scroll_top").click(function() {
    $('body, html').animate({scrollTop:0}, 500);
  });
});