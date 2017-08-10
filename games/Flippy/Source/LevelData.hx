package;

class LevelData implements {
  public var length:Int;
  private var levels:Array<String>;
  
  public function new() {

    levels = new Array();

    levels.push('
1-0-0-1 X X X X
               
X X X X X X X X
               
X X X X X X X X
               
X X X X X X X X
               
X X X X X X X X');

    length = 0;

    for (i in 0...levels.length) {
      levels[i] = levels[i].split("\n").join("");
      length++;
    }

  }

  public function getLevel(idx:Int):Level {
    var lvl:Level = {};
    return lvl;
  }

}
