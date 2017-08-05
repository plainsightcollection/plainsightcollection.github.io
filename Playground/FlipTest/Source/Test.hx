package; 

import starling.display.Sprite;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.display.Sprite3D;
import starling.display.Image;
import starling.events.Event;
import starling.events.KeyboardEvent;
import starling.animation.Tween;
import starling.core.Starling;

import openfl.utils.Assets;
import haxe.xml.Parser;

import openfl.Lib.getTimer;

class Test extends Sprite {
  private var tile:Sprite3D;
  private var img:Image;

  public function new() {
    super();

    var bmp = Assets.getBitmapData("assets/buraq.png");
    bmp.lock();
    var xml = Parser.parse(Assets.getText("assets/buraq.xml"));
    var tex = Texture.fromBitmapData(bmp);
    bmp.dispose();
    var atlas = new TextureAtlas(tex,xml);
    tex = atlas.getTexture("buraq");

    img = new Image(tex);

    tile = new Sprite3D();
    tile.addChild(img);

    addEventListener(Event.ADDED_TO_STAGE,onAdded);

  }

  private function onAdded() {
    tile.x = stage.stageWidth/2;
    tile.y = stage.stageHeight/2;
    tile.alignPivot();
    addChild(tile);
    addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
  }

  private function onKeyDown(e:KeyboardEvent):Void {
    if (e.keyCode != 32) return;

    Starling.current.juggler.removeTweens(tile);

    var thn = getTimer();
    var tween = new Tween(tile,3/30);
    if (tile.rotationY < 90*Math.PI/180) {
      tween.animate("rotationY",90*Math.PI/180);
      tween.onComplete = function() {
        img.color = 0xFF0000;
        var tween = new Tween(tile,3/30);
        tween.animate("rotationY",180*Math.PI/180);
        tween.onComplete = function() {
          trace(getTimer() - thn);
        }
        Starling.current.juggler.add(tween);
      }
    } else {
      tween.animate("rotationY",90*Math.PI/180);
      tween.onComplete = function() {
        img.color = 0xFFFFFF;
        var tween = new Tween(tile,3/30);
        tween.animate("rotationY",0);
        tween.onComplete = function() {
          trace(getTimer() - thn);
        }
        Starling.current.juggler.add(tween);
      }
    }

    Starling.current.juggler.add(tween);

  }

}
