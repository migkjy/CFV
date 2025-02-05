<!--#include virtual="/home/conf/config.asp" -->
<!--#include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->

<% 
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
%>

<!DOCTYPE html>
<html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sm_logo.png">
	
<link rel="stylesheet" type="text/css" href="/css/style.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">

<script type="text/javascript" src="/home/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script type="text/javascript" src="/home/js/jquery.fancybox.pack.js?v=2.1.4"></script>
<link type="text/css" href="/home/js/jquery.fancybox.css?v=2.1.4" />

<script type="text/javascript" src="/home/js/link.js" language="javascript"></script>
</head>

<body>
	
    <!--#include virtual="/home/include/tab_menu.asp"--> 
    <!--#include virtual="/home/include/right_menu.asp"--> 

    <div id="wrap">
        <div id="container">
        	
            <div id="contBody">

                <div class="pt10"></div>
                <div class="infor_title">개인정보취급방침</div>
                <div style="border-bottom:2px solid #000;"></div>

                <div class="agree_txt">
                    <%=GLOBAL_SIN%>(이하 '회사')는 정보 주체의 자유와 권리보호를 위해 [개인정보보호법] 및 관계법령이 정한바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다.
                    <br>이에 [개인정보보호법] 제 30조에 따라 정보주체에게 개인정보처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보처리방침을 수립 및공 개합니다.
                    <br>            
                    <br><strong>1. 개인정보의 처리 목적</strong>
                    <br>
                    회사는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 『개인정보보호법』 제 18 조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다. 
                    
                    <br>① 여행상담
                    <br>여행상품 예약 상담의 목적으로 개인정보를 처리합니다.
                    <br>② 여행상품 예약
                    <br>여행상품 예약, 출국가능 여부 파악 목적으로 개인정보를 처리합니다.
                    <br>③ 여행상품 서비스 제공
                    <br>항공권/호텔 등의 예약정보 및 출입국 정보 확인, 예약내역의 확인 및 상담, 여행자보험 가입지원, 국내 및 해외 여행서비스 이행, 여행고객 관리, 컨텐츠 제공, 여행서비스 이용대금 결제 및 정산, 환불의 목적으로 개인정보를 처리합니다.
                    <br>④ 민원 처리
                    <br>서비스 개선 의견 수렴, 불만 및 민원처리 목적으로 개인정보를 처리합니다.
                    <br> 
                    
                    <br><strong>2. 개인정보의 처리 및 보유 기간</strong>
                    <br>회사는 법령에 따른 개인정보 보유 이용기간 또는 정보주체로부터 개인정보를 수집시에 동의 받은 개인정보 보유 이용기간 내에서 개인정보를 처리 보유합니다.
                    <br>각각의 개인정보 처리 및 보유기간은 다음과 같습니다.            
                    <br>① 여행 상담 : 여행상담 완료 후 지체없이 파기
                    <br>② 여행상품 예약 : 서비스 제공 및 관계법령에 따른 보존기간까지, 단, 미결제 취소 정보는 예약 취소일로부터 12 개월간 보관합니다.
                    <br>③ 여행상품 서비스 제공 : 최대 5년간 보관
                    <br>- 계약 또는 청약철회 등에 관한 기록 : 5 년(전자상거래 등에서의 소비자 보호에 관한 법률)
                    <br>- 대금결제 및 재화 등의 공급에 관한 기록: 5 년(전자상거래 등에서의 소비자 보호에 관한 법률)
                    <br>- 소비자의 불만 또는 분쟁처리에 관한 기록: 3 년(전자상거래 등에서의 소비자 보호에 관한 법률)
                    <br>- 표시.광고에 관한 기록 : 6 개월(전자상거래 등에서의 소비자 보호에 관한 법률)
                    <br>④ 민원처리 : 민원처리 종료 후 1년간 보관
                    <br>
                    <br>다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료 시까지 보관합니다
                    <br>① 관계 법령 위반에 따른 수사 조사 등이 진행 중인 경우에는 해당 수사 조사 종료 시까지
                    <br>② 홈페이지 이용에 따른 채권 채무관계 잔존 시에는 해당 채권 채무관계 정산 시까지
                    <br>③ <예외 사유> 시에는 <보유기간>까지
                    <br>  
                    
                    <br><strong>3. 처리하는 개인정보의 항목</strong>
                    <br>회사는 다음의 개인정보 항목을 처리하고 있습니다
                    <br>① 여행 상품 예약
                    <br>- 국외여행상품 필수항목 : 성명(국문/영문), 생년월일, 연락처, 이메일, 성별
                    <br>② 여행상품 서비스 제공
                    <br>- 국외여행상품 필수항목 : 성명(국문/영문), 생년월일, 연락처, 이메일, 성별
                    <br>③ 민원처리
                    <br>- 필수항목 : 이름, 이메일, 연락처
                    <br>
                    <br><strong>4. 개인정보의 제3자 제공</strong>
                    <br>회사는 정보주체의 개인정보를 개인정보의 처리 목적에서 명시한 범위 내에서만 처리하며, 정보 주체의 동의, 법률의 특별한 규정 등 [개인정보 보호법] 제17조, 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공하고 그 이외에는 정보주체의 개인정보를 제3자에게 제공하지 않습니다
                    <br>
                    <br>
                    <div class="agree_box">
                        <table>
                            <colgroup>
                                <col width="24%">
                                <col width="20%">
                                <col width="22%"> 
                                <col width="16%">
                                <col width="*">
                            </colgroup>
                            <tbody>  
                                <tr>
                                    <td class="typj1">제공받는 자</td>
                                    <td class="typj2">제공목적</td>
                                    <td class="typj2">제공항목</td>
                                    <td class="typj2">보유 및 이용기간</td>
                                    <td class="typj2">관련근거</td>
                                </tr>
                                <tr>
                                    <td class="typj5">대한항공, 아시아나항공 및 국내외 항공사</td>
                                    <td class="typj4">항공권 예약 및 출국가능<br>여부 파악</td>
                                    <td class="typj4">성명(한글/영문),성별,연락처,<br>여권정보</td>
                                    <td class="typj4">이용목적 달성시까지</td>
                                    <td class="typj4">출입국관리법 제73조의 2</td>
                                </tr>
                                <tr>
                                    <td class="typj5">국내외 호텔/리조트</td>
                                    <td class="typj4">숙박예약 진행/확인</td>
                                    <td class="typj4">성명(한글/영문),연락처</td>
                                    <td class="typj4">업체별 상이</td>
                                    <td class="typj4">이용목적 달성시까지</td>
                                </tr>
                            </tbody>  
                        </table> 
                    </div>
                    
                    <br>회사는 다음의 경우 관련 법령에 따라 정보주체의 동의를 얻지 않고 관련 기관에 개인정보를 제공할 수 있습니다.
                    <br>
                    <br>회사는 다음과 같이 재난,감염병,급박한 생명,신체 위험을 초래하고 사건.사고, 급박한 재산 손실 등의 긴급상황이 발생하는 경우 정보주체의 동의 없이 관계기관에 개인정보를 제공할 수 있습니다. 
                    <br>
                    <br>          
                    
                    <div class="agree_box">
                        <table>
                            <colgroup>
                                <col width="18%">
                                <col width="13%">
                                <col width="21%">
                                <col width="*%">
                            </colgroup>
                            <tbody>  
                                <tr>
                                    <td class="typj1">분류</td>
                                    <td class="typj2">근거법령</td>
                                    <td class="typj2">제공기관</td>
                                    <td class="typj2">제공되는 개인정보</td>
                                </tr>
                                <tr>
                                    <td class="typj3">재난대응</td>
                                    <td class="typj3">재난안전법</td>
                                    <td class="typj3">중앙대책본부 또는 지역대책본부</td>
                                    <td class="typj4">
                                        - 성명,주민등록번호,주소 및 전화번호(휴대전화 포함)<br>
                                        - 이동경로 파악 및 수색 구조를 위한 다음 정보<br>
                                        가. CCTV를 통해 수집된 정보<br>
                                        나. 교통카드의 사용명세<br>
                                        다. 신용카드 직불카드 선불카드의 사용일시와 장소<br>
                                        라. 처방전의 의료기관 명칭, 전화번호 및 진료기록부상의 진료일시<br>
                                    </td>
                                </tr>                           
                                <tr>
                                    <td class="typj3">감염병의 예방 및 관리</td>
                                    <td class="typj3">감염병 예방법</td>
                                    <td class="typj3">질병관리청 또는 전국 시.도</td>
                                    <td class="typj4">
                                        성명 주민등록번호 주소 및 전화번호(휴대전화번호 포함)<br>
                                        [의료법]에 따른 처방전 및 진료기록부<br>
                                        질병관리청장이 정하는 기간의출입국관리기록 그밖에 이동경로를 파악하기 위한<br>다음 정보<br>
                                        가. [여신전문금융업법]에 따른 신용카드 직불카드 선불카드 사용명세<br>
                                        나. [대중교통의 육성 및 이용촉진에 관한 법률]에 다른 교통카드  사용명세<br>
                                        다. [개인정보보호법]에 따른 영상정보처리기기를 통하여 수집된 영상정보
                                    </td>
                                </tr>                              
                                <tr>
                                    <td class="typj3">자살위험자 보호</td>
                                    <td class="typj3">자살예방법</td>
                                    <td class="typj3">경찰관서, 해양경찰, 소방관서</td>
                                    <td class="typj4">성명,주민등록번호,주소 및 개인위치정보</td>
                                </tr>                             
                                <tr>
                                    <td class="typj3">납치,감금 등 범죄와<br>관련된자의 개인정보 처리</td>
                                    <td class="typj3">개인정보 보호법</td>
                                    <td class="typj3">경찰관서</td>
                                    <td class="typj4">CCTV등 영상정보</td>
                                </tr>                    
                            </tbody>  
                        </table> 
                    </div>
                    <br>이 경우 회사는 근거법령에 의거하여 필요한 최소한의 개인정보만을 제공하며, 목적과 다르게 제공하지 않겠습니다
                    <br>  
                    
                    <br><strong>5. 개인정보 처리의 위탁</strong>                        
                    <br>
                    <div class="agree_box">
                        <table>
                            <colgroup>
                                <col width="30%">
                                <col width="*%">
                            </colgroup>
                            <tbody>  
                                <tr>
                                    <td class="typj1">위탁받는 자(수탁자)</td>
                                    <td class="typj2">위탁업무</td>
                                </tr>
                                <tr>
                                    <td class="typj3">가비아</td>
                                    <td class="typj4">DB 운영 및 관리</td>
                                </tr>
                                <tr>
                                    <td class="typj3">주식회사 서아</td>
                                    <td class="typj4">홈페이지 유지보수 관리</td>
                                </tr>
                            </tbody>  
                        </table> 
                    </div>        
                    <br>회사는 위탁계약 체결시 [개인정보 보호법] 제 26조에 따라 위탁업무 수행 목적 외 개인정보 처리금지, 기술적,관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리.감독.손해배상 등 책임에 관한 사항을 계약서  등 문서에 명시하고 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다. 
                    <br>위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.
                    <br>
                    <br><strong>6. 개인정보의 국외 이전</strong>
                    <br>해당 없음
                    <br>
                    
                    <br><strong>7. 개인정보의 파기 절차 및 방법</strong>                  
                    <br>① 회사는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다
                    <br>② 정보주체로부터 동의 받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는 해당 개인정보를 별도의 데이터베이스로 옮기거나 보관장소를 달리하여 보존합니다. 
                    <br>③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.
                    <br>가.파기절차
                    <br>- 회사는 파기 사유가 발생한 개인정보를 선정하고 회사의 개인정보 보호 책임자의 승인을 받아 개인정보를 파기합니다.
                    <br>나.파기방법
                    <br>- 회사는 전자적 파일 형태로 기록 저장된 개인정보는 기록을 재상할 수 없도록 파기하며 종이 문서에 기록 저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.
                    
                    <br>
                    <br><strong>8. 미이용자의 개인정보 파기 등에 관한 조차(파기하는 경우)</strong>      
                    <br>① 회사는 1 년간 서비스를 이용하지 않은 이용자의 정보를 파기하고 있습니다. 다만, 다른 법령에서 정한 보존기간이 경과할 때까지 다른 이용자의 개인정보와 분리하여 별도로 저장.관리할 수 있습니다.
                    <br>② 회사는 개인정보의 파기 30 일 전까지 개인정보가 파기되는 사실, 기간, 만료일 및 파기되는 개인정보의 항목을 이메일, 문자 등 이용자에게 통지 가능한 방법으로 알리고 있습니다.
                    <br>③ 개인정보의 파기를 원하지 않으시는 경우, 기간 만료 전 서비스 로그인을 하시면 됩니다.
                
                    <br>
                    <br><strong>9. 미이용자의 개인정보 파기 등에 관한 조치(분리저장 하는 경우)</strong>      
                    <br> ① 회사는 1 년간 서비스를 이용하지 않은 이용자는 휴면계정으로 전환하고 개인정보를 별도로 분리하여 보관합니다. 분리 보관된 개인정보는 1 년간 보관 후 지체없이 파기합니다.
                    <br>② 회사는 휴면 전환 30 일 전까지 휴면 예정 회원에게 별도 분리 보관되는 사실 및 휴면 예정일, 별도 분리 보관하는 개인정보 항목을 이메일, 문자 등 이용자에게 통지 가능한 방법으로 알리고 있습니다.
                    <br>③ 휴면계정으로 전환을 원하지 않으시는 경우, 휴면 계정 전환 전 서비스 로그인을 하시면 됩니다. 또한 휴면 계정으로 전환되었더라도 로그인을 하는 경우 이용자의 동의에 따라 휴면 계정을 복원하여 정상적인 서비스를 이용할 수 있습니다.
                    
                    <br>
                    <br><strong>10. 정보 주체와 법정 대리인의 권리 의무 및 행사방법</strong>      
                    <br>①  정보주체는 회사에 대해 언제든지 개인정보 열람 정정 삭제 처리정지 요구등의 권리를 행사할 수 있습니다
                    <br>*만 14 세 미만 아동에 관한 개인정보의 열람 등 요구는 법정대리인이 직접 해야하며 만 14 세 이상의 미성년자인 정보주체는 정보주체의 개인정보에 관하여 미성년자 본인이 권리를 행사하거나 법정대리인을 통하여 권리를 행사할 수도 있습니다.
                    <br>② 권리 행사는 회사에 대해 개인정보보호법 시행령 제 41 조 제 1 항에 따라 서면, 전자우편, 모사전송(fax) 등을 통하여 하실 수 있으며 회사는 이에 대해 지체없이 조치하겠습니다.
                    <br>③ 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수도 있습니다. 이 경우 “개인정보 처리 방법에 관한 고시(제 2020-7 호)” 별지 제 11 호 서식에 따른 위임장을 제출하셔야 합니다.
                    <br>④ 개인정보 열람 및 처리정지 요구는 개인정보보호법 제 35 조 제 4 항, 제 37 조 제 2 항에 의하여 정보주체의 권리가 제한 될 수 있습니다.
                    <br>⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.
                    <br>⑥회사는 정보주체 권리에 따른 열람의 요구 정정 삭제의 요구 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.
                
                
                    <br>
                    <br><strong>11. 개인정보의 안전성 확보조치</strong>      
                    <br>회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다
                    <br>① 관리적 조치 :  내부관리계획 수립 시행 및 정기적 직원교육을 시행하고 있습니다.
                    <br>② 기술적 조치 : 개인정보 처리 시스템의 접근권한 관리, 접근 통제시스템 설치,개인정보의 암호화, 보안프로그램 설치 및 갱신하고 있습니다. 개인정보처리시스템에 접속한 기록을 최소 2 년 이상 보관, 관리하고 있습니다.
                    <br>③ 물리적 조치 : 전산실, 자료보관실 등의 접근통제            
                    
                    <br>            
                    <br><strong>12. 개인정보 자동 수집 장치의 설치 운영 및 거부에 관한 사항</strong>      
                    <br>① 회사는 정보주체에게 개별적인 맞춤 서비스를 제공하기 위하여 이용정보를 저장하고 수시로 불로오는 쿠키(cookie)를 사용합니다            
                    <br>② 쿠키는 웹사이트를 운영하는데 이용되는 서버가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터 내의 하드디스크에 저장되기도 합니다
                    <br>- 쿠키의 사용목적 : 이용자가 방문한 각 서비스와 웹사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안 접속  여부 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다. 
                    <br>- 쿠키의 설치 운영 및 거부 : 웹브라우저 상단의 도구 > 인터넷 옵션> 개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부할 수 있습니다. 
                    <br>- 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다. 
                    
                    <br>
                    <br><strong>13. 행태정보의 수집 이용 및 거부등에 관한 사항</strong>      
                    <br>① 회사는 서비스 이용과정에서 정보주체에게 최적화된 맞춤형 서비스 및 혜택 온라인 맞춤형 광고 등을 제공하기 위하여 행태정보를 수집 이용하고 있습니다. 
                    <br>② 회사는 다음과 같이 행태정보를 수집합니다
                    <br>
                    <br>
                    <div class="agree_box">
                        <table>
                            <colgroup>
                                <col width="29%">
                                <col width="18%">
                                <col width="29%"> 
                                <col width="*%">
                            </colgroup>
                            <tbody>  
                                <tr>
                                    <td class="typj1">수집하는 행태정보의 항목</td>
                                    <td class="typj2">행태정보 수집 방법</td>
                                    <td class="typj2">행태정보 수집목적</td>
                                    <td class="typj2">보유 이용기간 및 이후 정보처리 방법</td>
                                </tr>
                                <tr>
                                    <td class="typj3">이용자의 웹사이트 방문이력, 검색이력, 구매이력</td>
                                    <td class="typj3">이용자의 웹사이트 방문</td>
                                    <td class="typj4">이용자의 관심, 성향에 기반한 개인 맞춤형 상품 추천 서비스를 제공</td>
                                    <td class="typj3">수집일로부터 30일 후 파기</td>
                                </tr>
                            </tbody>  
                        </table> 
                    </div>
                    
                    <br>③ 회사는 만14세 미만임을 알고 있는 아동이나 만14세 미만의 아동을 주이용자로 하는 온라인 서비스로부터 맞춤형 광고 목적의 행태정보를 수집하지 않고, 만14세 미만임을 알고 있는 아동에게는 맞춤형 광고를 제공하지 않습니다.
                    <br>④ 정보주체는 웹브라우저의 쿠키 설정 변경등을 통해 온라인 맞춤형 광고를 일괄적으로 차단 허용할 수 있습니다. 다만, 쿠키 설정 변경은 웹사이트 자동로그인 등 일부 서비스의 이용에 영향을 미칠 수 있습니다.
                    <br>⑤ 정보주체는 아래의 연락처로 행태정보와 관련하여 궁금한 사항과 거부권행사, 피해 신고접수 등을 문의할 수 있습니다.
                    <br> 
                    <br> 
                    <div class="agree_box">
                        <table>
                            <colgroup>
                                <col width="50%">
                                <col width="50%">
                            </colgroup>
                            <tbody>  
                                <tr>
                                    <td class="typj1">개인정보보호 책임자</td>
                                    <td class="typj2">개인정보보호 담당자</td>
                                </tr>     
                                <tr>
                                    <td class="typj5">
                                        - 성명 : <%=PRIVACY_NAME1%><br>
                                        - 직책 : 운영이사<br>
                                        - 연락처 : <%=PRIVACY_PH1%> / <%=PRIVACY_ME1%> / <%=global_fax%>
                                    </td>
                                    <td class="typj4">
                                        - 성명 : <%=PRIVACY_NAME2%><br>
                                        - 직책 : 경영팀 <br>
                                        - 연락처 : <%=PRIVACY_PH2%> / <%=PRIVACY_ME2%> / <%=global_fax%>
                                    </td>
                                </tr>
                            </tbody>  
                        </table>    
                    </div>
                    
                    <br><strong>14. </strong>정보주체는 개인정보치해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국 인터넷 진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보 침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다            
                    <br>① 개인정보분쟁조정위원회 : (국번없이 ) 1833-6972(www.kopico.go.kr)
                    <br>② 개인정보침해신고센터 : (국번없이)118 (privacy.kisa.or.kr)
                    <br>③ 대검찰청: (국번없이) 1301 (www.spo.go.kr)
                    <br>④ 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)
                    
                    <br>
                    <br><strong>15. 영상정보처리기기 설치 및 운영</strong>        
                    <br>해당사항 없음
                    
                    <br>
                    <br><strong>16. 개인정보 처리방침의 변경</strong>        
                    <br>○ 개인정보취급방침 시행일자 : <%=GLOBAL_STA%>
                    <br>○ 개인정보취급방침 최종변경일자 : <%=GLOBAL_DATE%>
                </div>
             </div>
          </div>
        
    </div>
    
    <div class="pt80"></div>
        </div>
        
        <div id="footer"></div>
        <!--#include virtual="/home/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>