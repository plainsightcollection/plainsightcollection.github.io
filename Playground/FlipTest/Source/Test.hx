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

class Test extends Sprite {
  private var tile:Sprite3D;

  public function new() {
    super();

    var bmp = Assets.getBitmapData("assets/buraq.png");
    bmp.lock();
    var xml = Parser.parse(Assets.getText("assets/buraq.xml"));
    var tex = Texture.fromBitmapData(bmp);
    bmp.dispose();
    var atlas = new TextureAtlas(tex,xml);
    tex = atlas.getTexture("buraq");

    var img = new Image(tex);

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
    tile.rotationY = 0;

    var tween = new Tween(tile,3);
    tween.animate("rotationY",90*Math.PI/180);

    Starling.current.juggler.add(tween);

  }

}
