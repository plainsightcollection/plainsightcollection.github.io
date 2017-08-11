var base = "https://plainsightcollection.github.io/web/alpha/";
var body = document.getElementsByTagName("body")[0];

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
  if (count++ == 3) {
    try {
      eval(code);

      var w = 800;
      var h = 600;

      var bg = document.createElement("img");
      bg.src = base + "assets/game_wallball_white.png";
      bg.style.setProperty("position","fixed");
      bg.style.setProperty("z-index","1000000");
      bg.style.setProperty("width",w + "px");
      bg.style.setProperty("height",h + "px");

      var sts = document.createElement("div");
      sts.innerHTML = "Lives: <div id='lives'></div> Percent: <div id='percent'></div>";

      var a = document.createElement("a");
      a.href = "#";
      a.style.setProperty("position","fixed");
      a.style.setProperty("z-index","1000000");
      a.style.setProperty("user-select","none");
      a.onclick = function() {
        window.location.reload(false); 
      }

      var x = document.createElement("img");
      x.src = base + "assets/x.svg";
      x.style.setProperty("width","24px");
      x.style.setProperty("height","24px");

      a.appendChild(x);

      var ct = document.createElement("div");
      ct.id = "openfl-content";

      ct.style.setProperty("width",w + "px");
      ct.style.setProperty("height",h + "px");
      ct.style.setProperty("position","fixed");
      ct.style.setProperty("z-index","1000000");
      ct.style.setProperty("user-select","none");

      var lft = Math.max(0,Math.round((window.innerWidth-w)/2));
      var tp = Math.max(0,Math.round((window.innerHeight-h)/2));

      ct.style.setProperty("left",56+lft+"px");
      ct.style.setProperty("top",150+tp+"px");

      a.style.setProperty("left",(w-12)+lft+"px");
      a.style.setProperty("top",tp-12+"px");

      bg.style.setProperty("left",lft+"px");
      bg.style.setProperty("top",tp+"px");

      body.appendChild(bg);
      body.appendChild(sts);
      body.appendChild(ct);
      body.appendChild(a);

      document.title = t;

		  lime.embed ("WallBall", "openfl-content", 688, 368, { parameters: {} });

    } catch(e) {
      console.log(e);
    }
  }
}

var a = new XMLHttpRequest();
var b = new XMLHttpRequest();
var c = new XMLHttpRequest();
var d = new XMLHttpRequest();

a.onload = report;
b.onload = report;
c.onload = report;
d.onload = report;

a.open("GET", base + "lib/howler.min.js", true);
b.open("GET", base + "lib/pako.min.js", true);
d.open("GET", base + "lib/bridge.js", true);
c.open("GET", base + "WallBall.js", true);

a.send();
b.send();
c.send();
d.send();

//updateSize HTML5Application.hx
//HTML5HTTPRequest.hx
//loadImage and XMLHttpRequest use
