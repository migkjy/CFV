    <style type="text/css">
        /* 이미지박스 위의 주석처리는 익스에서만 펼쳐짐*/
        #ImageBox { width:99%; float:left; margin:10px 0 0 0; border:1px solid #E2E2E2; }
        #ImageBox form { width:100%; height:50px; float:left; background-color:#F0F0F0; }
        #ImageBox form div.Box {padding:8px 0 0 0;}
        #ImageBox form div.Box input {border:1px solid #DFDFDF;  background-color:#FFF; vertical-align:middle; height:28px;}
        #ImageBox form div.Box button {font-size:14px; font-weight:600; padding:4px 15px; vertical-align:middle; color:#FFF; border:1px solid #FF2900; background: #FF2900;}
        #ImageBox form div.Loading { padding-top:7px; text-align:center; }
        #ImageBox form div.Loading img { vertical-align:middle; }
        #ImageBox form span { float:left; margin:8px 0 0 10px; display:block; }
        #ImageBox form p { float:left; margin:3px 0 0 0; padding:0 0 0 5px; }
        #ImageBox form p input { font:13px 'NanumGothic'; }
        #ImageBox form p button { font:13px 'NanumGothic'; }
    		    
        #ImageBox .helpBox {margin:50px 0 0 0;  padding:10px 15px; border:solid 1px #d4d4d4; border-left-style:none; border-right-style:none; font:12px 'NanumGothic'; color:#999; line-height:1.5em; }
        #ImageBox ul { padding:0px;overflow-y:auto;overflow-x:hidden;margin-right:0px;height:580px;width:100%;margin-top:0px }*/
    	    
        #ImageBox ul.Loading { height:80px; padding-top:64px; text-align:center; }
        #ImageBox ul.Loading img { vertical-align:middle; }
        #ImageBox ul li { width:auto; height:300px; float:left; margin:0; padding:13px 7px; text-align:center; border:1px solid #FFF; overflow:hidden; } /* offset height : 72px */
        #ImageBox ul li.Focus { border-color:#D8F0FA; background-color:#EFF8FD; }
        #ImageBox ul li.Selected { border-color:#99DEFD; background-color:#E3F3FD; }
        #ImageBox ul li img { margin:0; padding:2px; border:1px solid #CBD8E1; background-color:#FFF; vertical-align:top; cursor:pointer; }
    	    #ImageBoxStatus { width:97%; float:left; padding:15px 10px; font:13px 'NanumGothic'; background-color:#F0F0F0; }
    </style>
    
    
    <div id="ImageBox">
        <form id="frmImageBox" method="post" action="EditorImageUploadOK.asp" enctype="multipart/form-data">
           <input type="hidden" name="num" value="<%=num%>" />
            
            <div class="Box">
                <table width="100%">
                    <tr>
                        <td width="80px" style="text-align:center; font-size:13px; font-weight:600;">이미지추가</td>
                        <td width="*"><input type="file" name="uploadFile" style="width:96%;font-size:13px;" /></td>
                        <td width="70px"><button type="submit">저장</button></td>
                    </tr>
                </table>
            </div>
            
            <div class="Box Loading" style="display:none;"><img src="../images/ajax-loader.gif" width="16" height="16" alt="Loading" />&nbsp;&nbsp;파일을 서버에 저장중입니다.</div>
        </form>
        
        <!--<div class="clear"></div>-->
        
        <div class="helpBox">
            이미지를 선택 후 저장하기를 누르시면 게시물의 이미지를 삽입할 수 있습니다.<br />
            저장되는 이미지형식은 gif, jpg, png 입니다.
        </div>
        <ul><!-- li><img src="" width="60" height="38" alt="" /></li //--></ul>
         <div id="ImageBoxStatus"><span style="font-size:16px; font-weight:600; color:#FF0000;"><strong>0</strong></span>개의 이미지가 저장되었습니다.</div>
    </div>


