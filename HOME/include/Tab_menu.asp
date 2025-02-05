    <link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">

    <script type="text/javascript">
        $(document).ready(function() {	
        	$('#nav li').hover(function() {
        		$('ul', this).slideDown(200);
        		$(this).children('a:first').addClass("hov");
        	}, function() {
        		$('ul', this).slideUp(100);
        		$(this).children('a:first').removeClass("hov");		
        	});
        });
    </script>

    <script language="javascript" type="text/javascript" src="/home/js/base-menu.js"></script>

     <div class="header_wrap">
   	   <div align="center">
           <table width="100%" border="0" cellpadding="0" cellspacing="0">
               <colgroup>
                   <col width="550px">
                   <col width="*">
               </colgroup>
               <tbody>
                   <tr>
                       <td height="70"><div style="padding:20px 0px 0px 40px;"><a href="/home/main.asp"><img src="/images/logo/title_logo.png" border="0" height="40" alt="<%=GLOBAL_SIN%>"></a></div></td>
                      <!-- <td align="right">
                           <div style="padding:0px 40px 0px 0px;">
                              <span class="txt_top"><a href="/home/mypage/my_page.asp">마이페이지</a></span><span style="padding:0 7px 0 9px;font-size:12px; color:#999;">|</span>
                               <span class="txt_top"><a href="/home/member/logout.asp"><i class="xi-unlock-o"></i> 로그아웃</a></span>
                           </div>
                       </td>-->
                   </tr>
               </tbody>
           </table>
   	   </div>
    </div>

    <div id="top">
        <div id="top_header">
            <div id="top_header_wrap">
                <div id="F5_header">
                    <div id="global_nav">
                        <div id="global_nav_wrap" style="padding:16px 0 0 0;">
                            <div id="nav">
                                <li class="top"> 
                            	    <a class="top_link">전체 일정</a>
                               	    <ul class="sub" style="padding:13px 17px;width:150px;">
                            		    <li><a href="/home/2024/schedule_1.asp">A팀 발리 프리덤</a></li>
                            		    <li><a href="/home/2024/schedule_2.asp">B팀 발리 우붓 플렉스</a></li>
                            		    <li><a href="/home/2024/schedule_3.asp">C팀 발리 우붓 마스터</a></li>
                            		    <li><a href="/home/2024/schedule_4.asp">D팀 발리 우붓 릴렉스</a></li>
                            	    </ul>
                            	</li>
                                <li class="top"> 
                            	    <a href="/home/2024/air_infor.asp" class="top_link">항공정보</a>
                            	</li>                      	
                                <li class="top"> 
                            	    <a class="top_link">호텔정보</a>
                               	    <ul class="sub" style="padding:13px 17px;width:130px;">
                            		    <li><a href="/home/2024/hotel_kempinski.asp">캠핀스키</a></li>
                            		    <li><a href="/home/2024/hotel_royalpitamaha.asp">로얄피타마하</a></li>
                            		    <li><a href="/home/2024/hotel_padma.asp">파드마</a></li>
                            	    </ul>
                            	</li>
                                <li class="top"> 
                            	    <a href="/home/good_tck/ticket_list.asp?g_kind=10" class="top_link">선택형 프로그램</a>
                            	</li>
                        
                            	<li class="top"> 
                            	    <a href="/home/board/food_list.asp" class="top_link">발리 맛집</a>
                            	</li>
                          
                            	<li class="top"> 
                            	    <a href="/home/2024/shopping_infor.asp" class="top_link">셔틀안내</a>
                            	</li>
                             	<li class="top"> 
                            	    <a class="top_link">기타(더보기)</a>
                              	    <ul class="sub" style="padding:13px 17px;width:155px;">
                            		    <li><a href="/home/bali_infor/infor_list.asp?infor_cd=02&nat_cd=ID&city=BAL">발리정보</a></li>
                            		    <li><a href="/home/2024/travel_wallet.asp">트래블월렛</a></li>
                            		    <li><a href="/home/2024/travel_insurance.asp">여행자보험</a></li>
                            	    </ul>
                            	</li>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="pop_matching" title="룸메이트 신청"></div>
    <script language="javascript">
        function fn_matching(_url100){
            $("#pop_matching").html('<iframe id="modalIframeId100" width="100%" height="99%" marginWidth="0" marginHeight="0" frameBorder="0" scrolling="auto" />').dialog("open");
            $("#modalIframeId100").attr("src",_url100);
        }
        $(document).ready(function(){
            $("#pop_matching").dialog({
                autoOpen: false,
                modal: true,
                width: 800,
                height: 850
            });
        });
    </script>