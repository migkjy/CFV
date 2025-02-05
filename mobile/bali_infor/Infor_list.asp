<!--#include virtual="/home/conf/config.asp" -->
<!--include virtual="/home/inc/cookies2.asp"-->
<!--#include virtual="/home/inc/support.asp"-->
<!--#include virtual="/mobile/scripts/mobile_checker.asp" -->   

<%
    Response.Expires = -1
    Session.codepage=65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private" 
%>      

<!DOCTYPE html>
<head>
<title><%=title1%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=yes">
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no,width=device-width" />

<meta property="og:url" content="<%=GLOBAL_URL%>">
<meta property="og:type" content="website">
<meta property="og:title" content="<%=GLOBAL_NM%>">
<meta property="og:image" content="<%=GLOBAL_URL%>/images/logo/sm_logo.png">
<meta property="og:description" content="<%=GLOBAL_NM%>">
<meta name="description" content="<%=GLOBAL_NM%>">
<meta name='keywords' content="<%=GLOBAL_NM%>">

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<link rel="shortcut icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">
<link rel="apple-touch-icon" href="<%=GLOBAL_URL%>/images/logo/sm_mobile.png">

<link rel="stylesheet" type="text/css" href="/mobile/css/import.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner1.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/banner2.css">

<script type="text/javascript" language="javascript" src="/mobile/js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/slick.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/swiper.min.js"></script>
<script type="text/javascript" language="javascript" src="/mobile/js/common.js"></script>

<script type="text/javascript" src="/home/js/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="/home/js/jquery-ui.css" />

<script src="/mobile/js/jquery.fancybox.pack.js?v=2.1.4"></script>
<link rel="stylesheet" type="text/css" href="/mobile/css/jquery.fancybox.css?v=2.1.4" />  
</head>

