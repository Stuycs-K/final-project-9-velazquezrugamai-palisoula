public class Tiles {
  color Color;
  
  final color PATH = color(131, 98, 12);
  final color INVALID = color(255, 13, 13);
  final color VALID = color(67, 237, 128);
  final color Tower = color(165);
  
  public Tiles(color image) {
    Color = image;
  }
  
  public color getColor() {
    return Color;
  }
}
