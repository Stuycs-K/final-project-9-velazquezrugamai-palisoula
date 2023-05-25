public class Enemy {
  int HP, speed;
  color image;
  String Resistance;
  int[] loc = new int[2];
  
  public Enemy(int health, int move, String type, int x, int y) {
    HP = health;
    speed = move;
    Resistance = type;
    loc[0]=x;
    loc[1]=y;
  }
  
  void move(Tiles[][] board) {
    //if (board[loc[1]/SQUARESIZE][(loc[0]+speed)/SQUARESIZE]==5)
    int[][] dir = {{0, 1}, {1, 0}, {-1, 0}, {0, -1}};
    //the for loop only goes until i = 2 because the road currently goes down and right only.
    for(int i = 0; i < 2; i++){
      int x = loc[0] + dir[i][0];
      int y = loc[1] + dir[i][1];
      if(board[x][y].getColor() == color(131, 98, 12)){
        loc[0] = x;
        loc[1] = y;
      }
    }
  }
  
  //enemy takes value damage
  void recieveDamage(int value) {
    HP -= value;
  }
  
  public void visualize() {
    
  }
}