<body>

    <div id="wrap" data-role="page" data-dom-cache="false">
    	
        <!--#include virtual="/mobile/include/left_menu.asp"-->
        <!--#include virtual="/mobile/include/top_menu.asp"-->
        
        <%
            OpenF5_DB objConn

            sli_sql ="SELECT top 8 count(num) from main_new_img where g_kind='20' and sub_kind='P' and use_yn='Y'"
           
            Set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sli_sql , objConn , 3
            ss_cnt = Rs(0)
            rs.close : Set rs=nothing
             
            ReDim e_img(ss_cnt), e_url(ss_cnt), e_title(ss_cnt), e_remark(ss_cnt)
             
            sql =" select  i_img, title, remark  from  main_new_img WHERE  (g_kind = 20) and sub_kind='P' and use_yn='Y' order by num asc"
            Set Rs = Server.CreateObject("ADODB.RecordSet")
            Rs.open sql,objConn,3
             
            If rs.EOF Then
            Else
                i =0
                Do until Rs.eof
             
                    r_img = Rs("i_img")
                    r_title = Rs("title")
                    r_remark = Rs("remark")
             
                    e_img(i)   = r_img
                    e_title(i) = r_title
                    e_remark(i) = r_remark
                    if not isnull(e_remark(i)) or e_remark(i) <> "" then   
                        e_remark(i) = replace(e_remark(i),chr(13)&chr(10),"<br>")
                    end if
                    
                Rs.movenext
                i = i +1
                Loop
            End if
             
            Rs.close : Set Rs=nothing
            
            CloseF5_DB objConn
        %> 
        
        <div style="width:100%;height:200px;background:url('/board/upload/main_img/<%=e_img(4)%>') no-repeat;background-position:top center;background-size:cover;">
            <div align="center">
                <table width="100%" height="200" border="0" cellpadding="0" cellspacing="0" style="background:url('/images/main/bg_main.png')">
                    <tr>
                        <td>
                            <div align="center">
                                <div class="sub_top_en"><%=e_title(4)%></div>
                                <div class="sub_top_ko"><%=e_remark(4)%></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="best_main1">
            <%
                OpenF5_DB objConn
            
                cd = Request("cd")
                nat_cd =trim( Request("nat_cd"))
                city = trim( Request("city"))
                infor_cd = Request("infor_cd")

                sql = " select a.nm_kor, a.nm_eng, b.description "
                sql = sql & " from TB_ti100 a LEFT OUTER JOIN  TB_ti110 b  ON a.nat_cd = b.nat_cd "
                sql = sql & " where a.nat_cd   = '"& nat_cd &"' "
                sql = sql & " order by  b.nat_cd, b.desc_cd	"	
                'response.write  sql
                set Rs = Server.CreateObject("ADODB.RecordSet")
                Rs.open sql,objConn,3
            
                If not rs.EOF Then
                    nm_kor = Rs("nm_kor")
                    nm_eng = Rs("nm_eng")
                    description = Rs("description")	 
                End If
    
                Rs.close  : set Rs = nothing
            %>

            <%
                sql = " select a.nm_kor, a.nm_eng, b.description "
                sql = sql & " from TB_ti200 a LEFT OUTER JOIN   TB_ti210 b  ON a.nat_cd = b.nat_cd and  a.city_cd = b.city_cd "
                sql = sql & " where a.nat_cd   = '"& nat_cd &"' "
                sql = sql & " and a.city_cd  = '"& city &"' "

                set Rs = Server.CreateObject("ADODB.RecordSet")
                Rs.open sql,objConn,3
        
                If not rs.EOF Then
                    city_description = Rs("description")	
            %>
                <div class="city_box"><%=city_description%></div>
            <%
                End If
        
                Rs.close
                set Rs = nothing
            %>
            <div class="pt30"></div>
            <div style="border-bottom:1px solid #000;"></div>

            <%
                sql = " select nm_kor, nm_eng,detail,t.seq, t.point1,t.point2,"
                sql = sql & "	img_path=(SELECT  top 1   img_path  FROM  TB_PH020  p  where t.seq=p.seq and p.INFO_CD ='"& infor_cd &"' and  p.DEL_YN = 'N' ORDER BY Disp_Or asc, img_seq asc) "
                sql = sql & "	from TB_ti320 t "

                sql = sql & " where nat_cd   = '"& nat_cd &"' "
                sql = sql & " and city_cd  = '"& city &"' "
                sql = sql & " order by t.nm_kor,t.Seq desc"

                Set Rs = Server.CreateObject("ADODB.Recordset")
                rs.open sql,objConn,1 
                rs_cnt = rs.RecordCount

          
            %> 

            <% If rs_cnt = 0 then %>
                <div class="none_infor">등록된 정보가 없습니다.</div>
            <%
                Else
               
                       Do while Not Rs.eof 
            
                        img_path = ""
                        seq = Trim(Rs("seq"))
                        nm_kor = Trim(Rs("nm_kor"))
                        nm_eng = Trim(Rs("nm_eng"))
            
                        detail = Trim(Rs("detail"))
                        
                        point1 = trim(Rs("point1")) 
                        point2 = trim(Rs("point2")) 
                        
                        img_path = Trim(Rs("img_path"))
                        img_path77 = Trim(Rs("img_path"))

                        if img_path <> "" and not isNull("img_path") then
                            nat_cd = left(img_path,2)
                            city = mid(img_path,3,3)
                            img_path = ""&GLOBAL_IMG_URL&"/images/area_img/"& nat_cd &"/"& city &"/"& img_path			
                        end if


            %>
                <div class="pt40"></div>
                <div>
                    <span class="infor_subject"><%=nm_kor %></span>
                    <% if point1 <> "" and not isNull("point1") and point2 <> "" and not isNull("point2") then %>
                        <span style="padding:0 0 0 3px;"><a onClick="javascript:googlemap('/mobile/google_map/google_map.asp?h_code=<%=seq%>&info_cd=02');" style="cursor:pointer;"><font color="#FF0000"><i class="xi-maker xi-x"></i></font></a></span>
                    <% end if %>
                </div>
                
                 <div class="pt20"></div>
     
                <% if img_path77 <> "" and not isNull("img_path77") then %>
                    <div><img src="<%=img_path%>" width="100%"  border="0"></div>
                <% end if %>

                <% if detail<> "" then %>
                    <div  class="infor_txt"><%=cutStr(replace(detail,chr(13)&chr(10),""),600)%></div>
                <% end if %>
            <% 
                          rs.MoveNext
                        Loop
 
                End If

        
                Rs.close
                set Rs = nothing
                
                CloseF5_DB objConn 
            %>
            
            <div class="pt30"></div>
        </div> 

        <!--#include virtual="/mobile/include/foot_ci.asp"--> 
    </div>
    
</body>
</html>

<script type="text/javascript">
    $(document).ready(function() {
        $('a#fancybox_googlemap').fancybox({
    		type: 'iframe',
          width:'100%',
          height : '100%'
        });
        $('a#btn_googlemap_click').click(function() {
            googlemap(g_url);
        });
    });
    
    function googlemap(g_url) {
        if( g_url == null || g_url == '' ) return ;
        $('a#fancybox_googlemap').attr('href',g_url);
        $('a#fancybox_googlemap').click();
    }
</script>
<a id="fancybox_googlemap" class="iframe" style="display:none;"></a>

<script language="javascript" type="text/javascript">
    $(function(){
        var ifm = $(".city_box iframe");
        ifm.each(function() {
            $(this).css("width","100%");
            $(this).css("height","60vw");
        });
    });

    $(function(){
        var img = $(".city_box img");
        img.each(function() {
            $(this).css("width","100%");
            $(this).css("height","auto");
        });
    });
 
    $(function(){
        var ifm = $(".infor_txt iframe");
        ifm.each(function() {
            $(this).css("width","100%");
            $(this).css("height","60vw");
        });
    });

    $(function(){
        var img = $(".infor_txt img");
        img.each(function() {
            $(this).css("width","100%");
            $(this).css("height","auto");
        });
    });
</script>
    