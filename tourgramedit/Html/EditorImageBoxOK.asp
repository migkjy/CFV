<%@ Language="VBScript" Codepage="65001" %>
<% Option Explicit %>
<!--#include file="../Include/Config.asp"-->
<%

    Response.CharSet = "utf-8"
    Dim num
    '저장형식은 꼭 UTF-8로 해야 함
    num =trim( Request("num"))
 
    
   Select Case(UCase(Request.ServerVariables("REQUEST_METHOD")))
        Case "GET"
        
            GetList()
        Case "POST"
        
            DelImageInfo()
    End Select
   'response.write num
   
    Response.End()


    Function GetList()
        With Response
            .ContentType = "text/xml"
            .Write("<?xml version=""1.0"" encoding=""utf-8"" ?>")
        End With

        Dim xmlDom, items, fileInfo
        
        Set xmlDom = Server.CreateObject("Microsoft.XMLDOM")
        Set items = xmlDom.CreateElement("items")
        xmlDom.AppendChild(items)
   
        Call dbOpen()

        Set rs = Server.CreateObject("ADODB.RecordSet")
        Set cmd = Server.CreateObject("ADODB.Command")

        With cmd
            .ActiveConnection = db
            .CommandText = "[dbo].[usp_EWGoodsImageBox_GetList]"
            .CommandType = adCmdStoredProc
          .Parameters.Append .CreateParameter("SessionID", adVarChar, adParamInput, 30, num)
        End With
             
        rs.CursorLocation = adUseClient
        rs.Open Cmd, ,adOpenForwardOnly, adLockReadOnly


        Set Cmd = Nothing

        Do Until rs.EOF
            Set fileInfo = xmlDom.CreateElement("file")

            fileInfo.SetAttribute "idx", rs("ImageNo")
            fileInfo.SetAttribute "width", rs("Width")
            fileInfo.SetAttribute "height", rs("Height")
            fileInfo.SetAttribute "size", rs("FileSize")
            fileInfo.SetAttribute "date", prtDate("YMDHM", rs("UploadDate"))
            fileInfo.text = rs("FileName")

            items.AppendChild(fileInfo)

            rs.MoveNext
        Loop

        rs.Close
        Set rs = Nothing

        Call dbClose()

        Response.Write(xmlDom.xml)

        Set xmlDom = Nothing
    End Function

    Function DelImageInfo()
        Dim imageNo, returnValue
        
        imageNo = Request.Form("ino")

        If isInt32(imageNo) = False Then
            Response.Write("2")
            Response.End()
        End If

        Call dbOpen()

        Set cmd = Server.CreateObject("ADODB.Command")

        With cmd
            .ActiveConnection = db
            .CommandText = "[dbo].[usp_EWGoodsImageBox_DelInfo]"
            .CommandType = adCmdStoredProc

            .Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
            .Parameters.Append .CreateParameter("ImageNo", adInteger, adParamInput,, ImageNo)
            .Parameters.Append .CreateParameter("SessionID", adVarChar, adParamInput, 30, num)


            .Execute,,adExecuteNoRecords

            returnValue = CInt(.Parameters("RETURN_VALUE").value)
        End With

        Set cmd = Nothing

        Call dbClose()

        Response.Write(returnValue)
    End Function
%>