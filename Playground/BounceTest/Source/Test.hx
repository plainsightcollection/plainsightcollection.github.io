package;

import starling.display.Sprite;
import starling.events.Event;
import starling.display.Image;
import starling.display.Stage;
import starling.textures.Texture;
import starling.core.Starling;
import starling.animation.IAnimatable;
import starling.display.Quad;

import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.Lib.getTimer;

import openfl.geom.Vector3D;
import openfl.geom.Matrix3D;

typedef Ball = {
  var pos:Point;
  var traj:Point;
}

typedef Sensor = {
  var off:Point;
  var trans:Point;
}

class Balls implements IAnimatable {
  private var playField:Sprite;
  private var balls:Array<Ball>;
  static inline private var dx = 170;
  static inline private var dy = 235;
  static inline private var r = 10;
  private var sensors:Array<Sensor>;
  private var act:Bool;
  private var clear:Bool;
  private var img:Image;

  public function new(plyfld:Sprite) {
    playField = plyfld;

    balls = new Array<Ball>();
    balls.push({pos:new Point(playField.stage.stageWidth/2,playField.stage.stageHeight/2),traj:new Point(1,1)});

    var bmp = new BitmapData(r*2,r*2,true,0);
    var cnv = new openfl.display.Sprite();
    cnv.graphics.beginFill(0xFF0000);
    cnv.graphics.drawCircle(r,r,r);
    cnv.graphics.endFill();
    bmp.draw(cnv);
    bmp.lock();
    var tex = Texture.fromBitmapData(bmp);
    bmp.dispose();
    
    img = new Image(tex);

    playField.addChild(img);

    sensors = new Array();
    sensors.push({off:new Point(0,-10),trans:new Point(1,-1)});
    sensors.push({off:new Point(10,0),trans:new Point(-1,1)});
    sensors.push({off:new Point(0,10),trans:new Point(1,-1)});
    sensors.push({off:new Point(-10,0),trans:new Point(-1,1)});

    act = false;
  }

  public function advanceTime(time:Float):Void {
    var x = balls[0].pos.x;
    var y = balls[0].pos.y;
    var clear = true;
    for (i in 0...4) {
      if (sensors[i].off.x + x >= 688 || sensors[i].off.x + x < 0 ||
          sensors[i].off.y + y >= 368 || sensors[i].off.y + y < 0) {
        clear = false;
        if (!act) {
          balls[0].traj.x *= sensors[i].trans.x;
          balls[0].traj.y *= sensors[i].trans.y;
        }
      }
    }
    act = !clear;
    balls[0].pos.x += balls[0].traj.x * time * dx;
    balls[0].pos.y += balls[0].traj.y * time * dy;
    img.x = balls[0].pos.x - r;
    img.y = balls[0].pos.y - r;
  }
}

class Test extends Sprite {
  var balls:Balls;

  public function new() {
    super();

    addEventListener(Event.ADDED_TO_STAGE,onAdded);
  }

  private function onAdded() {
    balls = new Balls(this);  
    Starling.current.juggler.add(balls);
  }
}
