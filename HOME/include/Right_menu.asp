 
    <script src="/home/js/tooltipsy.min.js" type="text/javascript"></script>

    <div id="side_Menu" class="sidebar">
        <ul class="handle">
            <li class="hastip opener" title="Quick Menu"><i class="xi-arrow-left"></i></li>
            <li class="hastip" title="위로" onclick="goTop();return false;"><i class="xi-angle-up-min"></i></li>
            <li class="hastip toBottom" title="아래로"><i class="xi-angle-down-min"></i></li>
            <!--<li class="right_kakaot" title="카카오톡" style="height:45px;background:#F7E111;"><a href="/" target="_balnk"><i class="xi-kakaotalk xi-x"></i></a></li>-->
        </ul>
    
        <div class="inner">
            <% 
                OpenF5_DB objConn   
                
                mem_nm = Trim(Request("mem_nm"))
            
                res_phone1  = Trim(Request("res_phone1"))
                res_phone2  = Trim(Request("res_phone2"))
                res_phone3  = Trim(Request("res_phone3"))
                tot_hp = res_phone1&"-"&res_phone2&"-"&res_phone3
            
            
                sql = " SELECT  kname,memid,  htel,point  FROM TB_member where memid= '"&memid&"' "
                Set Rs = objConn.Execute(sql)
                       
                mem_nm  = Trim(Rs("kname"))
                tot_hp  = Trim(Rs("htel"))
                point  = Trim(Rs("point"))
                   
                Rs.close  : Set Rs = nothing
            
            
                sql2 = "select sum(use_money) from TB_save_money where tot_htel = '"&tot_hp&"' and  can_yn='N'"
                Set Rs2 = Server.CreateObject("ADODB.RecordSet")
                Rs2.open sql2,objConn,3
                If Rs2.eof or Rs2.bof then
                Else
                    pay_point = Rs2(0)
                    if isNull(pay_point) then pay_point = 0 end if
                End if
                CloseRs Rs2 
                total_point = int(point) - int(pay_point)
            %>
            <div class="cs_menu">
                <div class="title"><i class="xi-info xi-x"></i> <%=mem_nm%>님 포인트 현황</div>
                <div style="border: 1px solid #dfdfdf;padding:8px 10px 10px 10px;">
                    <div>
                        <span class="p_txt1">◦보유 포인트 : </span>
                        <span class="point_txt1"><%=FormatNumber(point,0)%>&nbsp;CP</span>
                    </div>
                    <div>
                        <span class="p_txt1"> ◦사용 포인트 : </li>
                        <span class="point_txt2"><%=FormatNumber(pay_point,0)%>&nbsp;CP</span>
                    </div> 
                    <div>
                        <span class="p_txt1">◦잔여 포인트 : </span>
                        <span class="point_txt3"><%=FormatNumber(total_point,0)%>&nbsp;CP</span>
                    </div>
                </div>
            </div>

            <%
                sql5 = "select num, send_name, send_hp, app_gubn, ins_dt, cu_nm_kor, cu_hp, del_yn from TB_sel_memo where (send_hp = '"&tot_hp&"'  or  cu_hp  = '"&cu_htel&"')  and app_gubn = '1' and del_yn='N'"
                'RESPONSE.WRITE SQL5
                Set mRs = Server.CreateObject("ADODB.RecordSet")
                mRs.open sql5,objConn,3
                rs_cnt = mRs.RecordCount
                'response.write rs_cnt
                
                If mRs.eof or mRs.bof then
 
                    cntSql = "select count(*) from TB_sel_memo where send_hp = '"&tot_hp&"'  and app_gubn = '0' and del_yn='N'"
                    ' response.write cntSql
                    Set cntRs = Server.CreateObject("ADODB.RecordSet")
                    cntRs.open cntSql,objConn
                    if cntRs.eof or cntRs.bof then
                        me_Cnt = 0
                    else
                        me_Cnt = cntRs(0)
                    end if
                    CloseRs cntRs
                         
                    
                    cntSql = "select count(*) from TB_sel_memo where cu_hp = '"&tot_hp&"'  and app_gubn = '0' and del_yn='N'"
                    ' response.write cntSql
                    Set cntRs = Server.CreateObject("ADODB.RecordSet")
                    cntRs.open cntSql,objConn
                    if cntRs.eof or cntRs.bof then
                        mek_Cnt = 0
                    else
                        mek_Cnt = cntRs(0)
                    end if
                    CloseRs cntRs

                Else

                    my_send_name = Trim(mRs("send_name"))
                    my_send_hp = Trim(mRs("send_hp"))
                    my_cu_nm_kor = Trim(mRs("cu_nm_kor"))
                    my_cu_hp = Trim(mRs("cu_hp"))
            
                End if   
            %>
            <div class="cs_menu">
                <div class="title"><i class="xi-hotel xi-x"></i> 룸메이트 매칭 현황</div>
                <div style="border: 1px solid #dfdfdf;padding:8px 10px 10px 10px;">
                    <%  If rs_cnt <= 0 then %>
                        <div>
                            <span class="p_txt1">◦받은 매칭수 : </span>
                            <span class="mat_txt1"><%=me_Cnt%>건</span>
                        </div>
                        <div>
                            <span class="p_txt1">◦보낸 매칭수 : </span>
                            <span class="mat_txt2"><%=mek_Cnt%>건</span>
                        </div>
                    <% End if %>  
                              
                    <% If cstr(mem_nm) <>cstr(my_cu_nm_kor) then %>
                        <% if my_cu_nm_kor <>"" then%>
                            <div class="p_txt1"><strong>"<%=mem_nm%>"</strong>님은<br><strong>"<%=my_cu_nm_kor%>(<%=my_cu_hp%>)"</strong>님과<br>&nbsp;&nbsp;룸메이트 매칭이 되었습니다.</div>
                        <% end if %>
                    <% Else %>
                        <% if my_send_name <>"" then%>
                        <div class="p_txt1"><strong>"<%=mem_nm%>"</strong>님은<br><strong>"<%=my_send_name%>(<%=my_send_hp%>)"</strong>님과<br>&nbsp;&nbsp;룸메이트 매칭이 되었습니다.</div>
                        <% end if %>
                    <% end if %>     
                </div>
            </div>
             <%
                 CloseF5_DB objConn
            %>

            <div class="cs_menu">
                <div class="title"><i class="xi-list xi-x"></i> 카테고리</div>
                <ul>
                    <!--<li><a onclick="fn_matching('/home/room_mate/matching.asp');return false;" style="cursor:pointer;">룸메이트 신청</a></li>-->
                    <li><a href="/home/mypage/my_page.asp">마이페이지</a></li>
                    <!--<li><a href="/home/board/notice_list.asp">공지사항</a></li>-->
                    <li><a href="/home/member/logout.asp">로그아웃</a></li>
                </ul>
                
                 <div class="pt15"></div>
                 
                <ul>
                    <li><a href="/home/2024/schedule_1.asp" class="top_link">A팀 발리 프리덤</a></li>
                    <li><a href="/home/2024/schedule_2.asp" class="top_link">B팀 발리 우붓 플렉스</a></li>
                    <li><a href="/home/2024/schedule_3.asp" class="top_link">C팀 발리 우붓 마스터</a></li>
                    <li><a href="/home/2024/schedule_4.asp" class="top_link">D팀 발리 우붓 릴렉스</a></li>
                    <li><a href="/home/2024/air_infor.asp" class="top_link">항공정보</a></li>
                    <li><a href="/home/2024/hotel_kempinski.asp" class="top_link">호텔 캠핀스키</a></li>
                    <li><a href="/home/2024/hotel_padma.asp" class="top_link">호텔 파드마</a></li>
                    <li><a href="/home/2024/hotel_royalpitamaha.asp" class="top_link">호텔 로얄피타마하</a></li>
                    <li><a href="<%=GLOBAL_URL%>/home/good_tck/ticket_list.asp?g_kind=10" class="top_link">선택형 프로그램</a></li>
                    <li><a href="/home/2024/shopping_infor.asp" class="top_link">셔틀안내</a></li>
                    <li><a href="/home/2024/travel_wallet.asp">트래블월렛</a></li>
                    <li><a href="/home/bali_infor/infor_list.asp?infor_cd=02&nat_cd=ID&city=BAL" class="top_link">발리정보</a></li>
                    <!--<li><a href="/home/board/food_list.asp" class="top_link">발리 맛집</a></li>-->
                    <li><a href="/home/2024/travel_insurance.asp">여행자보험</a></li>
                    <li><a href="/">&nbsp;</a></li>
                </ul>
            </div>
        </div>
    </div>


    <script type="text/javascript">
        $(document).ready(function() {
        
            $('.hastip').tooltipsy({
                offset: [-4, 0]
            });
        
        
            $(".toBottom").click(function() {
                $('html').animate({scrollTop : ($('#footer').offset().top)}, 600);
            });
            
            var duration = 300;
            var $sidebar = $('.sidebar');
            
            var $opener = $("#side_Menu .handle li.opener").hover(function() {
               
                
                if($("#side_Menu").css("right") == "0px"){
                    $("#side_Menu").animate({right: '-236'}, duration, 'easeOutBack');
                    $("#side_Menu .handle li.opener i").css('transform', 'none');
                }else{
                    $("#side_Menu").animate({right: '0'}, duration, 'easeInBack');
                    $("#side_Menu .handle li.opener i").css('transform', 'rotate(180deg)');
                }
                
                }, function(){
                
            });
        });
        
        
        function goTop() {
            jQuery( 'html, body' ).animate({
                scrollTop: 0
            }, 500, 'swing');
            return false;
        }
    </script>