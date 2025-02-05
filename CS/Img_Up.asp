<%@codepage=65001 %>

<!-- #include file="Function_Upload.asp" -->

<%
    Flag = Request("Flag")
    
	imgA = Request("imgA")
	imgB = Request("imgB")
    g_code = Request("g_code")
    g_code_f = Request("g_code")
    goodsNum = Request("goodsNum")
    
    
    If Len(Trim(info))=1 Then info = "0"&info
        seq = Request("seq")				'//일련번호
        info = Request("info")			'//테이블 정보
        nat = UCASE(Request("nat"))	'//나라코드
        city = UCASE(Request("city"))	'//도시코드
        imgSeq = Request("imgSeq")
        sub_seq = Request("sub_seq")	'//이정보가 있으면 상세정보-호텔, 골프

        Select Case info
            Case "01"
                tbl = "TB_Ti310"
                subName = "310"
            Case "02"
                tbl = "TB_Ti320"
                subName = "320"
            Case "03"
                tbl = "TB_Ti330"
                subName = "330"
            Case "04"
                tbl = "TB_Ti340"
                subName = "340"
            Case "05"
                tbl = "TB_Ti350"
                subName = "350"
            Case "06"
                tbl = "TB_Ti360"
                subName = "360"
            Case "07"
                tbl = "TB_Ti370"
                subName = "370"
            Case "08"
                tbl = "TB_Ti380"
                subName = "380"
            Case Else
                tbl = "TB_Ti310"
                subName = "310"
        End Select
 
        OpenCsDB db


        '################################################	쿼리		#####################################################################
        strTitle		= ""
        strName	= ""

        IF nat<>"" and city<>"" and seq<>""  and info<>"" Then
            strName = "지역명"
            imgPath2 = "/images/area_img/"	

            '===	지역 이름 표시	===========================================================
            sql = "Select NM_Kor From "& tbl &" Where seq="& seq

            Set Rs = db.Execute(sql)
            strTitle = Rs("NM_Kor")
            '===	지역 이름 표시	===========================================================
	
            '==	지역 쿼리	=============================================================================================================
            sql = " Select Top 1 Info_Cd, Img_Path, isNull(Info_Desc,'') as InfoDesc, img_Seq, isNull(Size_Cd,'') as areaSize, "
            sql = sql & " (Case When Disp_Or is Null Then 99 "
            sql = sql & " When Disp_Or='' Then	99 "
            sql = sql & " Else Disp_Or End) As strOrder,  "
            sql = sql & " (Select Max(Img_Seq)+1 From TB_Ph020 Where Seq='"&seq&"') as Max_Img "
            sql = sql & " From TB_Ph020 a Join "&tbl&" b On a.Seq=b.Seq "
            sql = sql & " Where a.Seq='"&seq&"' and info_Cd='"&info&"' and a.Del_Yn='N' "
            If sub_seq<>"" Then 
                sql = sql & " And sub_seq="& sub_seq
            Else
                sql = sql & " And sub_seq is Null "
            End if
            
            If imgSeq<>"" Then sql = sql & " And img_Seq="& imgSeq
            sql = sql & "	Order By strOrder, Img_Seq 	"
            'response.write sql
            Set Rs = db.Execute(sql)

            if Not Rs.Eof Then
                infoCd = Rs("info_Cd")
                MaxSeq = Rs("Max_Img") '//다음 이미지 수
                imgSeq = Rs("Img_Seq") '//이미지 번호
                ImgPath = Rs("Img_Path") '//파일 이름
                areaDesc = Rs("infoDesc")
                sizeCd1 = Rs("areaSize")

                getUrl1 = "\images\area_img\" & Nat & "\" & City  & "\" '//이미지 경로
                img_Url1 = imgPath2 & Nat & "/" & City & "/" & ImgPath '//이미지 경로
                imgName1 = fnImgName(MaxSeq)
                imgName2 = fnImgName(seq)
                imgFullName = Nat & City & subName & imgName2 & "_" & imgName1 & ".jpg"
            else 
                getUrl1 = "\images\area_img\" & Nat & "\" & City  & "\" '//이미지 경로
                img_Url1 = imgPath2 & Nat & "/" & City & "/" & ImgPath '//이미지 경로
                MaxSeq = 1
                imgName2 = fnImgName(seq)
                imgFullName = Nat & City & subName  & imgName2 & "_0001.jpg"
            end if
            '==	지역 쿼리	=============================================================================================================
           
            '== 이미지 사이즈가 0이면 노이미지 링크===================================================================================
            fileSize = fnFsoSize(getUrl1, imgPath, "images/no_img_1.gif") '//이미지 존재여부 체크후 imgContents, fileSize 구한다. ======
            imgContents = fnFsoContents(getUrl1, imgPath, "images/no_img_1.gif") '//이미지 존재여부 체크후 imgContents, fileSize 구한다. ======
            '== 이미지 사이즈가 0이면 노이미지 링크===================================================================================

            Flag = "area"
            strUrl = "seq="&seq&"&info="&info&"&nat="&Nat&"&city="&City&"&sub_seq="&sub_seq
            goodDesc	= areaDesc


        Elseif g_code<>"" Then 
            strName = "상품명"
            '===	상품 이름 표시	===========================================================
            sql = "	Select G_codename "	&_
			"	From TB_goods_new "	&_
			"	WHERE		num	= '"& goodsNum &"'	"	
            Set Rs = Db.Execute(sql)
            
            if Not Rs.Eof Then	strTitle	= Rs("G_codename")
            Rs.Close
            '===	상품 이름 표시	===========================================================
	
	
            '==	상품 쿼리	=============================================================================================================
            sql = " Select Top 1 g_code, Seq, img_Path, isNull(good_Desc,'') as goodDesc, ins_Dt, isNull(SIZE_CD,'') as goodSize,  "
            sql = sql & " (Case When Disp_Or is Null Then 99 "
            sql = sql & " When Disp_Or='' Then	99 "
            sql = sql & " Else Disp_Or End) As strOrder,  "
            sql = sql & " (Select Max(Seq)+1 From TB_Ph010   "
            sql = sql & " Where		g_code	= '" & goodsNum &"') as MaxSeq "
            sql = sql & " From TB_ph010 "
            sql = sql & " Where		g_code = '" & goodsNum & "'"

            if Seq<>"" Then	sql = sql & " and seq	= "  & seq
            sql = sql & "	Order By strOrder, seq "
            'response.write sql

            Set Rs = db.Execute(sql)

            if Not Rs.Eof Then
                seq				= Rs("Seq")					'//이미지 순서
                imgPath			= Rs("img_Path")				'//이미지 경로
                goodDesc		= Rs("goodDesc")			'//상품설명
                insDt				= Rs("ins_Dt")					'//입력일
                MaxSeq	 		= Rs("MaxSeq")				'//다음에 등록될 이미지 seq
                sizeCd1			= Rs("goodSize")
            Rs.Close
            
            getUrl1			= "\images\good_img\" & goodsNum & "\"														'//이미지 경로
            img_Url1		= "/images/good_img/" & goodsNum & "/" & Left(imgPath,14) & "A" & Right(imgPath,4)									'//이미지 경로
            img_Url2		= "/images/good_img/" & goodsNum & "/" & imgPath																					'//이미지 경로
            
            '== 새로 저장될 풀이미지 이름 fnimgName 자리수 만큼 0을 채운후 이미지이름 리턴 함수 =================
            imgName1	= fnImgName_f(g_code)
            
            '###14년 12월 29일 수정
            if  len(imgName1) <10 then
                imgName2	= fnImgName(MaxSeq)
            else
                Select Case len(imgName1)
                    Case "10"
                        imgName2	= fnImgName_k(MaxSeq)
                    Case "11"
                        imgName2	= fnImgName_j(MaxSeq)
                End Select
            end if
            'imgName2	= fnImgName(MaxSeq)
            imgFullName = imgName1 & "_" & imgName2 & ".jpg"
            'response.write imgFullName
            '== 새로 저장될 풀이미지 이름 fnimgName 자리수 만큼 0을 채운후 이미지이름 리턴 함수 =================
        
        Else
            Rs.Close

            getUrl1			=  "\images\good_img\" & goodsNum & "\"		'//이미지 경로		
            MaxSeq		=1
	
            imgName1	= fnImgName_f(g_code)
		
            if  len(imgName1) <10 then
                imgName2	= fnImgName(MaxSeq)
            else
                Select Case len(imgName1)
                    Case "10"
                        imgName2	= fnImgName_k(MaxSeq)
                    Case "11"
                        imgName2	= fnImgName_j(MaxSeq)
                End Select
            end if

            ' imgName2	= fnImgName(MaxSeq)
            ' response.write imgName2
            ' response.end
            imgFullName = imgName1 & "_" & imgName2 & ".jpg"
            '###14년 12월 29일 수정끝
        End if
        '==	상품 쿼리	=============================================================================================================
     
        
        '== 이미지 사이즈가 0이면 노이미지 링크=================================================================
        imgPathA = Left(ImgPath,14) & "A" & Right(imgPath,4) '== 작은 사이즈 이미지
        imgPathB = Left(ImgPath,14) & "B" & Right(imgPath,4) '== 큰 사이즈 이미지
        imgPathC = ImgPath
		
        imgSizeA = fnFsoSize(getUrl1, imgPathA,"images/no_img_1.jpg")
        imgSizeB = fnFsoSize(getUrl1, imgPathB,"images/no_img_1.jpg")
        imgSizeC = fnFsoSize(getUrl1, imgPathC,"images/no_img_1.jpg")

        imgContentsA = fnFsoContents(getUrl1, imgPathA,"images/no_img_1.jpg")
        imgContentsB = fnFsoContents(getUrl1, imgPathB,"images/no_img_1.jpg")
        imgContentsC = fnFsoContents(getUrl1, imgPathC,"images/no_img_1.jpg")


        If imgSizeA<>0 Then 
            fileSize = imgSizeA
            imgContents = imgContentsA
        Elseif imgSizeB<>0 Then
            fileSize = imgSizeB
            imgContents = imgContentsB
        Elseif imgSizeC<>0 Then
            fileSize = imgSizeC
            imgContents = imgContentsC
        Else
            fileSize = 0
            imgContents = "images/no_img_1.jpg"
        End if
        '== 이미지 사이즈가 0이면 노이미지 링크=================================================================


        Flag = "goods"
        strUrl = "g_code="&g_code_f&"&imgA="&imgA&"&imgB="&imgB&"&goodsNum="&goodsNum
	
    End if
    '################################################	쿼리		#####################################################################


    strUrl  = strUrl & "&Flag="&Flag

    CloseDB DB
    Set Rs = Nothing
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<script language="javascript">
    function fnInsert(){ //등록
        var strForm = document.frm;
        if(strForm.ImgFileNm.value==""){
            alert("이미지를 선택해 주세요");
            return false;
        }
        strForm.action = "Img_Up_ins.asp";
        strForm.target = 'selfWin';
        window.name = 'selfWin';

        strForm.submit();
    }
    
    function fnModify(){ //수정
        var strForm, strOrder, strNum;
        strForm = document.frm;
	
        //if(strForm.imgNum.value=="1"){
        if(strForm.ImgFileNm.value=="1"){
            alert("등록후 수정하세요.");
            return false;
        }
        ans = confirm(strForm.fileName.value + "파일을 수정하시겠습니까?");
        if(ans){
            strForm.action = "Img_Up_Modify.asp";
            strForm.target = 'selfWin';
            window.name = 'selfWin';
            strForm.submit();
        }	
    }
    
    function fnDelete(){ //삭제
        var strForm	= document.frm;
        //if(strForm.imgNum.value=="1"){
        if(strForm.ImgFileNm.value=="1"){
            alert("등록후 삭제하세요.");
            return false;
        }
        ans = confirm(strForm.fileName.value + "파일을 삭제하시겠습니까?");
        if(ans){
            strForm.action = "Img_Up_Delete.asp";
            strForm.target = 'selfWin';
            window.name = 'selfWin';
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

            document.imgChange.width = img_w;
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
</script>
<script language="javascript" src="Script_Upload.js"></script>
</head>

<body>
	
    <form name="frm" method="post" action="" enctype="multipart/form-data">
    <input type="hidden" name="seq" value="<%=Seq%>">
    <input type="hidden" name="area" value="<%=area%>">
    <input type="hidden" name="imgPath" value="<%=imgPath%>">
    <input type="hidden" name="getUrl" value="<%=getUrl1%>">
    <input type="hidden" name="imgNum" value="<%=MaxSeq%>">
    <input type="hidden" name="imgFullName" value="<%=imgFullName%>">
    <input type="hidden" name="g_code" value="<%=g_code_f%>">
    <input type="hidden" name="goodsNum" value="<%=goodsNum%>">
    <input type="hidden" name="chkLength" value="">
    <input type="hidden" name="goodSize" value="<%=sizeCd1%>">
    <input type="hidden" name="sub_seq" value="<%=sub_seq%>">
    <input type="hidden" name="orderValue" value="">
    <input type="hidden" name="orderNum" value="">
    <input type="hidden" name="info" value="<%=Info%>">
    <input type="hidden" name="nat" value="<%=nat%>">
    <input type="hidden" name="city" value="<%=city%>">
    <input type="hidden" name="imgPath1" value="<%=imgPath1%>">
    <input type="hidden" name="imgSeq" value="<%=imgSeq%>">
    <input type="hidden" name="nat_cd" value="<%=nat_cd%>">
    <input type="hidden" name="desc_cd" value="<%=desc_cd%>">
    <input type="hidden" name="city_cd" value="<%=city_cd%>">
    <input type="hidden" name="Flag" value="<%=Flag%>">
    
        <div class="title_pop"><%=strTitle%></div>
        
        <div style="border:1px solid #C0C0C0; padding:15px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr> 
                    <td width="224" valign="top"><img src="<%=imgContents%>" name="imgChange" width="220" border="0" onError="this.src='images/no_img_1.jpg'"></td>
                    <td width="20"></td>
                    <td width="*">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr height="34">
                                <td width="90" style="font-weight:500;">이미지선택</td>
                                <td><input type="file" name="ImgFileNm" style="width:99%; height:24px;" onChange="javascript:document.imgChange.src=this.value" class="input_file"></td>
                            </tr>
                            <tr height="34">
                                <td style="font-weight:500;">등록이미지</td>
                                <td><input type="text" name="fileName" value="<%=imgPath%>"  style="width:99%; border-width:0px;height:18px" readOnly></td>
                            </tr>
                            <tr height="50">
                                <td style="font-weight:500;">이미지설명</td>
                                <td><textarea  name="contents" style="width:99%" rows="2" onKeyUp="fnChkRemark(this,198)" class="textarea_basic"><%=goodDesc%></textarea></td>
                            </tr>
                         <!--
                            <%' if g_code <>"" then %>
                            <input type="hidden" name="goodSizeS" value="30">
                            <%' else %>
                            <input type="hidden" name="goodSizeS" value="구분없음">
                            <%' end if %>
                        -->
                            <tr height="34"> 
                                <td style="font-weight:500;">이미지구분</td>
                                <td><% fnCdSize "IMG1", goodType %></td>
                            </tr>                       
                            <tr height="34">
                                <td style="font-weight:500;">이미지용량</td>
                                <td><input type="text" name="fileSize" value="<%=FormatNumber(fileSize,0)%> byte"  style="width:100px; border-width:0px" readOnly></td>
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
            <iframe src="Img_Main.asp?<%=strUrl%>" name="mainframe" width="100%" height="300" scrolling="on" frameborder="no"></iframe>
        </div>
        <div class="pt10"></div> 
        <div>※ 해당 이미지를 클릭하면 수정/삭제 가능하며, 순서에 번호를 기입하시면 이미지가 정렬됩니다.</div>
    </form>
    
</body>
</html>

<script language = "javascript">
    function closeIframe(){
        parent.$('#chain_schedule_img').dialog('close');
        return false;
    }
</script>