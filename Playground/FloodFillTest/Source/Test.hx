package;

import starling.display.Sprite;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.display.Image;

import openfl.Lib.getTimer;
import openfl.display.BitmapData;

class Test extends Sprite {
  public function new() {
    super();

    var bmp = new BitmapData(800,600);
    var then = getTimer();
    bmp.floodFill(400,300,0xFF00FF00);

    trace(getTimer() - then);

    var tex = Texture.fromBitmapData(bmp);
    var img = new Image(tex);

    addChild(img);

  }
}
