
float yV;
float xV;
float g;
float mouseXDisplacement;
float mouseYDisplacement;
boolean ballGrabbed;
float ballY;
float ballX;
int ballDiameter;
color ballColor;
boolean isColored;
int ballRadius;
float percentBounce;
int bgR = 0;
int bgG = 0;
int bgB = 0;
int rI = 1;
int gI = 2;
int bI = 3;


void setup() {
  size(800, 600);
  ballDiameter = 50;
  ballX = width/2;
  ballY = ballDiameter/2;
  ballColor = color(100);
  isColored = false;
  g = 9.8;
  yV = 0;
  ballRadius = ballDiameter/2;
  textSize(30);
  percentBounce = 0.8;
}

void draw() {
  background(bgR, bgG, bgB);
  if (isColored) {
    shiftBkgColors();
  }
  fill(ballColor);
  stroke(ballColor);


  text("Spacebar to reset", 100, 200);
  if (isColored) {
    fill(234, 24, 24);
    text("Press \"C\" to change color | Uses: 0", 100, 400);
    fill(ballColor);
  } else {
    text("Press \"C\" to change color | Uses: 1", 100, 400);
  }

  if (!ballGrabbed) {
    yV = yV+(g/60);
  } else {
    ballX = mouseX-mouseXDisplacement;
    ballY = mouseY-mouseYDisplacement;
  }
  fall();
  if (ballY >= height-ballRadius && !ballGrabbed) {
    yV = constrain(-yV*percentBounce, -50, 25);
    xV = xV*.9;
    ballY = height-ballRadius;
  } else if (ballY <= ballRadius && !ballGrabbed) {
    yV = constrain(-yV*percentBounce, -50, 25);
    xV = xV*.9;
    ballY = ballRadius;
  } else if (ballX >= width-ballRadius && !ballGrabbed) {
    xV = -xV*percentBounce;
    yV = yV*.9;
    ballX = width-ballRadius;
  } else if (ballX <= ballRadius && !ballGrabbed) {
    xV = -xV*percentBounce;
    yV = yV*.9;
    ballX = ballRadius;
  } else {
    xV = xV*.99;
  }
  circle(ballX, ballY, ballDiameter);
}
//void incrementColor(int colorValue,int increment){
//    colorValue = colorValue + increment;
//  if (colorValue >= 255) {
//    increment = -increment;
//  }
//  if (colorValue <= 0) {
//    increment = -increment;
//  }
//}

void onClick() {
  ballY = ballDiameter/2;
}

void keyPressed() {
  if (key == ' ') {
    resetBall();
  } else if (isColored == false && key == 'c') {
    ballColor = color(random(255), random(255), random(255));
    isColored = true;
  }
}

void fall() {
  ballY = ballY+yV;
  ballX = ballX+xV;
}

void mousePressed() {
  ballGrabbed = roundHitboxMoused(ballX, ballY, ballDiameter);
  mouseXDisplacement = mouseX-ballX;
  mouseYDisplacement = mouseY-ballY;
  //if(ballGrabbed){
  //  println("Grab!");
  //}
  //else{
  // println("Miss!");
  //}
}
void invertColorIncrement(int C, int I) {
  if (C >= 255) {
    I = -I;
  }
  if (C <= 0) {
    I = -I;
  }
}

void shiftBkgColors() {
  bgR = bgR + rI;
  if (bgR >= 255) {
    rI = -rI;
  }
  if (bgR <= 0) {
    rI = -rI;
  }

  bgG = bgG + gI;
  if (bgG >= 255) {
    gI = -gI;
  }
  if (bgG <= 0) {
    gI = -gI;
  }

  bgB = bgB + bI;
  if (bgB >= 255) {
    bI = -bI;
  }
  if (bgB <= 0) {
    bI = -bI;
  }
}

boolean inDistance(float centerX, float centerY, float checkedX, float checkedY, float distance) {
  /*
  Checks if a given point is within a given distance of another point
   */
  return distance >= dist(centerX, centerY, checkedX, checkedY); //(sqrt(sq(checkedX-centerX)+sq(checkedY-centerY)));
}
boolean roundHitboxMoused(float centerX, float centerY, float size) {
  /*
  Checks if the mouse is in a given distance of the given point
   */
  return inDistance(centerX, centerY, mouseX, mouseY, size);
}

void mouseReleased() {
  ballGrabbed = false;
}

void mouseDragged() {
  if (ballGrabbed) {
    xV = mouseXMovement();
    yV = mouseYMovement();
  }
}

void resetBall() {
  ballY = ballRadius;
  yV = 0;
  ballX = width/2;
  xV = 0;
}
float mouseXMovement() {
  return mouseX-pmouseX;
}
float mouseYMovement() {
  return mouseY-pmouseY;
}
float totalMouseMovement() {
  return dist(mouseX, mouseY, pmouseX, pmouseY);
}
