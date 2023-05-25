private Map board;
private int ROW, COL, SQUARESIZE, HALT;

void setup(){
  size(1000, 800);
  ROW = 25;
  COL = 25;
  SQUARESIZE = height/ROW;
  
  int round = 0;
  int lives = 100;
  int startingMoney = 500;
  board = new Map(round, lives, startingMoney, ROW, COL);
  makeMap();
}

void mouseClicked() {
  if (board.money>=250) {
    if (board.addTower(normalTower(mouseX/SQUARESIZE, mouseY/SQUARESIZE))) {
      board.changeMoney(-250);
    }
  }
}

//if key is pressed, skip round
void keyPressed() {
  if (key == 'e') {
    giveUp();
  }
}



/*color codes
brown: path for enemies
gray: tower
green: valid tower placement

*/
void draw() {
  avatar();
  textSize(25);
  fill(0);
  text("ROUND: " + board.round, width-195, 25);
  text("MONEY: " + board.money, width-195, 50);
  text("LIVES: " + board.lives, width-195, 75);
  noFill();
}

//Resets the board, and tell the player that they lost
void giveUp() {
  background(255);
  int round = 0;
  int lives = 100;
  int startingMoney = 500;
  board = new Map(round, lives, startingMoney, ROW, COL);
  textSize(35);
  PFont font = createFont("Ani-48.vlw", 35);
  textFont(font);
  fill(color(136, 8, 8));
  text("YOU HAVE GIVEN UP", width/2-130, height/2);
  makeMap();
  HALT = 2000;
}


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
  Tower[][] tempTowers = board.towerLoc;
  for (int i=0; i<temp.length; i++) {
    for (int j=0; j<temp[i].length; j++) {
      fill(temp[i][j].getColor());
      square(j*SQUARESIZE, i*SQUARESIZE, SQUARESIZE);
      noFill();
      tempTowers[i][j].makeTower();
    }
  }
  fill(104, 103, 237);
  rect(width-200, 0, width, height);
  noFill();
}

void makeMap() {
  int i = 0;
  int j = 0;
  for (i=0; i<ROW; i++) {
    for (j=0; j<COL; j++) {
      board.board[i][j] = new Tiles(color(67, 237, 128));
      int cost = 500;
      int radius = 0;
      int speed = 0;
      int damage = 0;
      String type = "";
      int[] loc = new int[] {height*500, width*500};
      int[] projLoc = loc;
      color projColor = color(0);
      PVector direction = new PVector(5, 5);
      Projectiles proj = new Projectiles(projLoc, projColor, direction);
      board.towerLoc[i][j] = new Tower(cost,radius,speed,damage,type,loc,proj);
    }
  }
  i=0;
  j=0;
  while (j!=COL) {
    board.board[i][j] = new Tiles(color(131, 98, 12));
    if (Math.random()<.62 && i!=ROW-1) {
      i++;
    }
    else {
      j++;
    }
  }
}

//Makes a normal tower
Tower normalTower(int x, int y) {
  int cost = 250;
  int radius = 10;
  int speed = 25;
  int damage = 1;
  String type = "piercing";
  int[] loc = new int[] {x, y};
  int[] projLoc = loc;
  color projColor = color(90, 234, 221);
  PVector direction = new PVector(1, 1);
  Projectiles proj = new Projectiles(projLoc, projColor, direction);
  return new Tower(cost,radius,speed,damage,type,loc,proj);
}
