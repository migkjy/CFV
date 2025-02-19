﻿<!--#include virtual="/home/conf/config.asp"--> 
<%
    With Response
        .CharSet = "utf-8" 
        .Expires = -1
        .ExpiresAbsolute = Now() - 1
        .AddHeader "pragma", "no-cache"
        .CacheControl = "no-cache"
        .Buffer = true
    End With
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link rel="stylesheet" type="text/css" href="/css/style.css" />
    
<style type="text/css">
    #imageFlow {
        position: absolute;
        width: 103%;
        height: 100%;
        left: 0%;
        overflow: hidden;
        background:url(/images/goods/gallery_bg.jpg); 
    }
    #imageFlow .diapo {
        position: absolute;
        left: -1000px;
        cursor: pointer;
        -ms-interpolation-mode: nearest-neighbor;
    }
    #imageFlow .link {
        border: dotted #fff 1px;
        margin-left: -1px;
        margin-bottom: -1px;
    }
    #imageFlow .bank {
        visibility: hidden;
    }
    #imageFlow .top {
        position: absolute;
        width: 100%;
        height: 100%;
    } 
    #imageFlow .text {
        position: absolute;
        left: 0px;
        width: 100%;
        bottom: 13%;
        text-align: center;
        color: #FFF; 
        font-size: 1.2em;
        font-family: verdana, arial, Helvetica, sans-serif;
        z-index: 1000;
    }
    #imageFlow .title {
        font-size: 1.0em;
    }
    #imageFlow .legend {
        font-size: 1.0em;
    }
    #imageFlow .scrollbar {
        position: absolute;
        left: 10%;
        bottom: 5%;
        width: 80%;
        height: 25px;
        z-index: 1000;
    }
    #imageFlow .track {
        position: absolute;
        left: 1%;
        width: 98%;
        height: 25px;
        filter: alpha(opacity=30);
        opacity: 0.3;
    }
    #imageFlow .arrow-left {
        position: absolute;
    }
    #imageFlow .arrow-right {
        position: absolute;
        right: 0px;
    }
    #imageFlow .bar {
        position: absolute;
        height: 25px;
        left: 25px;
    }
</style>
    
