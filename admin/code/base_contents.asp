<!--#include virtual="/admin/conf/config.asp"-->

<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"
    Response.AddHeader	"Expires","0"

    OpenF5_DB objConn

    cd_fg = Request("cd_")
    cd_nm = Request("cd_nm_")
    cd_fg_ = Request("cd_fg_")

    If cd_fg="" Then 
        cd_fg = cd_fg_
    End if
%>

<!DOCTYPE html>
<html>
<head>
<title>상품코드생성</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script language="javascript" type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
<script language="javascript" type="text/javascript" src="/admin/scripts/iframeResizer.contentWindow.min.js"></script>
</head>

<body>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #C0C0C0;height:40px;">
        <tr>
            <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="50%" style="padding:0px 0px 0px 20px">추가할 항목 입력하세요.</td>
                        <td width="*%">
                            <div align="right">
                                <span class="button_a" style="padding:0px 5px 0px 0px"><a onClick="fnChkBaseContentsList()">새로고침</a></span>
                                <span class="button_a" style="padding:0px 20px 0px 0px"><a onClick="fnChkBaseContentsIn('<%=cd_fg%>')">추가</a></span>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
    <div class="pb15"></div>  
    
    <div id="left_div" style="padding:0px;width:100%">
        <div class="p_overbox1" style="width:100%;height:100%"  onScroll="SetScrollPos_Left(this,document.getElementById('base_left_table'));">
            <div id="base_left_table" >

                <div class="table_list">
                    <table>
                        <tr>
                            <td width="9%" class="top1">코드</td>
                            <td width="*%" class="top2">코드명</td>
                            <td width="10%" class="top2">타입1</td>
                            <td width="10%" class="top2">타입2</td>
                            <td width="8%" class="top2">중지</td>
                            <td width="25%" class="top2">참고사항</td>
                            <td width="9%" class="top2">수정</td>
                            <td width="9%" class="top2">삭제</td>
                        </tr>
                     </table>
                     
                     <div id="con_base_in_table"></div>

                    <table>
                        <%
                            sql = "exec proc_TB_ba001_s01_all '"& cd_fg &"'"
                        
                            Set Rs = Server.CreateObject("ADODB.RecordSet")
                            Rs.open sql,objConn,3
                            count		= Rs.recordcount
                            
                            If Not Rs.Eof Then
                                k = 1
                                Do Until Rs.Eof
                                    remark = Replace(Rs("remark"),"'","")
                                    remark = Replace(Rs("remark"),"&amp;","&")
                        %>	
                        <tr bgcolor="#FFFFFF" onmouseover="this.style.backgroundColor='#D7ECFF';" onmouseout="this.style.backgroundColor='';">
                            <td width="9%" class="tob1"><input type="text" name="con_cd<%=k%>" id="con_cd<%=k%>" value="<%=Rs("cd")%>" style="width:80%;" class="input_basic" onClick="fnChkBaseContents('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>', '<%=Rs("del_fg")%>', '<%=remark%>', '<%=Rs("char_fr")%>','<%=Rs("char_to")%>' ,<%=k%>,<%=count%>)"></td>
                            <td width="*%" class="tob2"><input type="text" name="con_cd_nm<%=k%>" id="con_cd_nm<%=k%>" value="<%=Rs("cd_nm")%>" style="width:85%;" class="input_basic" onClick="fnChkBaseContents('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>', '<%=Rs("del_fg")%>', '<%=remark%>', '<%=Rs("char_fr")%>','<%=Rs("char_to")%>' ,<%=k%>,<%=count%>);"></td>
                            <td width="10%" class="tob2"><input type="text" name="con_char_fr<%=k%>" id="con_char_fr<%=k%>" value="<%=Rs("char_fr")%>" style="width:90%;" class="input_basic" onClick="fnChkBaseContents('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>', '<%=Rs("del_fg")%>', '<%=remark%>', '<%=Rs("char_fr")%>','<%=Rs("char_to")%>' ,<%=k%>,<%=count%>)" ></td>
                            <td width="10%" class="tob2"><input type="text" name="con_char_to<%=k%>"  id="con_char_to<%=k%>" value="<%=Rs("char_to")%>" style="width:80%;" class="input_basic" onClick="fnChkBaseContents('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>', '<%=Rs("del_fg")%>', '<%=remark%>', '<%=Rs("char_fr")%>','<%=Rs("char_to")%>' ,<%=k%>,<%=count%>)"></td>
                            <td width="8%" class="tob2">
                                <select name="con_del_fg<%=K%>" id="con_del_fg<%=K%>" style="width:70%;" class="select_basic" onClick="fnChkBaseContents('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>',  '<%=remark%>',  '<%=Rs("char_fr")%>','<%=Rs("char_to")%>' ,<%=k%>,<%=count%>)">
                                    <option value='Y' <%=fnSemSem(Rs("del_fg"),"Y")%>>Y</option>
                                    <option value='N' <%=fnSemSem(Rs("del_fg"),"N")%>>N</option>
                                </select>
                            </td>
                            <td width="25%" class="tob2"><input type="text" name="con_remark<%=k%>" id="con_remark<%=k%>"  value="<%=Replace(Rs("remark"),"'",Chr(34))%>" style="width:90%;" class="input_basic" onClick="fnChkBaseContents('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>', '<%=Rs("del_fg")%>', '<%=remark%>', '<%=Rs("char_fr")%>','<%=Rs("char_to")%>' ,<%=k%>,<%=count%>)"></td>
                            <td width="9%" class="tob2"><span class="button_a"><a onClick="fnChkBaseContentsUp(escape(document.getElementById('con_cd<%=k%>'). value), escape(document.getElementById('con_cd_nm<%=k%>').value), document.getElementById('con_del_fg<%=k%>').value, escape(document.getElementById('con_remark<%=k%>').value), document.getElementById('con_char_fr<%=k%>').value, escape(document.getElementById('con_char_to<%=k%>').value), escape('<%=cd_fg%>'),escape('<%=Rs("cd")%>'), escape('<%=Rs("cd_nm")%>'), escape('<%=Rs("del_fg")%>'), escape('<%=remark%>'))">수정</a></span></td>
                            <td width="9%" class="tob2"><span class="button_a"><a onClick="fnChkBaseContents('<%=Rs("cd")%>', '<%=Rs("cd_nm")%>',<%=k%>,<%=count%>);fnChkBaseContentsDel(escape('<%=Rs("cd")%>'),escape('<%=Rs("cd_nm")%>'),'<%=cd_fg%>')">삭제</a></span></td>
                        </tr>
                        <%
                                Rs.MoveNext
                                k = k+1
                                Loop
                            End If 
    		            		    		
                            CloseRs Rs
                        %>
                    </table>
                    
                    <form name="frmCommon" id="frmCommon" method="post">
                    <input type="hidden" name="con_cd" id="con_cd" value=""><!------ 메인 기초 설명 세팅하기  ---->
                    <input type="hidden" name="con_cd_nm" id="con_cd_nm" value=""><!------ 메인 기초 설명 세팅하기  ---->
                    <input type="hidden" name="con_del_fg" id="con_del_fg" value=""><!------ 메인 기초코드값 세팅하기  ---->
                    <input type="hidden" name="con_remark" id="con_remark" value=""><!------ 메인 기초 설명 세팅하기  ---->
                    <input type="hidden" name="con_char_fr" id="con_char_fr" value=""><!------ 메인 기초 설명 세팅하기  ---->
                    <input type="hidden" name="con_char_to" id="con_char_to" value=""><!------ 메인 기초 설명 세팅하기  ---->
                    <input type="hidden" name="con_num" id="con_num" value=""><!------ 메인 기초 설명 세팅하기  ---->
                    <input type="hidden" name="con_count" id="con_count" value=""><!------ 메인 기초 설명 세팅하기  ---->
                    <input type="hidden" name="con_insert_num"  id="con_insert_num" value="1000"><!------ 메인 추가시 넘버링  ---->
                    <input type="hidden" name="con_base_add_in" id="con_base_add_in" value=""><!------ 메인 추가시 넘버 저장 1000@1001@1002.... ---->
                    </form>
                    <iframe name="ifmJob" id="ifmJob" src=""  allowTransparency=true width="0" height="0" marginwidth="0" marginheight="0" vspace="0" scrolling="no" frameborder="0" framespacing="0"></iframe>
                </div>
                
            </div>
        </div>
    </div>

