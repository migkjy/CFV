
<%
    Response.Expires = -1
    Session.codepage = 65001
    Response.CharSet = "utf-8" 
    Response.AddHeader "Pragma", "No-Cache"
    Response.CacheControl = "Private"


  
  
    g_seq  = Trim(request("g_seq"))
    If g_seq="" or isnull(g_seq) then
        response.write "<script language='javascript'>"
        response.write " alert('주요인자오류..'); "
        response.write " self.close(); "
        response.write " </script>	 "
    End if

    tp = Trim(request("tp"))
    If tp="" or isnull(tp) then
        response.write "<script language='javascript'>"
        response.write " alert('주요인자오류..'); "
        response.write " self.close(); "
        response.write " </script>	 "
    End if
    
    tp = Ucase(tp)
    title = Trim(request("title"))
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<script type="text/javascript">
<!--
    function fnInsert(){
        var strForm = document.frm;
        document.getElementById("act_tp").value="I";
	
        if(strForm.srcfile.value==""){
            alert("이미지를 선택해 주세요    ");
            return false;
        }
        strForm.action = "file_ok.asp";
        strForm.submit();
    }

    
    function fnModify(){ 
        var strForm, strOrder, strNum;
        strForm = document.frm;
        document.getElementById("act_tp").value="M";
 
        if(strForm.p_seq.value==""){
            alert("파일 선택후 수정하세요 \n\n");
            return false;
        }

        ans = confirm("파일을 수정하시겠습니까? ");
        if(ans){
            strForm.action = "file_ok.asp";
            strForm.submit();
        }	
    }


    function fnDelete(){	
        g_seq= document.getElementById('g_seq').value;
        p_seq= document.getElementById('p_seq').value;
        var strForm	= document.frm;
  
        if(strForm.p_seq.value==""){
            alert("파일 선택후 삭제하세요.");
            return false;
        }
	
        var p_seq=  strForm.p_seq.value;

        ans = confirm("파일을 삭제하시겠습니까?");
        if(ans){
            strForm.action = "file_del.asp?tp=<%=tp%>&p_seq="+p_seq+"&g_seq="+g_seq;
            strForm.submit();
        }
    }


    function fnChangeImg(strValue){
        if (strValue != ""){
            var photo, img_w, img_w
            
            photo = new Image();
            photo.src = strValue;

            img_w = photo.width;
            img_h = photo.height;

            document.imgChange.width	= img_w;
            document.imgChange.height = img_h;
        }
        document.imgChange.src=strValue
    }


    function fnLoadImg(strValue){
        if (strValue != ""){
            var photo, img_w, img_w
			
            photo = new Image();
            photo.src = strValue;

            img_w = photo.width;
            img_h = photo.height;

            document.imgChange.width = img_w;
            document.imgChange.height = img_h;
        }
        document.imgChange.src=strValue
    }
//-->
</script>
</head>

<body>

    <form name="frm" method="post"  enctype="multipart/form-data">
    <input type="hidden" name="g_seq" id="g_seq"  value="<%=g_seq%>">
    <input type="hidden" name="p_seq" id="p_seq"  value="">
    <input type="hidden" name="act_tp"  id="act_tp"  value="I">
    <input type="hidden" name="tp" id="tp"  value="<%=tp%>">
    
        <div class="title_pop"><%=title%></div>

        <div style="border:1px solid #C0C0C0; padding:15px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr> 
                    <td width="224" valign="top"><img src="<%=imgContents%>" name="imgChange" width="220" border="0" onError="this.src='/admin/images/no_img_1.jpg'"></td>
                    <td width="20"></td>
                    <td width="*">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr height="34">
                                <td width="90" style="font-weight:500;">이미지선택</td>
                                <td><input type="file" name="srcfile" style="width:99%; height:24px;" onChange="javascript:document.imgChange.src=this.value" class="input_file"></td>
                            </tr>
                            <tr height="34">
                                <td style="font-weight:500;">등록이미지</td>
                                <td><input type="text" name="fileName" value="<%=imgPath%>"  style="width:99%; border-width:0px;height:18px" readOnly></td>
                            </tr>
                            <tr height="50">
                                <td style="font-weight:500;">이미지설명</td>
                                <td><textarea name="re_mark" style="width:99%" rows="2" onKeyUp="fnChkRemark(this,198)" class="textarea_basic"><%=goodDesc%></textarea></td>
                            </tr>
                        </table> 
                    </td>
                </tr>
            </table>
        </div> 
        
        <div style=padding:25px 0 50px 0;" align="center">
            <span class="button_b" style="padding:0px 4px"><a onClick="fnInsert();">등록</a></span>
            <span class="button_b" style="padding:0px 4px"><a onClick="fnModify();">수정</a></span>
            <span class="button_b" style="padding:0px 4px"><a onClick="fnDelete();">삭제</a></span>
            <span class="button_b" style="padding:0px 4px"><a onClick="closeIframe();">닫기</a></span>
        </div> 

        <div style="border:1px solid #C0C0C0; padding:15px;">
            <iframe src="img_main.asp?g_seq=<%=g_seq%>&tp=<%=tp%>" name="mainframe" width="100%" height="370" scrolling="on" frameborder="no"></iframe>
        </div>
        <div class="pt10"></div> 
        <div>※ 해당 이미지를 클릭하면 수정/삭제 가능하며, 순서에 번호를 기입하시면 이미지가 정렬됩니다.</div>
    </form>
    
</body>
</html>

<script language = "javascript">
    function closeIframe(){
        parent.$('#chain_img').dialog('close');
        return false;
    }
</script>
                