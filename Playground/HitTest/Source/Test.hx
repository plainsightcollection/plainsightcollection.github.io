package;

import starling.display.Sprite;
import starling.display.Image;
import starling.textures.Texture;
import starling.events.Event;
import starling.core.Starling;
import starling.animation.Tween;

import openfl.display.BitmapData;

class Test extends Sprite {
  private var ball:Image;

  public function new() {
    super();

    
    //Starling.current.juggler.delayCall(test,5);

    addEventListener(Event.ADDED_TO_STAGE,onAdded);
  }

  private function onAdded() {
    var cnv = new openfl.display.Sprite();
    cnv.graphics.beginFill(0x00FF00);
    var r = Math.round(stage.stageWidth/28/2);
    cnv.graphics.drawCircle(r,r,r);
    cnv.graphics.endFill();

    var bmp = new BitmapData(r*2,r*2,true,0);
    bmp.draw(cnv);
    ball = new Image(Texture.fromBitmapData(bmp));
    bmp.dispose();

    ball.x = (stage.stageWidth - ball.width)/2;
    ball.y = (stage.stageHeight - ball.height)/2;

    addChild(ball);

    /*
    var tween = new Tween(ball,1);
    tween.moveTo(0,0);
    tween.delay = 3;
    Starling.current.juggler.add(tween);
    */
  }

  private function test() {
  }

}
