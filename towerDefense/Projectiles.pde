public class Projectiles {
  int speed;
  int[] location;
  color Color;
  float dir;
  
  public Projectiles(int move, int[] coords, color image, float direction) {
    speed = move;
    location = coords;
    Color = image;
    dir = direction;
  }
  
  //moves the projectile across the screen
  public void move(int x, int y) {
    location[0]+=x*speed;
    location[1]+=y*speed;
  }
}
