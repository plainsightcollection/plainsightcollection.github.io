package;

import starling.display.Sprite;
import starling.display.Image;
import starling.textures.Texture;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.core.Starling;
import starling.animation.Tween;
import starling.display.Quad;

import openfl.geom.Vector3D;
import openfl.geom.Point;

import openfl.display.BitmapData;

class Test extends Sprite {
  private var ball:Image;
  private var quad:Quad;

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

    ball.x = (stage.stageWidth - ball.width)/2 - ball.width;
    ball.y = (stage.stageHeight - ball.height)/2;

    addEventListener(KeyboardEvent.KEY_DOWN, keys);

    addChild(ball);

    quad = new Quad(stage.stageWidth/28,stage.stageWidth/28,0xFF0000);
    quad.x = (stage.stageWidth - quad.width)/2 + quad.width;
    quad.y = (stage.stageHeight - quad.height)/2;
    addChild(quad);

    var v = new Vector3D(120-90,-(154-178),0,0);
    //var v = new Vector3D(90-16,-(178-122),0,0);
    //var v = new Vector3D(186-286,-(170-94),0,0);
    //var v = new Vector3D(27-126,-(122-46),0,0);
    //var v = new Vector3D(16-62,-(98-134),0,0);
    //var v = new Vector3D(26-127,-(122-46),0,0);
    v.normalize();
    var n = new Vector3D(1,0,0,0);
    trace(Math.acos(n.dotProduct(v))*180/Math.PI);

    trace(Point.distance(new Point(26,122),new Point(127,46)));

  }

  private function keys(e:KeyboardEvent):Void {
    if (e.keyCode != 32) return;

    var tween:Tween;

    Starling.current.juggler.removeTweens(ball);
    Starling.current.juggler.removeTweens(quad);

    ball.x = (stage.stageWidth - ball.width)/2 - ball.width;
    ball.y = (stage.stageHeight - ball.height)/2;

    tween = new Tween(ball,1);
    tween.moveTo(ball.x+stage.stageWidth*-0.22544642857142858,ball.y+stage.stageHeight*0.31666666666666665);
    Starling.current.juggler.add(tween);

    quad.scaleY = 1;
    tween = new Tween(quad,1);
    tween.animate("scaleY",(((80/448)*stage.stageWidth)+quad.width)/quad.width);
    Starling.current.juggler.add(tween);

  }

}
