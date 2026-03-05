CircusTriangles bkg;


void setup() {
  size(800, 600);
  bkg = new CircusTriangles();
}

void draw() {
  background(42);
  bkg.render();
}

void mousePressed() {
  bkg.emphasisAtMouse();
}

class CircusTriangles {
  PVector center = new PVector(width/2, height/2), emphasis = center;
  float radius = width, interval = 500, timeStart = 0, timeNow = 0;
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
  CircusTriangles(float rotationsPerSec) {
    interval = 1000/rotationsPerSec;
  }
  CircusTriangles() {
  }

  void render() {
    if (!runYet) {
      timeStart = millis();
      runYet = true;
    }
    timeNow = millis();
    for (int i = whichColor; i<numOfTri+whichColor; i++) {
      fill(colors[i%colors.length]);
      makeTriToRadius(i-whichColor);
    }
    if (timeNow >= timeStart+interval) {
      whichColor++;
      timeStart = timeNow;
    }
  }
  
  void makeTriToRadius(int whichTri) {
    float firstPointX = center.x+radius*cos((TWO_PI/numOfTri)*(whichTri%numOfTri));
    float firstPointY = center.y-radius*sin((TWO_PI/numOfTri)*(whichTri%numOfTri));
    
    // The "second" point is the first point of the next triangle clockwise
    float secondPointX = center.x+radius*cos((TWO_PI/numOfTri)*((whichTri+1)%numOfTri));
    float secondPointY = center.y-radius*sin((TWO_PI/numOfTri)*((whichTri+1)%numOfTri));
    
    triangle(emphasis.x, emphasis.y, firstPointX, firstPointY, secondPointX, secondPointY);
  }
  //float correctAngleAroundCircle(PVector angle,boolean xInverted,boolean yInverted){
  //  for(int i = 0;i<angle%90;i++){
  //   if(i%2 == 0){
  //    xInverted = !xInverted;
  //   }else{
  //    yInverted = !yInverted; 
  //   }
  //  }
  //  if(
  //}
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
