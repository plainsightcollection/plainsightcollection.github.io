var base = "http://172.17.0.12:8000/Export/html5/bin/";
document.title = t;

var code = "";

/*
var org = XMLHttpRequest.prototype.open;
XMLHttpRequest.prototype.open = function() {
  console.log(arguments);
  arguments[1] = base + arguments[1];
  org.apply(this, arguments);
}
*/

var count = 0;
var report = function(e) {
  code += e.currentTarget.responseText;
  if (count++ == 2) {
    try {
      eval(code);

      var ct = document.createElement("div");
      ct.id = "openfl-content";
      var w = 800;
      var h = 600;
      ct.style.setProperty("width",w + "px");
      ct.style.setProperty("height",h + "px");
      ct.style.setProperty("position","fixed");
      var lft = Math.max(0,Math.round((window.innerWidth-w)/2));
      var tp = Math.max(0,Math.round((window.innerHeight-h)/2));
      ct.style.setProperty("left",lft+"px");
      ct.style.setProperty("top",tp+"px");

      document.getElementsByTagName("body")[0].appendChild(ct);
		  lime.embed ("Flippy", "openfl-content", w, h, { parameters: {} });

    } catch(e) {
      console.log(e);
    }
  }
}

var a = new XMLHttpRequest();
var b = new XMLHttpRequest();
var c = new XMLHttpRequest();

a.onload = report;
b.onload = report;
c.onload = report;

a.open("GET", base + "lib/howler.min.js", true);
b.open("GET", base + "lib/pako.min.js", true);
c.open("GET", base + "Flippy.js", true);

a.send();
b.send();
c.send();

//updateSize
//HTML5HTTPRequest.hx
//loadImage and XMLHttpRequest use
