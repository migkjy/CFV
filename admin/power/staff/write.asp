<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/conf/tourgram_base64.asp"-->

<%
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.AddHeader "Expires","0"
    

    rekind = Request("rekind")
    cd = Request("cd")
    emp_no = Request("emp_no")
    key = Request("key")
    keyfield = Request("keyfield")
    page = Request("page")
    
    OpenF5_DB objConn
    
    If rekind="u" Then	'// 업데이트
    
    	tbl	= "TB_em001"
    
    	sql = " select nm,nm_eng,  "
    	sql = sql & " jm_no,birthday,birth_chk,ent_day,pp_no,pp_termination_day,sex, "
    	sql = sql & " email,addnum1,addnum2,address,tell,handphone,dept_cd,grade_cd,em_pass, "
    	sql = sql & " broad_cd,position_cd,team_cd,business,"
    	sql = sql & " holidays_tot = isNUll(holidays_tot,0),"
    	sql = sql & " holidays_cnt = isNUll(holidays_cnt,0), "
    	sql = sql & " img_path = isNUll(img_path,''), em_id=isNull(em_id,'') "
    	sql = sql & " from "& tbl 
    	sql = sql & "	where emp_no = '"&emp_no&"'" 
    	sql = sql & " and del_fg = 'N' "
    
    
    	Set Rs = objConn.Execute(sql)
    	If Not Rs.Eof Then 
    		nm_kor = Rs("nm") '//한글명
    		nm_eng = Rs("nm_eng") '//영문명
    		jmno = Rs("jm_no") '//주민번호
    		birthday = Rs("birthday") 
    		birth_chk = Rs("birth_chk") '//생일음력양력
    		ent_day = Rs("ent_day") '//입사일
    		pp_no = Rs("pp_no") '//여권번호
    		pp_termination_day = Rs("pp_termination_day") 
    		sex = Rs("sex")	'//성별
    		email = Rs("email") '//이메일 첫번째 주소 및 풀주소
        
    		if Not(Trim(email)="" or isnull(Trim(email)) )  then 
    		    email_temp = split(email,"@")
    		else
    		    email_temp(0) = ""
    		    email_temp(1) = ""      	
    		end if
           
        	addnum1 = Rs("addnum1") '//우편번호
    		addnum2 = Rs("addnum2") '//우편번호
    		address = Rs("address") '//집주소
    		tell = Rs("tell") '//사무실
    		tel2 = Rs("handphone") '//핸드폰
    		dept_cd = Rs("dept_cd") '//부서코드
    		grade_cd = Rs("grade_cd") '//직급코드
    		broad_cd = Rs("broad_cd") '//방송코드
    		position_cd = Rs("position_cd") '//클래스 
    		team_cd = Rs("team_cd") '//팀구분
    		business = Rs("business") '//직무
    		holidays_tot = Rs("holidays_tot") '//연차총수
    		holidays_cnt = Rs("holidays_cnt") '//연차 사용수
    		img_path = Rs("img_path")
    		em_id = Rs("em_id")
    		'em_pass_k = Rs("em_pass")
    		em_pass_k = Base64_Decode(Rs("em_pass"))
   
    		
    		If Len(Trim(birthday))=8 Then '//생일
    			birth_year = Left(birthday,4)
    			birth_month = Mid(birthday,5,2)
    			birth_day = Right(birthday,2)
    		End if	
    
    
    		If Len(pp_termination_day)>7 Then '//여권말료일
    			pp_year = Left(pp_termination_day,4)
    			pp_month = Mid(pp_termination_day,5,2)
    			pp_day = Right(pp_termination_day,2)
    		End if	
    
    		If Len(ent_day)>7 Then '//입사일
    			ent_year = Left(ent_day,4)
    			ent_month = Mid(ent_day,5,2)
    			ent_day = Right(ent_day,2)
    		End if	
    
    		If Len(jmno)=13 Then
    			jmno1	= Left(jmno,6)
    			jmno2	= Mid(jmno,7)
    		End If
    		
    
    		If holidays_tot>0 And holidays_cnt>=0 Then 
    			holidays_cnt2 = holidays_tot -	holidays_cnt
    		End if
    
    		Flag = "up"
    	End if
    	
    	CloseRs Rs
    Else 
    	    rekind = "n"	
    End if
    
    admin_nm = "관리자"
    admin_id = "admin"
    admin_email = "webmaster@tourgram.co.kr"
    
    del_mode = "ok"		'// 삭제에  필요한 권한
    up_mode = "ok"		'// 글수정에  필요한 권한
