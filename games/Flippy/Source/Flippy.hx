package;

import starling.display.Sprite;
import starling.display.Quad;
import starling.textures.Texture;
import starling.display.Image;
import starling.events.Event;
import starling.core.Starling;
import starling.animation.Tween;

import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.events.MouseEvent;

import Level;
import LevelData;

class Flippy extends Sprite {
  public static var nativeStage:openfl.display.Stage;

  public static inline var MT = 11;
  public static inline var ML = 11;
  public static inline var SIZE = 72;
  public static inline var LINK = 14;
  public static inline var CLR = 0xFF44D62C;
  public static inline var COLS = 8;
  public static inline var ROWS = 5;
  public static inline var DUR = 1/5;

  private var hLinks:Array<Quad>;
  private var vLinks:Array<Quad>;

  private var dragonTex:Texture;
  private var skullTex:Texture;

  private var dragons:Array<Image>;
  private var skulls:Array<Image>;

  private var left:Rectangle;
  private var right:Rectangle;
  private var reset:Rectangle;

  private var levelData:LevelData;
  private var levels:Array<Level>;

  private var locked:Bool;

  private var current:Int;

  public function new() {
    super();

    locked = true;

    levelData = new LevelData();
    levels = new Array();
    for (i in 0...levelData.length) 
      levels.push(levelData.getLevel(i));

    left = new Rectangle(19,379,41,32);
    right = new Rectangle(73,379,41,32);
    reset = new Rectangle(481,378,95,32);

    //placeholders

    var playfield = new Quad(SIZE*COLS,SIZE*ROWS,0xFF808080);
    playfield.x = ML;
    playfield.y = MT;
    addChild(playfield);

    var leftArrow = new Quad(41,32,0xFF808080);
    leftArrow.x = 19;
    leftArrow.y = 379;
    addChild(leftArrow);

    var rightArrow = new Quad(41,32,0xFF808080);
    rightArrow.x = 73;
    rightArrow.y = 379;
    addChild(rightArrow);

    var resetQuad = new Quad(95,32,0xFF808080);
    resetQuad.x = 481;
    resetQuad.y = 378;
    addChild(resetQuad);

    var q:Quad;

    hLinks = new Array();
    for (j in 0...ROWS) {
      for (i in 0...7) {
        q = new Quad(SIZE,LINK,CLR);
        q.x = ML+i*SIZE+(SIZE/2);
        q.y = MT+j*SIZE+(SIZE-LINK)/2;
        q.alpha = 0;
        hLinks.push(q);
        addChild(q);
      }
    }

    vLinks = new Array();
    for (j in 0...4) {
      for (i in 0...COLS) {
        q = new Quad(LINK,SIZE,CLR);
        q.x = ML+i*SIZE+(SIZE-LINK)/2;
        q.y = MT+j*SIZE+(SIZE/2);
        q.alpha = 0;
        vLinks.push(q);
        addChild(q);
      }
    }

    var bmp:BitmapData;
    var cnv:openfl.display.Sprite;
    var trans = new openfl.geom.Matrix();
    trans.translate(SIZE/18,SIZE/18);

    bmp = new BitmapData(SIZE,SIZE,true,0);
    cnv = new openfl.display.Sprite();
    cnv.graphics.beginFill(0xFFFF0000);
    cnv.graphics.drawCircle(SIZE*4/9,SIZE*4/9,SIZE*4/9);
    cnv.graphics.endFill();
    bmp.draw(cnv,trans);

    dragonTex = Texture.fromBitmapData(bmp);
    bmp.dispose();

    bmp = new BitmapData(SIZE,SIZE,true,0);
    cnv = new openfl.display.Sprite();
    cnv.graphics.beginFill(0xFF404040);
    cnv.graphics.drawCircle(SIZE*4/9,SIZE*4/9,SIZE*4/9);
    cnv.graphics.endFill();
    bmp.draw(cnv,trans);

    skullTex = Texture.fromBitmapData(bmp);
    bmp.dispose();

    var img:Image;

    dragons = new Array();
    skulls = new Array();
    for (j in 0...ROWS) {
      for (i in 0...COLS) {
        img = new Image(skullTex);
        img.x = ML+i*SIZE;
        img.y = MT+j*SIZE;
        img.alpha = 0;
        skulls.push(img);
        addChild(img);

        img = new Image(dragonTex);
        img.x = ML+i*SIZE;
        img.y = MT+j*SIZE;
        img.alpha = 0;
        dragons.push(img);
        addChild(img);
      }
    }

    nativeStage.addEventListener(MouseEvent.CLICK, onClick);
    addEventListener(Event.ADDED_TO_STAGE,onAdded);

    clear();
  }

