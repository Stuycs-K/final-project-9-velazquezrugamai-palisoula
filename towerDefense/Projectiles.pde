public class Projectiles {
  int[] location = new int[2];
  color Color;
  PVector dir;
  int damage;
  
  public Projectiles(int[] coords, color image, PVector direction, int dam) {
    location[0] = coords[0];
    location[1] = coords[1];
    Color = image;
    direction.normalize();
    dir = direction;
    damage = dam;
  }
  
  //moves the projectile across the screen
  public void move() {
    location[0]+=((int)(dir.x))/4;
    location[1]+=((int)(dir.y))/4;
  }
  
  void setDir(PVector value) {
    dir = value;
  }
  
  int getDamage() {
    return damage;
  }
  
  void project() {
    fill(Color);
    circle(location[0], location[1], SQUARESIZE/3);
    noFill();
  }
}
