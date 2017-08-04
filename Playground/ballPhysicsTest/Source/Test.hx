package;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.display.Image;

import openfl.geom.Vector3D;
import openfl.geom.Matrix3D;
import openfl.display.BitmapData;

class Test extends Sprite {
  public function new() {
    super();

    var xo = 320;
    var yo = 480;

    var cnv = new openfl.display.Sprite();

    var normal = new Vector3D(0,1,0,0);

    var trans = new Matrix3D();
    var v = normal;

    trans.identity();
    trans.appendScale(1,240,1);
    v = trans.transformVector(v);
    cnv.graphics.lineStyle(5,0x000000);
    cnv.graphics.moveTo(xo,yo);
    cnv.graphics.lineTo(xo+v.x,yo-v.y);

    v = normal;
    trans.identity();
    trans.appendScale(1,240,1);
    trans.appendRotation(45,new Vector3D(0,0,1,0));
    v = trans.transformVector(v);
    cnv.graphics.lineStyle(5,0x0000FF);
    cnv.graphics.moveTo(xo,yo);
    cnv.graphics.lineTo(xo+v.x,yo-v.y);

    v = normal;
    trans.identity();
    trans.appendRotation(45,new Vector3D(0,0,1,0));
    v = trans.transformVector(v);
    var i = v.dotProduct(normal);
    i = Math.acos(i);
    i = (i*180)/Math.PI;
    i = i*-1; //reverse

    v = normal;
    trans.identity();
    trans.appendScale(1,240,1);
    trans.appendRotation(i,new Vector3D(0,0,1,0));
    v = trans.transformVector(v);
    cnv.graphics.lineStyle(5,0xFF0000);
    cnv.graphics.moveTo(xo,yo);
    cnv.graphics.lineTo(xo+v.x,yo-v.y);

    var bmp = new BitmapData(640,480,true,0xFFFFFFFF);
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
