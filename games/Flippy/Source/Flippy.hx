package;

import starling.display.Sprite;
import starling.display.Quad;
import starling.textures.Texture;
import starling.display.Image;

import openfl.display.BitmapData;

class Flippy extends Sprite {
  private static inline var MT = 11;
  private static inline var ML = 11;
  private static inline var SIZE = 72;
  private static inline var LINK = 14;
  private static inline var CLR = 0xFF44D62C;

  private var hLinks:Array<Quad>;
  private var vLinks:Array<Quad>;

  private var dragonTex:Texture;
  private var skullTex:Texture;

  private var dragons:Array<Image>;
  private var skulls:Array<Image>;

  public function new() {
    super();

    //placeholders

    var playfield = new Quad(SIZE*8,SIZE*5,0xFF808080);
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

    var reset = new Quad(95,32,0xFF808080);
    reset.x = 481;
    reset.y = 378;
    addChild(reset);

    var q:Quad;

    hLinks = new Array();
    for (j in 0...5) {
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
      for (i in 0...8) {
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
    for (j in 0...5) {
      for (i in 0...8) {
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

  }

}
