public class Map {
  ArrayList<Tower> towerLoc;
  ArrayList<Enemy> enemyLoc;
  Tiles[][] board;
  int round, lives, money;
  ArrayList<Projectiles> proLoc;

  //creates a new map
  public Map(int rounds, int live, int mon, int ROW, int COL) {
    round = rounds;
    lives = live;
    money = mon;
    enemyLoc = new ArrayList<Enemy>();
    towerLoc = new ArrayList<Tower>();
    board = new Tiles[ROW][COL];
    proLoc = new ArrayList<Projectiles>();
  }

  //adds tower to a tile
  boolean addTower(Tower tow) {
    int x = tow.location[0];
    int y = tow.location[1];
    boolean attackUp = tow.getPierce()>1;
    if (validPlacement(x, y) || (attackUp && canUpgrade(x, y))) {
      towerLoc.add(tow);
      board[y][x] = new Tiles(INVALID);
      return true;
    }
    return false;
  }

  //moves enemies and projectiles across the board
  void moveEverything(int value) {
    for (int i=enemyLoc.size()-1; i>=0; i--) {
      Enemy enemy = enemyLoc.get(i);
      enemy.move(board);
      if (enemy.end(value)) {
        enemyLoc.remove(i);
        changeLives(-enemy.getHP());
      }
    }
    for (int i=0; i<proLoc.size(); i++) {
      Projectiles object = proLoc.get(i);
      proLoc.get(i).move();
      for (int j=0; j<enemyLoc.size(); j++) {
        Enemy enemy = enemyLoc.get(j);
        PVector enemyCoord = new PVector(enemy.getLocX(), enemy.getLocY());
        PVector projectileLoc = new PVector(object.getLocX(), object.getLocY());
        if (PVector.dist(enemyCoord, projectileLoc)<=HITBOX) {
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
        int x = 0;
        int y = i*SQUARESIZE;
        enemyLoc.add(new Enemy(health, move, x, y));
        i+=board.length;
      }
    }
  }

  //Delete a projectile if it goes out of bounds
  void deleteProj() {
    for (int i=proLoc.size()-1; i>=0; i--) {
      float[] tempLoc = proLoc.get(i).location;
      if (tempLoc[0]<0 || tempLoc[1]<0 || tempLoc[0]>=width-DIFF-SQUARESIZE/3 || tempLoc[1]>=height) {
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

  //When upgrading a tower, remove the older tower placed there originally
  void removeOld(int x, int y) {
    int index = findTowerIndex(x, y);
    if (index!=-1) {
      towerLoc.remove(index);
      setBoard(y, x, new Tiles(VALID));
    }
  }

  //accessor method for the tiles array
  public Tiles[][] getBoard() {
    return board;
  }

  //accessor method for a specific Tile
  public Tiles getTile(int i, int j) {
    return board[i][j];
  }

  //accessor method for the amount of money the map has
  public int getMoney() {
    return money;
  }

  //accessor method for the amount of rounds passed in this map
  public int getRounds() {
    return round;
  }

  //accessor method for the projectiles on the map
  public ArrayList<Projectiles> getPro() {
    return proLoc;
  }

  //accessor method for the enemies on the map
  public ArrayList<Enemy> getEnemy() {
    return enemyLoc;
  }

  //accessor method for the towers on the map
  public ArrayList<Tower> getTower() {
    return towerLoc;
  }

  //accessor method for the amount of lives the map has
  int getLives() {
    return lives;
  }

  //adds projectile to tower
  void addProjectile(Projectiles proj) {
    proLoc.add(proj);
  }

  //setter method for a specific tile on the baord
  public void setBoard(int i, int j, Tiles obj) {
    board[i][j] = obj;
  }

  //Increases the rounds passed by 1
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
  boolean canUpgrade(int x, int y) {
    boolean inRange = (x >= 0 && y < board.length && y >= 0 && x < board[y].length);
    return inRange && (board[y][x].getColor() == INVALID);
  }

  //Draws the map, then the towers, on top of it, then the enemies on top of those
  void avatar() {
    Tiles[][] temp = getBoard();
    ArrayList<Tower> tempTowers = getTower();
    for (int i=0; i<temp.length; i++) {
      for (int j=0; j<temp[i].length; j++) {
        fill(temp[i][j].getColor());
        if (j!=temp[i].length-1) square(j*SQUARESIZE, i*SQUARESIZE, SQUARESIZE);
        else rect(j*SQUARESIZE, i*SQUARESIZE, SQUARESIZE+5, SQUARESIZE);
        if (i==temp.length-1) square(j*SQUARESIZE, i*SQUARESIZE, SQUARESIZE+5);
        noFill();
      }
    }
    fill(175);
    rect(width-DIFF, 0, DIFF, height);
    noFill();
    PFont font = loadFont("Ani-25.vlw");
    textFont(font);
    fill(0);
    text("ROUND: " + getRounds(), width-DIFF+5, SQUARESIZE);
    text("MONEY: " + getMoney(), width-DIFF+5, SQUARESIZE*2);
    text("LIVES: " + getLives(), width-DIFF+5, SQUARESIZE*3);
    rect(width-DIFF, SQUARESIZE*3+5, 200, 100);
    if (MODE == 1) fill(125);
    else fill(255);
    rect(width-DIFF, SQUARESIZE*3+105, 200, 100);
    if (MODE == 1) fill(255);
    else fill(125);
    text("BUY", width-DIFF+70, SQUARESIZE*4+10);
    text("    TOWERS ", width-DIFF+15, SQUARESIZE*4+40);
    text("    UPGRADE", width-DIFF+5, SQUARESIZE*3+162);
    noFill();
    for (int i=0; i<enemyLoc.size(); i++) {
      getEnemy().get(i).visualize();
    }
    for (int i=0; i<getPro().size(); i++) {
      getPro().get(i).project();
    }
    for (int i=0; i<tempTowers.size(); i++) {
      tempTowers.get(i).makeTower();
    }
    if (MODE==1) options();
  }

  //finds the tower object of a tower in a specific location, returns null if no such tower exists
  public Tower findTower(int x, int y) {
    for (int i=0; i<towerLoc.size(); i++) {
      Tower tower = towerLoc.get(i);
      if (x==tower.getX() && y==tower.getY()) {
        return tower;
      }
    }
    return null;
  }

  //Finds the index of a tower in a specific location, returns -1 if no such tower exists
  public int findTowerIndex(int x, int y) {
    for (int i=0; i<towerLoc.size(); i++) {
      Tower tower = towerLoc.get(i);
      if (x==tower.getX() && y==tower.getY()) {
        return i;
      }
    }
    return -1;
  }

  public void options() {
    int size = DIFF-200;
    Tower temp = normalTower(0, 0);
    String[] names = new String[] {"NORMAL", "DAMAGE", "RANGE", "RELOAD"};
    for (int i=0; i<4; i++) {
      if (i==0) {
        fill(125);
      } else if (i==2) {
        fill(75, 215, 90);
      } else {
        fill(120-30*i, 30+20*i, 50+20*i);
      }
      rect(width-DIFF+250+(size/5+10)*i, SQUARESIZE*3+5, size/5, 100);
      fill(255);
      textSize(20);
      text(names[i], width-DIFF+260+(size/5+10)*i, SQUARESIZE*4.1);
      text("COST: " + (temp.whichType(names[i].toLowerCase()).getCost()), width-DIFF+260+(size/5+10)*i, SQUARESIZE*5);
    }
    noFill();
  }
}
