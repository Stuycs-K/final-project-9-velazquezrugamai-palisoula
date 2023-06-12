private Map board;
private int ROW, COL, SQUARESIZE, HALT, ENEMIES, MODE, hold, DIFF, HITBOX, x, y, prevX, prevY;
private boolean add, ranger;
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
  MODE = 1;
  DIFF = width-height;
  HITBOX=(int)(SQUARESIZE/1.8);
  x= -1;
  y = -1;
}

//places down a tower and upgrades
void mouseClicked() {
  ranger = false;
  int tempX = x;
  int tempY = y;
  x = mouseX/SQUARESIZE;
  y = mouseY/SQUARESIZE;
  int firstX = prevX;
  int firstY = prevY;
  prevX = mouseX;
  prevY = mouseY;
  boolean validX = mouseX>=width-DIFF && mouseX<=(width-DIFF)+200;
  boolean validY = mouseY>=SQUARESIZE*3 && mouseY<=SQUARESIZE*3+200;
  ranger = prevX>=width-DIFF+250+(DIFF/5-30)*2 && prevX<=width-DIFF+250+(DIFF/5-30)*2+DIFF/5-40 && prevY>=SQUARESIZE*3+5 && prevY<=SQUARESIZE*3+105;
  if (validX && validY) {
    MODE = ((mouseY-SQUARESIZE*3-5)/100)+1;
  }
  else if (mouseX<=width-DIFF && MODE==1 && board.getMoney()>=250 && board.getTile(y, x).getColor() == VALID) {
    boolean validHeight = firstY>=SQUARESIZE*3+5 && firstY<=SQUARESIZE*3+105;
    boolean normal = firstX>=width-DIFF+250 && firstX<=width-DIFF+210+DIFF/5;
    boolean damage = firstX>=width-DIFF+220+DIFF/5 && firstX<=width-DIFF+180+DIFF/5*2 && board.getMoney()>=650;
    boolean range = firstX>=width-DIFF+250+(DIFF/5-30)*2 && firstX<=width-DIFF+250+(DIFF/5-30)*2+DIFF/5-40 && board.getMoney()>=400;
    boolean speed = firstX>=width-DIFF+250+(DIFF/5-30)*3 && firstX<=width-DIFF+250+(DIFF/5-30)*3+DIFF/5-40 && board.getMoney()>=650;
    if (validHeight) {
      if (normal && board.addTower(normalTower(x, y))) {
        board.changeMoney(-normalTower(x,y).getCost());
      }
      else if (range && board.addTower(rangeTower(x, y))) {
        board.changeMoney(-rangeTower(x,y).getCost());
      }
      else if (damage && board.addTower(damageTower(x, y))) {
        board.changeMoney(-damageTower(x,y).getCost());
      }
      else if (speed && board.addTower(reloadTower(x, y))) {
        board.changeMoney(-reloadTower(x,y).getCost());
      }
    }
  }
  else if (MODE==2 && mouseX>=width-DIFF) {
    x=mouseX-height;
    y=mouseY;
    boolean validHeight = y>=SQUARESIZE*5.736 && y<=SQUARESIZE*8.06;
    boolean range = x>=SQUARESIZE*5 && x<=SQUARESIZE*9;
    boolean damage = x>=SQUARESIZE*9.2 && x<=SQUARESIZE*13.2;
    boolean speed = x>=SQUARESIZE*13.4 && x<=SQUARESIZE*17.4;
    x = tempX;
    y = tempY;
    if (board.findTowerIndex(x,y)!=-1 && validHeight) {
      Tower tow = board.findTower(x,y);
      int cost = 0;
      if (range) {
        cost = tow.upRange();
        if (board.getMoney()<cost) {
          tow.deRange();
          cost=0;
        }
      }
      else if (damage) {
        cost = tow.upDamage();
        if (board.getMoney()<cost) {
          tow.deDamage();
          cost=0;
        }
      }
      else if (speed) {
        cost = tow.upReload();
        if (board.getMoney()<cost) {
          tow.deSpeed();
          cost=0;
        }
      }
      if (cost>0) {
        board.changeMoney(-cost);
      }
    }
  }
}

//different hotkeys
void keyPressed() {
  //press 'e' to give up
  if (key == 'e') {
    giveUp();
  }
  //press space to start the new round
  if (key == ' ' && ENEMIES==0) {
    for (int i = board.getPro().size()-1; i>=0; i--) {
      board.getPro().remove(i);
    }
    board.increaseRound();
    startRound();
    board.changeMoney(750);
    add = true;
    ENEMIES = board.getRounds()*10;
  }
  //press 'm' to recieve an influx of cash
  if (key=='m') {
    board.changeMoney(500);
  }
  //press ',' to speed up enemy spawning
  if (key==',') {
    hold--;
    if (hold<=0) {
      hold = 1;
    }
  }
  //press '.' to slow down enemies
  if (key=='.') {
    hold++;
  }
  //press '\\' to cover every available square with a tower
  if (key=='\\') {
    boardState();
  }
  //press 'l' to decrease the amount of cash you have
  if (key=='l') {
    board.changeMoney(-500);
    if (board.getMoney()<0) {
      board.changeMoney(-board.getMoney());
    }
  }
}

