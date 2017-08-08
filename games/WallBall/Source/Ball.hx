package;

import starling.display.Image;
import starling.textures.Texture;
import starling.animation.IAnimatable;

import openfl.geom.Point;
import openfl.geom.Vector3D;

import Dir;
import WallBall;

typedef C = WallBall;

class Ball extends Image implements IAnimatable {
  public var cx:Float;
  public var cy:Float;
  private var xp:Float;
  private var yp:Float;
  public var v:Dir;
  private var top:Bool;
  private var right:Bool;
  private var bottom:Bool;
  private var left:Bool;

  public function new(tex:Texture) {
    super(tex);
  }

  public function advanceTime(time:Float):Void {
    time = Math.min(C.MXT,time);

    checkBalls();

    checkBG(time);

    if (top && bottom || left && right) {
      trace("Ball trouble!");
      return;
    }

    x = xp-C.R;
    y = yp-C.R;
    cx = xp;
    cy = yp;

  }

  private function checkBG(time:Float):Void {
    xp = cx + C.DX*C.DIRS[v].x * time;
    yp = cy + C.DY*C.DIRS[v].y * time;

    top = walled(xp + C.DIRS[N].x,yp + C.DIRS[N].y);
    right = walled(xp + C.DIRS[E].x,yp + C.DIRS[E].y);
    bottom = walled(xp + C.DIRS[S].x,yp + C.DIRS[S].y);
    left = walled(xp + C.DIRS[W].x, yp + C.DIRS[W].y);

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
        trace("Invalid velocity in checkBG.");
        return;
      }
    }

  }

  private function checkBalls():Void {
    var a = new Point(cx,cy);
    var b = new Point(0,0);
    var d:Float;
    var o:Ball;
    var t:Dir;
    for (i in 0...C.level) {
      o = C.balls[i];

      if (this == o) continue;

      b.x = o.cx;
      b.y = o.cy;
      d = Point.distance(a,b);
      if (d > C.D) continue;

      left = (o.cx <= cx);
      right = !left;
      top = (o.cy <= cy);
      bottom = !top;

      if (top) {
        v = SW;
        o.v = NE;
      }
      if (top && left) {
        v = SE;
        o.v = NW;
      }
      if (bottom) {
        v = NW;
        o.v = SE;
      }
      if (bottom && left) {
        v = NE;
        o.v = SW;
      }

    }
  }

  private function walled(x:Float, y:Float):Bool {
    if (x < 0 || x >= C.WIDTH) return true;
    if (y < 0 || y >= C.HEIGHT) return true;

    return (C.playfields[0].getPixel32(Math.round(x/C.SCALE),
                                       Math.round(y/C.SCALE)) >> 24!= 0);
  }

}
