public class Tower {
  int cost, range, reload, pierce, timeWaited;
  String type;
  private int[] location;
  Projectiles proj;
  
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
  
  public boolean shoot(Map obj, Enemy enem){
    int[] towLoc = new int[] {location[0]*SQUARESIZE + SQUARESIZE/2, location[1]*SQUARESIZE + SQUARESIZE/2};
    float distance = PVector.dist(new PVector(enem.loc[0], enem.loc[1]), new PVector(towLoc[0], towLoc[1]));
    if (distance<=range && timeWaited==0) {
      PVector temp = new PVector(enem.loc[0]-towLoc[0], enem.loc[1]-towLoc[1]);
      proj.setDir(temp);
      obj.addProjectile(proj);
      timeWaited=reload;
      return true;
    }
    else {
      reduceWait();
      return false;
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
  
  public void makeTower() {
    fill(TOWER);
    circle(location[0]*SQUARESIZE+SQUARESIZE/2, location[1]*SQUARESIZE+SQUARESIZE/2, SQUARESIZE/2);
    noFill();
  }
  
  public void reduceWait() {
    if (timeWaited!=0) {
      timeWaited--;
    }
  }
}
