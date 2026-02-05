
  int headD = 100;

void setup() {
  size(800, 600);
  background(42);
  rectMode(CENTER);
}


void draw() {
  background(42);
  //drawRedCircle();
  // calling my functions
  drawPerson(headD);
  drawHat();
  drawMonocle();
}

//void mousePressed(){
//  drawRedCircle();
//}


void drawRedCircle() {
  fill(255, 0, 0);
  circle(mouseX, mouseY, 50);
}

void drawPerson(int headD) {
  /*
   This function draws a person that is cool.
   */


  // head variables
  int headX = width/2;
  int headY = height/2;

  // torso vars (includes neck and hip)
  int torsoLength = 200;
  int neckX = headX;
  int neckY = headY + headD/2;
  int hipX = headX;
  int hipY = neckY + torsoLength;


  // arm vars
  int armSpan = 200;
  int leftArmX = headX - armSpan/2;
  int leftArmY = headY + headD/2;
  int rightArmX = headX + armSpan/2;
  int rightArmY = headY + headD/2;


  // draw head
  stroke(255);
  strokeWeight(1);
  fill(#9229FC);
  circle(headX, headY, headD);
  line(leftArmX, leftArmY, rightArmX, rightArmY);
  line(neckX, neckY, hipX, hipY);
}



void drawHat() {
  // declare hat vars
  // head variables
  int headD = 100;
  int headX = width/2;
  int headY = height/2;

  int brimX;
  int brimY;
  int brimW;
  int brimH;

  int crownX;
  int crownY;
  int crownW;
  int crownH;

  // initialize my hat vars
  brimX = headX;
  brimY = headY - headD/2;
  brimW = 200;
  brimH = 35;

  crownW = 100;
  crownH = 200;
  crownX = headX; // crownX = headX - crownW/2;
  crownY = brimY - crownH/2; // crownY = headY - headD/2 - crownH/2

  // draw the brim
  fill(0);
  strokeWeight(1);
  ellipse(brimX, brimY, brimW, brimH);
  // draw the crown
  rect(crownX, crownY, crownW, crownH, 10);
}

void drawMonocle() {
  // declare my vars
  int monocleX;
  int monocleY;
  int monocleD;

  // head variables
  int headD = 100;
  int headX = width/2;
  int headY = height/2;

  // initialize my vars
  monocleX = headX + headD/4;
  monocleY = headY - headD/8;
  monocleD = 25;

  // draw my monocle
  noFill();
  strokeWeight(3);
  circle(monocleX, monocleY, monocleD);
}
