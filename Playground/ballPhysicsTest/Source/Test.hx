package;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.display.Image;

import openfl.geom.Vector3D;
import openfl.display.BitmapData;

class Test extends Sprite {
  public function new() {
    super();

    var cnv = new openfl.display.Sprite();
    cnv.graphics.lineStyle(5,0x00FF00);
    cnv.graphics.moveTo(0,0);
    cnv.graphics.lineTo(640,480);

    var bmp = new BitmapData(640,480,true,0x00000000);
    bmp.draw(cnv);

    var tex = Texture.fromBitmapData(bmp);

    var img = new Image(tex);
    img.x = 0;
    img.y = 0;
    
    addChild(img);

    //addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function onAddedToStage(e:Event):Void {
  }

}
