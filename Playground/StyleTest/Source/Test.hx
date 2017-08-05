package;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.display.Image;

import openfl.display.BitmapData;

import haxe.ds.Vector;

class Test extends Sprite {
  private var imgs:Array<Image>;

  public function new() {
    super();

    var r:Int = 50;

    var cnv = new openfl.display.Sprite();
    cnv.graphics.beginFill(0xFFFFFF);
    cnv.graphics.drawCircle(r,r,r);
    cnv.graphics.endFill();

    var bmp = new BitmapData(r*2,r*2,true,0);
    bmp.draw(cnv);

    var tex = Texture.fromBitmapData(bmp);
    bmp.dispose();

    imgs = new Array();
    for (i in 0...4) {
      imgs.push(new Image(tex));
    }

    imgs[1].color = 0xFF0000;
    imgs[2].color = 0x00FF00;
    imgs[3].color = 0x0000FF;

    addEventListener(Event.ADDED_TO_STAGE,onAdded);
  }

  private function onAdded() {
    for (i in 0...imgs.length) {
      var img = imgs[i];

      img.x = (stage.stageWidth - img.width)/2 
              - 1.2*img.width*(imgs.length-1)/2 
              + 1.2*img.width*i;
      img.y = (stage.stageHeight - img.height)/2;

      addChild(img);
    }
  }

}
