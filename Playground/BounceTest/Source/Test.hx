package;

import starling.display.Sprite;
import starling.display.Image;
import starling.events.Event;
import starling.textures.Texture;
import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.textures.TextureSmoothing;

import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Vector3D;
import openfl.Assets;

enum Dir {
  N;
  NE;
  E;
  SE;
  S;
  SW;
  W;
  NW;
}

class Constants {
  public static inline var WIDTH = 688;
  public static inline var HEIGHT = 368;
  public static inline var R = 9;
  public static inline var D = 19;
  public static inline var DX = 170;
  public static inline var DY = 235;
  public static inline var DW = 183;
  public static inline var MXT = 1/30;
  public static var DIRS:Map<Dir,Point> = [
    NE => new Point(1,-1),
    SE => new Point(1,1),
    SW => new Point(-1,1),
    NW => new Point(-1,-1),
    N => new Point(0,-R),
    E => new Point(R,0),
    S => new Point(0,R),
    W => new Point(-R,0)
  ];
  public static var BG:BitmapData;
  public static var BALLS:Array<Ball>;
}
typedef C = Constants;

class Ball extends Image implements IAnimatable {
  public var cx:Float;
  public var cy:Float;
  private var xp:Float;
  private var yp:Float;
  public var v:Dir;
  private var live:Bool;
  private var top:Bool;
  private var right:Bool;
  private var bottom:Bool;
  private var left:Bool;

  public function new(cxp:Float, cyp:Float, vp:Dir, tex:Texture) {
    super(tex);

    cx = cxp;
    cy = cyp;
    v = vp;

    live = true;
  }

  public function advanceTime(time:Float):Void {
    if (!live) return;
    time = Math.min(C.MXT,time);

    xp = cx + C.DX*C.DIRS[v].x * time; 
    yp = cy + C.DX*C.DIRS[v].y * time; 

    checkBalls();

    xp = cx + C.DX*C.DIRS[v].x * time; 
    yp = cy + C.DX*C.DIRS[v].y * time; 

    checkWalls();

    if (xp != cx && yp == cy) return;

    if (top && bottom || left && right) {
      //live = false;
      trace("Ball lost!");
      cx = 10;
      cy = 10;
      return;
    }

    x = xp-C.R;
    y = yp-C.R;
    cx = xp;
    cy = yp;

  }

  private function checkWalls():Void {
    top = walled(xp + C.DIRS[N].x,yp + C.DIRS[N].y);
    right = walled(xp + C.DIRS[E].x,yp + C.DIRS[E].y);
    bottom = walled(xp + C.DIRS[S].x,yp + C.DIRS[S].y);
    left = walled(xp + C.DIRS[W].x,yp + C.DIRS[W].y);

    switch v {
      case NE: {
        if (top || right) {
          xp = cx;
          yp = cy;
        }
        if (top) v = SE;
        if (right) v = NW;
      }
      case SE: {
        if (bottom || right) {
          xp = cx;
          yp = cy;
        }
        if (bottom) v = NE;
        if (right) v = SW;
      }
      case SW: {
        if (bottom || left) {
          xp = cx;
          yp = cy;
        }
        if (bottom) v = NW;
        if (left) v = SE;
      }
      case NW: {
        if (top || left) {
          xp = cx;
          yp = cy;
        }
        if (top) v = SW;
        if (left) v = NE;
      }
      default: {
        live = false;
        xp = cx;
        yp = cx;
        trace("Invalid velocity.");
        return;
      }
    }

    return;
  }

  private function checkBalls():Void {
    var a = new Point(cx,cy);
    var b = new Point(cx,cy);
    var d:Float;
    var vp:Dir;
    var vv = new Vector3D(cx,cy,0,0);
    vv.normalize();
    var vw = new Vector3D(0,1,0,0);
    for (i in 0...C.BALLS.length) {
      if (cx == C.BALLS[i].cx && 
          cy == C.BALLS[i].cy) continue;
      b.x = C.BALLS[i].cx;
      b.y = C.BALLS[i].cy;
      d = Point.distance(a,b);
      if (d > C.R) continue;
      vw.x = C.BALLS[i].cx - cx;
      vw.y = C.BALLS[i].cy - cy;
      vw.normalize();
      if (Math.abs(Math.acos(vv.dotProduct(vw))) > Math.PI/2) continue;
      switch v {
        case NE: v = SW;
        case SE: v = NW;
        case SW: v = NE;
        case NW: v = SE;
        default: {
          trace("Invalid velocity.");
        }
      }
    }
  }

  private function walled(x:Float,y:Float):Bool {
    if (x < 0 || x >= C.WIDTH) return true;
    if (y < 0 || y >= C.HEIGHT) return true;

    var xi = Math.round(x/4);
    var yi = Math.round(y/4);

    return ((C.BG.getPixel32(xi,yi) >> 24) != 0);
  }
}

class Test extends Sprite implements IAnimatable {
  private var balls:Array<Ball>;
  public function new() {
    super();

    addEventListener(Event.ADDED_TO_STAGE,onAdded);
  }

  private function onAdded() {

    var bgBmp = Assets.getBitmapData("assets/testField.png");
    bgBmp.lock();
    C.BG = bgBmp;
    var bgt = Texture.fromBitmapData(bgBmp);
    var img = new Image(bgt);
    img.width = C.WIDTH;
    img.height = C.HEIGHT;
    img.smoothing = TextureSmoothing.NONE;
    addChild(img);

    var cnv = new openfl.display.Sprite();
    cnv.graphics.beginFill(0x00FF00);
    cnv.graphics.drawCircle(C.D/2,C.D/2,C.D/2);
    cnv.graphics.endFill();

    var bmp = new BitmapData(C.D,C.D,true,0);
    bmp.draw(cnv);
    bmp.lock();

    var tex = Texture.fromBitmapData(bmp);
    bmp.dispose();

    balls = new Array();
    var ball:Ball;
    for (i in 0...49) {
      ball = new Ball(Math.floor(Math.random()*C.WIDTH),
                      Math.floor(Math.random()*C.HEIGHT),
                      [NE,SE,SW,NE][Math.floor(Math.random()*4)],
                      tex);
      addChild(ball);
      balls.push(ball);
    }
    C.BALLS = balls;
    Starling.current.juggler.add(this);

  }

  public function advanceTime(time:Float):Void {
    for (i in 0...balls.length) {
      balls[i].advanceTime(time);
    }
  }
}
