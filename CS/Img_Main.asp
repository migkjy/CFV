<!-- #include file="Function_Upload.asp" -->

<%
    Flag = Request("Flag")
    sub_seq = Request("sub_seq")

    OpenCsDB db

    If strMapPath="" Then strMapPath = server.mapPath("../")
    	
        If Flag="goods" Then
            g_code = Request("g_code")
            goodsNum = Request("goodsNum")

            if goodSeq="" Then goodSeq=1
            '==저장된 지역 이미지 정보============================================================================
            '== 이미지 사이즈 구하기 ==============================================================================
            sql = "	Select cd, cd_nm From TB_Ba001 Where Cd_fg='size' "
            Set Rs	= Db.Execute(sql)

            if Not Rs.Eof Then
                sizeCdCount = Rs.RecordCount

                i=0
                ReDim sizeCd(sizeCdCount), sizeCdNm(sizeCdCount)

                Do Until Rs.Eof Or i>sizeCdCount
                    sizeCd(i)		= Rs("cd")
                    sizeCdNm(i)	= Rs("cd_Nm")
                    Rs.MoveNext	
                    
                    if imgValue="" Then imgValue	= imgValue & sizeCd(i) Else imgValue	= imgValue & "," & sizeCd(i)
                    if imgValue="" Then imgText	= imgText & sizeCdNm(i) Else imgText = imgText & "," & sizeCdNm(i)
                    	
                i = i+1
                Loop
            end if
            Rs.Close
            '== 이미지 사이즈 구하기 ==============================================================================
            
            sql = " Select g_code, Seq, img_Path, isNull(good_Desc,'') as goodDesc, ins_Dt, isNull(SIZE_CD,'') as goodSize,  "
            sql = sql & " (Case When Disp_Or is Null Then 99 "
            sql = sql & " When Disp_Or='' Then	99 "
            sql = sql & " Else Disp_Or End) As strOrder,  "
            sql = sql & " (Select Max(Seq)+1 From TB_Ph010   "
            sql = sql & " Where		g_code	= '" & goodsNum &"') as MaxSeq "
            sql = sql & " From TB_ph010 "
            sql = sql & " Where		g_code = '" & goodsNum & "'"
            sql = sql & " Order By strOrder, seq "
            'response.write sql
            'RESPONSE.END
            Set Rs = db.Execute(sql)

            imgPath2 = "/images/good_img/"
            
            if Not Rs.Eof Then
                seq = Rs("Seq")					             '//이미지 순서
                imgPath = Rs("img_Path")				'//이미지명
                goodDesc = Rs("goodDesc")			'//상품설명
                insDt = Rs("ins_Dt")					         '//입력일
                MaxSeq = Rs("MaxSeq")				     '//다음에 등록될 이미지 seq

                getUrl1 =  "\images\good_img\" & goodsNum & "\"		'//이미지 경로

                '== 새로 저장될 풀이미지 이름 ======================================================================
                imgName1		= fnImgName(goodSeq)
                imgName2	 	= fnImgName(MaxSeq)
                imgFullName = g_code & imgName1 & "_" & imgName2 & ".jpg"
                '== 새로 저장될 풀이미지 이름 ======================================================================
            
            else
            	
                if MaxSeq="" or MaxSeq=0 Then MaxSeq=1
                imgName1 = fnImgName(goodSeq)	'//함수
                imgName2 = "000" & MaxSeq

                getUrl1			= "\images\good_img\" & goodsNum & "\"														'//이미지 경로
                img_Url1		= imgPath2 & goodsNum & "/" & Left(imgPath,16) & "B" & Right(imgPath,4)								'//이미지 경로
                img_Url2		= imgPath2 & goodsNum & "/" & imgPath																				'//이미지 경로
                imgFullName = g_code & imgName1 & "_" & imgName2 & ".jpg"
            end if
            '==저장된 지역 이미지 정보============================================================================
	
	
        Elseif Flag="area" Then
            seq = request("seq")				'//
            info = request("info_cd")		'//테이블 정보
            nat = request("nat")				'/나라코드
            city = request("city")				'//도시코드
            strMapPath = request("path")

            if info="" Then info=Request("info")

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
                Case Else
                    tbl = "TB_Ti310"
                    subName = "310"
            End Select


            imgPath2 = "/images/area_img/"
            '== 이미지 사이즈 구하기 ==============================================================================
            sql = " Select cd, cd_nm From TB_Ba001 Where Cd_fg='size' "
            Set Rs	= Db.Execute(sql)

            if Not Rs.Eof Then
                sizeCdCount		= Rs.RecordCount

                i=0
                ReDim sizeCd(sizeCdCount), sizeCdNm(sizeCdCount)

                Do Until Rs.Eof Or i>sizeCdCount
                    sizeCd(i)		= Rs("cd")
                    sizeCdNm(i)	= Rs("cd_Nm")
                    Rs.MoveNext	
                    if imgValue="" Then imgValue	= imgValue & sizeCd(i) Else imgValue	= imgValue & "," & sizeCd(i)
                    if imgValue="" Then imgText	= imgText & sizeCdNm(i) Else imgText = imgText & "," & sizeCdNm(i)
		
                i = i+1
                Loop
            end if
            
            Rs.Close
            '== 이미지 사이즈 구하기 ==============================================================================

            '==저장된 지역 이미지 정보============================================================================
            sql = " Select Info_Cd, Nm_Kor, Img_Path, isNull(Info_Desc,'') as InfoDesc, img_Seq, ins_Dt , isNull(Size_Cd,'') as sizeCd, " 
            sql = sql & " (Case When Disp_Or is Null Then 99 "
            sql = sql & " When Disp_Or='' Then	99 "
            sql = sql & " Else Disp_Or End) As strOrder,  "
            sql = sql & " (Select Max(Img_Seq)+1 From TB_Ph020 Where Seq='"&seq&"') as Max_Img "
            sql = sql & " From TB_Ph020 a Join "&tbl&" b On a.Seq=b.Seq "
            sql = sql & " Where a.Seq="&seq&" and info_Cd='"&info&"' and a.Del_Yn='N' "
            If sub_seq<>"" Then 
                sql = sql &	"	And sub_seq="& sub_seq
            Else
                sql = sql &	"	And sub_seq is Null "
            End if
            sql = sql & "	Order By strOrder, Img_Seq "
            'response.write sql
            Set Rs = db.Execute(sql)

            If Not Rs.Eof Then
                infoCd = Rs("info_Cd")
                Nm_Kor = Rs("Nm_Kor")				'//나라코드	
                Max_Img = Rs("Max_Img")			'//다음 이미지 수
                imgSeq = Rs("Img_Seq")				'//이미지 번호
                Img_Path = Rs("Img_Path")			'//파일 이름

                getUrl1 = "\images\area_img\" & Nat & "\" & City  & "\"  '//이미지 경로

                '== 새로 저장될 풀이미지 이름 ======================================================================
                imgName1		= fnImgName(Max_Img)
                imgName2		= fnImgName(seq)
                imgFullName = Nat & City & subName & imgName2 & "_" & imgName1 & ".jpg"
                '== 새로 저장될 풀이미지 이름 ======================================================================
            Else 
                imgName2 = fnImgName(seq)
                imgFullName = Nat & City & subName & imgName2 & "_0001.jpg"
                getUrl1 = "\images\area_img\" & Nat & "\" & City  & "\"  '//이미지 경로
                img_Url1 = imgPath2 & Nat & "/" & City & "/" & Img_Path  '//이미지 경로
                Max_Img = 1
            End if
            '==저장된 지역 이미지 정보============================================================================

        End if

        getUrl2 = strMapPath & getUrl1
