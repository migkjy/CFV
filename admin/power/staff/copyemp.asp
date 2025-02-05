<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/power.asp"-->

<%
    OpenF5_DB objConn
%>

<!DOCTYPE html>
<html>
<head>
<title>권한 복사</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.6.2.min.js"></script>

<script language="javascript">
<!--
    function sendform(){
        if (document.myform.MY_type.value ==""){
            alert("\기존직원의 부서를 선택하세요.")
            return false;
        }    

        if (document.myform.c_emp_no.value ==""){
            alert("\기존직원 사번을 입력하셔야 합니다.")
            document.myform.c_emp_no.focus();
            return false;
        }    
        
        if (document.myform.MYk_type.value ==""){
            alert("\신규직원의 부서를 선택하세요.")
            return false;
        }    
        
        if (document.myform.p_emp_no.value ==""){
            alert("\신규 등록하고자 하는 사번을 입력하셔야 합니다.")
            document.myform.p_emp_no.focus();
            return false;
        }         

        document.myform.submit();
    }
//-->
</script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 권한 복사</div>

        <form action="copyempok.asp" method="post" name="myform" style="display:inline; margin:0px;">
	
            <div class="table_box">
                <table>
                    <tr>
                        <td width="12%" class="lop1">기존 직원사번</td>
                        <td width="15%"class="lop2">
                            <script type="text/javascript">
                                function setup_country_change(){
                                    $('#MY_type').change(update_cities);
                                }
                                function update_cities(){
                                    var dept_cd_k = $('#MY_type').attr('value');
                                    $.get('dept_sub.asp?dept_cd_k='+dept_cd_k,show_cities);
                                }  
                                function show_cities(res){
                                    $('#cities').html(res);
                                }
                                $(document).ready(setup_country_change);
                            </script>

                            <select name="MY_type" id="MY_type" class="select_basic" style="width:100%;">
                                <option value="" selected>부서선택</option>
                                <%
                                    sql = " exec proc_TB_ba001_cd_cdnm_asc  'dept'"
                                    set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open sql,objConn,3
                                    If Rs.eof or Rs.bof then
                                %>
                                <option>항목이 없습니다.</option>
                                <%
                                    Else
                                        Do Until Rs.eof
                                %>
                                <option value="<%=Trim(Rs("cd"))%>"><%=Trim(Rs("cd_nm"))%></option>
                                <%
                                        Rs.movenext
                                        Loop
                                    End if
                                    CloseRs Rs 
                                %>
                            </select>
                        </td>
                        <td width="*%"class="lop2" id="cities">
                            <select name="c_emp_no" id="PN_type" class="select_basic" style="width:200px;">
                                <option value="" selected>사원선택</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="lop1">신규 직원사번</td>
                        <td class="lop2">
                            <script type="text/javascript">
                                function setup_country_changek(){
                                    $('#MYk_type').change(update_citiesk);
                                }
                                function update_citiesk(){
                                    var dept_cd_kj = $('#MYk_type').attr('value');
                                    $.get('p_dept_sub.asp?dept_cd_kj='+dept_cd_kj,show_citiesk);
                                }  
                                function show_citiesk(res){
                                    $('#citiesk').html(res);
                                }
                                $(document).ready(setup_country_changek);
                            </script>

                            <select name="MYk_type" id="MYk_type" class="select_basic" style="width:100%;">
                                <option value="" selected>부서선택</option>
                                <%
                                    sql = " exec proc_TB_ba001_cd_cdnm_asc  'dept'"
                                    set Rs = Server.CreateObject("ADODB.RecordSet")
                                    Rs.open sql,objConn,3
                                    If Rs.eof or Rs.bof then
                                %>
                                <option>항목이 없습니다.</option>
                                <%
                                    else
                                    Do Until Rs.eof
                                %>
                                <option value="<%=Trim(Rs("cd"))%>"><%=Trim(Rs("cd_nm"))%></option>
                                <%
                                    Rs.movenext
                                    Loop
                                    end if
                                    CloseRs Rs 
                                %>
                            </select>
                        </td>
                        <td class="lop2" id="citiesk">
                            <select name="p_emp_no" id="PN_typek" class="select_basic" style="width:200px;">
                                <option value=" " selected>사원선택</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            
            <div class="pt25"></div>   
                
            <div align="center">
                <span class="button_b" style="padding:0px 2px"><a onclick="sendform()">복사하기</a></span>
            </div>
            
        </form>
    </div>
        
</body>
</html>  
