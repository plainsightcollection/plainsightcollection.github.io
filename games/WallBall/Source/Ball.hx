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

    xp = cx + C.DX*C.DIRS[v].x * time;
    yp = cy + C.DY*C.DIRS[v].y * time;

    checkBalls();

    xp = cx + C.DX*C.DIRS[v].x * time;
    yp = cy + C.DY*C.DIRS[v].y * time;

    checkWalls();

    if (top && bottom || left && right) {
      trace("Ball trouble!");
      cx = (C.WIDTH-C.D)/2;
      cy = (C.HEIGHT-C.D)/2;
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
        trace("Invalid velocity in checkWalls.");
        return;
      }
    }

  }

  private function checkBalls():Void {
    var a = new Point(cx,cy);
    var b = new Point(0,0);
    var d:Float;
    var vp:Dir;
    var w = new Vector3D(cx,cy,0,0);
    w.normalize();
    var k = new Vector3D(0,1,0,0);
    for (i in 0...C.level) {
      if (cx == C.balls[i].cx &&
          cy == C.balls[i].cy) continue;

      b.x = C.balls[i].cx;
      b.y = C.balls[i].cy;

      d = Point.distance(a,b);
      if (d > C.R) continue;

      k.x = C.balls[i].cx - cx;
      k.y = C.balls[i].cy - cy;
      k.normalize();

      if (Math.abs(Math.acos(w.dotProduct(k))) > Math.PI/2) continue;

      switch v {
        case NE: v = SW;
        case SE: v = NW;
        case SW: v = NE;
        case NW: v = SE;
        default: {
          trace("Invalid velocity in checkBalls()");
        }
      }
    }
  }

  private function walled(x:Float, y:Float):Bool {
    if (x < 0 || x >= C.WIDTH) return true;
    if (y < 0 || y >= C.HEIGHT) return true;

    return (C.playfields[0].getPixel32(Math.round(x/4),Math.round(y/4)) >> 24!= 0);
  }

}
