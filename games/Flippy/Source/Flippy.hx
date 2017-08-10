package;

import starling.display.Sprite;
import starling.display.Quad;

class Flippy extends Sprite {
  private static inline var MT = 11;
  private static inline var ML = 11;
  private static inline var SIZE = 72;
  private static inline var LINK = 14;

  public function new() {
    super();

    //placeholders

    var playfield = new Quad(SIZE*8,SIZE*5,0xFF808080);
    playfield.x = ML;
    playfield.y = MT;
    addChild(playfield);

    var leftArrow = new Quad(41,32,0xFF808080);
    leftArrow.x = 19;
    leftArrow.y = 379;
    addChild(leftArrow);

    var rightArrow = new Quad(41,32,0xFF808080);
    rightArrow.x = 73;
    rightArrow.y = 379;
    addChild(rightArrow);

    var reset = new Quad(95,32,0xFF808080);
    reset.x = 481;
    reset.y = 378;
    addChild(reset);

    trace("here");
  }

}
