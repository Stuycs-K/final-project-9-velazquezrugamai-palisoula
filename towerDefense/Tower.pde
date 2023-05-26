public class Tower {
  int cost, range, reload, pierce, timeWaited;
  String type;
  private final int[] location;
  Projectiles proj;
  
  public Tower(int price, int radius, int attackSpeed, int damage, String attackType, int[] loc, Projectiles pro) {
    cost = price;
    range = radius;
    reload = attackSpeed;
    pierce = damage;
    type = attackType;
    location = loc;
    proj = pro;
  }
  
  public void shoot(Map obj, Enemy enem){
    float distance = PVector.dist(new PVector(enem.loc[0], enem.loc[1]), new PVector(location[0]*SQUARESIZE, location[1]*SQUARESIZE));
    if (distance<=range && timeWaited==0) {
      PVector temp = new PVector(enem.loc[0]-location[0]*SQUARESIZE, enem.loc[1]-location[1]*SQUARESIZE);
      proj.setDir(temp.normalize());
      obj.addProjectile(proj);
      timeWaited=reload;
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
    fill(color(165));
    circle(location[0]*SQUARESIZE+SQUARESIZE/2, location[1]*SQUARESIZE+SQUARESIZE/2, SQUARESIZE/2);
    noFill();
  }
  
  public void reduceWait() {
    timeWaited--;
    if (timeWaited<0) {
      timeWaited=0;
    }
  }
}
