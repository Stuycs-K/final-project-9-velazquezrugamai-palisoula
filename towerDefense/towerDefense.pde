private Map board;
private int ROW, COL, SQUARESIZE, HALT, ENEMIES;
private boolean add;
public final color PATH = color(131, 98, 12);
public final color INVALID = color(255, 13, 13);
public final color VALID = color(56, 78, 29);
public final color TOWER = color(165);
public final color PROJECTILE = color(90, 234, 221);

void setup() {
  size(1000, 800);
  ROW = 25;
  COL = 25;
  SQUARESIZE = height/ROW;
  add = false;
  ENEMIES = 0;
  int round = 0;
  int lives = 100;
  int startingMoney = 500;
  board = new Map(round, lives, startingMoney, ROW, COL);
  makeMap();
}
//places down a tower
void mouseClicked() {
  if (board.money>=250) {
    if (board.addTower(normalTower(mouseX/SQUARESIZE, mouseY/SQUARESIZE))) {
      board.changeMoney(-250);
    }
  }
  //if(board.money>=100 && board.canUpgrade(mouseX/SQUARESIZE, mouseY/SQUARESIZE)){
  //  board.addTower(upTower(mouseX/SQUARESIZE, mouseY/SQUARESIZE));
  //  board.changeMoney(-100);
  //  board.board[mouseY/SQUARESIZE][mouseX/SQUARESIZE] = new Tiles(color(222, 25, 212));
  //}
}

//if key is pressed, ' ' to skip round, press e to give up
void keyPressed() {
  if (key == 'e') {
    giveUp();
  }
  if (key == ' ' && board.enemyLoc.size()==0) {
    board.increaseRound();
    startRound();
    board.changeMoney(750);
    add = true;
    ENEMIES = board.round*10;
  }
}



/*color codes
 brown: path for enemies
 gray: tower
 green: valid tower placement
 
 */
void draw() {
  avatar();
  advance();
  if (add==true && ENEMIES!=0) {
    startRound();
  }
  println(board.proLoc.size());
}

//Resets the board, and tell the player that they lost
void giveUp() {
  background(255);
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
  try {
    Thread.sleep(time);
  }
  catch (Exception e) {
  }
}

//Draws the map, then the towers, on top of it, then the enemies on top of those
void avatar() {
  wait(HALT);
  HALT-=HALT;
  Tiles[][] temp = board.board;
  ArrayList<Tower> tempTowers = board.towerLoc;
  for (int i=0; i<temp.length; i++) {
    for (int j=0; j<temp[i].length; j++) {
      fill(temp[i][j].getColor());
      square(j*SQUARESIZE, i*SQUARESIZE, SQUARESIZE);
      noFill();
    }
  }
  fill(175);
  rect(width-200, 0, width, height);
  noFill();
  PFont font = loadFont("Ani-25.vlw");
  textFont(font);
  fill(0);
  text("ROUND: " + board.round, width-195, SQUARESIZE);
  text("MONEY: " + board.money, width-195, SQUARESIZE*2);
  text("LIVES: " + board.lives, width-195, SQUARESIZE*3);
  noFill();
  for (int i=0; i<board.enemyLoc.size(); i++) {
    board.enemyLoc.get(i).visualize();
  }
  for (int i=0; i<board.proLoc.size(); i++) {
    board.proLoc.get(i).project();
  }
  for (int i=0; i<tempTowers.size(); i++) {
    tempTowers.get(i).makeTower();
  }
}

//Makes a random map for the enemies to move on
void makeMap() {
  int i = 0;
  int j = 0;
  for (i=0; i<ROW; i++) {
    for (j=0; j<COL; j++) {
      board.board[i][j] = new Tiles(VALID);
    }
  }
  i=0;
  j=0;
  while (j!=COL) {
    board.board[i][j] = new Tiles(PATH);
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
  int radius = 100;
  int speed = 10;
  int damage = 1;
  String type = "piercing";
  int[] loc = new int[] {x, y};
  int[] projLoc = new int[] {x*SQUARESIZE, y*SQUARESIZE};
  color projColor = PROJECTILE;
  PVector direction = new PVector(0, 0);
  Projectiles proj = new Projectiles(projLoc, projColor, direction, damage);
  return new Tower(cost, radius, speed, damage, type, loc, proj);
}

//upgrades a tower
Tower upTower(int x, int y) {
  int cost = 100;
  int radius = 15;
  int speed = 28;
  int damage = 2;
  String type = "piercing";
  int[] loc = new int[] {x, y};
  int[] projLoc = new int[] {x*SQUARESIZE, y*SQUARESIZE};
  color projColor = PROJECTILE;
  PVector direction = new PVector(0, 0);
  Projectiles proj = new Projectiles(projLoc, projColor, direction, damage);
  return new Tower(cost, radius, speed, damage, type, loc, proj);
}
//Tells the towers to shoot
void countdown() {
  for (int i=0; i<board.towerLoc.size(); i++) {
    board.towerLoc.get(i).reduceWait();
    for (int k=board.enemyLoc.size()-1; k>=0; k--) {
      if (board.towerLoc.get(i).shoot(board, board.enemyLoc.get(k))) break;
    }
  }
}

//Spawns in enemies and grants the player cash
void startRound() {
  int hold = 50;
  if (frameCount%hold==0) {
    board.addEnemy();
    ENEMIES--;
  }
}

//Advances the enemies and projectiles ahead
void advance() {
  board.moveEverything(width-210);
  countdown();
  board.deleteProj();
}
