private Map board;
private int ROW, COL, SQUARESIZE;

void setup(){
  size(800, 800);
  ROW = 100;
  COL = 100;
  SQUARESIZE = height/ROW;
  
  int round = 0;
  int lives = 100;
  int startingMoney = 500;
  board = new Map(round, lives, startingMoney, ROW, COL);
}

void mouseClicked() {
  
}

void keyPressed() {
  
}

void draw() {
  
}

//Draws the map, then the towers, on top of it, then the enemies on top of those
void avatar() {
  Tiles[][] temp = board.board;
  for (int i=0; i<temp.length; i++) {
    for (int j=0; j<temp[i].length; i++) {
      fill(temp[i][j].getColor());
      square(i*SQUARESIZE, j*SQUARESIZE, SQUARESIZE);
      noFill();
    }
  }
}
