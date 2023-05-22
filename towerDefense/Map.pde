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
  
  void changeLives(int value) {
    
  }
  
  void changeMoney(int value) {
    
  }
  
  boolean validPLacement(int x, int y, Tower tow) {
    return true;
  }
}
