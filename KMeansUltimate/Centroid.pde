public class Centroid {
  PVector pos;
  float radius;
  ArrayList<Point> neighbours;
  
  Centroid() {
    pos = new PVector(random(1), random(1));
    radius = 0;
    neighbours = new ArrayList<>();
  }
  
  void update() {
    setPos();
    setRadius();
  }
  
  void setPos() {
    // Sets the position of the centroid to the average of neighbour points.
    
    this.pos = new PVector(0,0);
    for (Point p : this.neighbours) {
      this.pos.add(p.pos);
    }
    this.pos.div(this.neighbours.size());
  }
  
  void setRadius() {
    // Sets the radius of the centroid to the distance to the farthest point.
    
    this.radius = 0;
    for (Point p : this.neighbours) {
      float r = p.pos.dist(this.pos);
      this.radius = this.radius < r ? r : this.radius;
    }
  }
  
  void connectPoints() {
    fill(0, 255, 0);
    stroke(0, 255, 0);
    for(Point p: this.neighbours){
      line(p.pos.x*width, p.pos.y*height, this.pos.x*width, this.pos.y*height);
    }
  }
  
  void addNeighbour(Point p) {
    int i = 0;
    for (; i < this.neighbours.size(); i++) {
      if (calcAngle(p.pos) < calcAngle(this.neighbours.get(i).pos)) {
        break;
      }
    }
    this.neighbours.add(i, p);
  }
  
  float calcAngle(PVector p) {
    return degrees(atan2( (this.pos.y - p.y), (this.pos.x - p.x) ));
  }
  
  void display() {
    // Coverage Area
    circle(this.pos.x * width, this.pos.y * height, 2*this.radius*width);
    fill(0, 255, 0);
    
    // Centroid Center
    circle(this.pos.x * width, this.pos.y * height, 10);
    connectPoints();
  }
  
  //connectPoints();
}
