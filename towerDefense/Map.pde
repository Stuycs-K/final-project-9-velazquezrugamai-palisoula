public class Map {
  Tower[][] towerLoc;
  ArrayList<Enemy> EnemyLoc;
  Tiles[][] board;
  int round, lives, money;
  ArrayList<Projectiles> proLoc;
  
  public Map(int rounds, int live, int mon, int ROW, int COL) {
    round = rounds;
    lives = live;
    money = mon;
    EnemyLoc = new ArrayList<Enemy>();
    towerLoc = new Tower[ROW][COL];
    board = new Tiles[ROW][COL];
    proLoc = new ArrayList<Projectiles>();
  }
  
  //adds tower to place
  void addTower(int x, int y, Tower tow){
    if(validPlacement(x, y)) tow.location = new int[] {x, y};
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
    return (x >= 0 && x < board.length && y >= 0 && y < board[x].length)&& board[x][y].getColor() == color(67, 237, 128);
  }
  
  //moves the enemies across the board
  void moveEnemies() {
   for (int i=0; i<EnemyLoc.size(); i++) {
     EnemyLoc.get(i).move(board);
   }
  }
}
