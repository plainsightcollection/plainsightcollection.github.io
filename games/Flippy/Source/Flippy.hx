package;

import starling.display.Sprite;
import starling.display.Quad;
import starling.textures.Texture;
import starling.display.Image;

import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.events.MouseEvent;

class Flippy extends Sprite {
  public static var nativeStage:openfl.display.Stage;

  private static inline var MT = 11;
  private static inline var ML = 11;
  private static inline var SIZE = 72;
  private static inline var LINK = 14;
  private static inline var CLR = 0xFF44D62C;
  private static inline var COLS = 8;
  private static inline var ROWS = 5;

  private var hLinks:Array<Quad>;
  private var vLinks:Array<Quad>;

  private var dragonTex:Texture;
  private var skullTex:Texture;

  private var dragons:Array<Image>;
  private var skulls:Array<Image>;

  private var left:Rectangle;
  private var right:Rectangle;
  private var reset:Rectangle;

  public function new() {
    super();

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
        skulls.push(img);
        addChild(img);

        img = new Image(dragonTex);
        img.x = ML+i*SIZE;
        img.y = MT+j*SIZE;
        dragons.push(img);
        addChild(img);
      }
    }

    nativeStage.addEventListener(MouseEvent.CLICK, onClick);
  }

  private function onClick(e:MouseEvent) {

    if (left.contains(e.localX,e.localY)) {
      trace("left");
    }
    if (right.contains(e.localX,e.localY)) {
      trace("right");
    }
    if (reset.contains(e.localX,e.localY)) {
      trace("reset");
    }

    if (e.localX < ML) return;
    if (e.localX > ML+SIZE*COLS) return;
    if (e.localY < MT) return;
    if (e.localY > MT+SIZE*ROWS) return;

    var idx = Math.ceil((e.localX-ML)/SIZE-1) + 
              Math.ceil((e.localY-MT)/SIZE-1)*COLS;
    trace(idx);
  }

}
