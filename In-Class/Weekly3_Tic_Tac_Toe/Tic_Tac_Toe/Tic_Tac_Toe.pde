
float cellSize;
float lineLength;
float ofCell;
color oC;
color xC;
color bkg;
int topLeft;
int topMid;
int topRight;
int midLeft;
int midMid;
int midRight;
int botLeft;
int botMid;
int botRight;
float leftX;
float farLeftX;
float rightX;
float farRightX;
float topY;
float farTopY;
float botY;
float farBotY;
boolean xLast;
boolean announced;

void setup() {
  size(800, 600);

  cellSize = 150;
  lineLength = cellSize*3;
  ofCell = 0.8;
  oC = color(#38FA2B);
  xC = color(#DE1414);
  bkg = color(100);
  background(bkg);
  topLeft = 0;
  topMid = 0;
  topRight = 0;
  midLeft = 0;
  midMid = 0;
  midRight = 0;
  botLeft = 0;
  botMid = 0;
  botRight = 0;
  leftX = (width-cellSize)/2;
  farLeftX = (width-lineLength)/2;
  rightX = (width+cellSize)/2;
  farRightX = (width+lineLength)/2;
  topY = (height-cellSize)/2;
  farTopY = (height-lineLength)/2;
  botY = (height+cellSize)/2;
  farBotY = (height+lineLength)/2;
  xLast = false;
  announced = false;
  stroke(255);
  drawTikTakToeBoard(cellSize, lineLength);
}

void draw() {
  if (!noWinner() && !announced) {
    if(xLast){
      fill(xC);
      textSize(150);
      text("X Wins",200,height/2,10);
      println("X Wins!");
      announced = true;
    }
    else{
      fill(oC);
      textSize(150);
      text("O Wins",200,height/2,10);
      println("0 Wins!");
      announced = true;
    }
  }
  if(cat()){
    fill(200);
      textSize(100);
      text("Nobody Wins :(",75,height/2,10);
      println("Nobody Wins!");
  }
}

void drawTikTakToeBoard(float cellSize, float lineLength) {

  line((width-cellSize)/2, (height-lineLength)/2, (width-cellSize)/2, (height+lineLength)/2);
  line((width+cellSize)/2, (height-lineLength)/2, (width+cellSize)/2, (height+lineLength)/2);
  line((width-lineLength)/2, (height-cellSize)/2, (width+lineLength)/2, (height-cellSize)/2);
  line((width-lineLength)/2, (height+cellSize)/2, (width+lineLength)/2, (height+cellSize)/2);
}

void drawXShape(float midX, float midY, float cellSize, float ofCell, color xC) {
  stroke(xC);
  line(midX-(cellSize/2*ofCell), midY-(cellSize/2*ofCell), midX+(cellSize/2*ofCell), midY+(cellSize/2*ofCell));
  line(midX-(cellSize/2*ofCell), midY+(cellSize/2*ofCell), midX+(cellSize/2*ofCell), midY-(cellSize/2*ofCell));
}

void drawOShape(float midX, float midY, float cellSize, float ofCell, color oC, color bkg) {
  noFill();
  stroke(oC);
  circle(midX, midY, cellSize*ofCell);
}

void mousePressed() {
  if (noWinner()) {
    placeTik();
  }
}

boolean placeTaken(int place) {
  /*
  checks if the place is occupied by checking if it is greater than 0
   */

  return place > 0;
}
int placeLocation(int place, float leftBound, float topBound) {
  if (!placeTaken(place)) {
    if (xLast) {
      drawOShape(leftBound+cellSize/2, topBound+cellSize/2, cellSize, ofCell, oC, bkg);
      xLast = !xLast;
      return 2;
    } else {
      drawXShape(leftBound+cellSize/2, topBound+cellSize/2, cellSize, ofCell, xC);
      xLast = !xLast;
      return 1;
    }
  } else {
    return place;
  }
}

boolean inTicTacBounds(float x, float y) {
  return inBounds(x, y, farLeftX, farRightX, farTopY, farBotY);
}

boolean inBounds(float x, float y, float leftBound, float rightBound, float topBound, float bottomBound) {
  return ((leftBound < x) && (x < rightBound) && (topBound < y) && (y < bottomBound));
}
boolean mouseInBounds(float leftBound, float rightBound, float topBound, float bottomBound) {
  return inBounds(mouseX, mouseY, leftBound, rightBound, topBound, bottomBound);
}
boolean noWinner() {
  return !(win(topLeft,topMid,topRight) ||
    win(midLeft,midMid,midRight) ||
    win(botLeft,botMid,botRight) ||
    win(topLeft,midLeft,botLeft) ||
    win(topMid,midMid,botMid) ||
    win(topRight,midRight,botRight) ||
    win(topLeft,midMid,botRight) ||
    win(botLeft,midMid,topRight));
}
boolean cat(){
  return !((topLeft == 0)||
  (midLeft == 0)||
  (botLeft == 0)||
  (topMid == 0)||
  (midMid == 0)||
  (botMid == 0)||
  (topRight == 0)||
  (midRight == 0)||
  (botRight == 0));
}

boolean win(int place1, int place2, int place3){
  return (!(place1 == 0) || !(place2 == 0) || !(place3 == 0)) &&
         (place1 == place2) && (place2 == place3) && (place1 == place3);
}

void placeTik() {
  if (mouseInBounds(farLeftX, leftX, farTopY, topY)) {
    topLeft = placeLocation(topLeft, farLeftX, farTopY);
    println(topLeft);
  }
  if (mouseInBounds(farLeftX, leftX, topY, botY)) {
    midLeft = placeLocation(midLeft, farLeftX, topY);
    println(midLeft);
  }
  if (mouseInBounds(farLeftX, leftX, botY, farBotY)) {
    botLeft = placeLocation(botLeft, farLeftX, botY);
    println(botLeft);
  }
  if (mouseInBounds(leftX, rightX, farTopY, topY)) {
    topMid = placeLocation(topMid, leftX, farTopY);
    println(topMid);
  }
  if (mouseInBounds(leftX, rightX, topY, botY)) {
    midMid = placeLocation(midMid, leftX, topY);
    println(midMid);
  }
  if (mouseInBounds(leftX, rightX, botY, farBotY)) {
    botMid = placeLocation(botMid, leftX, botY);
    println(botMid);
  }
  if (mouseInBounds(rightX, farRightX, farTopY, topY)) {
    topRight = placeLocation(topRight, rightX, farTopY);
    println(topRight);
  }
  if (mouseInBounds(rightX, farRightX, topY, botY)) {
    midRight = placeLocation(midRight, rightX, topY);
    println(midRight);
  }
  if (mouseInBounds(rightX, farRightX, botY, farBotY)) {
    botRight = placeLocation(botRight, rightX, botY);
    println(botRight);
  }
}
