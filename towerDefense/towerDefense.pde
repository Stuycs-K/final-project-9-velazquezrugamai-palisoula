private Map board;
private int ROW, COL, SQUARESIZE, HALT, ENEMIES, MODE, hold, DIFF, HITBOX;
private boolean add;
public final color PATH = color(131, 98, 12);
public final color INVALID = color(255, 13, 13);
public final color VALID = color(56, 78, 29);
public final color TOWER = color(165);
public final color PROJECTILE = color(90, 234, 221);
public final color UPGRADED = color(222, 25, 212);

//sets the initial starting board screen
void setup() {
  fullScreen();
  ROW = 25;
  COL = 25;
  SQUARESIZE = height/ROW;
  add = false;
  ENEMIES = 0;
  int round = 0;
  int lives = 100;
  int startingMoney = 500;
  hold = 50;
  board = new Map(round, lives, startingMoney, ROW, COL);
  makeMap();
  MODE = -1;
  DIFF = width-height;
  HITBOX=(int)(SQUARESIZE/2.3);
}

//places down a tower
void mouseClicked() {
  int x = mouseX/SQUARESIZE;
  int y = mouseY/SQUARESIZE;
  if (mouseX>=width-DIFF) {
    if (mouseY>=SQUARESIZE*3) {
      MODE = mouseY/100;
    }
  }
  else if (MODE==1 && board.getMoney()>=250 && board.getTile(y, x).getColor() == VALID) {
    if (board.addTower(normalTower(x, y))) {
      board.changeMoney(-250);
    }
  } else if(MODE==2 && board.getMoney()>=100 && board.canUpgrade(x, y)){
      board.removeOld(x, y);
      board.addTower(upTower(x, y));
      board.changeMoney(-100);
      board.setBoard(y, x, new Tiles(UPGRADED));
  }
}

//if key is pressed, ' ' to skip round, press e to give up
void keyPressed() {
  if (key == 'e') {
    giveUp();
  }
  if (key == ' ' && board.getEnemy().size()==0) {
    for (int i = board.getPro().size()-1; i>=0; i--) {
      board.getPro().remove(i);
    }
    board.increaseRound();
    startRound();
    board.changeMoney(750);
    add = true;
    ENEMIES = board.getRounds()*10;
  }
  if (key=='m') {
    board.changeMoney(500);
  }
  if (key==',') {
    hold--;
    if (hold<=0) {
      hold = 1;
    }
  }
  if (key=='.') {
    hold++;
  }
  if (key=='\\') {
    boardState();
  }
  if (key=='l') {
    board.changeMoney(-500);
    if (board.getMoney()<0) {
      board.changeMoney(-board.getMoney());
    }
  }
}

void mouseMoved() {
  
}

//Draws the range that a tower would have
void drawArea() {
  int radi = 0;
  int x = mouseX;
  int y = mouseY;
  int boardX = x/SQUARESIZE;
  int boardY = y/SQUARESIZE;
  boolean foundTower = board.findTowerIndex(boardX, boardY)!=-1;
  if (MODE==1 || foundTower) {
    if (foundTower && board.findTower(boardX, boardY).getCost()==100) radi=upTower(0,0).getRadius();
    else radi=normalTower(0,0).getRadius();
  }
  strokeWeight(10);
  if (x<=(width-DIFF-radi-9)) circle(x, y, radi*2);
  strokeWeight(1);
} 

/*color codes
 brown: path for enemies
 gray: tower
 green: valid tower placement
 Draws the board, map, enemies, towers, and projectiles
 */
void draw() {
  wait(HALT);
  HALT-=HALT;
  board.avatar();
  advance();
  if (add==true && ENEMIES!=0) {
    startRound();
  }
  dead();
  win();
  drawArea();
}

//Resets the board, and tell the player that they lost
void giveUp() {
  background(255);
  PImage boom = loadImage("boom.jpg");
  image(boom, width/2-width/4.8, 0);
  int round = 0;
  int lives = 100;
  int startingMoney = 500;
  board = new Map(round, lives, startingMoney, ROW, COL);
  PFont font = loadFont("Ani-48.vlw");
  textFont(font);
  fill(color(136, 8, 8));
  text("YOU HAVE GIVEN UP", width/2-250, height/2);
  makeMap();
  HALT = 2000;
}

//Halts the screen for time miliseconds
void wait(int time) {
  try {Thread.sleep(time);}
  catch (Exception e) {}
}

