public class Map {
  Tower[][] towerLoc;
  ArrayList<Enemy> enemyLoc;
  Tiles[][] board;
  int round, lives, money;
  ArrayList<Projectiles> proLoc;
  
  public Map(int rounds, int live, int mon, int ROW, int COL) {
    round = rounds;
    lives = live;
    money = mon;
    enemyLoc = new ArrayList<Enemy>();
    towerLoc = new Tower[ROW][COL];
    board = new Tiles[ROW][COL];
    proLoc = new ArrayList<Projectiles>();
  }
  
  //adds tower to place
  boolean addTower(Tower tow){
    int x = tow.location[0];
    int y = tow.location[1];
    if(validPlacement(x, y)) {
      towerLoc[y][x]=tow;
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
    return (x >= 0 && x < board.length && y >= 0 && y < board[x].length)&& board[x][y].getColor() == color(56,78,29);
  }
  
  //moves the enemies across the board
  void moveEnemies() {
   for (int i=0; i<enemyLoc.size(); i++) {
     enemyLoc.get(i).move(board);
   }
  }
}
