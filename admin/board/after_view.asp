<!--#include virtual="/admin/conf/config.asp"-->
<!--#include virtual="/admin/inc/cookies.asp"-->
<!--#include virtual="/admin/inc/support.asp"-->

<%
    tbl = "trip_after"
    tbl2 = "trip_after_dat"
 
    num = Request("num")
       If Trim(num)="" or isnull(num) then
             Response.write "<script type='text/javascript'>"
             Response.write " alert('접근하실수 없습니다1...'); "
             Response.write " history.back();"
             Response.write " </script>	 "
             Response.end
       End if 
  

    gotopage = Request("gotopage")

    s_cont = Request("s_cont")
    s_cont = Replace(s_cont,"'","") 
    cont = Request("cont")
    cont = Replace(cont,"'","")


    OpenF5_DB objConn

    sql="select num , user_id , user_nm , title , con_tents , img  ,img_w  ,img_h , ins_dt , hit  from "&tbl&" where num="&num&" and del_yn='N' " 
    Set Rs = objConn.Execute(Sql)

    If rs.eof or rs.bof then
        Response.write "<script type='text/javascript'>"
        Response.write " alert('접근하실수 없습니다....'); "
        Response.write " history.back(); "
        Response.write " </script>	 "
        Response.End
    Else
        num       = Rs("num")
        user_nm   = Rs("user_nm")
        title     = Rs("title")
        con_tents = Rs("con_tents")
        
                if not isnull(con_tents) or con_tents <> "" then   
                 con_tents = replace(con_tents,chr(13)&chr(10),"<br>")
             end if
             
        t_img = Rs("img")
        img_w = Rs("img_w")
          if img_w > 200 then
            img_w =200
          End if
        img_h = Rs("img_h")
    
        ins_dt = left(Rs("ins_dt"),10)
        hit = Rs("hit")
    End if
    
    CloseRs Rs
    
    sql = " update "&tbl&" set hit = hit + 1   where num = "&num
    objConn.Execute(sql)  
%>

<!DOCTYPE html>
<html>
<head>
<title>발리 맛집</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="icon" type="image/png" sizes="32x32" href="/images/logo/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/images/logo/favicon-16x16.png">
<script type="text/javascript" src="/admin/scripts/jquery-1.9.1.js"></script>
</head>

