<!--#include virtual="/home/inc/json2.asp"-->
 


<%



    tp   = request("tp")
    data_url  = request("data_url")
 
    
 
    dim naver_api_sorturl
    dim DataToSend
    dim xmlhttp
    dim xmlhttp_result

    naver_api_sorturl = "https://openapi.naver.com/v1/util/shorturl"
    DataToSend = "url=" & server.urlencode(data_url)

   set xmlhttp = server.Createobject("MSXML2.ServerXMLHTTP")
   xmlhttp.Open "POST", naver_api_sorturl ,false
   xmlhttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
   xmlhttp.setRequestHeader "X-Naver-Client-Id","4atxqPQ5WyN29LeP_q79"  '/*Ű*/
   xmlhttp.setRequestHeader "X-Naver-Client-Secret","CwJlZYuthj"        '/*id*/
   xmlhttp.send DataToSend

   xmlhttp_result = xmlhttp.responseText


   set xmlhttp = nothing

   dim getJson
   set getJson = JSON.parse( join(array( xmlhttp_result )) )

   dim rq_sorturl_msg : rq_sorturl_msg = getJson.message
   dim rq_sorturl_code : rq_sorturl_code = getJson.code
   dim rq_sorturl_url : rq_sorturl_url = getJson.result.url

   set getJson= nothing

   
   response.write rq_sorturl_url
%>

