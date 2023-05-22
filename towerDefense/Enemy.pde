public class Enemy {
  int HP, speed;
  String[][] image;
  String Resistance;
  int[] loc;
  
  void move() {
    
  }
  
  void recieveDamage(int value) {
    HP -= value;
  }
}
