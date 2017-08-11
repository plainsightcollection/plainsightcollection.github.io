package;

import starling.display.Sprite;
import starling.textures.Texture;
import starling.animation.IAnimatable;
import starling.display.Quad;
import starling.display.Image;

import WallBall as C;

class Mason extends Sprite implements IAnimatable {
  private var activeA:Bool;
  private var activeB:Bool;
  private var quadA:Quad;
  private var imgA:Image;
  private var imgB:Image;
  private var quadC:Quad;
  private var xp:Int;
  private var yp:Int;
  private var xo:Int;
  private var yo:Int;

  public function new() {
    super();

    quadA = new Quad(C.MSN,C.MSN,0xFFFF0000);
    imgA = new Image(C.atlas.getTexture("topper"));
    imgB = new Image(C.atlas.getTexture("topper"));
    quadC = new Quad(C.MSN,C.MSN,0xFF0000FF);
  }

  public function begin(x:Int,y:Int):Void {
    xo = x;
    yo = y;
    
    if (C.upDown) {
      quadA.x = x-(C.MSN/2);
      quadA.y = y-C.MSN;

      imgA.x = x-(C.MSN/2);
      imgA.y = y-C.MSN;

      imgB.x = x-(C.MSN/2);
      imgB.y = y;

      xp = 0;
      yp = -1;

    } else {
      quadA.x = x-(C.MSN-1);
      quadA.y = y-(C.MSN/2);

      imgA.x = x-(C.MSN-1);
      imgA.y = y-(C.MSN/2);

      imgB.x = x;
      imgB.y = y-(C.MSN/2);

      xp = -1;
      yp = 0;
    }

    quadA.width = C.MSN;
    quadA.height = C.MSN;

    quadC.x = imgB.x;
    quadC.y = imgB.y;
    quadC.width = C.MSN;
    quadC.height = C.MSN;

    addChild(quadA);
    addChild(imgA);
    addChild(quadC);
    addChild(imgB);

    activeA = true;
    activeB = true;

  }

  public function end(bricks:Int):Void {
    switch bricks {
      case 0: {
        activeA = false;
        C.walls[0].x = C.WIDTH*2;
        C.walls[0].y = C.HEIGHT*2;
        C.walls[0].width = 10;
        C.walls[0].height = 10;
        removeChild(imgA);
        removeChild(quadA);
      }
      default: {
        activeB = false;
        C.walls[1].x = C.WIDTH*2;
        C.walls[1].y = C.HEIGHT*2;
        C.walls[1].width = 10;
        C.walls[1].height = 10;
        removeChild(imgB);
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

      imgA.x += xp*C.DW*time;
      imgA.y += yp*C.DW*time;

      quadA.width = xo-quadA.x-yp*(C.MSN/2);
      quadA.height = yo-quadA.y-xp*(C.MSN/2);

      C.walls[0].x = quadA.x;
      C.walls[0].y = quadA.y;
      C.walls[0].width = quadA.width;
      C.walls[0].height = quadA.height;
      C.walls[0].inflate(C.D,C.D);

      if (C.walled(quadA.x,quadA.y) ||
          C.walled(quadA.x-yp*C.MSN,quadA.y-xp*C.MSN)) {
        trace("A hit wall!");
        C.walls[0].x = Math.round(quadA.x/C.SCALE);
        C.walls[0].y = Math.round(quadA.y/C.SCALE);
        C.walls[0].width = Math.round(quadA.width/C.SCALE);
        C.walls[0].height = Math.round(quadA.height/C.SCALE);
        C.updateBackground(C.walls[0],0xFF000000);
        C.fill();
        end(0);
      }
    }

    if (activeB) {
      imgB.x -= xp*C.DW*time;
      imgB.y -= yp*C.DW*time;

      quadC.x = xo+yp*(C.MSN/2);
      quadC.y = yo+xp*(C.MSN/2); 

      quadC.width = C.MSN-xp*(imgB.x-xo);
      quadC.height = C.MSN-yp*(imgB.y-yo);

      C.walls[1].x = quadC.x;
      C.walls[1].y = quadC.y;
      C.walls[1].width = quadC.width;
      C.walls[1].height = quadC.height;
      C.walls[1].inflate(C.D,C.D);

      /*
      quadC.x = C.walls[1].x;
      quadC.y = C.walls[1].y;
      quadC.width = C.walls[1].width;
      quadC.height = C.walls[1].height;
      */

      if (C.walled(imgB.x-xp*C.MSN,imgB.y-yp*C.MSN) ||
          C.walled(imgB.x+C.MSN,imgB.y+C.MSN)) {
        trace("B hit wall!");
        C.walls[1].x = Math.round(quadC.x/C.SCALE);
        C.walls[1].y = Math.round(quadC.y/C.SCALE);
        C.walls[1].width = Math.round(quadC.width/C.SCALE);
        C.walls[1].height = Math.round(quadC.height/C.SCALE);
        C.updateBackground(C.walls[1],0xFF000000);
        C.fill();
        end(1);
      }
    }

  }

}
