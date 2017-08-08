package;

import starling.display.Sprite;
import starling.events.Event;
import starling.core.Starling;
import starling.animation.IAnimatable;

import openfl.events.MouseEvent;
import openfl.display.BitmapData;
import openfl.geom.Point;

import Bridge;
import Ball;
import Wall;
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
  public static var walls:Array<Wall>;
  public static var self:WallBall;

  public static inline var WIDTH = 688;
  public static inline var HEIGHT = 368;
  public static inline var R = 9;
  public static inline var D = 19;
  public static inline var DX = 170;
  public static inline var DY = 235;
  public static inline var DW = 183;
  public static inline var MXT = 1/30;
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

    addEventListener(Event.ADDED_TO_STAGE,onAdded);
    nativeStage.addEventListener(MouseEvent.CLICK, onClick);
    nativeStage.addEventListener(MouseEvent.RIGHT_CLICK, onClick);
  }

  private function onAdded() {
  }

  private function onClick(e:MouseEvent) {
  }

  public function advanceTime(time:Float):Void {
  }

  public static function setup(lvl:Int):Void {
  }

}
