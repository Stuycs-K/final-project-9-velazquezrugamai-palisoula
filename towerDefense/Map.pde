public class Map {
  Tower[][] towerLoc;
  ArrayList<Enemy> EnemyLoc;
  Tiles[][] board;
  int round, lives, money;
  
  public Map(int rounds, int live, int mon, int ROW, int COL) {
    round = rounds;
    lives = live;
    money = mon;
    EnemyLoc = new ArrayList<Enemy>();
    towerLoc = new Tower[ROW][COL];
    board = new Tiles[ROW][COL];
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
