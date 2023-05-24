private Map board;
private int ROW, COL, SQUARESIZE;

void setup(){
  size(800, 800);
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
  
}

void keyPressed() {
  if (key == 'e') {
    size(800, 800);
    ROW = 25;
    COL = 25;
    SQUARESIZE = height/ROW;
  
    int round = 0;
    int lives = 100;
    int startingMoney = 500;
    board = new Map(round, lives, startingMoney, ROW, COL);
    makeMap();
  }
}

void draw() {
  avatar();
}

//Draws the map, then the towers, on top of it, then the enemies on top of those
void avatar() {
  Tiles[][] temp = board.board;
  for (int i=0; i<temp.length; i++) {
    for (int j=0; j<temp[i].length; j++) {
      fill(temp[i][j].getColor());
      square(j*SQUARESIZE, i*SQUARESIZE, SQUARESIZE);
      noFill();
    }
  }
}

void makeMap() {
  int i = 0;
  int j = 0;
  for (i=0; i<ROW; i++) {
    for (j=0; j<COL; j++) {
      board.board[i][j] = new Tiles(color(67, 237, 128));
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
