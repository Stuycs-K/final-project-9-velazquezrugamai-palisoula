public class Tower {
  int cost, range, reload, pierce;
  String type;
  int[] location;
  
  public Tower(int price, int radius, int attackSpeed, int damage, String attackType, int[] loc) {
    cost = price;
    range = radius;
    reload = attackSpeed;
    pierce = damage;
    type = attackType;
    location = loc;
  }
  
  public void shoot(){
    
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
}