//Makes a random map for the enemies to move on
void makeMap() {
  int i = 0;
  int j = 0;
  for (i=0; i<ROW; i++) {
    for (j=0; j<COL; j++) {
      board.setBoard(i, j, new Tiles(VALID));
    }
  }
  i=0;
  j=0;
  while (j!=COL) {
    board.setBoard(i, j, new Tiles(PATH));
    if (Math.random()<.62 && i!=ROW-1) {
      i++;
    } else {
      j++;
    }
  }
}

//Makes a normal tower
Tower normalTower(int x, int y) {
  int cost = 250;
  int radius = 150;
  int speed = 150;
  int damage = 1;
  String type = "piercing";
  int[] loc = new int[] {x, y};
  int[] projLoc = new int[] {x*SQUARESIZE+SQUARESIZE/2, y*SQUARESIZE+SQUARESIZE/2};
  color projColor = PROJECTILE;
  PVector direction = new PVector(0, 0);
  Projectiles proj = new Projectiles(projLoc, projColor, direction, damage);
  return new Tower(cost, radius, speed, damage, type, loc, proj);
}

//upgrades a tower
Tower upTower(int x, int y) {
  int cost = 100;
  int speed = 82;
  int radius = 200;
  int damage = 3;
  String type = "piercing";
  int[] loc = new int[] {x, y};
  int[] projLoc = new int[] {x*SQUARESIZE+SQUARESIZE/2, y*SQUARESIZE+SQUARESIZE/2};
  color projColor = PROJECTILE;
  PVector direction = new PVector(0, 0);
  Projectiles proj = new Projectiles(projLoc, projColor, direction, damage);
  return new Tower(cost, radius, speed, damage, type, loc, proj);
}

//Tells the towers to shoot
void countdown() {
  ArrayList<Tower> towers = board.getTower();
  ArrayList<Enemy> enemies = board.getEnemy();
  for (int i=0; i<towers.size(); i++) {
    Tower tower = towers.get(i);
    tower.reduceWait();
    for (int k=0; k<enemies.size(); k++) {
      Enemy enemy = enemies.get(k);
      if (tower.shoot(board, enemy)) break;
    }
  }
}

//Spawns in enemies and grants the player cash
void startRound() {
  if (frameCount%hold==0) {
    board.addEnemy();
    ENEMIES--;
  }
}

//Advances the enemies and projectiles ahead
void advance() {
  board.moveEverything(width-DIFF-8);
  countdown();
  board.deleteProj();
}

//determines if the player has died, and shows them the loss screen
void dead() {
  if (board.getLives()<=0) {
    add = false;
    for (int i=board.enemyLoc.size()-1; i>=0; i--) {
      board.getEnemy().remove(i);
    }
    for (int i=board.getPro().size()-1; i>=0; i--) {
      board.getPro().remove(i);
    }
    lost();
  }
}

//shows the player the loss screen
void lost() {
  background(255);
  PImage boom = loadImage("boom.jpg");
  image(boom, width/2-width/4.8, 0);
  int round = 0;
  int lives = 100;
  int startingMoney = 500;
  board = new Map(round, lives, startingMoney, ROW, COL);
  PFont font = loadFont("Ani-48.vlw");
  textFont(font);
  fill(color(136, 8, 8));
  text("YOU HAVE LOST", width/2-250, height/2);
  makeMap();
  HALT = 4000;
}

//determines if the player has won, and shows them the victory screen
void win() {
  if (board.getRounds()>=11) {
    background(255);
    PImage boom = loadImage("boom.jpg");
    image(boom, width/2-width/4.8, 0);
    int round = 0;
    int lives = 100;
    int startingMoney = 500;
    board = new Map(round, lives, startingMoney, ROW, COL);
    PFont font = loadFont("Ani-48.vlw");
    textFont(font);
    fill(color(136, 8, 8));
    text("YOU HAVE WON!!", width/2-250, height/2);
    text("but can you win again?", width/2-250, height/2+350);
    makeMap();
    HALT = 8000;
    add = false;
    ENEMIES=0;
  }
}

//cheat method that adds the upgraded tower across the entire screen
void boardState() {
  Tiles[][] map = board.getBoard();
  for (int i=0; i<map.length; i++) {
    for (int j=0; j<map[i].length; j++) {
      if (map[i][j].getColor()==VALID) {
        board.addTower(normalTower(j, i));
        board.setBoard(i, j, new Tiles(INVALID));
      }
      if (map[i][j].getColor()==INVALID) {
        board.addTower(upTower(j, i));
        board.setBoard(i, j, new Tiles(UPGRADED));
      }
    }
  }
}