%>

<!DOCTYPE html>
<html>
<head>
<title><%=fnTitle(cd)%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/admin/scripts/global.js"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> <%=fnTitle(cd)%></div>

        <form name="form1" method="post" enctype="multipart/form-data" style="display:inline; margin:0px;">
        <input type="hidden" name="cd"		value="<%=cd%>">
        <input type="hidden" name="rekind" value="<%=rekind%>">
        <input type="hidden" name="emp_no" value="<%=emp_no%>">  

            <div class="table_box">
                <table>
                    <tr>
                        <td width="12%" class="lop1">사진</td>
                        <td width="*%"class="lop2" colspan="3"><div style="padding:5px 0;"><img src="<%=img_path%>" onError="this.src='/admin/images/staff_img.png'" width="120" id="imgChange" name="imgChange"></div></td>
                    </tr>
                    <tr>
                        <td width="12%" class="lop1">한글명</td>
                        <td width="30%" class="lop2"><input type="text" name="nm" value="<%=nm_kor%>" style="width:200px;" class="input_basic"></td>
                        <td width="12%" class="lop3">영문명</td>
                        <td width="*%" class="lop2"><input type="text" name="nm_eng" value="<%=nm_eng%>" onKeyUp="toUpCase(this)" style="width:400px;" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="lop1">성별</td>
                        <td class="lop2">
                            <table>
                                <tr>
                                    <td width="20"><input type="radio" name="sex" value="F" <%=fnDieDie(sex,"F","checked")%> class="check_basic"></td>
                                    <td width="50">여자</td> 
                                    <td width="20"><input type="radio" name="sex" value="M" <%=fnDieDie(sex,"M","checked")%> class="check_basic"></td>
                                    <td width="*">남자</td> 
                                </tr>
                            </table>
                        </td>
                        <td class="lop3">생년월일</td>
                        <td class="lop2">
                            <table>
                                <tr>  
                                    <td width="110">
                                        <select name="birth_year"   id="birth_year" hname="태어난 년" required class="select_basic" style="width:100px;">
                                            <option value="">----</option>
                                            <%
                                                start_year	= CInt(Year(now))-80
                                                end_year		= CInt(Year(now))	           
                                                subYear start_year, end_year, birth_year																	
                                            %>
                                        </select>
                                    </td>
                                    <td width="30">년</td>
                                    <td width="80">
                                        <select name="birth_month"  id="birth_month" onChange="fnDayCall(document.getElementById('birth_year').value,this.value,document.getElementById('birth_day'))"  hname="태어난 월" required class="select_basic" style="width:70px;">
                                            <option value="">----</option>
                                            <%
                                                subMonth(birth_month)
                                            %>
                                        </select>
                                    </td>
                                    <td width="30">월</td>
                                    <td width="80">
                                        <select name="birth_day"  id="birth_day" hname="태어난 일" required class="select_basic" style="width:70px;">
                                            <option value="<%=birth_day%>"><%=birth_day%></option>
                                        </select>
                                    </td>
                                    <td width="50">일</td>
                                    <td width="20"><input type="radio" name="birth_chk" value="0" <%=fnDieDie("0",birth_chk,"checked")%> class="check_basic"></td>
                                    <td width="50">양력</td>
                                    <td width="20"><input type="radio" name="birth_chk" value="1" <%=fnDieDie("1",birth_chk,"checked")%> class="check_basic"></td>
                                    <td width="*">음력</td>
                                </tr>
                            </table>     
                        </td>
                    </tr>
                    <tr>
                        <td class="lop1">여권번호</td>
                        <td class="lop2"><input type="text" name="pp_no" value="<%=pp_no%>" style="width:200px;" maxlength="20" class="input_basic"></td>
                        <td class="lop1">여권만료일</td>
                        <td  class="lop2">
                            <table>
                                <tr>  
                                    <td width="110">
                                        <select name="pp_year"  id="pp_year"  hname="여권만료 년도" required class="select_basic" style="width:100px;">
                                            <option value="">----</option>
                                            <%
                                                start_year = CInt(Year(now))	
                                                end_year = CInt(Year(now))+20
                                                subYear start_year, end_year, pp_year		    								
                                            %>
                                        </select>
                                    </td>
                                    <td width="30">년</td>
                                    <td width="80">
                                        <select name="pp_month" id="pp_month" hname="여권만료 월" required onChange="fnDayCall(document.form1.pp_year.value,this.value,document.form1.pp_day)" class="select_basic" style="width:70px;">
                                            <option value="">----</option>
                                            <%
                                                subMonth(pp_month)
                                            %>
                                        </select>
                                    </td>
                                    <td width="30">월</td>
                                    <td width="80">
                                        <select name="pp_day" id="pp_day" hname="여권만료 일" required class="select_basic" style="width:70px;">
                                            <option value="<%=pp_day%>"><%=pp_day%></option>
                                        </select>
                                    </td>
                                    <td width="*">일</td>
                                </tr>
                            </table>   
                        </td>
                    </tr>
                    <tr>
                        <td class="lop1">주소</td>
                        <td class="lop2" colspan="3">
                            <span><input type="text" name="addnum1" id="addnum1" value="<%=addnum1%>" style="width:100px;" maxlength="5" class="input_basic" readonly></span>
                            <span id="guide" style="color:#999"></span>
                        
                            <span class="button_a" style="padding:0px 10px 0px 4px"><a onClick="addsearch_doro();return false;">우편번호 찾기</span>
                            <span><input type="text" name="address" id="address" value="<%=address%>" style="width:60%;" maxlength="100" class="input_basic"></span>   
                        </td>
                    </tr>
                </table>

                <div class="pb15"></div> 

                <table>
                    <tr>
                        <td width="12%" class="lop1">사원번호</td>
                        <td width="30%"class="lop2"><input type="text" name="em_id" value="<%=em_id%>" style="width:200px;" maxlength="8" class="input_basic"></td>
                        <td width="12%" class="lop3">비밀번호</td>
                        <td width="*%"class="lop2"><input type="password" name="em_pass" value="<%=em_pass_k%>" style="width:200px;" maxlength="8" class="input_basic"></td>
                    </tr>
                    <tr>
                        <td class="lop1">전화번호</td>
                        <td class="lop2">
                            <span style="padding: 0 5px 0 0;">사무실</span>
                            <span><input type="text" name="tell" style="width:35%;" maxlength="15" class="input_basic" value="<%=tell%>"></span>
                            <span style="padding: 0 5px 0 05px;">휴대폰</span>
                            <span><input type="text" name="tel2" style="width:35%;" maxlength="15" class="input_basic" value="<%=tel2%>"></span>
                        </td>
                        <td class="lop3">이메일</td>
                        <td class="lop2">
                            <span><input type="text" name="email1" <% If rekind="u" Then %>value="<%=email_temp(0)%>"<% end if %> onKeyUp="LowerCase(this)" style="width:25%;" maxlength="15" class="input_basic" ></span>
                            <span>@</span>
                            <span><input type="text" name="email2" <% If rekind="u" Then %>value="<%=email_temp(1)%>"<% end if %> onKeyUp="LowerCase(this)" style="width:30%;" maxlength="20" class="input_basic"  onFocus = "setEmailEnable(form1.emailcode,form1.email2)" ></span>
                            <span>
                                <select name="emailcode" style="width:20%;"  class="select_basic" onChange="setEmailcode(form1.email2,form1.emailcode,form1.emailcode.selectedIndex)" >
                                    <option value="0">--선택하세요--</option>
                                    <%
                                        subBa001_Email "mail",email
                                    %>
                                    <option value="9" >직접입력</option>
                                </select>
                            </span>
                        </td>
                    </tr>
                    <tr> 
                        <td class="lop1">부서구분</td>
                        <td class="lop2">
                            <select name="dept_cd" hname="근무부서" required class="select_basic" style="width:150px;">
                                <option selected>선택</option>
                                <%
                                    subBa001 "dept", dept_cd	
                                %>
                            </select>
                        </td>
                        <td class="lop1">직위</td>
                        <td  class="lop2">
                            <select name="grade_cd" hname="직위" required class="select_basic" style="width:150px;">
                                <option  value="">선택</option>
                                <%                  		
                                    subBa001 "duty", grade_cd	    									
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr> 
                        <td class="lop1">팀구분</td>
                        <td class="lop2">
                            <select name="team_cd" hname="팀구분" required class="select_basic" style="width:150px;">
                                <option value="">선택</option>
                                <%
                                    subBa001 "crtm", team_cd
                                %>
                            </select>
                        </td>
                        <td class="lop1">담당업무</td>
                        <td  class="lop2"><input  name="business" type="text" style="width:70%" class="input_basic" value="<%=business%>" ></td>
                    </tr>
                    <tr> 
                        <td class="lop1">어학구분</td>
                        <td class="lop2">
                            <select name="broad_cd" hname="어학코드" required class="select_basic" style="width:150px;">
                            <option  value="">선택</option>
                            <%
                                subBa001 "crbr", broad_cd
                            %>
                            </select>
                        </td>
                        <td class="lop1">어학수준</td>
                        <td  class="lop2">
                            <select name="position_cd" hname="수준" required class="select_basic" style="width:150px;">
                            <option value="">선택</option>
                            <%
                                subBa001 "crcl", position_cd	
                            %>
                            </select>
                        </td>
                    </tr>
                    <tr> 
                        <td class="lop1">입사일자</td>
                        <td class="lop2">
                            <table>
                                <tr>  
                                    <td width="110">
                                        <select name="ent_year"  id="ent_year" hname="입사일자 년" required class="select_basic" style="width:100px;">
                                            <option value="">----</option>
                                            <%
                                                start_year	= CInt(Year(now))-30
                                                end_year		= CInt(Year(now))+1
                                                subYear start_year, end_year, ent_year  											
                                            %>
                                        </select>
                                    </td>
                                    <td width="30">년</td>
                                    <td width="80">
                                        <select name="ent_month"  id="ent_month" hname="입사일자 월" required onChange="fnDayCall(document.getElementById('ent_year').value,this.value,document.getElementById('ent_day'))" class="select_basic" style="width:70px;">
                                            <option value="">----</option>
                                            <%
                                                subMonth(ent_month)
                                            %>
                                        </select>
                                    </td>
                                    <td width="30">월</td>
                                    <td width="80">
                                        <select name="ent_day"  id="ent_day" hname="입사일자 일" required class="select_basic" style="width:70px;">
                                            <option value="<%=ent_day%>"><%=ent_day%></option>
                                        </select>
                                    </td>
                                    <td width="*">일</td>
                                </tr>
                            </table>     
                        </td>
                        <td class="lop1">연차일수</td>
                        <td class="lop2">
                            <span>총 연차일 수</span>
                            <span style="padding:0px 10px 0px 5px"><input type="text" name="holidays_tot" value="<%=holidays_tot%>" style="width:70px;" class="input_basic"></span>
                            <span>사용일 수</span>
                            <span style="padding:0px 10px 0px 5px"><input type="text" name="holidays_cnt" value="<%=holidays_cnt%>" style="width:70px;" class="input_basic"></span>
                            <span>미 사용일 수</span>
                            <span style="padding:0px 10px 0px 5px"><input type="text" name="holidays_cnt2" value="<%=holidays_cnt2%>" style="width:70px;" class="input_basic"></span>
                        </td>
                    </tr>
                    <tr> 
                        <td class="lop1">사진등록</td>
                        <td class="lop2" colspan="3"><input type="file" name="file" value=""  onChange="fnChangeImg(this.value)" style="width:50%" class="input_noline" ></td>
                    </tr>
                </table>
            </div>
            
            <div class="pt25"></div>   
                
            <div align="center">
                <span class="button_b" style="padding:0px 4px"><a onclick="fnSubmit();">인사등록</a></span>
                <span class="button_b" style="padding:0px 4px"><a onClick="fnBoardList()">목록</a></span>
            </div>
            
        </form>
    </div>
        