<script type="text/javascript">
    document.oncontextmenu = function(){return false;}
    document.onselectstart = function(){return false;}
    document.onkeydown = function(){return false;}
    
    var imf = function () {
        /* //////////// ==== private methods ==== //////////// */
        var lf = 0;
        var instances = [];
        /* ===== custom getElementsByClass ==== */
        function getElementsByClass (object, tag, className) {
            var o = object.getElementsByTagName(tag);
            for ( var i = 0, n = o.length, ret = []; i < n; i++)
                if (o[i].className == className) ret.push(o[i]);
            if (ret.length == 1) ret = ret[0];
            return ret;
        }
        /* ===== crossbrowsers addEvent ==== */
        function addEvent (o, e, f) {
            if (window.addEventListener) o.addEventListener(e, f, false);
            else if (window.attachEvent) r = o.attachEvent('on' + e, f);
        }
        /* ===== create image reflexion ==== */
        function createReflexion (cont, img) {
            var flx = false;
            if (document.createElement("canvas").getContext) {
                /* ---- canvas ---- */
                flx = document.createElement("canvas");
                flx.width = img.width;
                flx.height = img.height;
                var context = flx.getContext("2d");
                context.translate(0, img.height);
                context.scale(1, -1);
                context.drawImage(img, 0, 0, img.width, img.height);
                flx.style.opacity = '0.35';
            } else {
                /* ---- DXImageTransform ---- */
                flx     = document.createElement('img');
                flx.src = img.src;
                flx.style.filter = 'flipv progid:DXImageTransform.Microsoft.Alpha(' +
                                   'opacity=25, style=1, finishOpacity=0, startx=0, starty=0, finishx=0, finishy=' +
                                   (img.height * .25) + ')';
            }
            /* ---- insert Reflexion ---- */
            flx.style.position = 'absolute';
            flx.style.left     = '-1000px';
            cont.appendChild(flx);
            return flx;
        }
        /* //////////// ==== ImageFlow Constructor ==== //////////// */
        function ImageFlow(oCont, horizon, size, zoom, border, start, interval) {
            this.diapos     = [];
            this.scr        = false;
            this.size       = size;
            this.zoom       = zoom;
            this.horizon    = horizon;
            this.bdw        = border;
            this.oCont      = oCont;
            this.oc         = document.getElementById(oCont);
            this.scrollbar  = getElementsByClass(this.oc,   'div', 'scrollbar');
            this.text       = getElementsByClass(this.oc,   'div', 'text');
            this.title      = getElementsByClass(this.text, 'div', 'title');
            this.legend     = getElementsByClass(this.text, 'div', 'legend');
            this.bar        = getElementsByClass(this.oc,   'img', 'bar');
            this.arL        = getElementsByClass(this.oc,   'img', 'arrow-left');
            this.arR        = getElementsByClass(this.oc,   'img', 'arrow-right');
            this.bw         = this.bar.width;
            this.alw        = this.arL.width - 5;
            this.arw        = this.arR.width - 5;
            this.bar.parent = this.oc.parent  = this;
            this.arL.parent = this.arR.parent = this;
            this.view       = this.back       = -1;
            this.time_start = start * 62.5 || 0;
            this.time_inter = interval * 62.5 || 0;
            this.time_out   = this.time_start;
            this.time       = 0;
            this.time_dir   = 1;
            this.resize();
            this.oc.onselectstart = function () { return false; }
            /* ---- create images ---- */
            var img   = getElementsByClass(this.oc, 'div', 'bank').getElementsByTagName('a');
            this.NF = img.length;
            for (var i = 0, o; o = img[i]; i++) {
                this.diapos[i] = new Diapo(this, i,
                                            o.href,
                                            //o.title || '- ' + i + ' -',
                                            o.title || '',
                                            o.innerHTML || o.href,
                                            o.rel || '',
                                            o.target || '_self'
                );
            }
            /* ==== add mouse wheel events ==== */
            if (window.addEventListener)
                this.oc.addEventListener('DOMMouseScroll', function(e) {
                    this.parent.scroll(-e.detail);
                    return false;
                }, false);
            this.oc.onmousewheel = function () {
                this.parent.scroll(event.wheelDelta);
                return false;
            }
            /* ==== scrollbar drag N drop ==== */
            this.bar.onmousedown = function (e) {
                if (!e) e = window.event;
                var scl = e.screenX - this.offsetLeft;
                var self = this.parent;
                /* ---- move bar ---- */
                this.parent.oc.onmousemove = function (e) {
                    if (!e) e = window.event;
                    self.bar.style.left = Math.round(Math.min((self.ws - self.arw - self.bw), Math.max(self.alw, e.screenX - scl))) + 'px';
                    self.view = Math.round(((e.screenX - scl) ) / (self.ws - self.alw - self.arw - self.bw) * (self.NF-1));
                    if (self.view != self.back) self.calc();
                    return false;
                }
                /* ---- release scrollbar ---- */
                this.parent.oc.onmouseup = function (e) {
                    self.oc.onmousemove = null;
                    return false;
                }
                return false;
            }
            /* ==== right arrow ==== */
            this.arR.onclick = this.arR.ondblclick = function () {
                if (this.parent.view < this.parent.NF - 1)
                    this.parent.calc(1);
            }
            /* ==== Left arrow ==== */
            this.arL.onclick = this.arL.ondblclick = function () {
                if (this.parent.view > 0)
                    this.parent.calc(-1);
            }
        }
        /* //////////// ==== ImageFlow prototype ==== //////////// */
        ImageFlow.prototype = {
            /* ==== targets ==== */
            calc : function (inc) {
                if (inc) {
                    this.view += inc;
                    /* ---- stop autoscroll ---- */
                    this.time = 0;
                    this.time_out = this.time_start;
                }
                var tw = 0;
                var lw = 0;
                var o = this.diapos[this.view];
                if (o && o.loaded) {
                    /* ---- reset ---- */
                    var ob = this.diapos[this.back];
                    if (ob && ob != o) {
                        ob.img.className = 'diapo';
                        ob.z1 = 1;
                    }
                    /* ---- update legend ---- */
                    this.title.replaceChild(document.createTextNode(o.title), this.title.firstChild);
                    this.legend.replaceChild(document.createTextNode(o.text), this.legend.firstChild);
                    /* ---- update hyperlink ---- */
                    if (o.url) {
                        o.img.className = 'diapo link';
                        window.status = 'hyperlink: ' + o.url;
                    } else {
                        o.img.className = 'diapo';
                        window.status = '';
                    }
                    /* ---- calculate target sizes & positions ---- */
                    if(o.r < 1) o.w1 = Math.min(o.iw, this.wh * .8, Math.round(this.ht * this.horizon / o.r)) * o.z1;
                    else o.w1 = Math.round(this.ht * this.horizon / o.r) * o.z1;
                    var x0 = o.x1 = (this.wh * .5) - (o.w1 * .5);
                    var x = x0 + o.w1 + this.bdw;
                    for (var i = this.view + 1, o; o = this.diapos[i]; i++) {
                        if (o.loaded) {
                            o.x1 = x;
                            o.w1 = (this.ht / o.r) * this.size;
                            x   += o.w1 + this.bdw;
                            tw  += o.w1 + this.bdw;
                        }
                    }
                    x = x0 - this.bdw;
                    for (var i = this.view - 1, o; o = this.diapos[i]; i--) {
                        if (o.loaded) {
                            o.w1 = (this.ht / o.r) * this.size;
                            o.x1 = x - o.w1;
                            x   -= o.w1 + this.bdw;
                            tw  += o.w1 + this.bdw;
                            lw  += o.w1 + this.bdw;
                        }
                    }
                    /* ---- move scrollbar ---- */
                    if (!this.scr && tw) {
                        var r = (this.ws - this.alw - this.arw - this.bw) / tw;
                        this.bar.style.left = Math.round(this.alw + lw * r) + 'px';
                    }
                    /* ---- save preview view ---- */
                    this.back = this.view;
                }
            },
            /* ==== mousewheel scrolling ==== */
            scroll : function (sc) {
                if (sc < 0) {
                    if (this.view < this.NF - 1) this.calc(1);
                } else {
                    if (this.view > 0) this.calc(-1);
                }
            },
            /* ==== resize  ==== */
            resize : function () {
                this.wh = this.oc.clientWidth;
                this.ht = this.oc.clientHeight;
                this.ws = this.scrollbar.offsetWidth;
                this.calc();
                this.run(true);
            },
            /* ==== animation loop ==== */
            run : function (res) {
                /* ---- move all images ---- */
                var i = this.NF;
                while (i--) this.diapos[i].move(res);
                /* ---- autoscroll ---- */
                if (this.time_out) {
                    this.time++;
                    if (this.time > this.time_out) {
                        this.view += this.time_dir;
                        if (this.view >= this.NF || this.view < 0) {
                            this.time_dir = -this.time_dir;
                            this.view += this.time_dir * 2;
                        }
                        this.calc();
                        this.time = 0;
                        this.time_out = this.time_inter;
                    }
                }
            }
        }
        /* //////////// ==== Diapo Constructor ==== //////////// */
        Diapo = function (parent, N, src, title, text, url, target) {
            this.parent        = parent;
            this.loaded        = false;
            this.title         = title;
            this.text          = text;
            this.url           = url;
            this.target        = target;
            this.N             = N;
            this.img           = document.createElement('img');
            this.img.src       = src;
            this.img.parent    = this;
            this.img.className = 'diapo';
            this.x0            = this.parent.oc.clientWidth;
            this.x1            = this.x0;
            this.w0            = 0;
            this.w1            = 0;
            this.z1            = 1;
            this.img.parent    = this;
            this.img.onclick   = function() { this.parent.click(); }
            this.parent.oc.appendChild(this.img);
            /* ---- display external link ---- */
            if (url) {
                this.img.onmouseover = function () { this.className = 'diapo link';    }
                this.img.onmouseout  = function () { this.className = 'diapo'; }
            }
        }
        /* //////////// ==== Diapo prototype ==== //////////// */
        Diapo.prototype = {
            /* ==== HTML rendering ==== */
            move : function (res) {
                var that = this.parent;
                if (this.loaded) {
                    var sx = this.x1 - this.x0;
                    var sw = this.w1 - this.w0;
                    if (Math.abs(sx) > 2 || Math.abs(sw) > 2 || res) {
                        /* ---- paint only when moving ---- */
                        this.x0 += sx * .1;
                        this.w0 += sw * .1;
                        if (this.x0 < that.wh && this.x0 + this.w0 > 0) {
                            /* ---- paint only visible images ---- */
                            this.visible = true;
                            var o = this.img.style;
                            var h = this.w0 * this.r;
                            /* ---- diapo ---- */
                            o.left   = Math.round(this.x0) + 'px';
                            o.bottom = Math.floor(that.ht * (1 - that.horizon)) + 'px';
                            o.width  = Math.round(this.w0) + 'px';
                            o.height = Math.round(h) + 'px';
                            /* ---- reflexion ---- */
                            if (this.flx) {
                                var o = this.flx.style;
                                o.left   = Math.round(this.x0) + 'px';
                                o.top    = Math.ceil(that.ht * that.horizon + 1) + 'px';
                                o.width  = Math.round(this.w0) + 'px';
                                o.height = Math.round(h) + 'px';
                            }
                        } else {
                            /* ---- disable invisible images ---- */
                            if (this.visible) {
                                this.visible = false;
                                this.img.style.width = '0px';
                                if (this.flx) this.flx.style.width = '0px';
                            }
                        }
                    }
                } else {
                    /* ==== image onload ==== */
                    if (this.img.complete && this.img.width) {
                        /* ---- get size image ---- */
                        this.iw     = this.img.width;
                        this.ih     = this.img.height;
                        this.r      = this.ih / this.iw;
                        this.loaded = true;
                        /* ---- create reflexion ---- */
                        this.flx    = createReflexion(that.oc, this.img);
                        if (that.view < 0) that.view = this.N;
                        else if (this.N == 0) that.view = this.N;
                        that.calc();
                    }
                }
            },
            /* ==== diapo onclick ==== */
            click : function () {
                /* ---- stop autoscroll ---- */
                this.parent.time = 0;
                this.parent.time_out = this.parent.time_start;
                if (this.parent.view == this.N) {
                    /* ---- click on zoomed diapo ---- */
                    if (this.url) {
                        /* ---- open hyperlink ---- */
                        window.open(this.url, this.target);
                    } else {
                        /* ---- zoom in/out ---- */
                        this.z1 = this.z1 == 1 ? this.parent.zoom : 1;
                        this.parent.calc();
                    }
                } else {
                    /* ---- select diapo ---- */
                    this.parent.view = this.N;
                    this.parent.calc();
                }
                return false;
            }
        }
        /* //////////// ==== public methods ==== //////////// */
        return {
            /* ==== initialize script ==== */
            create : function (div, horizon, size, zoom, border, start, interval) {
                /* ---- instanciate imageFlow ---- */
                var load = function () {
                    var loaded = false;
                    var i = instances.length;
                    while (i--) if (instances[i].oCont == div) loaded = true;
                    if (!loaded) {
                        /* ---- push new imageFlow instance ---- */
                        instances.push(
                            new ImageFlow(div, horizon, size, zoom, border, start, interval)
                        );
                        /* ---- init script (once) ---- */
                        if (!imf.initialized) {
                            imf.initialized = true;
                            /* ---- window resize event ---- */
                            addEvent(window, 'resize', function () {
                                var i = instances.length;
                                while (i--) instances[i].resize();
                            });
                            /* ---- stop drag N drop ---- */
                            addEvent(document.getElementById(div), 'mouseout', function (e) {
                                if (!e) e = window.event;
                                var tg = e.relatedTarget || e.toElement;
                                if (tg && tg.tagName == 'HTML') {
                                    var i = instances.length;
                                    while (i--) instances[i].oc.onmousemove = null;
                                }
                                return false;
                            });
                            /* ---- set interval loop ---- */
                            setInterval(function () {
                                var i = instances.length;
                                while (i--) instances[i].run();
                            }, 16);
                        }
                    }
                }
                /* ---- window onload event ---- */
                addEvent(window, 'load', function () { load(); });
            }
        }
    }();
    
    /* ==== create imageFlow ==== */
    //          div ID, horizon, size, zoom, border, autoscroll_start, autoscroll_interval
    imf.create("imageFlow", 0.75, 0.15, 1.8, 10, 8, 4);
    
