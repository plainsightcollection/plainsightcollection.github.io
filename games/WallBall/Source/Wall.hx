package;

import starling.display.Image;
import starling.textures.Texture;
import starling.animation.IAnimatable;

class Wall extends Image implements IAnimatable {
  public function new(tex:Texture) {
    super(tex);
  }

  public function advanceTime(time:Float):Void {
  }

}
