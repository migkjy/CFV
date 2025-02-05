document.oncontextmenu = function(){return false;}
document.onselectstart = function(){return false;}
document.onkeydown = function(){return false;}



//################### S : GooGle Map API ###################

function createMarker(point, icon,  h_name, h_review, him_img) 
{ 
    var marker = new GMarker(point, icon); 
	GEvent.addListener(marker, "click", function()  
	{ 
    var body = '<div style="text-align:center;"><img src="' + him_img + '" width="150"></div>';
    body += '   <div style="font-size: 13px; font-weight:500;text-align:center;padding:5px 0 0 0;">' + h_name + '</div>';
		marker.openInfoWindowHtml(body); 
	});	

	return marker; 
}


function myclick(point, icon,h_name, h_review, him_img) 
{
    var body = '<div style="text-align:center;"><img src="' + him_img + '" width="150"></div>';
    body += '    <div style="font-size: 13px; font-weight:500;text-align:center;padding:5px 0 0 0;">' + h_name + '</div>';
	map.openInfoWindowHtml(point,body); 
}



//################### E : GooGle Map API ###################
