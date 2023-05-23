public class Enemy {
  int HP, speed;
  String[][] image;
  String Resistance;
  int[] loc = new int[2];
  
  public Enemy(int health, int move, String type, int x, int y) {
    HP = health;
    speed = move;
    Resistance = type;
    loc[0]=x;
    loc[1]=y;
  }
  
  void move() {
    
  }
  //enemy takes value damage
  void recieveDamage(int value) {
    HP -= value;
  }
}