</body>
</html>
                
<%
    CloseF5_DB objConn
%>

<script language="javascript">
<!-- 
	function fnChangeImg(strValue){
        if (strValue != ""){
            var photo, img_w, img_w
				
            photo			= new Image();
            photo.src	= strValue;

            //img_w		= photo.width;
            //img_h		= photo.height;
            img_w		= 120;
            img_h		= 155;

            document.imgChange.width		= img_w;
            document.imgChange.height		= img_h;
        }
        document.imgChange.src=strValue
	}


	function fnSubmit(){
		var obj		= document.form1;
		if(fnTrim(obj.nm.value)==""){
		    obj.nm.focus();
		    alert("이름을 입력하세요.");
		    return;
		}

		if(fnTrim(obj.tell.value)==""){ 
		    obj.tell.focus();
		    alert("사무실 전화번호를 입력하세요.");
		    return;
		}
		
		if(fnTrim(obj.email1.value)=="" || fnTrim(obj.email2.value)=="" ){
		    obj.email1.focus();
		    alert("이메일을 입력하세요.        ");
		    return;
		}
		
		obj.action		=	"write_ok.asp";
		obj.submit();
	}


	function setEmailcode(setObject,selectObject,index) {
		setObject.value=selectObject[index].text;
		if (selectObject.value == "0" || selectObject.value == "9") {
		    alert("정확한 메일주소를 선택해 주세요~~~");
		    setObject.focus();
		}
		else
		setObject.blur();
	}

	// 이메일 관련
	function setEmailEnable(emailcodeObject,ipmenu2Object) {
		if (emailcodeObject.value == "0" || emailcodeObject.value == "9") {
		    ipmenu2Object.value="";
		    ipmenu2Object.focus();
		}
		else
		ipmenu2Object.blur();
	}


	function fnBoardList(){
		var	url = 'cd=<%=cd%>&key=<%=key%>&keyfield=<%=keyfield%>&page=<%=page%>';
		location.href='list.asp?'+url;
	}
	
	function fnBoardWrite(){
		location.reload();
	}

	function fnJuminChk(value){
		var obj		= document.form1;
		if (value.length==6){
			var now = new Date();
			var now_year = (now.getYear()).toString().substr(2,2);
			month = value.substr(2,2);
			day = value.substr(4,2);

			year = parseInt(now_year)-parseInt(value.substr(0,2));

			if (year<0){
				year = '19'+value.substring(0,2).toString();	
			}else{
				year = '20'+value.substring(0,2).toString();	
			}

			obj.birth_year.value	= year;
			obj.birth_month.value=month;
			fnDayCall(obj.birth_year.value,obj.birth_month.value,obj.birth_day);
			obj.birth_day.value		= day;
		}
	}
	
	
	function toUpCase(object){
		object.value = object.value.toUpperCase(); //toLowerCase 소문자
	}
 
	function LowerCase(object){
		object.value = object.value.toLowerCase(); //toLowerCase 소문자
	} 
//-->
</script>



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function addsearch_doro() {
  
  
    new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('addnum1').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address').value = fullAddr;

         
            }
        }).open();
    }
</script>