public class Projectiles {
  int speed;
  int[] location;
  color Color;
  
  public Projectiles(int move, int[] coords, color image) {
    speed = move;
    location = coords;
    Color = image;
  }
  
  public void move(int x, int y) {
    location[0]+=x;
    location[1]+=y;
  }
}
