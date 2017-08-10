package;

import openfl.display.Sprite;
import starling.core.Starling;

class Main extends Sprite {
  private var starling:Starling;
  
  public function new () {
    super ();

    Flippy.nativeStage = stage;
    
    starling = new Starling(Flippy, stage);
    //starling.showStats = true;
    starling.start ();
    
  }
  
}