</script>
</head>

<body>

	<%

    g_seq  = Trim(Request("g_seq"))

    OpenF5_DB objConn  
  %>

    <div id="imageFlow">
        <div class="top"></div>
        <div class="bank">
        <%
         
           sql = "select p_seq, g_seq, tp, file_img,p_remark from ex_good_photo where g_seq = '"&g_seq&"'   ORDER BY disp_seq"
           Set Rs = Server.CreateObject("ADODB.RecordSet")
           Rs.open sql,objConn,3
           
           rcnt	= Rs.Recordcount	
           i = 0
           imgCnt = 0

           If  NOT Rs.eof then

              redim r_seq(rcnt),imgPath(rcnt),imgTitle(rcnt)
              Do Until Rs.Eof

                 r_seq(i)   = Rs("p_seq")
                 
                 img         = Rs("file_img")
                 p_remark    = Rs("p_remark")
                 if p_remark="" or isnull(p_remark) then
                   p_remark=" "
                 End if
                 
                 imgTitle(i) = p_remark
                 
               

                 if r_seq(i) > 0 then
                     imgCnt = imgCnt + 1
                     imgPath(i) ="/board/upload/tck/"&g_seq&"/"&img&""
                 end if

                  
        %>
           <a href="<%=imgPath(i)%>" ><%=imgTitle(i)%></a>
        <%      
            		Rs.MoveNext
            		Loop
            	End If
            	Rs.close
              set Rs = nothing
        %>
        </div>

        <div class="text">
            <div class="title">Loading</div>
            <div class="legend">Please wait...</div>
        </div>
        <div class="scrollbar">
            <img class="track" src="/images/goods/sb.png" alt="">
            <img class="arrow-left" src="/images/goods/sl.png" alt="">
            <img class="arrow-right" src="/images/goods/sr.png" alt="">
            <img class="bar" src="/images/goods/sc.png" alt="">
        </div>
    </div>
    
    <div style="padding:15px"> 
        <div id="mapContainer" style="width: 100%; height: 780px"></div>
    </div>
</body>
</html>
