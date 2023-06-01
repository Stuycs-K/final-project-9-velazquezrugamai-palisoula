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
    boolean attackUp = tow.getpierce()>1;
    if(validPlacement(x, y) || (attackUp && canUpgrade(x, y))) {
      towerLoc.add(tow);
      board[y][x] = new Tiles(INVALID);
      return true;
    }
    return false;
  }

//adds projectile to tower
  void addProjectile(Projectiles proj) {
    proLoc.add(proj);
  }
  
//INcreases the rounds passed by 1
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
    boolean inRange = (x >= 0 && y < board.length && y >= 0 && x < board[y].length);
    return inRange && board[y][x].getColor() == VALID;
  }
  
//can the tower be upgraded?
  boolean canUpgrade(int x, int y){
    boolean inRange = (x >= 0 && y < board.length && y >= 0 && x < board[y].length);
    return inRange && (board[y][x].getColor() == INVALID);
  }
  
  //moves enemies and projectiles across the board
  void moveEverything(int value) {
   for (int i=enemyLoc.size()-1; i>=0; i--) {
     Enemy enemy = enemyLoc.get(i);
     enemy.move(board);
     if (enemy.end(value)) {
       enemyLoc.remove(i);
       changeLives(0-enemy.getHP());
     }
   }
   for (int i=0; i<proLoc.size(); i++) {
     Projectiles object = proLoc.get(i);
     proLoc.get(i).move();
     for (int j=0; j<enemyLoc.size(); j++) {
       Enemy enemy = enemyLoc.get(j);
       PVector enemyCoord = new PVector(enemy.loc[0], enemy.loc[1]);
       PVector projectileLoc = new PVector(object.location[0], object.location[1]);
       if (PVector.dist(enemyCoord, projectileLoc)<=SQUARESIZE/2) {
         proLoc.remove(i);
         enemy.recieveDamage(object.getDamage());
         killEnemy(j);
         i--;
         j=0;
         break;
       }
      
     }
   }
  }
  
  //Adds enemies based off of of the round
  void addEnemy() {
    for (int i=0; i<board.length; i++) {
      if (board[i][0].getColor()==PATH) {
        int health = round/2;
        int move = money/350;
        String type = "normal";
        int x = 0;
        int y = i;
        enemyLoc.add(new Enemy(health, move, type, x, y));
      }
    }
  }
  
  //Delete a projectile if it goes out of bounds
  void deleteProj() {
    for (int i=proLoc.size()-1; i>=0; i--) {
      int[] tempLoc = proLoc.get(i).location;
      if (tempLoc[0]<0 || tempLoc[1]<0 || tempLoc[0]>=width-200 || tempLoc[1]>=height) {
        proLoc.remove(i);
      }
    }
  }
  
  //If an enemy has 0 HP or less, remove them from the field
  boolean killEnemy(int value) {
    if (enemyLoc.get(value).getHP()<=0) {
      enemyLoc.remove(value);
      changeMoney(15);
      return true;
    }
    return false;
  }
  
  int getLives() {
    return lives;
  }
  
  int getRound() {
    return round;
  }
  
  void removeOld(int x, int y) {
    for (int i=0; i<towerLoc.size(); i++) {
      int[] Loc = towerLoc.get(i).getLocation();
      if (Loc[0]==x && Loc[1]==y) {
        towerLoc.remove(i);
        break;
      }
    }
  }
  
  public Tiles[][] getBoard() {
    return board;
  }
  
  public int getMoney() {
    return money;
  }
}