  private function onAdded() {
    locked = false;
    current = 0;
    view();
  }

  private function onClick(e:MouseEvent) {
    if (locked) return;

    if (left.contains(e.localX,e.localY)) {
      current--;
      if (current < 0) current = levels.length-1; 
      view();
      return;
    }
    if (right.contains(e.localX,e.localY)) {
      current++;
      if (current >= levels.length) current = 0; 
      view();
      return;
    }
    if (reset.contains(e.localX,e.localY)) {
      levels[current] = levelData.getLevel(current);
      view();
      return;
    }

    if (e.localX < ML) return;
    if (e.localX > ML+SIZE*COLS) return;
    if (e.localY < MT) return;
    if (e.localY > MT+SIZE*ROWS) return;

    var idx = Math.ceil((e.localX-ML)/SIZE-1) + 
              Math.ceil((e.localY-MT)/SIZE-1)*COLS;

    move(idx);

  }

  private function clear():Void {
    for (link in hLinks) link.alpha = 0;
    for (link in vLinks) link.alpha = 0;
    for (dragon in dragons) dragon.alpha = 0;
    for (skull in skulls) skull.alpha = 0;
  }

  private function view():Void {
    locked = true;

    clear();

    for (i in 0...hLinks.length)
      if (levels[current].hBarStates[i]) 
        hLinks[i].alpha = 1.0;

    for (i in 0...vLinks.length)
      if (levels[current].vBarStates[i]) 
        vLinks[i].alpha = 1.0;

    for (i in 0...dragons.length) {
      if (levels[current].dragonStates[i]) {
        dragons[i].alpha = 1.0;
      } else {
        if (levels[current].tileStates[i])
          skulls[i].alpha = 1.0;
      }
    }

    locked = false;

  }

  private function move(tile:Int):Void {
    var moves = levels[current].moves[tile];

    if (moves.length == 0) return;

    locked = true;

    for (i in 0...moves.length) {
      var mv = moves[i];
      var tween:Tween;

      tween = new Tween(dragons[mv],DUR);
      if (levels[current].dragonStates[mv]) {
        tween.fadeTo(0);
      } else {
        tween.fadeTo(1);
      }

      Starling.current.juggler.add(tween);

      tween = new Tween(skulls[mv],DUR);
      if (levels[current].dragonStates[mv]) {
        tween.fadeTo(1);
      } else {
        tween.fadeTo(0);
      }


      if (i == moves.length-1) {
        tween.onComplete = function() {
          for (mv in moves) 
            levels[current].dragonStates[mv] = 
              !levels[current].dragonStates[mv];
          var clear = true;
          for (st in levels[current].dragonStates) {
            if (st) {
              clear = false;
              break;
            }
          }
          if (clear) {
            win();
          } else {
            locked = false;
          }
        }
      }

      Starling.current.juggler.add(tween);

    }
  }

  private function win():Void {
    var tween:Tween;
    for (i in 0...hLinks.length) {
      tween = new Tween(hLinks[i],DUR);
      tween.fadeTo(0);
      Starling.current.juggler.add(tween);
    }
    for (i in 0...hLinks.length) {
      tween = new Tween(vLinks[i],DUR);
      tween.fadeTo(0);
      if (i == hLinks.length-1)
        tween.onComplete = function() {
          for (i in 0...levels[current].hBarStates.length)
            levels[current].hBarStates[i] = false;
          for (i in 0...levels[current].vBarStates.length)
            levels[current].vBarStates[i] = false;
          for (i in 0...levels[current].moves.length)
            levels[current].moves[i] = [];
          locked = false;
        }
      Starling.current.juggler.add(tween);
    }
  }

}
