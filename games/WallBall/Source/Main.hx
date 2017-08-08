package;

import openfl.display.Sprite;
import starling.core.Starling;

class Main extends Sprite {
  private var starling:Starling;
  
  public function new () {
    super ();
    
    WallBall.nativeStage = stage;
    starling = new Starling (WallBall, stage);
    starling.showStats = true;
    starling.start ();

  }

}
