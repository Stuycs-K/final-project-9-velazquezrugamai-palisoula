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
  public void move() {
    location[0]+=dir.x;
    location[1]+=dir.y;
  }
  
  void setDir(PVector value) {
    dir = value;
  }
}
