
    <link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">

    <header id="header">
        <div class="inner">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-bottom:0px solid #F2F2F2;height:60px;box-shadow:0px 2px 2px rgba(0,0,0,0.1);">
                <tr>
                    <td width="*%" align="left" style="padding:5px 0px 2px 15px;"><a href="<%=GLOBAL_URL%>/mobile/main.asp" external="N" data-role="none"><img src="/images/logo/title_logo.png" border="0" width="100%"></a></td>
                    <td width="60%" align="right" style="padding:0px 5px 0px 0px;">
                        <!--
                        <% if memid= "lee@naver.com" then %>
                        <span class="top_txt"><a onclick="fn_matching('/mobile/room_mate/matching.asp');return false;" style="cursor:pointer;">룸메이트신청</a></span>
                        <span class="top_txt"><a href="/mobile/mypage/my_page.asp">마이페이지</a></span>
                        <span class="top_out"><a href="/mobile/member/logout.asp">로그아웃</a></span>
                        <% end if %>  
                        --> 
                    </td>
                    <td width="12%" align="left"><a href="#" id="btnMenu" data-role="none"><img src="/mobile/images/main/btn_hdleft.png" alt="전체메뉴"></a></td>
                </tr>
            </table>
        </div>
    </header>
    
    <div style="padding:60px 0 0 0;background:#FFF;"></div>
    
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
                width: 330,
                height: 650
            });
        });
    </script>