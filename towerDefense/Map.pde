public class Map {
  ArrayList<Tower> towerLoc;
  ArrayList<Enemy> enemyLoc;
  Tiles[][] board;
  int round, lives, money;
  ArrayList<Projectiles> proLoc;
  
  public Map(int rounds, int live, int mon, int ROW, int COL) {
    round = rounds;
    lives = live;
    money = mon;
    enemyLoc = new ArrayList<Enemy>();
    towerLoc = new ArrayList<Tower>();
    board = new Tiles[ROW][COL];
    proLoc = new ArrayList<Projectiles>();
  }
  
  //adds tower to place
  boolean addTower(Tower tow){
    int x = tow.location[0];
    int y = tow.location[1];
    if(validPlacement(x, y)) {
      towerLoc.add(tow);
      board[y][x] = new Tiles(color(255, 13, 13));
      return true;
    }
    return false;
  }

//adds projectile to tower
  void addProjectile(Projectiles proj) {
    proLoc.add(proj);
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
    return (x >= 0 && x < board.length && y >= 0 && y < board[x].length)&& board[y][x].getColor() == color(56,78,29);
  }
  
  boolean canUpgrade(int x, int y){
    return (board[y][x].getColor() == color(255, 13, 13));
  }
  
  //moves enemies and projectiles across the board
  void moveEverything() {
   for (int i=0; i<enemyLoc.size(); i++) {
     enemyLoc.get(i).move(board);
   }
   for (int i=0; i<proLoc.size(); i++) {
     proLoc.get(i).move();
   }
  }
  
  //Adds enemies based off of of the round
  void addEnemy() {
    for (int i=0; i<board.length; i++) {
      if (board[i][0].getColor()==color(131, 98, 12)) {
        int health = 1;
        int move = SQUARESIZE/4;
        String type = "normal";
        int x = 0;
        int y = i;
        enemyLoc.add(new Enemy(health, move, type, x, y));
      }
    }
  }
  
  void deleteProj() {
    for (int i=0; i<proLoc.size(); i++) {
      int[] tempLoc = proLoc.get(i).location;
      if (tempLoc[0]<0 || tempLoc[1]<0 || tempLoc[0]>=width-200 || tempLoc[1]>=height) {
        proLoc.remove(i);
        i--;
      }
    }
  }
}
