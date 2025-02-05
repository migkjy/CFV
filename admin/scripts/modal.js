// 초기화.
function init_modal() {

	// 요소가 존재하는가?
	if (!$('a.modal').length) {

		// 요소가 존재하지 않는다면, 함수를 빠져나간다.
		return;
	}

	// IE 6 탐지 (boolean)
	var $IE6 = typeof document.addEventListener !== 'function' && !window.XMLHttpRequest;

	// 몇몇 계산을 수행한다.
	function sizeModal() {

		// 모달의 크기를 계산한다.
		var $modal = $('#modal_window');
		var $modal_width = $modal.outerWidth();
		var $modal_height = $modal.outerHeight();
		var $modal_top = '-' + Math.floor($modal_height / 2) + 'px';
		var $modal_left = '-' + Math.floor($modal_width / 2) + 'px';

		// 모달을 설정한다.
		$('#modal_window').css('margin-top', $modal_top).css('margin-left', $modal_left);
	}

	/* IE 6용 */ 
	function positionModal() {

		// 적절한 위치에 모달을 위치시킨다.
		$('#modal_wrapper').css('top', $(document).scrollTop() + 'px');
	}

	// 모달을 표시하는 함수이다.
	function showModal() {
		if ($IE6) {
			positionModal();
		}

		// 모달의 래퍼를 나타낸다.
		$('#modal_wrapper').show();

		// 크기를 계산한다.
		sizeModal();

		// 모달 창을 나타낸다.
		$('#modal_window').css('visibility', 'visible').show();

		// 로드 시 이미지의 크기를 재조정한다.
		$('#modal_content img').each(function() {
			$(this).load(function() {
				$(this).removeClass('modal_placeholder').show();
				sizeModal();
			});
		});
	}

	// <body>의 끝부분에 모달을 추가한다.
	$('body').append('<div id="modal_wrapper"><!--[if IE 6]><iframe id="modal_iframe" frameborder="0"></iframe><![endif]--><div id="modal_overlay"></div><div id="modal_window"><div id="modal_bar"><strong>Modal window</strong><a href="#" id="modal_close">Close</a></div><div id="modal_content"></div></div>');

	// modal이라는 클래스를 가지는 링크를 찾는다. 
	$('a.modal').click(function() {

		// href="..."를 검사한다.
		var $the_link = $(this).attr('href');

		// 링크의 대상을 확인한다.
		if ($the_link.match(/^#./)) {

			// #anchor 콘텐트를 가져온다.
			$('#modal_content').html($($(this).attr('href')).html());
			showModal();

		} else if ($the_link.match(/.jpg$/) || $the_link.match(/.png$/) || $the_link.match(/.gif$/)) {

			// 이미지 콘텐트를 가져온다.
			$('#modal_content').html('<p id="modal_image_wrapper"><img src="' + $the_link + '" class="modal_placeholder" /></p>');
			showModal();

		} else {

			// 외부의 Ajax 콘텐트를 가져온다.
			$('#modal_content').load($(this).attr('href').replace('#', ' #'), '', showModal);
		}

		// 모달의 제목을 결정한다.
		if ($(this).attr('title')) {

			// 제목을 추가한다.
			$('#modal_bar strong').html($(this).attr('title'));

		} else if ($(this).html() !== '') {

			// 링크의 텍스트를 추가한다.
			$('#modal_bar strong').html($(this).html());
		}

		// 링크로 이동하지 않는다.
		this.blur();
		return false;
	});

	// 모달 요소를 숨긴다.
	$('#modal_overlay, #modal_close').click(function() {

		// 모달을 숨긴다.
		$('#modal_wrapper').hide();

		// 이미지가 더 늦게 로드될 것이기에, 숨겨야 한다.
		$('#modal_window').css('visibility', 'hidden');

		// 이미지 리스너의 바인딩을 제거한다.
		$('#modal_content img').each(function() {
			$(this).unbind();
		});

		// 모달의 콘텐트를 제거한다.
		$('#modal_content').html('');

		// 모달의 제목을 재설정한다.
		$('#modal_bar strong').html('Modal window');

		// 링크로 이동하지 않는다.
		this.blur();
		return false;
	});

	// IE 6인 경우, 브라우저의 스크롤 이벤트를 연결한다.
	if ($IE6) {
		$(window).scroll(function() {
			if ($('#modal_wrapper').is(':visible')) {
				positionModal();
			}
		});
	}
}

// 작업을 시작한다.
$(document).ready(function() {
	init_modal();
});