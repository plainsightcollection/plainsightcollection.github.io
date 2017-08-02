class Solve {
  private var board:Array<String>;
  private var width:Int;
  private var height:Int;
  private var seq:Map<String,String>;
  private var goal:String;
  private var states:Array<String>;
  //private var combos:Array<Array<Int>>;
  private var moves:Array<Array<Array<Int>>>;
  private var win:Array<Array<Int>>;
  private var shortest:Int;
  private var iterations:Int;

  public function new(brd:String,wd:Int,hgt:Int,sq:Map<String,String>,gl:String,itr:Int):Void {
    board = StringTools.replace(brd,"\n","").split("");
    width = wd;
    height = hgt;
    seq = sq;
    goal = gl;
    iterations = itr;

    states = new Array();
    for (i in seq.keys()) states.push(i);

    moves = new Array();
    for (i in 0...width) {
      for (j in 0...height) {
        if (states.indexOf(board[idx(i,j)]) == -1) continue;
        var move:Array<Array<Int>> = [[i,j]];

        if (bounded(i,j-1) && 
            bounded(i,j-2) && 
            board[idx(i,j-1)] == '|') 
              move.push([i,j-2]);

        if (bounded(i+1,j) && 
            bounded(i+2,j) && 
            board[idx(i+1,j)] == '-') 
              move.push([i+2,j]);

        if (bounded(i,j+1) && 
            bounded(i,j+2) && 
            board[idx(i,j+1)] == '|') 
              move.push([i,j+2]);

        if (bounded(i-1,j) && 
            bounded(i-2,j) && 
            board[idx(i-1,j)] == '-') 
              move.push([i-2,j]);

        moves.push(move);
      }
    }

    win = [];
    shortest = 1000000;

  }

  private function bounded(x:Int,y:Int):Bool {
    if (x >= width) return false;
    if (y >= height) return false;
    return true;
  }

  private function idx(x:Int,y:Int):Int {
    return x+y*width;
  }

  private function check(brd:Array<String>):Bool {
    var count = 0;
    for (i in 0...brd.length) {
      if (brd[i] == goal) count++;
    }
    if (count == moves.length) return true;
    return false;
  }

  private function move(brd:Array<String>,mvIdx:Int):Array<String> {
    var mv = moves[mvIdx];
    for (i in 0...mv.length) {
      var subMv = mv[i];
      var ele = brd[idx(subMv[0],subMv[1])];
      brd[idx(subMv[0],subMv[1])] = seq[ele];
    }
    return brd;
  }

  private function strategy(combo:Array<Int>):Array<Array<Int>> {
    var brd = board.slice(0);
    var ln = 0;
    for (j in 0...combo.length) {
      var mv = combo[j];
      move(brd,mv);
      ln++;
      if (check(brd)) {
        var best:Array<Array<Int>> = new Array();
        for (k in 0...ln) {
          best.push(moves[combo[k]][0]);
        }
        return best;
      }
    }
    return [];
  }

  private function solved():Void {
    for (i in 0...iterations) {
      var combo:Array<Int> = new Array();
      for (j in 0...50) {
        combo.push(Math.floor(Math.random()*moves.length));
      }
      var strat = strategy(combo);
      if (strat.length > 0 && strat.length < shortest) {
        win = strat;
        shortest = strat.length;
        trace(win);
        trace('shortest: ${shortest}, iterations: ${i}');

        var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".split("");

        var sol = board.slice(0);

        for (i in 0...win.length) {
          var label = alphabet[i % alphabet.length];
          sol[idx(win[i][0],win[i][1])] = label;
        }

        var len = cast(board.length/width,Int);
        var offset = 0;
        for (i in 0...len) {
          sol.insert(i*width+(offset++),"\n");
        }

        trace(sol.join(""));

      }
    };
  }

  static public function main():Void {
    var brd = '
1-0 X X X X 0-0
| |           |
0 1-0-0 0-0-0-1
      | |      
X X X 0-0 X X X
      | |      
0-0-0-0 0-0-0 0
|           | |
0-1 X X X X 0-1
';

    var solve = new Solve(brd,15,9,["0" => "1", "1" => "0"],"0",100000000);
    solve.solved();

  }

}
