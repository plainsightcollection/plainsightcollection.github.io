package;

import starling.display.Image;
import starling.textures.Texture;
import starling.animation.IAnimatable;

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
  }

  private function checkBalls():Void {
  }

}
