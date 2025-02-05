document.oncontextmenu = function(){return false;}
document.onselectstart = function(){return false;}
document.onkeydown = function(){return false;}



//################### S : GooGle Map API ###################

function createMarker(point, icon,  h_name, h_review, him_img) 
{ 
    var marker = new GMarker(point, icon); 
	GEvent.addListener(marker, "click", function()  
	{ 
    var body = '<div align="center"><img src="' + him_img + '" width="150px"></div>';
    body += '<div style="padding:5px 0 0 0" align="center"><font color="#000"><strong>' + h_name + '</strong></font></div>';
    marker.openInfoWindowHtml(body); 
	});	

	return marker; 
}


function myclick(point, icon,h_name, h_review, him_img) 
{
    var body = '<div align="center"><img src="' + him_img + '" width="150px"></div>';
    body += '<div style="padding:5px 0 0 0" align="center"><font color="#000"><strong>' + h_name + '</strong></font></div>';
	map.openInfoWindowHtml(point,body); 
}



//################### E : GooGle Map API ###################


