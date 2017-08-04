package;

import starling.display.Sprite;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.display.Image;
import starling.text.TextField;

import openfl.Lib.getTimer;
import openfl.display.BitmapData;

class Test extends Sprite {
  public function new() {
    super();

    var thn:Int;
    var color:Int;

    var max:Int = 0;
    var min:Int = 1000000;
    var avg:Float = 0;
    var cur:Int;

    var bmp:BitmapData = new BitmapData(400,300);
    for (i in 0...100) {
      color = Math.floor(Math.random()*(1+0xFFFFFF)) | 0xFF000000;
      thn = getTimer();
      bmp.floodFill(200,150,color);
      cur = getTimer() - thn;
      avg += cur;
      if (cur > max) max = cur;
      if (cur < min) min = cur;
    }
    avg /= 100;

    var txt = new TextField(100,200,'avg: ${avg}, min: ${min}, max: ${max}');
    txt.x = (800-100)/2;
    txt.y = (600-200)/2;

    var cln = bmp.clone();

    var tex = Texture.fromBitmapData(cln);
    var img = new Image(tex);

    addChild(img);
    addChild(txt);

  }
}
