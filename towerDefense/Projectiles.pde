public class Projectiles {
  int[] location = new int[2];
  color Color;
  PVector dir;
  int damage;
  
  public Projectiles(int[] coords, color image, PVector direction, int dam) {
    location[0] = coords[0];
    location[1] = coords[1];
    Color = image;
    dir = direction.normalize();
    damage = dam;
  }
  
  //moves the projectile across the screen
  public void move() {
    location[0]+=(int)(2*dir.x);
    location[1]+=(int)(2*dir.y);
  }
  
  void setDir(PVector value) {
    dir = value;
  }
  
  void project() {
    fill(Color);
    circle(location[0]+SQUARESIZE/2, location[1]+SQUARESIZE/2, SQUARESIZE/3);
    noFill();
  }
}