//Draws the range that a tower would have
void drawArea(Tower tow) {
  int radi = tow.getRadius();
  int location = tow.getX()*SQUARESIZE;
  if (location+radi<height) {
    strokeWeight(3);
    float Xloc = (tow.getX()+.5)*SQUARESIZE;
    float Yloc = (tow.getY()+.5)*SQUARESIZE;
    if (x<=(width-DIFF-radi-9)) circle(Xloc, Yloc, radi*2);
    strokeWeight(1);
  }
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
  if (MODE==1) {
    if (ranger) {
      drawArea(rangeTower(mouseX/SQUARESIZE,mouseY/SQUARESIZE));
    }
    else {
      drawArea(normalTower(mouseX/SQUARESIZE,mouseY/SQUARESIZE));
    }
  }
  dead();
  win();
  upgrades();
  //CHANGE ME AFTER OTHER TOWERS HAVE BEEN MADE. SUCH THAT YOU CAN PLACE DOWN THESE NEW TOWERS
}
//calls on upgrade menu
void upgrades() {
  if (MODE==2) {
    if (board.findTowerIndex(x,y)!=-1) {
      Tower tower = board.findTower(x,y);
      tower.menu();
    }
  }
}

//Resets the board, and tell the player that they lost
void giveUp() {
  background(255);
  PImage boom = loadImage("boom.jpg");
  image(boom, width/2-width/4.8, 100);
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
  String type = "normal";
  int[] loc = new int[] {x, y};
  float[] projLoc = new float[] {x*SQUARESIZE+SQUARESIZE/2, y*SQUARESIZE+SQUARESIZE/2};
  color projColor = PROJECTILE;
  PVector direction = new PVector(0, 0);
  Projectiles proj = new Projectiles(projLoc, projColor, direction, damage);
  return new Tower(cost, radius, speed, damage, type, loc, proj);
}

//upgrades reload speed
Tower reloadTower(int x, int y) {
  int cost = 650;
  int speed = 82;
  int radius = 150;
  int damage = 1;
  String type = "reload";
  int[] loc = new int[] {x, y};
  float[] projLoc = new float[] {x*SQUARESIZE+SQUARESIZE/2, y*SQUARESIZE+SQUARESIZE/2};
  color projColor = color(15, 100, 255);
  PVector direction = new PVector(0, 0);
  Projectiles proj = new Projectiles(projLoc, projColor, direction, damage);
  return new Tower(cost, radius, speed, damage, type, loc, proj);
}
//upgrades range
Tower rangeTower(int x, int y) {
  int cost = 400;
  int speed = 150;
  int radius = 250;
  int damage = 1;
  String type = "range";
  int[] loc = new int[] {x, y};
  float[] projLoc = new float[] {x*SQUARESIZE+SQUARESIZE/2, y*SQUARESIZE+SQUARESIZE/2};
  color projColor = color(135, 125, 15);
  PVector direction = new PVector(0, 0);
  Projectiles proj = new Projectiles(projLoc, projColor, direction, damage);
  return new Tower(cost, radius, speed, damage, type, loc, proj);
}
//upgrades damage
Tower damageTower(int x, int y) {
  int cost = 650;
  int radius = 150;
  int speed = 150;
  int damage = 3;
  String type = "damage";
  int[] loc = new int[] {x, y};
  float[] projLoc = new float[] {x*SQUARESIZE+SQUARESIZE/2, y*SQUARESIZE+SQUARESIZE/2};
  color projColor = color(255, 5, 25);
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
  image(boom, width/2-width/4.8, 100);
  int round = 0;
  int lives = 100;
  int startingMoney = 500;
  board = new Map(round, lives, startingMoney, ROW, COL);
  PFont font = loadFont("Ani-48.vlw");
  textFont(font);
  fill(color(136, 8, 8));
  text("YOU HAVE LOST", width/2-200, height/2);
  makeMap();
  HALT = 4000;
}

//determines if the player has won, and shows them the victory screen
void win() {
  if (board.getRounds()>=11) {
    background(255);
    PImage boom = loadImage("boom.jpg");
    image(boom, width/2-width/4.8, 100);
    int round = 0;
    int lives = 100;
    int startingMoney = 500;
    board = new Map(round, lives, startingMoney, ROW, COL);
    PFont font = loadFont("Ani-48.vlw");
    textFont(font);
    fill(color(57, 255, 20));
    text("YOU HAVE WON!!", width/2-200, height/2);
    text("but can you win again?", width/2-215, height/2+350);
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
      String[] names = new String[] {"normal", "range", "reload", "damage"};
      if (map[i][j].getColor()==VALID) {
        Tower tow = normalTower(0,0);
        tow = tow.whichType(names[(int)(Math.random()*names.length)]);
        tow.setLoc(j, i);
        board.addTower(tow);
        board.setBoard(i, j, new Tiles(INVALID));
      }
    }
  }
}
