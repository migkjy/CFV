<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<!DOCTYPE html>
<html>
<head>
<title>메인 인트로</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 메인 인트로</div>

        <%       
            OpenF5_DB objConn
        
            sql ="SELECT top 5 num, i_img, i_url, title, remark, use_yn  from main_new_img where g_kind='10' and sub_kind='P'  order by num asc  "
            Set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sql,objConn,3
        
            IF Rs.eof then
            Else
        
                i=1
                Do until Rs.eof
        
                  r_num    = Rs("num")
                  r_img    = Rs("i_img")
                  r_url    = Rs("i_url")
        
                  r_title  = Rs("title")
                  r_remark = Rs("remark")
                  r_use_yn = Rs("use_yn")

                  img_size_remark ="가로 1920px 세로 940px "
        %>
        <form name="uploadForm<%=r_num%>"  method="post" enctype="multipart/form-data"  >
            <div class="table_box">
                <table>
                    <tr>
                        <td width="700px" class="lop1" valign="top"><div align="left"><img src="/board/upload/main_img/<%=r_img%>" id="imgname_<%=r_num%>" width="100%" border="0"></div></td>
                        <td width="*%" class="lop4" valign="top">
                            <table>
                                <tr> 
                                    <td width="110px" style="font-weight:500;">① 이미지</td>
                                    <td width="*%"><input type="file" name="srcfile" style="width:96%;" class="input_file"></td>
                                </tr>
                                <tr> 
                                    <td style="font-weight:500;">② 사용유무</td>
                                    <td>
                                        <select name="use_yn" class="select_basic" style="width:100px;">
                                     	    <option value="Y" <% if r_use_yn ="Y" then response.write "selected" End if %>>사용</option>
                                     	    <option value="N" <% if r_use_yn ="N" then response.write "selected" End if %>>미사용</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr> 
                                    <td colspan="2">※ 이미지 사이즈는 <strong><%=img_size_remark%></strong> 입니다. <strong><%=img_txt%></strong></td>
                                </tr>
                                <tr> 
                                    <td colspan="2"><span class="button_b"><a onClick="sendit<%=r_num%>();">수정</a></span></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

                <input type="hidden" name="num" value="<%=r_num%>"> 
                <input type="hidden" name="g_kind" value="<%=ts%>"> 
                        
                <script type="text/javascript">
                <!--
                    function sendit<%=r_num%>(){
                        document.uploadForm<%=r_num%>.action = "img_ok.asp";
                        document.uploadForm<%=r_num%>.target = "uploadIFrame";
                        document.uploadForm<%=r_num%>.submit();
                    }
                 //-->
                </script>
                <div class="pt15"></div>  
            </div> 
        </form>
        <%
                Rs.movenext
                i = i + 1
                Loop
                        
            End if
                        
            Rs.close  : Set Rs = nothing
        %>
        <iframe id="uploadIFrame" name="uploadIFrame" width="0" height="0" style="display:none;"></iframe>
    </div>

</body>
</html>