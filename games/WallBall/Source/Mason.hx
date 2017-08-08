package;

import starling.display.Sprite;
import starling.textures.Texture;
import starling.animation.IAnimatable;
import starling.display.Quad;

import WallBall as C;

class Mason extends Sprite implements IAnimatable {
  private var activeA:Bool;
  private var activeB:Bool;
  private var quadA:Quad;
  private var quadB:Quad;
  private var xp:Int;
  private var yp:Int;

  public function new() {
    super();

    quadA = new Quad(24,24,0xFFFF0000);
    quadB = new Quad(24,24,0xFF0000FF);
  }

  public function begin(x:Int,y:Int):Void {
    if (C.upDown) {
      quadA.x = x-12;
      quadA.y = y-24;

      quadB.x = x-12;
      quadB.y = y;

      xp = 0;
      yp = -1;

    } else {
      quadA.x = x-23;
      quadA.y = y-12;

      quadB.x = x;
      quadB.y = y-12;

      xp = -1;
      yp = 0;
    }

    addChild(quadA);
    addChild(quadB);

    activeA = true;
    activeB = true;

  }

  public function end(bricks:Int):Void {
    switch bricks {
      case 0: {
        activeA = false;
        removeChild(quadA);
      }
      default: {
        activeB = false;
        removeChild(quadB);
      }
    }
    if (!activeA && !activeB) C.layingBrick = false;
  }

  public function advanceTime(time:Float):Void {
    if (!C.layingBrick) return;

    if (activeA) {
      quadA.x += xp*C.DW*time;
      quadA.y += yp*C.DW*time;

      if (C.walled(quadA.x,quadA.y) ||
          C.walled(quadA.x-yp*24,quadA.y-xp*24)) {
        trace("A hit wall!");
        end(0);
      }
    }

    if (activeB) {
      quadB.x -= xp*C.DW*time;
      quadB.y -= yp*C.DW*time;

      if (C.walled(quadB.x-xp*24,quadB.y-yp*24) ||
          C.walled(quadB.x+24,quadB.y+24)) {
        trace("B hit wall!");
        end(1);
      }
    }

  }

}
