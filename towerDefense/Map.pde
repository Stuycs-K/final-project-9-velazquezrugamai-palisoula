public class Map {
  Tower[][] towerLoc;
  ArrayList<Enemy> EnemyLoc;
  String[][] board;
  int round, lives, money;
  
  public Map(int ro, int li, int mo) {
    round = ro;
    lives = li;
    money = mo;
    EnemyLoc = new ArrayList<Enemy>();
    Tower[][] towerLoc = new Tower[board.length][board[0].length];
  }
  
  void changeBoard(int x, int y, Object obj) {
    
  }
  
  void increaseRound() {
    round++;
  }
  //adding value to the lives
  void changeLives(int value) {
    lives += value;
  }
  //adding value to the money
  void changeMoney(int value) {
    money += value;
  }
  //can the tower be placed at (x, y)?
  boolean validPlacement(int x, int y) {
    return x >= 0 && x < board.length && y >= 0 && y < board[x].length;
  }
}
