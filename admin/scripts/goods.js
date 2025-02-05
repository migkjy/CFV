
	//다른달 출발 날짜 보기//
	function GoGoods(Good_Cdstr,StartDaystr,month_gu)
		{
			location.href= "view_inc.asp?num="+Good_Cdstr+"&clickyearmonth="+StartDaystr+"&month_gu="+month_gu; 
		} 
		
		
		function PoGoods(Good_Cdstr,StartDaystr,month_gu)
		{
			location.href= "goods_inc.asp?num="+Good_Cdstr+"&clickyearmonth="+StartDaystr+"&month_gu="+month_gu; 
		} 
	
	//출발일자보기/숨기기
	function fnDispGoods(obj,img_obj, inum, StartDaystr, Good_Cdstr){

		 if(	document.getElementById(obj).style.display == '')
			{
					document.getElementById(obj).style.display = 'none';
					img_obj.src = "/images/goods/btn_open.gif";
			}
			else
			{
				document.getElementById("data_ev001_"+inum).src = "view_inc.asp?num="+Good_Cdstr+"&clickyearmonth="+StartDaystr+"&month_gu=ya1";
				

				document.getElementById(obj).style.display = '';
				img_obj.src = "/images/goods/btn_iclose.gif";
			}

	}
	
	
function goGoodsView(strApart, strBpart,strCpart,goodsNum,num){
	 
		top.location.href="index.asp?ts=goods_day&nav=goods&strApart="+strApart+"&strBpart="+strBpart+"&strCpart="+strCpart+"&goodsNum="+goodsNum+"&selNum="+num+""

	}