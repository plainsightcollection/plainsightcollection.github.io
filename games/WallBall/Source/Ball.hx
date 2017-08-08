package;

import starling.display.Image;
import starling.textures.Texture;
import starling.animation.IAnimatable;

class Ball extends Image implements IAnimatable {
  public function new(tex:Texture) {
    super(tex);
  }

  public function advanceTime(time:Float):Void {
  }

}
