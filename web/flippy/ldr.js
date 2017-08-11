var base = "https://plainsightcollection.github.io/web/flippy/";
var body = document.getElementsByTagName("body")[0];

var code = "";
var count = 0;

var report = function(e) {
  code += e.currentTarget.responseText;
  if (count++ == 2) {
    try {
      eval(code);

      var w = 800;
      var h = 600;

      var a = document.createElement("a");
      a.className = "plainsight";
      a.href = "#";
      a.style.setProperty("position","fixed");
      a.style.setProperty("z-index","1000000");
      a.style.setProperty("user-select","none");
      a.onclick = function() {
        var ps = document.getElementsByClassName("plainsight");
        for (var i = 0; i < ps.length; i++) ps[i].style.setProperty("visibility","hidden");
      }
      window.onkeydown = function(e) {
        if (e.keyCode != 66) return;
        var ps = document.getElementsByClassName("plainsight");
        for (var i = 0; i < ps.length; i++) ps[i].style.setProperty("visibility","visible");
      };

      var x = document.createElement("img");
      x.className = "plainsight";
      x.src = base + "assets/x.svg";
      x.style.setProperty("width","24px");
      x.style.setProperty("height","24px");

      a.appendChild(x);

      var ct = document.createElement("div");
      ct.className = "plainsight";
      ct.id = "openfl-content";

      ct.style.setProperty("width","800px");
      ct.style.setProperty("height","600px");
      ct.style.setProperty("position","fixed");
      ct.style.setProperty("z-index","1000000");
      ct.style.setProperty("user-select","none");

      var lft = Math.max(0,Math.round((window.innerWidth-w)/2));
      var tp = Math.max(0,Math.round((window.innerHeight-h)/2));

      ct.style.setProperty("left",lft+"px");
      ct.style.setProperty("top",tp+"px");

      a.style.setProperty("left",(w-12)+lft+"px");
      a.style.setProperty("top",tp-12+"px");

      body.appendChild(ct);
      body.appendChild(a);

      document.title = t;

		  lime.embed ("Flippy", "openfl-content", 800, 600, { parameters: {} });

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

//updateSize HTML5Application.hx
//HTML5HTTPRequest.hx
//loadImage and XMLHttpRequest use
