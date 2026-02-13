color bkg = color(0);
PVector sPosn;
float sSide;
color sC;
float sLeft;
float sRight;
float sTop;
float sBottom;
float leniency;

PVector c1;
float cD1;
color cC1;
PVector c2;
float cD2;
color cC2;
PVector c3;
float cD3;
color cC3;

float pSpeed;
boolean isUp = false;
boolean isDown = false;
boolean isLeft = false;
boolean isRight = false;


void setup() {
  size(800, 600);
  rectMode(CENTER);
  sPosn = new PVector(width/2, height/2);
  sSide = height/6;
  sLeft = sPosn.x-sSide;
  sRight = sPosn.x+sSide;
  sTop = sPosn.y-sSide;
  sBottom = sPosn.y+sSide;
  leniency = 3;
  
  c1 = new PVector(width/6, height/5);
  cD1 = height*.3;
  cC1 = color(255, 100, 0);
  c2 = new PVector(width/1.2, height/1.1);
  cD2 = height*.1;
  cC2 = color(200, 50, 200);
  c3 = new PVector(width/1.1, height/4);
  cD3 = width*.1;
  cC3 = color(0, 100, 255);
  
  pSpeed = 4;
}

void draw() {
  background(bkg);
  sC = color(0, 255, 0);
  
  movePlayer();

  makeCircle(c1.x, c1.y, cD1, cC1);
  circleWasHit(c1.x, c1.y, cD1, cC1, sPosn.x, sPosn.y, sSide, leniency);

  makeCircle(c2.x, c2.y, cD2, cC2);
  circleWasHit(c2.x, c2.y, cD2, cC2, sPosn.x, sPosn.y, sSide, leniency);

  makeCircle(c3.x, c3.y, cD3, cC3);
  circleWasHit(c3.x, c3.y, cD3, cC3, sPosn.x, sPosn.y, sSide, leniency);


  makeSquare(sPosn.x, sPosn.y, sSide, sC);
  //sPosn.x += 1;
}




void makeSquare(float x, float y, float side, color c) {
  fill(c);
  square(x, y, side);
}

void makeCircle(float x, float y, float d, color c) {
  fill(c);
  circle(x, y, d);
}

void circleWasHit(float cX, float cY, float cD, color cC, float sX, float sY, float sS, float leniency) {
  if (circleHitSquare(cX, cY, cD, sX, sY, sS, leniency)) {
    sC = color(cC);
  }
}

boolean circleHitSquare(float cX, float cY, float cD, float sX, float sY, float sS, float leniency) {
  return octogonHitSquare(cX, cY, cD/2, sX-sS/2, sX+sS/2, sY-sS/2, sY+sS/2, leniency);
}

boolean squareHitSquare(float l1, float r1, float t1, float b1, float l2, float r2, float t2, float b2, float leniency) {
  return (l1+leniency <= r2 && r1-leniency >= l2 && t1+leniency <= b2 && b1+leniency >= t2);
}

boolean octogonHitSquare(float x, float y, float octoRadius, float squareLeft, float squareRight, float squareTop, float squareBottom, float leniency) {
  float hitRadius = octoRadius+leniency;
  return (inBounds(x-hitRadius, y, squareLeft, squareRight, squareTop, squareBottom) ||
    inBounds(x+hitRadius, y, squareLeft, squareRight, squareTop, squareBottom) ||
    inBounds(x, y-hitRadius, squareLeft, squareRight, squareTop, squareBottom) ||
    inBounds(x, y+hitRadius, squareLeft, squareRight, squareTop, squareBottom) ||
    inBounds(x-hitRadius/sqrt(2), y-hitRadius/sqrt(2), squareLeft, squareRight, squareTop, squareBottom) ||
    inBounds(x+hitRadius/sqrt(2), y-hitRadius/sqrt(2), squareLeft, squareRight, squareTop, squareBottom) ||
    inBounds(x-hitRadius/sqrt(2), y+hitRadius/sqrt(2), squareLeft, squareRight, squareTop, squareBottom) ||
    inBounds(x+hitRadius/sqrt(2), y+hitRadius/sqrt(2), squareLeft, squareRight, squareTop, squareBottom));
}

boolean inBounds(float x, float y, float leftBound, float rightBound, float topBound, float bottomBound) {
  /*
  checks if the given input is within all four bounds
   */
  return ((leftBound <= x) && (x <= rightBound) && (topBound <= y) && (y <= bottomBound));
}

boolean inSquareCentered(float x, float y, float side, float inputX, float inputY) {
  /*
  checks if the input is in the given square centered at (x,y) with sides of side
   */
  return inBounds(inputX, inputY, x-side, x+side, y-side, y+side);
}


boolean inDistance(float centerX, float centerY, float checkedX, float checkedY, float distance) {
  /*
  Checks if a given point is within a given distance of another point
   */
  return distance >= dist(centerX, centerY, checkedX, checkedY);
}
void startMovement() {
  if (key == 'w') {
    isUp = true;
  } else if (key == 's') {
    isDown = true;
  }
  if (key == 'a') {
    isLeft = true;
  } else if (key == 'd') {
    isRight = true;
  }
  if (key == CODED) {
    if (keyCode == UP) {
      isUp = true;
    } else if (keyCode == DOWN) {
      isDown = true;
    }
    if (keyCode == LEFT) {
      isLeft = true;
    } else if (keyCode == RIGHT) {
      isRight = true;
    }
  }
}
void stopMovement() {
  if (key == 'w') {
    isUp = false;
  } else if (key == 's') {
    isDown = false;
  }
  if (key == 'a') {
    isLeft = false;
  } else if (key == 'd') {
    isRight = false;
  }
  if (key == CODED) {
    if (keyCode == UP) {
      isUp = false;
    } else if (keyCode == DOWN) {
      isDown = false;
    }
    if (keyCode == LEFT) {
      isLeft = false;
    } else if (keyCode == RIGHT) {
      isRight = false;
    }
  }
}
void keyPressed() {
  startMovement();
}

void keyReleased() {
  stopMovement();
}

void movePlayer() {
  if (isUp) {
    sPosn.y -= pSpeed;
  }
  if (isDown) {
    sPosn.y += pSpeed;
  }
  if (isLeft) {
    sPosn.x -= pSpeed;
  }
  if (isRight) {
    sPosn.x += pSpeed;
  }
}
