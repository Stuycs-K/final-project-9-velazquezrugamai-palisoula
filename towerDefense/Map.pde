public class Map {
  Tower[][] towerLoc;
  Enemy[][] EnemyLoc;
  String[][] board;
  int round, lives, money;
  
  public Map(int ro, int li, int mo) {
    round = ro;
    lives = li;
    money = mo;
  }
  
  void changeBoard(int x, int y, Map obj) {
    
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
  
  boolean validPlacement(int x, int y, Tower tow) {
    return true;
  }
}