<body>

    <div style="padding:10px 10px 50px 0px">
    	
        <div class="title_sujet"><i class="xi-align-left xi-x"></i> 발리 맛집</div>

        <div class="table_box">
            <table>
                <tr>
                    <td width="12%" class="lop1">작성자</td>
                    <td width="*%" class="lop2"><%=User_nm%></td>
                </tr>
                <tr>
                    <td class="lob1">등록일</td>
                    <td class="lob2"><%=ins_dt%></td>
                </tr>
                <% if Len(t_img)> 3 then %>
                <tr>
                    <td class="lob1">이미지</td>
                    <td class="lob5"><img src="/board/upload/after/<%=t_img%>" border="0" width="<%=img_w%>" valign="middle"></td>
                </tr>
                <% end if %>
                <tr>
                    <td class="lob1">제 목</td>
                    <td class="lob2"><%=title%></td>
                </tr>
                <tr>
                    <td class="lob1">내 용</td>
                    <td class="lob5"><%=con_tents%></td> 
                </tr>
            </table> 
         
            <div class="pt25"></div>   
            
            <div align="center">
                <span class="button_b" style="padding:0px 4px"><a onClick="location.href='after_ins.asp?num=<%=num%>'">수정</a></span>
                <span class="button_b" style="padding:0px 4px"><a onClick="check_del('<%=num%>')" >삭제</a></span>
                <span class="button_b" style="padding:0px 4px"><a href="after_list.asp">목록</a></span>
            </div>
            
            <div class="pt25"></div> 
            <% 
                sql2="select seq ,num ,user_nm, content, passwd,ins_dt  from "&tbl2&" where num="&num&" and del_yn='N' order by seq desc "
                Set Rs2 = objConn.Execute(Sql2)
                                
                If NOT (Rs2.eof or Rs2.bof) then
                                     
                    Do until Rs2.EOF
                                
                        r_seq = Rs2("seq")
                        r_num = Rs2("num")
                        r_user_nm  = Rs2("user_nm")
                        r_content  = Rs2("content")
                        if not isnull(r_content) or r_content <> "" then   
                            r_content = replace(r_content,chr(13)&chr(10),"<br>")
                        end if
                                         
                        r_ins_dt   = Left(Rs2("ins_dt"),10)
            %>
                <table>
                    <tr>
                        <td width="12%" class="cop4">댓글</td>
                        <td width="8%" class="cop7"><%=r_user_nm%></td>
                        <td width="8%" class="cop7"><%=r_ins_dt%></td>
                        <td width="*%" class="cop5"><div style="padding:5px 0;"><%=r_content%></div></td>
                        <td width="10%" class="cop7" ><span class="button_a"><a onclick="dat_del('<%=r_seq%>','<%=num%>')">삭제</a></span></td>
                    </tr>
                </table>
                
                <div class="pt10"></div>  
            <%
                    Rs2.movenext
                    Loop
                                    
                End if
                                
                Closers Rs2
            %>
            
            <form name="reply" method="post" action="dat_write.asp" style="display:inline; margin:0px;" >
            <input type="hidden" name="num" value="<%=num%>">
            <input type="hidden" name="tb" value="af" >
            <input type="hidden" name="ss" value="<%=Session.SessionID%>">
                <table>
                    <tr>
                        <td width="12%" class="cop4">댓글등록</td>
                        <td width="8%" class="cop7">한글명</td>
                        <td width="8%" class="cop7"><input type="text" name="dat_user_nm" style="width:75%;" maxlength="20" class="input_color"></td>
                        <td width="8%" class="cop7">비밀번호</td>
                        <td width="8%" class="cop7"><input type="password" name="dat_pass" style="width:75%; " maxlength="10" class="input_color"></td> 
                        <td width="*%" class="cop6"><textarea name="dat_content" cols="20" wrap="VIRTUAL" style="width:100%; border:1px solid #d8d9d9;background-color:#F8F9F9; height:50px;"></textarea></td>
                        <td width="10%" class="cop7" ><span class="button_a"><a onclick="dat_write();">등록</a></span></td>
                    </tr>
                </table>
                <iframe src="about:blank" name="dat_wr" id="dat_wr" width="0" height="0" allowTransparency=true  marginwidth="0" marginheight="0" vspace="0"></iframe>
            </form>
        </div>
        
    </div>
    
</body>
</html>

<%
    CloseF5_DB objConn 
%>

<script type="text/javascript">
<!--
    function check_del(num){
        answer = confirm("위의 글을 정말 삭제하시겠습니까?");
        if(answer==true){
            location.href="after_del.asp?num="+num+"&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>";
        }
    }

    function dat_del(z,a){
        if(confirm("정말로 삭제하시겠습니까?")){
            location.href="dat_del.asp?seq="+z+"&num="+a+"&gotopage=<%=gotopage%>&s_cont=<%=s_cont%>&cont=<%=cont%>&page=af";
        }
    }


    function dat_write(){
        var	f  = document.reply;

        if(!f.dat_user_nm.value){
            alert("한글명을 넣어주세요.");
            f.dat_user_nm.focus();
            return false;
        }

        if(!f.dat_pass.value){
            alert("비밀번호를 넣어주세요.");
            f.dat_pass.focus();
            return false;
        }
	
        if(f.dat_pass.value.length< 4){
            alert("비밀번호는 4글짜 이상 입력하셔야 합니다.");
            f.dat_pass.focus();
            return false;
        }

        if(!f.dat_content.value){
            alert("내용을 넣어주세요.");
            f.dat_content.focus();
            return false;
        }

        f.target = "dat_wr";
        f.submit();
    }
//-->
</script>


