// URL to htmlarea files
var config = new Object();    // create new config object
 
config.width = "620";
config.height = "100px";
config.bodyStyle = 'background-color: white; font-family: "µ∏øÚ"; font-size: 10pt';
config.debug = 0;



// NOTE:  You can remove any of these blocks and use the default config!
/*
config.toolbar = [
    ['fontname'],
    ['fontsize'],
    ['bold','italic','underline','separator'],
    ['justifyleft','justifycenter','justifyright','separator'],
    ['OrderedList','UnOrderedList','Outdent','Indent','separator'],
    ['forecolor','backcolor','separator'],
    ['HorizontalRule','Createlink','htmlmode'],
];
*/
config.toolbar = [
    ['fontname'],
    ['fontsize'],
    ['bold','italic','underline','separator'],
    [],
    ['InsertImage'],
    ['forecolor','separator'],
    ['Createlink','htmlmode'],
];
config.fontnames = {
    "µ∏øÚ":	"µ∏øÚ",
    "±º∏≤":	"±º∏≤",
    "πŸ≈¡":	"πŸ≈¡",    
    "±√º≠":	"±√º≠",        
    "Arial":           "arial, helvetica, sans-serif",
   // "Courier New":     "courier new, courier, mono",
    "Georgia":         "Georgia, Times New Roman, Times, Serif",
    "Tahoma":          "Tahoma, Arial, Helvetica, sans-serif"
    //"Times New Roman": "times new roman, times, serif"
};
config.fontsizes = {
    "1 (8 pt)":  "1",
    "2 (10 pt)": "2",
    "3 (12 pt)": "3",
    "4 (14 pt)": "4",
    "5 (18 pt)": "5",
    "6 (24 pt)": "6",
    "7 (36 pt)": "7"
  };

//config.stylesheet = "./sample.css";
  
config.fontstyles = [   // make sure classNames are defined in the page the content is being display as well in or they won't work!
  { name: "headline",     className: "headline",  classStyle: "font-family: arial black, arial; font-size: 28px; letter-spacing: -2px;" },
  { name: "arial red",    className: "headline2", classStyle: "font-family: arial black, arial; font-size: 12px; letter-spacing: -2px; color:red" },
  { name: "verdana blue", className: "headline4", classStyle: "font-family: verdana; font-size: 18px; letter-spacing: -2px; color:blue" }

// leave classStyle blank if it's defined in config.stylesheet (above), like this:
//  { name: "verdana blue", className: "headline4", classStyle: "" }  
];