%>
<script language="javascript">
    function fnImgDisplay(strImg,strSeq,strFileName,count,num, fileSize){ //클릭시 이미지 바꿔주기
        parent.document.imgChange.src	= strImg; 
        e = parent.document.frm;
        strContents = eval("document.frm.contents"+strSeq)
        strimgSize = eval("document.frm.imgSize"+strSeq)
        
        if(e.Flag.value!="area"){
            e.seq.value = strSeq;														         //수정시 필요한 이미지 번호
        }
        e.imgPath.value = strFileName;													//파일 이름
        e.chkLength.value = count;														//레코드개수
        e.fileSize.value = fnAllMoney(fileSize) + " byte";							//이미지 용량
        e.contents.value = strContents.value;											//내용
        e.fileName.value = strFileName;												//파일 이름
        document.frm.chkLength.value = count; 
        parent.fnTest(strimgSize.value);
        e.imgSeq.value = strSeq;
    }
</script>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/admin/css/style_pop.css" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script language="javascript" src="Script_Upload.js"></script>
</head>

<body>
	
    <form name="frm" method="post" action="" style="display:inline; margin:0px;">
    <input type="hidden" name="seq" value="<%=Seq%>">
    <input type="hidden" name="area" value="<%=area%>">
    <input type="hidden" name="getUrl" value="<%=getUrl2%>">
    <input type="hidden" name="g_code" value="<%=g_code%>">
    <input type="hidden" name="goodsNum" value="<%=goodsNum%>">
    <input type="hidden" name="imgFullName" value="<%=Left(imgFullName,12)%>">
    <input type="hidden" name="chkLength" value="">
    <input type="hidden" name="blurNum" value="">
    <input type="hidden" name="blurValue" value="">
    <input type="hidden" name="Flag" value="<%=Flag%>">
    <input type="hidden" name="sub_seq" value="<%=sub_seq%>">
    <input type="hidden" name="info" value="<%=Info%>">
    <input type="hidden" name="nat" value="<%=nat%>">
    <input type="hidden" name="city" value="<%=city%>">
	
        <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
            <tr>
                <%
                    order_Page = "Img_Up_Order.asp?goodsNum="&goodsNum&"" 
        
                    If Flag="goods" Then
                
                        If Rs.Eof Then
                            Response.Write "<tr><td align='center' width='100%' height='280'>" &_
                            "등록된 이미지가 없습니다. " &_
                            "</td></tr>"	
                        Else
                            Response.Write	"<tr>"
        			
                            i = 1
                            j = 0
                            Do Until Rs.Eof or i > Rs.RecordCount
                            
                                seq = Rs("Seq")	 
                                imgPath = Rs("img_Path")	 
                                goodDesc = Rs("goodDesc")	 
                                insDt = Rs("ins_Dt")	 
                                MaxSeq = Rs("MaxSeq")		 
                                sizeCd1 = Rs("goodSize")
                                goodOrder = Rs("strOrder")
        
                                insDt = Left(Rs("Ins_Dt"),4) & "/" & mid(Rs("Ins_Dt"),5,2) & "/" & Right(RS("Ins_Dt"),2) 
                                ImgUrl1 = "/images/good_img/" & area & "/"   
        
                                For k=0 To sizeCdCount-1		
                                    if sizeCd1 = sizeCd(k) Then 
                                        cdContents = "" & sizeCdNm(k) & "" 
                                        Exit For
                                    else 
                                        cdContents = "없음"
                                    end if
                                Next


                                If goodOrder = 99 Then goodOrder=0
                                   if goodOrder = 0 Then 
                                       goodOrder=" <input type='text' name='txtSelect"&i&"' value='-' style='width:50px; height:22px' class='input_color'  onClick='fnClick(this)' "
                                       goodOrder= goodOrder & " onBlur=fnBlur(this,this.value,'"&seq&"','"&order_Page&"') class='input_color'>"
                                   else
                                       goodOrder="<input type='text' name='txtSelect"&i&"' value='"&goodOrder&"' style='width:50px; height:22px' class='input_color' onClick='fnClick(this)' "
                                       goodOrder= goodOrder & " onBlur=fnBlur(this,this.value,'"&seq&"','"&order_Page&"')>"
                                   end if
                                   goodOrder = goodOrder & "<input type='hidden' name='txt"&i&"' style='height:20px' value="&seq&">" 

        
                                If Len(goodDesc)>30 Then goodDesc2 = Left(Ltrim(goodDesc),30) & "..." Else goodDesc2=goodDesc
                                   if goodDesc="" Then 
                                       goodDesc1 = "등록 내용 없음"
                                   else
                                       goodDesc1 = "" & goodDesc2 & ""
                                   end if
                                   goodDesc1 = goodDesc1 & " <input type='hidden' name='contents" & seq &"' value='"&goodDesc&"'>"

	
                                imgPathA	= Left(ImgPath,14) & "A" & Right(imgPath,4) 
                                imgPathB	= Left(ImgPath,14) & "B" & Right(imgPath,4) 
                                imgPathC	= ImgPath
        
                                imgUrlA = fnFsoUrl(getUrl1, imgPathA,"images/no_img_1.jpg")
                                imgUrlB = fnFsoUrl(getUrl1, imgPathB,"images/no_img_1.jpg")
                                imgUrlC = fnFsoUrl(getUrl1, imgPathC,"images/no_img_1.jpg")
        
                                fileSizeA = fnFsoSize(getUrl1, imgPathA,"images/no_img_1.jpg")
                                fileSizeB = fnFsoSize(getUrl1, imgPathB,"images/no_img_1.jpg")
                                fileSizeC = fnFsoSize(getUrl1, imgPathC,"images/no_img_1.jpg")
        
                                imgContentsA = fnFsoContents(getUrl1, imgPathA,"images/no_img_1.jpg")
                                imgContentsB = fnFsoContents(getUrl1, imgPathB,"images/no_img_1.jpg")
                                imgContentsC = fnFsoContents(getUrl1, imgPathC,"images/no_img_1.jpg")
        
                            
                                If fileSizeA<>0 Then
                                    ImgUrl = imgUrlA
                                    imgContents	= imgContentsA
                                    fileSize = fileSizeA
                                Elseif fileSizeC<>0 Then
                                    ImgUrl = imgUrlC
                                    imgContents	= imgContentsC
                                    fileSize = fileSizeC
                                Else
                                    ImgUrl = imgUrlA
                                    imgContents	= imgContentsA
                                    fileSize = fileSizeA
                                End if

                                strClick	= "onClick=fnImgDisplay('"& imgContents &"','"& seq &"','"& imgPath &"','"& count &"','"& j &"','"& fileSize &"') " 
                                strClick	= strClick & " style='cursor:pointer;' " 
                %>
                <td width="140" valign="top" <%=strClick%>><img src="<%=imgContents%>" border=0 Name="outImg" width="125"  style="cursor:pointer;"></td>
                <td width="*">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                            <td height="26">순서 :</td>
                            <td width="5"></td>
                            <td><%=goodOrder%></td>
                        </tr>    	
                      <!--
                        <tr> 
                            <td height="26">구분 :</td>
                            <td width="5"></td>
                            <td><%'=cdContents%></td>
                        </tr>-->
                        <tr> 
                            <td height="26">설명 :</td>
                            <td width="5"></td>
                            <td><%=goodDesc1%></td>
                        </tr>
                    </table>
                    <input type="hidden" Name="imgSize<%=seq%>" value="<%=sizeCd1%>">	
                </td>
                <% If count=1 Then %>
                <td width="140"></td>
                <td width="330"><input type="hidden" name="strRsCount" value="<%=count%>"></td>
                <% End if %>
                <%
                            Rs.MoveNext 
                            i = i+1
                            j = j+1
				                
                            if (j Mod 2) = 0 Then
                                Response.write "</tr><tr><td height='20'></td></tr>"
                            end if
                        
                            Loop		
                        End if	
                        
                        CloseDB DB
                %>
 
 
 
                <%
                    Elseif Flag="area" Then	
		
                        If Rs.Eof Then
                            Response.Write "<tr><td align='center' width='100%' height='280'>" &_
                            "등록된 이미지가 없습니다. " &_
                            "</td></tr>"	
                        Else
                            Response.Write	"<tr valign='middle'>"
				
                            i = 1
                            j = 0
                            Do Until Rs.Eof or i > Rs.RecordCount
                            	
                                ImgPath = Rs("Img_Path") 
                                InfoDesc = Rs("InfoDesc") 
                                imgSeq = Rs("Img_Seq")
                                sizeCd1 = Rs("sizeCd")
                                areaOrder = Rs("strOrder")

                                ins_Dt = Left(Rs("Ins_Dt"),4) & "/" & mid(Rs("Ins_Dt"),5,2) & "/" & Right(RS("Ins_Dt"),2)
                                ImgUrl = "/images/area_img/" & Nat & "/" & City & "/" & ImgPath 
                                count = Rs.RecordCount 

                                For k=0 To sizeCdCount-1		
                                    if sizeCd1 = sizeCd(k) Then 
                                        cdContents = " " & sizeCd1 & " " & sizeCdNm(k) & " " 
                                    Exit For
                                    else 
                                        cdContents = "없음"
                                    end if
                                Next
                            
                                If areaOrder = 99 Then areaOrder=0
                                    if areaOrder = 0 Then 
                                        areaOrder=" <input type='text' name='txtSelect"&i&"' value='-'  style='width:50px; height:22px' class='input_color' onClick='fnClick(this)' "
                                        areaOrder= areaOrder & " onBlur=fnBlur(this,this.value,'"&imgSeq&"','"&order_Page&"') class='input_color'>"
                                    else
                                        areaOrder="<input type='text' name='txtSelect"&i&"' value='"&areaOrder&"' style='width:50px; height:22px' class='input_color' onClick='fnClick(this)'  " 
                                        areaOrder= areaOrder & " onBlur=fnBlur(this,this.value,'"&imgSeq&"','"&order_Page&"')>"
                                    end if
                                    areaOrder = areaOrder & "<input type='hidden' name='txt"&i&"'  style='height:20px' value="&imgSeq&">"	'//번호부모창으로 넘기기 위해서


                                If  Len(InfoDesc)>30 Then InfoDesc2 = Left(Ltrim(InfoDesc),30) & "..." Else InfoDesc2 = InfoDesc
                                    if InfoDesc="" Then 
                                        infoDesc1 = "등록 내용 없음 "
                                    else
                                        infoDesc1 = " " & InfoDesc2 & " "
                                    end if
                                    infoDesc1 = infoDesc1 & " <input type='hidden' name='contents" & imgSeq &"' value='"& InfoDesc2 &"'>"

                         
                                imgUrl = fnFsoUrl(getUrl1, imgPath, "images/no_img_1.jpg") 
                                fileSize = fnFsoSize(getUrl1, imgPath, "images/no_img_1.jpg")	 
                                imgContents = fnFsoContents(getUrl1, imgPath, "images/no_img_1.jpg")	 
                                
                                strClick	= "onClick=fnImgDisplay('"& imgContents &"','"& imgSeq &"','"& imgPath &"','"& count &"','"& j &"','"& fileSize &"') " 
                                strClick	= strClick & " style='cursor:pointer;' " 
                %>
                <td width="140" valign="top" <%=strClick%>><img src="<%=imgContents%>" border=0 Name="outImg"  width="125"  style="cursor:pointer;"></td>
                <td width="*">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                            <td height="26">순서 :</td>
                            <td width="5"></td>
                            <td><%=areaOrder%></td>
                        </tr>
                        <!--	
                        <tr> 
                            <td height="26">구분 :</td>
                            <td width="5"></td>
                            <td><%=cdContents%></td>
                        </tr>
                        -->
                        <tr> 
                            <td height="26">설명 :</td>
                            <td width="5"></td>
                            <td><%=infoDesc1%></td>
                        </tr>	
                    </table>
                    <input type="hidden" Name="imgSize<%=imgSeq%>" value="<%=sizeCd1%>">	
                </td>
                <% If count=1 Then %>
                <td width="140"></td>
                <td width="330"><input type="hidden" name="strRsCount" value="<%=count%>"></td>
                <% End if %>

                <%
                            Rs.MoveNext 
                            i = i+1
                            j = j+1
				                
                            if (j Mod 2) = 0 Then
                                Response.write "</tr><tr><td height='15'></td></tr>"
                            end if
                        
                            Loop		
                        End if	
                        
                        CloseDB DB
                
                    End if
                %>
        </table>
    
    </form>
    
</body>
</html>