<%
    OpenF5_DB objConn	


    sql = " SELECT  kname,memid,  htel,point  FROM TB_member where memid= '"&memid&"' "
    Set Rs = objConn.Execute(sql)
           
    mem_nm  = Trim(Rs("kname"))
    tot_hp  = Trim(Rs("htel"))
    point  = Trim(Rs("point"))
       
    Rs.close  : Set Rs = nothing
    
    
    sql5 = "select num, send_name, send_hp, app_gubn, ins_dt, cu_nm_kor, cu_hp, del_yn from TB_sel_memo where (send_hp = '"&tot_hp&"'  or  cu_hp  = '"&cu_htel&"')  and app_gubn = '1' and del_yn='N'"
    Set mRs = Server.CreateObject("ADODB.RecordSet")
    mRs.open sql5,objConn,3
    rs_cnt = mRs.RecordCount
    
    If mRs.eof or mRs.bof then
        cntSql = "select count(*) from TB_sel_memo where send_hp = '"&tot_hp&"'  and app_gubn = '0' and del_yn='N'"
        Set cntRs = Server.CreateObject("ADODB.RecordSet")
        cntRs.open cntSql,objConn
        if cntRs.eof or cntRs.bof then
            me_Cnt = 0
        else
            me_Cnt = cntRs(0)
        end if
        CloseRs cntRs
    End if  
%>

<!--매칭 요청이 있을때만 -->
<%  If me_Cnt <> 0 then %>

    <script language="JavaScript" type="text/JavaScript">
        function setCookie( name, value, expiredays ) { 
            var todayDate = new Date(); 
                todayDate.setDate( todayDate.getDate() + expiredays ); 
                document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
            } 
        
        function closeWin() { 
            if ( document.notice_form.chkbox.checked ){ 
                setCookie( "maindiv", "done" , 1 ); 
            } 
            document.all['divpop'].style.visibility = "hidden";
        }
    </script>
    
    <div id="divpop" style="width:100%;height:auto;background:url('/images/main/pop_bg.png');position:absolute;z-index:1000;visibility:hidden;">
        <div style="padding:260px 0px 900px 0px;">
            <div align="center">
                <table width="568" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width:100%;height:auto;background:url('/images/main/matching_bg.png');height:434px;border-radius:20px;" valign="top">
                            <div align="center">
                                <div style="font-size:18px; font-weight:700; padding:80px 0 5px 0;"><%=mem_nm%>님</div>
                                <div>
                                    <span style="font-size:16px; font-weight:500;">룸메이트 매칭이</span>
                                    <span style=color:#FF5000;font-size:18px;"><strong>"<%=me_Cnt%>"</strong></span>
                                    <span style="font-size:16px; font-weight:500;">건</span>
                                </div>
                                <div style="font-size:16px; font-weight:500;">요청이 있습니다.</div>
                                
                                <a href="/home/mypage/my_page.asp">
                                    <div style="font-size:13px; padding:5px 0 5px 0;">마이페이지에서<br>매칭 확정을 선택하세요</div>
                                    <div><img src="/images/main/icon_my.png" border="0" style="border-radius:4px;"></div>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <tr height="45">
                        <td align="center">	
                            <form name="notice_form" style="display:inline; margin:0px;">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="70%"style="padding:0px 0px 0px 1px"><span class="checks"><input type="checkbox" name="chkbox" id="chkbox" value="checkbox"><label for="chkbox"><span style="color:#FFFFFF; font-size:15px;">다시보지 않기</span></label></span></td>
                                        <td width="*%" style="padding:0px 10px 0px 0px" align="right"><a href="javascript:closeWin();"><img src="/images/main/close.png" border="0"></a></td>
                                    </tr>
                                </table>
                            </form>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    
    <script language="Javascript">
        cookiedata = document.cookie;    
        if ( cookiedata.indexOf("maindiv=done") < 0 ){      
            document.all['divpop'].style.visibility = "visible";
            } 
            else {
                document.all['divpop'].style.visibility = "hidden"; 
        }
    </script>

<%
    End if 
    CloseF5_DB objConn  
%>