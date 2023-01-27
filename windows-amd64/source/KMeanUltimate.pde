ArrayList<Point> points;
int k = 5;
int n = 1000;
int num[] = {-1, 1};
Centroid centroids[] = new Centroid[k];
ArrayList<Point> centers;

void setup() {
  size(800,800);
  reset();
}

void drawPoints() {
  for (Point p: points) {
    p.display();
  }
  for (Centroid c: centroids) {
    c.display();
  }
  for (Point c: centers) {
    c.display();
  }
}

float randomize(float n) {
  return n + pow(-1, int(random(2))) * random(random(0.2));
}

void reset() {
  points = new ArrayList<>();
  centers = new ArrayList<>();
  for (int i = 0; i < k; i++) {
    float _x = random(1), _y = random(1);
    centers.add(new Point(_x, _y, color(0, 0, 255)));
    Centroid cc = new Centroid();
    //cc.pos = new PVector(_x, _y);
    centroids[i] = cc;
    color c = color((int)random(255), (int)random(255), (int)random(255));
    for (int j = 0; j < n; j++) {
      float x = randomize(_x), y = randomize(_y);
      Point p = new Point(x, y, c);
      points.add(p);
    }
    
  }
}

void fitCentroids() {
  for (Centroid c: centroids) {
    c.neighbours = new ArrayList<>();
  }
  
  for (Point p: points) {
    int min_i = 0;
    float min_dist = 10e6;
    for (int i = 0; i < k; i++) {
      float d = p.pos.dist(centroids[i].pos);
      if (min_dist > d) {
        min_dist = d;
        min_i = i;
      }
    }
    centroids[min_i].addNeighbour(p);
  }
  
  for (Centroid c: centroids) {
    c.update();
  }
}

void resetCentroids() {
  for (int i = 0; i < k; i++){
    centroids[i] = new Centroid();
  }
}

void keyPressed() {
  if (keyCode == UP) {
    println("Resetting Centroid Positions");
    resetCentroids();
  } else if (keyCode == DOWN) {
    println("Resetting Setup");
    reset();
  }
}

void mousePressed() {
  fitCentroids();
}

void draw() {
  background(100);
  drawPoints();
}
