package;

import starling.display.Sprite;
import starling.events.Event;
import starling.core.Starling;
import starling.animation.IAnimatable;
import starling.textures.Texture;
import starling.display.Image;
import starling.textures.TextureSmoothing;
import starling.textures.TextureAtlas;

import openfl.events.MouseEvent;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.Assets;

import haxe.xml.Parser;

import Bridge;
import Ball;
import Mason;
import Dir;
import WallFilter;

class WallBall extends Sprite implements IAnimatable {
  public static var nativeStage:openfl.display.Stage;
  public static var bridge:Bridge;

  public static var lives:Int;
  public static var upDown:Bool;
  public static var layingBrick:Bool;
  public static var level:Int;
  public static var balls:Array<Ball>;
  public static var playfields:Array<BitmapData>;
  public static var walls:Array<Rectangle>;
  public static var mason:Mason;
  public static var self:WallBall;
  public static var background:Texture;
  public static var atlas:TextureAtlas;

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
  public static inline var MSN = 24;
  public static inline var SWIDTH = 172;
  public static inline var SHEIGHT = 92;
  public static inline var GOAL = 75;
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
    layingBrick = false;

    var bmp = Assets.getBitmapData("assets/wallball.png");

    var tex = Texture.fromBitmapData(bmp);
    bmp.dispose();

    var xml = Parser.parse(Assets.getText("assets/wallball.xml"));
    atlas = new TextureAtlas(tex,xml);
    tex = atlas.getTexture("ball");

    balls = new Array();
    for (i in 0...MAX) {
      balls.push(new Ball(tex));
    }

    playfields = new Array();
    for (i in 0...2) playfields.push(new BitmapData(SWIDTH,SHEIGHT,true,0));

    walls = new Array();
    for (i in 0...2) walls.push(new Rectangle(WIDTH*2,HEIGHT*2,10,10));

    mason = new Mason();

    addEventListener(Event.ADDED_TO_STAGE,onAdded);
    nativeStage.addEventListener(MouseEvent.CLICK, onClick);
    nativeStage.addEventListener(MouseEvent.RIGHT_CLICK, onClick);
  }

  private function onAdded() {
    background = Texture.fromBitmapData(playfields[0]);
    var img = new Image(background);
    img.smoothing = TextureSmoothing.NONE; 
    img.x = 0;
    img.y = 0;
    img.scale = SCALE;
    img.filter = new WallFilter(); 
    addChild(img);
    addChild(mason);
    Starling.current.juggler.add(this);
    setup(2);
  }

  private function onClick(e:MouseEvent) {
    if (e.type == MouseEvent.RIGHT_CLICK) {
      upDown = !upDown;
      if (upDown) bridge.cursor("ns-resize");
      if (!upDown) bridge.cursor("ew-resize");
      return;
    }

    if (e.type != MouseEvent.CLICK) return;
    if (layingBrick) return;


    var x:Int = Math.round(e.localX/SCALE)*4;
    var y:Int = Math.round(e.localY/SCALE)*4;


    if (walled(x-12,y-12) ||
        walled(x+12,y-12) ||
        walled(x-12,y+12) ||
        walled(x+12,y+12)
       ) {
      trace("denied");
      return;
    }

    layingBrick = true;
    mason.begin(x,y);

  }

  public function advanceTime(time:Float):Void {
    time = Math.min(MXT,time);

    mason.advanceTime(time);

    for (i in 0...level) {
      balls[i].advanceTime(time);
    }

  }

  public static function setup(lvl:Int):Void {
    if (lvl > MAX) lvl = MAX;
    trace("game over!");
    layingBrick = false;
    level = lvl;
    lives = level;
    bridge.lives(level);
    bridge.percent(0);

    mason.end(0);
    mason.end(1);

    updateBackground(new Rectangle(0,0,SWIDTH,SHEIGHT),0x00000000);

    for (i in 0...MAX) self.removeChild(balls[i]);

    var tooTight = false;
    var a = new Point(0,0);
    var b = new Point(0,0);
    for (i in 0...level) {
      balls[i].v = [NE,SE,SW,NW][Math.floor(Math.random()*4)];

      do {
        balls[i].cx = Math.floor(Math.random()*(WIDTH-R*2-1)+R+1);
        balls[i].cy = Math.floor(Math.random()*(HEIGHT-R*2-1)+R+1);
        a.x = balls[i].cx;
        a.y = balls[i].cy;
        
        tooTight = false;
        for (j in 0...i) {
          b.x = balls[j].cx;
          b.y = balls[j].cy;
          if (Point.distance(a,b) >= D) continue;
          tooTight = true;
          trace("tight!");
          break;
        }

      } while(tooTight);

      self.addChild(balls[i]);
    }
  }

  public static function walled(x:Float, y:Float):Bool {
    if (x < 0 || x >= WIDTH) return true;
    if (y < 0 || y >= HEIGHT) return true;

    return (playfields[0].getPixel32(Math.round(x/SCALE),
                                       Math.round(y/SCALE)) >> 24 != 0);
  }

  public static function updateBackground(rect:Rectangle,color:Int) {
    playfields[0].lock();
    playfields[0].fillRect(rect,color);
    playfields[0].unlock();
    background.root.uploadBitmapData(playfields[0]);
    background.root.onRestore = function() {
      background.root.uploadBitmapData(playfields[0]);
    }
  }

  public static function fill() {
    playfields[1] = playfields[0].clone();
    playfields[1].lock();
    for (i in 0...level) {
      playfields[1].floodFill(Math.round(balls[i].cx/4),Math.round(balls[i].cy/4),0xFFFF0000);
    }
    playfields[0].lock();
    var color:UInt;
    var count = 0;
    for (i in 0...SWIDTH) {
      for (j in 0...SHEIGHT) {
        color = playfields[1].getPixel32(i,j);
        if (color != 0xFFFF0000) {
          playfields[0].setPixel32(i,j,0xFF000000);
          count++;
        }
      }
    }
    playfields[1].unlock();
    playfields[0].unlock();
    updateBackground(new Rectangle(0,0,0,0),0);
    var per = Math.round(100*count/(SWIDTH*SHEIGHT));
    bridge.percent(per);
    if (per >= GOAL) setup(++level);
  }

}
