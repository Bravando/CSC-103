CircusTriangles bkg = new CircusTriangles();


void setup() {
  size(800, 600);
}

void draw() {
  bkg.render();
}

void mousePressed() {
  bkg.emphasisAtMouse();
}

class CircusTriangles {
  PVector center = new PVector(width/2, height/2), emphasis = center;
  float radius = width, interval = 1000, timeStart = 0, timeNow = 0;
  color[] colors = {color(255), color(255, 0, 0)};
  boolean runYet = false;
  int numOfTri = 18, whichColor = 0;

  CircusTriangles(PVector center, PVector emphasis, float radius, float rotationsPerSec, color[] colors, int numOfTri) {
    this.center = center;
    this.emphasis = emphasis;
    this.radius = radius;
    interval = 1000/rotationsPerSec;
    this.colors = colors;
    this.numOfTri = numOfTri;
  }
  CircusTriangles(PVector center, float radius, float rotationsPerSec, color[] colors, int numOfTri) {
    this.center = center;
    emphasis = center;
    this.radius = radius;
    interval = 1000/rotationsPerSec;
    this.colors = colors;
    this.numOfTri = numOfTri;
  }
  CircusTriangles() {
  }

  void render() {
    if (!runYet) {
      timeStart = millis();
      runYet = true;
    }
    timeNow = millis();
    for (int i = whichColor; i<numOfTri; i++) {
      fill(colors[i%colors.length]);
      makeTriToRadius(i);
    }
    if (timeNow >= timeStart+interval) {
      whichColor++;
      timeStart = timeNow;
    }
  }
  void makeTriToRadius(int whichTri) {
    float firstPointX = radius*cos((360/numOfTri)*(whichTri%numOfTri));
    float firstPointY = radius*sin((360/numOfTri)*(whichTri%numOfTri));

    // The "second" point is the first point of the next triangle clockwise
    float secondPointX = radius*cos((360/numOfTri)*((whichTri+1)%numOfTri));
    float secondPointY = radius*sin((360/numOfTri)*((whichTri+1)%numOfTri));

    triangle(emphasis.x, emphasis.y, firstPointX, firstPointY, secondPointX, secondPointY);
  }
  void changeEmphasis(PVector place) {
    emphasis = place;
  }
  void changeEmphasis(float x, float y) {
    emphasis = new PVector(x, y);
  }
  void emphasisAtMouse() {
    changeEmphasis(mouseX, mouseY);
  }
}
