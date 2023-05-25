public class Projectiles {
  int[] location;
  color Color;
  PVector dir;
  
  public Projectiles(int[] coords, color image, PVector direction) {
    location = coords;
    Color = image;
    dir = direction.normalize();
  }
  
  //moves the projectile across the screen
  public void move(int x, int y) {
    location[0]+=x*dir.x;
    location[1]+=y*dir.y;
  }
  
  void setDir(PVector value) {
    dir = value;
  }
}
