package;

class LevelData {
  private var levels:Array<String>;
  
  public function new() {

    levels = new Array();

    levels.push('
1-0-0-1 X X X X
               
X X X X X X X X
               
X X X X X X X X
               
X X X X X X X X
               
X X X X X X X X');

    for (i in 0...levels.length) {
      levels[i] = levels[i].split("\n").join("");
      trace(levels[i]);
    }

  }
}


