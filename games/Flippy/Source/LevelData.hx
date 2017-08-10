package;

import Level;
import Flippy;

class LevelData {
  public var length:Int;
  private var levels:Array<Array<String>>;
  
  public function new() {

    levels = new Array();

    //1
    levels.push(['
X X X X X X X X
               
X X X X X X X X
               
X X 1-0-0-1 X X
               
X X X X X X X X
               
X X X X X X X X']);

    //2
    levels.push(['
X X X X X X X X
               
X X 0 X X X X X
    |          
X 1-0-0-0-0-1 X
          |    
X X X X X 0 X X
               
X X X X X X X X']);

    //3
    levels.push(['
X X X X X X X X
               
X X 0 X X 0 X X
    |     |    
X 1-0-0-0-0-1 X
    |     |    
X X 0 X X 0 X X
               
X X X X X X X X']);

    //4
    levels.push(['
0-0 X X X X 0-0
| |           |
1 1 X 1 1 X 1-1
      | |      
X X X 0-0 X X X
      | |      
0-0 X 1 1 X 0 0
|           | |
1-1 X X X X 1-1']);

    //5
    levels.push(['
1-0 X X X X 0-0
| |           |
0 1-0-0 0-0-0-1
      | |      
X X X 0-0 X X X
      | |      
0-0-0-0 0-0-0 0
|           | |
0-1 X X X X 0-1']);

    //6
    levels.push(['
0-1 X X X X 0-0
| |           |
0 0-0-0 0-0-0-0
|     | |     |
1 X X 0-0 X X 1
|     | |     |
0-0-0-0 0-0-0 0
|           | |
0-1 X X X X 0-0']);

    //7
    levels.push(['
X X X X X X X X
               
X X 1-0-0-0 X X
    |   | |    
X X 0 0-0 0 X X
    | |   |    
X X 0-0-0-1 X X
               
X X X X X X X X']);

    //8
    levels.push(['
X X X X X X X X
               
X X 0-0-0-1 X X
    |   | |    
X X 0-0-0-0 X X
    | |   |    
X X 1-0-0-0 X X
               
X X X X X X X X']);

    //9
    levels.push(['
X X X X X X X X
               
X X 0-0-0-1 X X
    |   | |    
X 0-0-0-0-0-0 X
    | |   |    
X X 1-0-0-0 X X
               
X X X X X X X X']);

    //10
    levels.push(['
X X X X X X X X
               
1-0 X 0-0 X 0-1
| |   | |   | |
0 0-1-0 0-1-0 0
| |   | |   | |
1-0 X 0-0 X 0-1
               
X X X X X X X X']);

    //11
    levels.push(['
X 0-0-1 X X X X
  |   |        
1-0 X 0-1 X 0-1
| |   | |   | |
0 0-1-0 0-1-0 0
| |   | |   | |
1-0 X 1-0 X 0-1
        |   |  
X X X X 1-0-0 X']);

    //12
    levels.push(['
X 1-0-1 1-0-1 X
  |   | |   |  
1-0 X 0-0 X 0-1
| |   | |   | |
0 0-0-1 1-0-0 0
| |   | |   | |
1-0 X 0-0 X 0-1
  |   | |   |  
X 1-0-1 1-0-1 X']);

    //13
    levels.push(['
X X X X X X X X
               
X 1-0-0 X X X X
      |        
X X X 0 X X X X
      |        
X X X 0-1-1 X X
               
X X X X X X X X']);

    //14
    levels.push(['
X X X X X X X X
               
X 0-0-0 X X X X
    | |        
X X 0-1-0 X X X
      | |      
X X X 0-0-0 X X
               
X X X X X X X X']);

    //15
    levels.push(['
X X 0 X X X X X
    |          
X 0-1-0 X X X X
    | |        
X X 0-1-0 X X X
      | |      
X X X 0-1-0 X X
        |      
X X X X 0 X X X']);

    //16
    levels.push(['
0-1 X X X X 1-0
| |         | |
1-0 X X X X 0-1
               
X X X X X X X X
               
1-0 X X X X 0-1
| |         | |
0-1 X X X X 1-0']);

    //17
    levels.push(['
X 0-1 X X 1-0 X
  | |     | |  
X 1-0 X X 0-1 X
    |     |    
X X 1-0-0-1 X X
    |     |    
X 1-0 X X 0-1 X
  | |     | |  
X 0-1 X X 1-0 X']);

    //18
    levels.push(['
X 1-0 X X 0-1 X
  | |     | |  
X 0-0-0 0-0-0 X
    | | | |    
X X 0-1-1-0 X X
    | | | |    
X 0-0-0 0-0-0 X
  | |     | |  
X 1-0 X X 0-1 X']);

    //19
    levels.push(['
1-1-1 X X 1-1-1
    |     |    
X X 0-1 1-0 X X
    | | | |    
X X 1 0-0 1 X X
    |     |    
0-1-1 X X 1-1-0
| |         | |
1 0 X X X X 0 1']);

    //20
    levels.push(['
0-1-0 X X 0-1-0
|   |     |   |
1 X 1-1 1-1 X 1
    | | | |    
X 1-1 0-0 1-1 X
  | |     | |  
0-0-1 X X 1-0-0
| |         | |
1 0 X X X X 0 1']);

    //21
    levels.push(['
1-0-1 X X 1-0-1
|   |     |   |
0 X 0-0 0-0 X 0
|   | | | |   |
0-0-1 1-1 1-0-0
  | |     | |  
1-1-0 X X 0-1-1
| |         | |
1 0 X X X X 0 1']);

    //22
    levels.push(['
1-1 X 0-1 X 1-1
  |   |     |  
X 0 X 0 X X 0 X
  |   |     |  
1-0-1-0-0-1-0-1
  |     |   |  
X 0 X X 0 X 0 X
  |     |   |  
1-1 X 1-0 X 1-1']);

    //23
    levels.push(['
1-0 X 0-1 X 0-1
  |   |     |  
X 0-1-0-1 X 0 X
  | | |     |  
1-0-1-0-0-1-0-1
  |     | | |  
X 0 X 1-0-1-0 X
  |     |   |  
1-0 X 1-0 X 0-1']);

    //24
    levels.push(['
1-1 X 0-1 X 1-1
  |   |     |  
X 0-0-0-1 1 0 X
  | | |   | |  
1-0-0-0-0-0-0-1
  | |   | | |  
X 0 1 1-0-0-0 X
  |     |   |  
1-1 X 1-0 X 1-1']);

    //25
    levels.push(['
1-0-0-0 1-0-0-1
      | |      
X X X 1-0 X X X
      |        
X X 1-0-0-0 X X
        |      
X X X 1-0 X X X
      | |      
1-0-0-0 1-0-0-1']);

    length = 0;

    for (i in 0...levels.length) {
      levels[i] = levels[i][0].split("\n").join("").split("");
      length++;
    }

  }

  public function getLevel(idx:Int):Level {
    var moves:Array<Array<Int>> = new Array();
    var dragonStates:Array<Bool> = new Array();
    var tileStates:Array<Bool> = new Array();
    var hBarStates:Array<Bool> = new Array();
    var vBarStates:Array<Bool> = new Array();

    var level = levels[idx];

    for (j in 0...Flippy.ROWS) {
      for (i in 0...Flippy.COLS) {
        var tile = i+j*Flippy.COLS;
        var idx = i*2+j*(Flippy.COLS*2*2-2);
        var symbol = level[idx];

        var subMoves:Array<Int> = new Array();

        if (symbol == 'X') {
          tileStates.push(false);
        } else {
          tileStates.push(true);
          subMoves.push(tile);
        }

        if (symbol == '1') {
          dragonStates.push(true);
        } else {
          dragonStates.push(false);
        }

        if (i < Flippy.COLS-1) {
          if (level[idx+1] == "-") {
            subMoves.push(tile+1);
            hBarStates.push(true);
          } else {
            hBarStates.push(false);
          }
        }

        if (j < Flippy.ROWS-1) {
          if (level[idx+Flippy.COLS*2-1] == "|") {
            subMoves.push(tile+8);
            vBarStates.push(true);
          } else {
            vBarStates.push(false);
          }
        }

        if (i > 0 && hBarStates[tile-1-j])
          subMoves.push(tile-1);
        if (j > 0 && vBarStates[tile-8])
          subMoves.push(tile-8);

        moves.push(subMoves);

      }
    }

    return {
      moves: moves,
      dragonStates: dragonStates,
      tileStates: tileStates,
      hBarStates: hBarStates,
      vBarStates: vBarStates
    };
  }

}
