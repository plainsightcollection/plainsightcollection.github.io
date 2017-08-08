package;

import starling.display.Sprite;
import starling.events.Event;
import starling.core.Starling;
import starling.animation.IAnimatable;
import starling.textures.Texture;

import openfl.events.MouseEvent;
import openfl.display.BitmapData;
import openfl.geom.Point;
openfl.geom.Rectangle;

import Bridge;
import Ball;
import Mason;
import Dir;

class WallBall extends Sprite implements IAnimatable {
  public static var nativeStage:openfl.display.Stage;
  private var bridge:Bridge;

  public static var lives:Int;
  public static var upDown:Bool;
  public static var layingBrick:Bool;
  public static var level:Int;
  public static var balls:Array<Ball>;
  public static var playfields:Array<BitmapData>;
  public static var walls:Array<Rectangle>;
  public static var self:WallBall;

  public static inline var WIDTH = 688;
  public static inline var HEIGHT = 368;
  public static inline var R = 9;
  public static inline var D = 19;
  public static inline var DX = 170;
  public static inline var DY = 235;
  public static inline var DW = 183;
  public static inline var MXT = 1/30;
  public static inline var MIN = 2;
  public static inline var MAX = 49;
  public static inline var SCALE = 4;
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

  public function new() {
    super();

    bridge = new Bridge();
    self = this;

    upDown = true;

    var bmp = new BitmapData(D,D,true,0);
    var cnv = new openfl.display.Sprite();
    cnv.graphics.beginFill(0xFF00FF00);
    cnv.graphics.drawCircle(D/2,D/2,D/2);
    cnv.graphics.endFill();
    bmp.draw(cnv);
    bmp.lock;

    var tex = Texture.fromBitmapData(bmp);
    bmp.dispose();

    balls = new Array();
    for (i in 0...MAX) {
      balls.push(new Ball(tex));
    }

    playfields = new Array();
    for (i in 0...2) playfields[i] = new BitmapData(WIDTH,HEIGHT,true,0);

    addEventListener(Event.ADDED_TO_STAGE,onAdded);
    nativeStage.addEventListener(MouseEvent.CLICK, onClick);
    nativeStage.addEventListener(MouseEvent.RIGHT_CLICK, onClick);
  }

  private function onAdded() {
    setup(2);
    Starling.current.juggler.add(this);
  }

  private function onClick(e:MouseEvent) {
    if (e.type == MouseEvent.RIGHT_CLICK) {
      upDown = !upDown;
      if (upDown) bridge.cursor("ns-resize");
      if (!upDown) bridge.cursor("ew-resize");
      return;
    }

    if (e.type != MouseEvent.CLICK) return;
  }

  public function advanceTime(time:Float):Void {
    for (i in 0...level) {
      balls[i].advanceTime(time);
    }
  }

  public static function setup(lvl:Int):Void {
    layingBrick = false;
    level = lvl;
    lives = level;
    self.bridge.lives(level);

    for (i in 0...MAX) self.removeChild(balls[i]);
    for (i in 0...level) {
      balls[i].cx = Math.floor(Math.random()*WIDTH);
      balls[i].cy = Math.floor(Math.random()*HEIGHT);
      balls[i].v = [NE,SE,SW,NW][Math.floor(Math.random()*4)];
      self.addChild(balls[i]);
    }
  }

}
