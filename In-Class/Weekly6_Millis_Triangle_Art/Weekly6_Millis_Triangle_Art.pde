CircusTriangles forAssignment,good;
PVector center = new PVector(width/2,height/2);


void setup() {
  size(800, 600);
  forAssignment = new CircusTriangles(width,height);
  good = new CircusTriangles();
  center = new PVector(width/2,height/2);
  noStroke();
}

void draw() {
  background(42);
  forAssignment.render();
  //good.render();
  //drawTriRowFromTo(center,0,width,0,4,color(255),color(255,0,0));    // For testing purposes
}

void mousePressed() {
  forAssignment.emphasisAtMouse();
  //good.emphasisAtMouse();
}

void drawTriRowFromTo(PVector tip, float startX, float endX,float y, int number,color c1, color c2){
  float howFar = endX-startX;
 for(int i = 0;i<number;i++){
   if(i%2 == 0){
     fill(c1);
   }else{
     fill(c2);
   }
   triangle(tip.x,tip.y,startX+(howFar/number)*i,y,startX+(howFar/number)*(i+1),y);
 }
}

class CircusTriangles {
  PVector center = new PVector(width/2, height/2), emphasis = center, side = new PVector(width,height);
  float radius = width*0.66, interval = 500, timeStart = 0, timeNow = 0;
  color[] colors = {color(255), color(255, 0, 0)};
  boolean runYet = false, isRectBound = false;
  int numOfTri = 18, whichColor = 0, initialColor = 0;

  CircusTriangles(PVector center, PVector emphasis, float radius, float rotationsPerSec, color[] colors, int numOfTri) {
    this.center = center;
    this.emphasis = emphasis;
    this.radius = radius;
    interval = 1000/rotationsPerSec;
    this.colors = colors;
    this.numOfTri = numOfTri;
  }
   CircusTriangles(PVector center, PVector emphasis, float wid, float hgt, float rotationsPerSec, color[] colors, int numOfTri) {
    this.center = center;
    this.emphasis = emphasis;
    side.x = wid;
    side.y = hgt;
    isRectBound = true;
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
    center = new PVector(width/2, height/2);
  }
  CircusTriangles(float wid, float hgt) {
    side.x = wid;
    side.y = hgt;
    isRectBound = true;
    center = new PVector(width/2, height/2);
  }
  CircusTriangles() {
    center = new PVector(width/2, height/2);
  }
  
  void render(){
    if(isRectBound){
      renderRectBound();
    }else{
     renderCircleBound(); 
    }
  }
  
  void renderRectBound(){
    if (!runYet) {
      timeStart = millis();
      runYet = true;
    }
    timeNow = millis();
    if (timeNow >= timeStart+interval) {
      initialColor++;
      timeStart = timeNow;
    }
    whichColor = initialColor;
    whichColor = drawTris(whichColor,true,true);
    whichColor = drawTris(whichColor,false,false);
    whichColor = drawTris(whichColor,true,false);
    drawTris(whichColor,false,true);
  }
  int drawTris(int starter, boolean isAcross, boolean isStartingTopLeft){
    int trisAcross = int((side.x*numOfTri)/((side.y+side.x)*2)), trisDown = numOfTri/2-trisAcross,start = starter+1, i = start;
    if(isAcross){
      if(isStartingTopLeft){
        while(i<trisAcross+start){
          fill(colors[i%colors.length]);
          triangle(emphasis.x,emphasis.y,
          center.x-(side.x/2)+(side.x/trisAcross)*(i-start),center.y-side.y/2,
          center.x-(side.x/2)+(side.x/trisAcross)*(i+1-start),center.y-side.y/2);
          i++;
     }
     }else{
       while(i<trisAcross+start){
          fill(colors[i%colors.length]);
          triangle(emphasis.x,emphasis.y,
          center.x+side.x/2-(side.x/trisAcross)*(i-start),center.y+side.y/2,
          center.x+side.x/2-(side.x/trisAcross)*(i+1-start),center.y+side.y/2);
          i++;
     }
     }
    }else{
      if(isStartingTopLeft){
        while(i<trisDown+start){
          fill(colors[i%colors.length]);
          triangle(emphasis.x,emphasis.y,
          center.x+side.x/2,center.y-side.y/2+(side.y/trisDown)*(i-start),
          center.x+side.x/2,center.y-side.y/2+(side.y/trisDown)*(i+1-start));
          i++;
     }
     }else{
       while(i<trisDown+start){
          fill(colors[i%colors.length]);
          triangle(emphasis.x,emphasis.y,
          center.x-side.x/2,center.y+side.y/2-(side.y/trisDown)*(i-start),
          center.x-side.x/2,center.y+side.y/2-(side.y/trisDown)*(i+1-start));
          i++;
     }
     }
    }
    return i;
  }

  void renderCircleBound() {
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
