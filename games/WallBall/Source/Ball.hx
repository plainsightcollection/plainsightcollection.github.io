package;

import starling.display.Image;
import starling.textures.Texture;
import starling.animation.IAnimatable;

import openfl.geom.Point;
import openfl.geom.Vector3D;

import Dir;
import WallBall as C;

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
    checkBalls();

    checkBG(time);

    checkWalls();

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

    top = C.walled(xp + C.DIRS[N].x,yp + C.DIRS[N].y);
    right = C.walled(xp + C.DIRS[E].x,yp + C.DIRS[E].y);
    bottom = C.walled(xp + C.DIRS[S].x,yp + C.DIRS[S].y);
    left = C.walled(xp + C.DIRS[W].x, yp + C.DIRS[W].y);

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

  private function checkWalls():Void {
    for (i in 0...C.level) {
      for (j in 0...2) 
        if (C.walls[j].contains(cx,cy)) {
          trace("Ball hit mason!");
          C.mason.end(j);
          C.bridge.lives(--C.lives);
          if (C.lives < 1) C.setup(2);
        }
    }
  }

  public function sensorReset():Void {
    top = false;
    right = false;
    bottom = false;
    left = false;
  }

}
