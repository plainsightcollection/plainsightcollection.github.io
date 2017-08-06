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

typedef Ball = {
  var pos:Point;
  var traj:Point;
}

class Balls implements IAnimatable {
  private var playField:Sprite;
  private var balls:Array<Ball>;
  static inline private var dx = 0.7*4*60;
  static inline private var dy = 0.97*4*60;
  private var img:Image;
  var acc:Float;

  public function new(plyfld:Sprite) {
    playField = plyfld;

    balls = new Array<Ball>();
    balls.push({pos:new Point(25,25),traj:new Point(1,1)});

    var bmp = new BitmapData(20,20,true,0);
    var cnv = new openfl.display.Sprite();
    cnv.graphics.beginFill(0x00FF00);
    cnv.graphics.drawCircle(10,10,10);
    cnv.graphics.endFill();
    bmp.draw(cnv);
    bmp.lock();
    var tex = Texture.fromBitmapData(bmp);
    bmp.dispose();
    
    img = new Image(tex);


    acc = 0;

    var q = new Quad(688,368,0xFFFFFFFF);
    q.x = 0;
    q.y = 0;
    playField.addChild(q);

    playField.addChild(img);
  }

  public function advanceTime(time:Float):Void {
    var xp:Float;
    var yp:Float;
    xp = balls[0].pos.x;
    yp = balls[0].pos.y;
    xp += balls[0].traj.x*dx*time;
    yp += balls[0].traj.y*dy*time;
    if (yp-2 < 0) balls[0].traj.y *= -1;
    if (yp+2 > 368) balls[0].traj.y *= -1;
    if (xp-2 < 0) balls[0].traj.x *= -1;
    if (xp+2 > 688) balls[0].traj.x *= -1;
    balls[0].pos.x += balls[0].traj.x*dx*time;
    balls[0].pos.y += balls[0].traj.y*dy*time;
    img.x = balls[0].pos.x+9;
    img.y = balls[0].pos.y+9;
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
