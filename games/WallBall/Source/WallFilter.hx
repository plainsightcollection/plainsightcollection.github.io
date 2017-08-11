package;

import starling.filters.FragmentFilter;
import starling.textures.Texture;

import openfl.display3D.Program3D;
import openfl.display3D.Context3D;
import openfl.Vector;
import openfl.display3D.Context3DProgramType;

import WallBall as C;

class WallFilter extends FragmentFilter {
  private var shader:Program3D;
  private var tex:Texture;
  private var scale:Vector<Float>;

  public function new() {
    super();

    tex = C.atlas.getTexture("bricks");

    scale = new Vector();

    //the scaling factors are based on the supertexture

    scale.push(C.WIDTH/1024);
    scale.push(C.HEIGHT/1024);
    scale.push(0);
    scale.push(0);

    scale.push(1/1024);
    scale.push(371/1024);
    scale.push(0);
    scale.push(0);

    scale.push(0);
    scale.push(-370/1024);
    scale.push(0);
    scale.push(0);

  }

  public override function dispose():Void {
    if (shader != null) shader.dispose();
    super.dispose();
  }

  private override function createPrograms():Void {
    shader = assembleAgal('
      mul ft0, v0, fc0
      add ft0, ft0, fc1
      tex ft1, v0, fs0 <2d,nomip,nearest,clamp>
      mul ft1, fc2, ft1.wwww
      add ft0, ft0, ft1
      tex oc, ft0, fs1 <2d,nomip,nearest,clamp>
    ');
  }

  private override function deactivate(pass:Int,ctx:Context3D,tex:Texture) {
    ctx.setTextureAt(1,null);
  }

  private override function activate(pass:Int,ctx:Context3D,tex:Texture) {
    ctx.setTextureAt(1,this.tex.base);
    ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,scale,3);
    ctx.setProgram(shader);
  }
}
