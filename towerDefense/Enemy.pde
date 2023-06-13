public class Enemy {
  private int HP, speed;
  color image;
  int[] loc = new int[2];
  int radius = SQUARESIZE/2;
  
  //makes a new enemy on the map
  public Enemy(int health, int move, int x, int y) {
    HP = health;
    speed = move;
    loc[0]=x;
    loc[1]=y;
    if (speed==0) {
      speed++;
    }
    if (HP==0) {
      HP++;
    }
  }
  
  //allows the enemy to move based on the tiles in the map, and their speed increases how fast they can move across this board
  void move(Tiles[][] board) {
    //if (board[loc[1]/SQUARESIZE][(loc[0]+speed)/SQUARESIZE]==5)
    int temp = speed;
    while (temp!=0) {
      int[][] dir = {{0, 1}, {1, 0}, {-1, 0}, {0, -1}};
      //the for loop only goes until i = 2 because the road currently goes down and right only.
      for(int i = 0; i < 2; i++){
        int x = loc[0] + dir[i][0];
        int y = loc[1] + dir[i][1];
        if (y/SQUARESIZE>=board.length) {
          y=(board.length-1)*SQUARESIZE+(int)(SQUARESIZE/1.05);
        }
        if (x/SQUARESIZE>=board[0].length) {
          x=(board[0].length-1)*SQUARESIZE+(int)(SQUARESIZE/1.05);
        }
        if(board[y/SQUARESIZE][x/SQUARESIZE].getColor() == PATH){
          loc[0] = x;
          loc[1] = y;
        }
      }
      temp--;
    }
  }
  
  //enemy takes value damage
  void recieveDamage(int value) {
    HP -= value;
  }
  
  //draws the enemy on the map
  public void visualize() {
    fill(image);
    ellipse(loc[0], loc[1], (int)(SQUARESIZE/1.5), SQUARESIZE/2);
    noFill();
  }
  
  //determines if the enemy has reached the end
  public boolean end(int value) {
    return loc[0]>=value;
  }
  
  //accessor method for the HP the enmy has
  public int getHP() {
    return HP;
  }
  
  //accessor method for the X-coordinate of the enemy
  public int getLocX() {
    return loc[0];
  }
  
  //accessor method for the Y-coordinate of the enemy
  public int getLocY() {
    return loc[1];
  }
}
