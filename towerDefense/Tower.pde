public class Tower {
  int cost, range, reload, pierce, timeWaited;
  String type;
  private int[] location;
  Projectiles proj;
  
  //Creates a new tower
  public Tower(int price, int radius, int attackSpeed, int damage, String attackType, int[] loc, Projectiles pro) {
    cost = price;
    range = radius;
    reload = attackSpeed;
    pierce = damage;
    type = attackType;
    location = loc;
    proj = pro;
    timeWaited=0;
  }
  
  //Tells the tower to shoot at the enemy closest to the back lines
  public boolean shoot(Map obj, Enemy enem){
    int[] towLoc = new int[] {location[0]*SQUARESIZE+SQUARESIZE/2, location[1]*SQUARESIZE+SQUARESIZE/2};
    PVector enemy = new PVector(enem.getLocX(), enem.getLocY());
    PVector tower = new PVector(towLoc[0], towLoc[1]);
    float distance = PVector.dist(enemy, tower);
    if (distance<=range && timeWaited==0) {
      PVector temp = new PVector(enem.getLocX()-towLoc[0], enem.getLocY()-towLoc[1]);
      proj.setDir(temp);
      proj.setDamage(getPierce());
      obj.addProjectile(proj.copy());
      timeWaited=reload;
      return true;
    }
    return false;
  }
  
  //Draws the tower in Processing
  public void makeTower() {
    fill(TOWER);
    if (getType().equals("reload")) fill(color(25, 50, 255));
    if (getType().equals("range")) fill(color(5, 255, 23));
    if (getType().equals("damage")) fill(color(255, 5, 25));
    circle(location[0]*SQUARESIZE+SQUARESIZE/2, location[1]*SQUARESIZE+SQUARESIZE/2, SQUARESIZE/2);
    noFill();
  }
  
  //setter method to reduce the time needed for the tower to reload
  public void reduceWait() {
    if (timeWaited!=0) {
      timeWaited--;
    }
  }
    
  //adding value to the range
  public void changeRange(int value){
    range += value;
  }
  //adding value to pierce
  public void changePierce(int value){
    pierce += value;
  }
  //adding value to the cost
  public void changeCost(int value){
    cost += value;
  }
  
  //accessor method for the location of the tower
  public int[] getLocation() {
    return location;
  }
  
  //accessor method for the damage of the tower
  public int getPierce() {
    return pierce;
  }
  
  //accessor method for the radius of the tower
  public int getRadius() {
    return range;
  }
  
  //accessor method for x-coordinate of the tower
  public int getX() {
    return location[0];
  }
  
  //accessor method for y-coordinate of the tower
  public int getY() {
    return location[1];
  }
  
  //accessor method for cost of the tower
  public int getCost() {
    return cost;
  }
  
  //accessor method for the reload Speed of the tower
  public int getReload() {
    return reload;
  }
  
  //accessor method for the type of the tower
  public String getType() {
    return type;
  }
  
  //draws the menu and showcases the specific stats of each tower
  public void menu() {
    drawArea(this);
    fill(255, 0, 0);
    float offset = SQUARESIZE*9.2;
    float botSide = SQUARESIZE*4;
    float size = SQUARESIZE*2.325;
    float yoffset = SQUARESIZE*3.1;
    float dist = 1.85;
    rect(height+offset*(5/9.2), yoffset, botSide, size);
    rect(height+offset*(5/9.2), dist*yoffset, botSide, size);
    rect(height+offset*(13.4/9.2), yoffset, botSide, size);
    rect(height+offset*(13.4/9.2), dist*yoffset, botSide, size);
    rect(height+offset, yoffset, botSide, size);
    rect(height+offset, dist*yoffset, botSide, size);
    fill(0);
    int costReload = reloadCost(getReload());
    int costDamage = damageCost(getPierce());
    int costRange = rangeCost(getRadius());
    text("RANGE: " + getRadius(),height+SQUARESIZE*5.3, SQUARESIZE*4.5);
    text("DAMAGE: " + getPierce(), height+SQUARESIZE*9.6, SQUARESIZE*4.5);
    text("RELOAD: " + getReload()/(double)100, height+SQUARESIZE*13.6, SQUARESIZE*4.5);
    text("COST: " + costRange,height+SQUARESIZE*5.5, SQUARESIZE*7);
    text("COST: " + costDamage, height+SQUARESIZE*9.6, SQUARESIZE*7);
    text("COST: " + costReload, height+SQUARESIZE*13.8, SQUARESIZE*7);
  }
  
  //upgrades reload speed
  public int upReload() {
    Tower temp=whichType(getType());
    if (reload >= temp.getReload()-70) {
      reload -= 10;
      return reloadCost(reload+10);
    }
    return -1;
  }
  
  //calculates reload Cost without upgrading
  public int reloadCost(int value) {
    Tower temp=whichType(getType());
    if (value >= temp.getReload()-70) {
      return 55*(temp.getReload()-value+10);
    }
    return -1;
  }
  
  //upgrades range
  public int upRange() {
    Tower temp=whichType(getType());
    if (range <= temp.getRadius()+110) {
      range += 10;
      return rangeCost(range-10);
    }
    return -1;
  }
  
  //calculates range Cost without upgrading
  public int rangeCost(int value) {
    Tower temp=whichType(getType());
    if(value <= temp.getRadius()+110) {
      return 10*(value-temp.getRadius()+10);
    }
    return -1;
  }
  
  //upgrades damage
  public int upDamage() {
    Tower temp=whichType(getType());
    if (pierce <= temp.getPierce()+3) {
      pierce++;
      return damageCost(pierce-1);
    }
    return -1;
  }
  
  //calculates reload Cost without upgrading
  public int damageCost(int value) {
    Tower temp=whichType(getType());
    if(value <= temp.getPierce()+3) {
      return 500*(value-temp.getPierce())*value+500;
    }
    return -1;
  }
  
  //decreases the tower's range by 1 upgrade value worth
  public void deRange() {
    range-=10;
  }
  
  //decreases the tower's reload Speed by 1 upgrade value worth
  public void deSpeed() {
    reload+=10;
  }
  
  //decreases the tower's damage by 1 upgrade value worth
  public void deDamage() {
    pierce--;
  }
  
  //returns the type of tower that the String wants it to call
  public Tower whichType(String type) {
    if (type.equals("normal")) {
      return normalTower(0,0);
    }
    else if (type.equals("reload")) {
      return reloadTower(0,0);
    }
    else if (type.equals("range")) {
      return rangeTower(0,0);
    }
    else if (type.equals("damage")) {
      return damageTower(0,0);
    }
    else {
      return null;
    }
  }
  
  //sets the location the tower is at, and sets the location that their projectile originates from
  public void setLoc(int x, int y) {
    location[0] = x;
    location[1] = y;
    proj.setLoc(x, y);
  }
}
