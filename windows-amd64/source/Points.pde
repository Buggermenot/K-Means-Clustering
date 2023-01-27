public class Points {
  PVector pos;
  color c;
  Points (float x, float y, color co) {
    pos = new PVector(x, y);
    c = co;
  }
  
  void display () {
    fill(this.c);
    stroke(0);
    circle(this.pos.x * width, this.pos.y * height, 10);
  }
}
