    
    <script type="text/javascript" src="/admin/scripts/base-menu.js"></script>

    <div id="top">
        <div id="top_header">
            <div id="top_header_wrap">
                <div id="F5_header">
                    <div id="global_nav">
                    	
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="45px" style="background: #FF5001;">
                                    <ul id="nav">
                                        <li class="top">
                                            <a href="javascript:;" data-url="/admin/main.asp" class="top_link" style="padding:0 10px;"><span class="down"><i class="xi-home xi-x"></i> 메인</span></a>
                                       </li>
                                       <li class="top">
                                            <a href="#" class="top_link"><span class="down">프로그램 상품관리</span></a>
                                            <ul class="sub">
                                                <li><a href="javascript:;" data-url="/admin/goods_tck/tck_list.asp?g_kind=10">상품관리</a></li>
                                            </ul>
                                        </li>
                                       <li class="top">
                                            <a href="#" class="top_link"><span class="down">예약관리</span></a>
                                            <ul class="sub">
                                                <li><a href="javascript:;" data-url="/admin/reserve_tck/reserve_list.asp">예약관리</a></li>
                                                <li><a href="javascript:;" data-url="/admin/reserve_tck/plan_index.asp">월별모객현황</a></li>
                                            </ul>
                                        </li>
                                       <li class="top">
                                            <a href="#" class="top_link"><span class="down">룸메이트 매칭관리</span></a>
                                            <ul class="sub">
                                                <li><a href="javascript:;" data-url="/admin/roommate/matching_list.asp">매칭현황</a></li>
                                            </ul>
                                        </li>
                                        <li class="top">
                                            <a href="#" class="top_link"><span class="down">회원 / 인사관리</span></a>
                                            <ul class="sub">
                                                <li><a href="javascript:;" data-url="/admin/member/member_list.asp">회원관리</a></li> 
                                                <li>
                                                    <div style="border-top:1px solid #e44904;"></div>
                                                    <a href="javascript:;" data-url="/admin/power/staff/list.asp">인사관리</a>
                                                </li>
                                                <li><a href="javascript:;" data-url="/admin/power/staff/copyemp.asp">권한 복사</a></li>                                              
                                            </ul>
                                        </li>
                                        <li class="top">
                                            <a href="#" class="top_link"><span class="down">여행정보 관리</span></a>
                                            <ul class="sub">
                                                <li><a href="javascript:;" data-url="/admin/tour_info/nat_total.asp"> 국가/도시코드</a></li>
                                                <li><a href="javascript:;" data-url="/admin/tour_info/area_total.asp">지역정보</a></li>
                                            </ul>
                                        </li>
                                        <li class="top">
                                            <a href="#" class="top_link"><span class="down">게시판 관리</span></a>
                                            <ul class="sub">
                                                <li><a href="javascript:;" data-url="/admin/board/after_list.asp">발리 맛집</a></li>
                                                <li><a href="javascript:;" data-url="/admin/board/notice_list.asp?g_kind=10">공지사항</a></li>
                                                <!--
                                                <li><a href="javascript:;" data-url="/admin/board/qna_list.asp">문의 게시판</a></li>
                                                <li><a href="javascript:;" data-url="/admin/board/faq_list.asp">자주묻는질문</a></li>
                                                -->
                                            </ul>
                                        </li>
                                        <li class="top">
                                            <a href="#" class="top_link"><span class="down">홈페이지 관리</span></a>
                                            <ul class="sub">
                                               <li>
                                                    <div style="border-top:1px solid #e44904;"></div>
                                                    <a href="javascript:;" data-url="/admin/board/notice_list.asp?g_kind=20">페이지 등록</a>
                                                </li> 
                                                <li>
                                                    <div style="border-top:1px solid #e44904;"></div>
                                                    <a href="javascript:;" data-url="/admin/main_img/img_1.asp">메인 인트로</a>
                                                </li>
                                                <li><a href="javascript:;" data-url="/admin/main_img/img_2.asp">카테고리-1</a></li>
                                                <li><a href="javascript:;" data-url="/admin/main_img/img_3.asp">카테고리-2</a></li>
                                                <li><a href="javascript:;" data-url="/admin/main_img/img_3m.asp">카테고리-3</a></li>
                                                <li>
                                                    <div style="border-top:1px solid #e44904;"></div>
                                                    <a href="javascript:;" data-url="/admin/main_img/img_1m.asp">모바일 인트로</a>
                                                </li> 
                                                <li><a href="javascript:;" data-url="/admin/main_img/img_2m.asp">모바일 카테고리</a></li>
                                            </ul>
                                        </li>
                                        <li class="top">
                                            <a href="#" class="top_link"><span class="down">환경설정</span></a>
                                            <ul class="sub">
                                                <li><a href="javascript:;" data-url="/admin/code/idx.asp">상품코드관리</a></li>
                                            </ul>
                                        </li>
                                        <li class="top" style="padding:0 0 0 20px"><span class="id_name"><i class="xi-unlock-o xi-x"></i> <%=nm%></span></li>
                                        <li class="top" style="padding:0 0 0 20px; height:45px; line-height:45px;"><span class="id_log"><a href="javascript:Logout();">로그아웃</a></span></li>
                                    </ul>
                                </td>
                            </tr>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
    <!--
        function Logout() {
            location.href= "/admin/logout.asp";
        }
    //-->
    </script>
    
