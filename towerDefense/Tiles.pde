public class Tiles {
  color Color;
  
  public final color PATH = color(131, 98, 12);
  public final color INVALID = color(255, 13, 13);
  public final color VALID = color(56,78,29);
  public final color TOWER = color(165);
  
  public Tiles(color image) {
    Color = image;
  }
  
  public color getColor() {
    return Color;
  }
}
