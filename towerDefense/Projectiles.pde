public class Projectiles {
  float[] location = new float[2];
  color Color;
  PVector dir;
  int damage;
  
  //creates a projectiles
  public Projectiles(float[] coords, color image, PVector direction, int dam) {
    location[0] = coords[0];
    location[1] = coords[1];
    Color = image;
    direction.normalize();
    dir = direction;
    damage = dam;
  }
  
  //moves the projectile across the screen
  public void move() {
    location[0]+=((int)(dir.x*5*damage));
    location[1]+=((int)(dir.y*5*damage));
  }
  
  //draws the projectile
  void project() {
    fill(Color);
    circle(location[0], location[1], SQUARESIZE/3);
    noFill();
  }
  
  //makes a copy of the projctile
  Projectiles copy() {
    float[] Loc = new float[2];
    Loc[0] = getLoc()[0];
    Loc[1] = getLoc()[1];
    color CLR = getColor();
    PVector heading = getDirection();
    int dmg = getDamage();
    return new Projectiles(Loc, CLR, heading, dmg);
  }
  
    
  //Setter method for the direction the projectiles must go
  void setDir(PVector value) {
    dir = value;
  }
  
  //accessor method for the damage the projectile deals
  int getDamage() {
    return damage;
  }
  
  //accessor method for the color of the projectiles
  color getColor() {
    return Color;
  }
  
  //accessor method for the direction of the projectile
  PVector getDirection() {
    return dir;
  }
  
  //accessor method for the location of the projectile
  float[] getLoc() {
    return location;
  }
  
  //accessor method for the X-coordinate of the projectile
  float getLocX() {
    return location[0];
  }
  
  //accessor method for the Y-coordinate of the projectile
  float getLocY() {
    return location[1];
  }
  
  //setter method for the damage value of a projectile
  void setDamage(int value) {
    damage = value;
  }
  
  //setter method of the projectiles location
  void setLoc(int x, int y) {
    location[0] = (.5+x)*SQUARESIZE;
    location[1] = (y+.5)*SQUARESIZE;
  }
}
