package;

import starling.display.Sprite;
import starling.display.Image;
import starling.events.Event;
import starling.textures.Texture;
import starling.animation.IAnimatable;
import starling.core.Starling;

import openfl.display.BitmapData;
import openfl.geom.Point;

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
}
typedef C = Constants;

class Ball extends Image implements IAnimatable {
  private var cx:Float;
  private var cy:Float;
  private var xp:Float;
  private var yp:Float;
  private var v:Dir;
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

    checkWalls();

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
        trace("Invalid velocity.");
        return;
      }
    }

    if (top && left && bottom && right) {
      live = false;
      trace("Ball lost!");
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
    return;
  }

  private function walled(x:Float,y:Float):Bool {
    if (x < 0 || x >= C.WIDTH) return true;
    if (y < 0 || y >= C.HEIGHT) return true;
    return false;
  }
}

class Test extends Sprite {
  public function new() {
    super();

    addEventListener(Event.ADDED_TO_STAGE,onAdded);
  }

  private function onAdded() {
    var cnv = new openfl.display.Sprite();
    cnv.graphics.beginFill(0x00FF00);
    cnv.graphics.drawCircle(C.D/2,C.D/2,C.D/2);
    cnv.graphics.endFill();

    var bmp = new BitmapData(C.D,C.D,true,0);
    bmp.draw(cnv);
    bmp.lock();

    var tex = Texture.fromBitmapData(bmp);
    bmp.dispose();

    var ball:Ball;
    for (i in 0...49) {
      ball = new Ball(Math.floor(Math.random()*C.WIDTH),
                      Math.floor(Math.random()*C.HEIGHT),
                      [NE,SE,SW,NE][Math.floor(Math.random()*4)],
                      tex);
      addChild(ball);
      Starling.current.juggler.add(ball);
    }
  }
}