</body>
</html>

<%
    CloseF5_DB objConn 
%>

<script language="javascript">
<!--
    function SetScrollPos_Left(tagDIV,obj_tbl){
        var positionTop = 0;
        if (tagDIV != null){
            positionTop = parseInt(tagDIV.scrollTop, 10);
            obj_tbl.style.top = positionTop;
        }
    }
    
    
    function fnChkBaseContents(cd, cd_nm, del_fg, remark, char_fr,char_to, num, count){
    
        for(k=1;k<=count;k++){
            obj1 = document.getElementById('con_cd'+k);
            obj2 = document.getElementById('con_cd_nm'+k);
            obj3 = document.getElementById('con_del_fg'+k);
            obj4 = document.getElementById('con_remark'+k);
            obj5 = document.getElementById('con_char_fr'+k);
            obj6 = document.getElementById('con_char_to'+k);
    
            obj1.style.backgroundColor = '#ffffff';
            obj2.style.backgroundColor = '#ffffff';
            obj3.style.backgroundColor = '#ffffff';
            obj4.style.backgroundColor = '#ffffff';
            obj5.style.backgroundColor = '#ffffff';
            obj6.style.backgroundColor = '#ffffff';
    
            if (k==num){
                obj1.style.backgroundColor = '#DFF2FE';
                obj2.style.backgroundColor = '#DFF2FE';
                obj3.style.backgroundColor = '#DFF2FE';
                obj4.style.backgroundColor = '#DFF2FE';
                obj5.style.backgroundColor = '#DFF2FE';
                obj6.style.backgroundColor = '#DFF2FE';
            }
        }
        document.getElementById('con_cd').value				= cd;
        document.getElementById('con_cd_nm').value		= cd_nm;
        document.getElementById('con_del_fg').value		= del_fg;
        document.getElementById('con_remark').value		= remark;
        document.getElementById('con_char_fr').value	= char_fr;
        document.getElementById('con_char_to').value	= char_to;
        document.getElementById('con_num').value			= num;
        document.getElementById('con_count').value		= count;
    
    } 
    
    
    //** 데이터 수정
    function fnChkBaseContentsUp(cd, cd_nm, del_fg, remark,char_fr,char_to, cd_fg, cd_, cd_nm_, del_fg_,remark_){
        var msg = confirm(/*cd_nm_+'('+cd_+')(을)를 '+cd_nm+'('+cd+')*/''+' 수정하시겠습니까?    ');
        var url = 'cd='+cd+'&cd_nm='+cd_nm+'&del_fg='+del_fg+'&remark='+remark+'&char_fr='+char_fr+'&char_to='+char_to+'&cd_fg='+cd_fg+'&cd_='+cd_+'&cd_nm_='+cd_nm_+'&del_fg_='+del_fg_+'&remark_='+remark_;
    
        if (msg){
            ifmJob.location.href = 'base_contents_up.asp?'+url;
        }
    } 
    
    
    //** 데이터 삭제
    function fnChkBaseContentsDel(cd, cd_nm, cd_fg){
        var msg = confirm(/*cd_nm+'('+cd+')(을)를 */'삭제하시겠습니까?     ');
        var url = 'cd='+escape(cd)+'&cd_nm='+escape(cd_nm)+'&cd_fg='+escape(cd_fg);
        if (msg){
            ifmJob.location.href = 'base_contents_del.asp?'+url;
        }
    }
    
    
    //** 새로고침 기능
    function fnChkBaseContentsList(){
    	location.reload();
    }
    
    
    //** 데이터 생성 리스트 삭제
    function fnChkBaseContentsAddDel(obj,num){
        var base_add_in	= '';
        var num_string	= num.toString() + '@';
        base_add_in = document.getElementById('con_base_add_in').value;
    
        base_add_in	= base_add_in.replace(num_string,'');
        document.getElementById('con_base_add_in').value	= base_add_in;
    	
        obj.style.display = 'none';
    }
    
    
    
    //** 데이터 저장
    function fnChkBaseContentsAddIn(cd_fg){//////////// 데이터 추가
        var url = '';
        var str = document.getElementById('con_base_add_in').value;
        var value = '';
    
        str = str.substring(0, str.length -1);	//새로 추가시 번호조합 1000@1001....
        str_list = str.split('@');
    
        size = str_list.length;//받는 페이지에서 배열 개수를 받기위해..
    
        if (size>50){
            alert('50개 까지 등록가능합니다');	//등록제한
            return;
        }
    
    
        for(i = 0 ; i < size; i++){
    		    num_i		= str_list[i];
    		    if (num_i.length!=4){			//저장되어진 숫자들이 4자리가 아닐때
    		        alert('잘못된 값입니다.');
    		        return;
    		    }
            
    		    num_i					= num_i.toString();
    		    cd_i					= 'con_cd' + num_i;
    		    cd_nm_i				= 'con_cd_nm' + num_i;
    		    cd_remark_i		= 'con_remark' + num_i;
    		    cd_char_fr_i	= 'con_char_fr' + num_i;
    		    cd_char_to_i	= 'con_char_to' + num_i;
            
    		    cd_str					= escape(document.getElementById(cd_i).value);
    		    cd_nm_str				= escape(document.getElementById(cd_nm_i).value);
    		    cd_remark_str	=	 escape(document.getElementById(cd_remark_i).value);
    		    cd_char_fr_str	= escape(document.getElementById(cd_char_fr_i).value);
    		    cd_char_to_str	= escape(document.getElementById(cd_char_to_i).value);
            
    		    
    		    if(cd_remark_str==''){cd_remark_str=' '}
    		    if(cd_char_fr_str==''){cd_char_fr_str=' '}
    		    if(cd_char_to_str==''){cd_char_to_str=' '}
            
    		    
    		    if(isNaN(num_i)){
    		        alert('오류가 발생했습니다. 새로고침후 사용하세요');	//저장되어진 변수가 숫자가 아닐때
    		        return;
    		    }
            
    		    if (cd_str=='' || cd_nm_str==''){
    		        alert('입력값이 비었습니다.');	
    		        return;
    		    }
            
    		    value	= value + cd_str + '||' + cd_nm_str + '||' + cd_remark_str + '||' + cd_char_fr_str + '||' + cd_char_to_str + '@@';//스트링으로 넘겨 배열로 처리하기 위해 cd||값@@cd_nm||값
        }   
        value	= value.substring(0, value.length-2);
    
        url	= 'cd_fg='+cd_fg+'&value='+value;
    
        ifmJob.location.href = 'base_contents_In.asp?'+url;
    }
    
    
   //** 추가 리스트 생성
    function fnChkBaseContentsIn(cd_fg){
		num = document.getElementById('con_insert_num').value;
		num = parseInt(num) + 1;
   		
		document.getElementById('con_base_add_in').value	+= num.toString() + '@';
		document.getElementById('con_insert_num').value		= num;
		base =			  "    <table id='con_table_display"+num+"'>"
		base = base + "        <tr> "
		base = base + "            <td width='9%' class='tob1'><input type='text' name='con_cd"+ num +"' id='con_cd"+ num +"' value='' style='width:80%;' class='input_basic'></td>"
		base = base + "            <td width='*%' class='tob2'><input type='text' name='con_cd_nm"+ num +"' id='con_cd_nm"+ num +"' value='' style='width:85%;' class='input_basic'></td>"
		base = base + "            <td width='10%' class='tob2'><input type='text' name='con_char_fr"+ num +"'  id='con_char_fr"+ num +"' value='' style='width:90%;' class='input_basic'></td>"
		base = base + "            <td width='10%' class='tob2'><input type='text' name='con_char_to"+ num +"' id='con_char_to"+ num +"' value = '' style='width:80%;' class='input_basic'></td>"
		base = base + "            <td width='8%' class='tob2'>"
		base = base + "                <select name='con_del_fg"+ num +"'  id='con_del_fg"+ num +"' style='width:70%;' class='select_basic'>"
		base = base + "                    <option value='N'>N</option>"
		base = base + "                </select>"
		base = base + "            </td>"
		base = base + "            <td width='25%' class='tob2'><input type='text' name='con_remark"+ num +"' id='con_remark"+ num +"' value='' style='width:90%;' class='input_basic'></td>"
		base = base + "            <td width='9%' class='tob2'><span class='button_a'><a onClick=\"fnChkBaseContentsAddIn('"+cd_fg+"')\">등록</a></span></td>"
		base = base + "            <td width='9%' class='tob2'>	<span class='button_a'><a onClick=\"fnChkBaseContentsAddDel(document.getElementById('con_table_display"+ num +"'),"+ num +")\" id='del_"+num+"'>삭제</a></span></td>"
		base = base + "	        </tr>"
		base = base + "	    </table>"
		document.getElementById("con_base_in_table").innerHTML +=  base;
	
    }
//-->
</script>
