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
    int[] towLoc = new int[] {location[0]*SQUARESIZE + SQUARESIZE/2, location[1]*SQUARESIZE + SQUARESIZE/2};
    PVector enemy = new PVector(enem.loc[0], enem.loc[1]);
    PVector tower = new PVector(towLoc[0], towLoc[1]);
    float distance = PVector.dist(enemy, tower);
    if (distance<=range && timeWaited==0) {
      PVector temp = new PVector(enem.loc[0]-towLoc[0], enem.loc[1]-towLoc[1]);
      proj.setDir(temp);
      obj.addProjectile(proj.copy());
      timeWaited=reload;
      return true;
    }
    return false;
  }
  
  //Draws the tower in Processing
  public void makeTower() {
    fill(TOWER);
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
  
  public void menu() {
    Tower temp = normalTower(0,0);
    fill(255, 0, 0);
    rect(height+SQUARESIZE*5, SQUARESIZE*3+5, DIFF-SQUARESIZE*6.975, SQUARESIZE*4.65);
    fill(0);
    text("RANGE: " + getRadius(),height+SQUARESIZE*5.5, SQUARESIZE*4.5);
    text("DAMAGE: " + getPierce(), height+SQUARESIZE*9.5, SQUARESIZE*4.5);
    text("RELOAD: " + getReload()/(double)100, height+SQUARESIZE*13.5, SQUARESIZE*4.5);
    if (temp.getType().equals("norm")) {
      temp=normalTower(0,0);
    }
    text("COST: " + 10*(getRadius()-temp.getRadius()+1),height+SQUARESIZE*5.5, SQUARESIZE*7);
    text("COST: " + 500*(getPierce()-temp.getPierce()+1)*(getPierce()-temp.getPierce()+1), height+SQUARESIZE*9.5, SQUARESIZE*7);
    text("COST: " + 55*(getReload()-temp.getReload()+5), height+SQUARESIZE*13.5, SQUARESIZE*7);
  }
}
