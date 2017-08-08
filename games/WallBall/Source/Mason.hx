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
  private var quadC:Quad;
  private var xp:Int;
  private var yp:Int;
  private var xo:Int;
  private var yo:Int;

  public function new() {
    super();

    quadA = new Quad(C.MSN,C.MSN,0xFFFF0000);
    quadB = new Quad(C.MSN,C.MSN,0xFF0000FF);
    quadC = new Quad(C.MSN,C.MSN,0xFF00FF00);
  }

  public function begin(x:Int,y:Int):Void {
    xo = x;
    yo = y;
    
    if (C.upDown) {
      quadA.x = x-(C.MSN/2);
      quadA.y = y-C.MSN;

      quadB.x = x-(C.MSN/2);
      quadB.y = y;

      xp = 0;
      yp = -1;

    } else {
      quadA.x = x-(C.MSN-1);
      quadA.y = y-(C.MSN/2);

      quadB.x = x;
      quadB.y = y-(C.MSN/2);

      xp = -1;
      yp = 0;
    }

    quadA.width = C.MSN;
    quadA.height = C.MSN;
    quadB.width = C.MSN;
    quadB.height = C.MSN;

    quadC.x = quadB.x;
    quadC.y = quadB.y;
    quadC.width = C.MSN;
    quadC.height = C.MSN;

    addChild(quadA);
    addChild(quadC);
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
        removeChild(quadC);
      }
    }
    if (!activeA && !activeB) C.layingBrick = false;
  }

  public function advanceTime(time:Float):Void {
    if (!C.layingBrick) return;

    if (activeA) {
      quadA.x += xp*C.DW*time;
      quadA.y += yp*C.DW*time;

      quadA.width = xo-quadA.x-yp*(C.MSN/2);
      quadA.height = yo-quadA.y-xp*(C.MSN/2);

      if (C.walled(quadA.x,quadA.y) ||
          C.walled(quadA.x-yp*C.MSN,quadA.y-xp*C.MSN)) {
        trace("A hit wall!");
        end(0);
      }
    }

    if (activeB) {
      quadB.x -= xp*C.DW*time;
      quadB.y -= yp*C.DW*time;

      quadC.x = xo+yp*(C.MSN/2);
      quadC.y = -yp*(quadB.y)-xp*(yo-(C.MSN/2)); 

      quadC.width = -yp*(C.MSN)-xp*(quadB.x-xo);
      quadC.height = -xp*(C.MSN)-yp*(yo-quadB.y);

      if (C.walled(quadB.x-xp*C.MSN,quadB.y-yp*C.MSN) ||
          C.walled(quadB.x+C.MSN,quadB.y+C.MSN)) {
        trace("B hit wall!");
        end(1);
      }
    }

  }

}
