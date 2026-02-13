color bkg = color(0);
PVector sPosn;
float sSide;
color sC;
float sLeft;
float sRight;
float sTop;
float sBottom;

float circleD;
color circleC;


void setup(){
  size(800,600);
  rectMode(CENTER);
  sPosn = new PVector(width/2,height/2);
  sSide = 300;
  sLeft = sPosn.x-sSide;
  sRight = sPosn.x+sSide;
  sTop = sPosn.y-sSide;
  sBottom = sPosn.y+sSide;
  
  
  circleD = 100;
  circleC = color(255,100,0);
  
}

void draw(){
 background(bkg); 
 sC = color(0,255,0);
 
 squareWasHit(mouseX,mouseY,circleD,sPosn.x,sPosn.y,sSide);
 makeSquare(sPosn.x,sPosn.y,sSide,sC);
 makeCircle(mouseX,mouseY,circleD,circleC);
 //squarePosn.x += 1;
 
 
}




void makeSquare(float x,float y,float side,color c){
 fill(c);
 square(x,y,side);
}

void makeCircle(float x,float y,float d,color c){
  fill(c);
  circle(x,y,d);
}

void squareWasHit(float cX,float cY,float cD,float sX,float sY,float sS){
  if(octogonHitSquare(cX,cY,cD/2,sX-sS/2,sX+sS/2,sY-sS/2,sY+sS/2)){
   sC = color(255,0,0); 
  }
}

boolean squareHitSquare(float l1, float r1, float t1, float b1, float l2, float r2, float t2, float b2){
 return (l1 <= r2 && r1 >= l2 && t1 <= b2 && t2 >= b1);
}
boolean octogonHitSquare(float x,float y, float octoRadius,float squareLeft,float squareRight,float squareTop,float squareBottom){
  return (inBounds(x-octoRadius,y,squareLeft,squareRight,squareTop,squareBottom) ||
          inBounds(x+octoRadius,y,squareLeft,squareRight,squareTop,squareBottom) ||
          inBounds(x,y-octoRadius,squareLeft,squareRight,squareTop,squareBottom) ||
          inBounds(x,y+octoRadius,squareLeft,squareRight,squareTop,squareBottom) ||
          inBounds(x-octoRadius/sqrt(2),y-octoRadius/sqrt(2),squareLeft,squareRight,squareTop,squareBottom) ||
          inBounds(x+octoRadius/sqrt(2),y-octoRadius/sqrt(2),squareLeft,squareRight,squareTop,squareBottom) ||
          inBounds(x-octoRadius/sqrt(2),y+octoRadius/sqrt(2),squareLeft,squareRight,squareTop,squareBottom) ||
          inBounds(x+octoRadius/sqrt(2),y+octoRadius/sqrt(2),squareLeft,squareRight,squareTop,squareBottom));
}

boolean inBounds(float x, float y, float leftBound, float rightBound, float topBound, float bottomBound) {
  return ((leftBound <= x) && (x <= rightBound) && (topBound <= y) && (y <= bottomBound));
}

boolean inSquareCentered(float x,float y,float side,float inputX,float inputY){
  return inBounds(inputX,inputY,x-side,x+side,y-side,y+side);
}


boolean inDistance(float centerX, float centerY, float checkedX, float checkedY, float distance) {
  /*
  Checks if a given point is within a given distance of another point
   */
  return distance >= dist(centerX, centerY, checkedX, checkedY);
}
