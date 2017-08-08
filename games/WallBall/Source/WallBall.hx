package;

import starling.display.Sprite;
import starling.events.Event;
import starling.core.Starling;

import openfl.events.MouseEvent;

import Bridge;

class WallBall extends Sprite {
  public static var nativeStage:openfl.display.Stage;
  private var bridge:Bridge;

  public function new() {
    super();

    bridge = new Bridge();

    addEventListener(Event.ADDED_TO_STAGE,onAdded);
    nativeStage.addEventListener(MouseEvent.CLICK, onClick);
  }

  private function onAdded() {
  }

  private function onClick(e:MouseEvent) {
    bridge.cursor("cell");
  }

}
