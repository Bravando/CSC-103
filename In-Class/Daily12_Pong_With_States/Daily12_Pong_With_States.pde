
float racketWidth, racketHeight, widthFromEdge, ballSize, racketSpeed, racketLeniency, ballLeniency;
int initialBallTimer;
Racket left, right;
PVector leftRacketStart, rightRacketStart, ballStart, ballSpeed;
int[] rightRacketControls= new int[2], leftRacketControls = new int[2];
PingPongBall ball;


void setup() {
  size(800, 600);
  rectMode(CENTER);
  widthFromEdge = 1/8;
  racketWidth = width/80;
  racketHeight = height/6;
  racketSpeed = 6;
  racketLeniency = 1;

  leftRacketStart = new PVector(width*widthFromEdge, height/2);
  leftRacketControls[0] = 'w';
  leftRacketControls[1] = 's';
  left = new Racket(leftRacketStart, "left", racketSpeed, leftRacketControls, new PVector(racketWidth, racketHeight), racketLeniency);

  rightRacketStart = new PVector(width*(1-widthFromEdge), height/2);
  rightRacketControls[0] = UP;
  rightRacketControls[1] = DOWN;
  right = new Racket(rightRacketStart, "right", racketSpeed, rightRacketControls, new PVector(racketWidth, racketHeight), racketLeniency);

  ballSize = 10;
  ballStart = new PVector(width/2, height/2);
  ballSpeed = new PVector(width/(800/3), height/400);
  ballLeniency = 2;
  ball = new PingPongBall(ballStart, ballSpeed, ballSize, ballLeniency);
  initialBallTimer = 150;
}


void draw() {
  background(200);

  if ((initialBallTimer == 0) && (!ball.anyWon())) {
    ball.move();
    ball.smackedHor(left);
    ball.smackedHor(right);
    initialBallTimer =  ball.score();
  } else {
    initialBallTimer--;
  }
  if(ball.anyWon()){
  ball.win();
  text(ball.winner + " wins!",130,200);
  }

  ball.make();
  left.make();
  right.make();
  left.move();
  right.move();
  textSize(120);
  fill(255,0,0);
  text(ball.scoreRight,width-99,height-50);
  text(ball.scoreLeft,40,height-50);
}
void keyPressed() {
  left.startMovement();
  right.startMovement();
}
void keyReleased() {
  left.stopMovement();
  right.stopMovement();
}
void makeSquare(float x, float y, float side, color c) {
  fill(c);
  square(x, y, side);
}

void makeRect(float x, float y, float wid, float hgt, color c) {
  fill(c);
  rect(x, y, wid, hgt);
}

void makeCircle(float x, float y, float d, color c) {
  fill(c);
  circle(x, y, d);
}

PVector addPVector(PVector a, PVector b) {
  return new PVector(a.x+b.x, a.y+b.y);
}
PVector addToPVector(float n, PVector posn) {
  return new PVector(posn.x+n, posn.y+n);
}
boolean inDist(float x, float y, float hitRadius, float foundX, float foundY){
 return (dist(x,y,foundX,foundY) < hitRadius); 
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
boolean inRectCentered(float x, float y, float wid, float hgt, float inputX, float inputY) {
  /*
  checks if the input is in the given rectangle centered at (x,y) with sides of wid and hgt
   */
  return inBounds(inputX, inputY, x-wid/2, x+wid/2, y-hgt/2, y+hgt/2);
}
boolean octogonHitSquare(float x, float y, float octoRadius, float squareLeft, float squareRight, float squareTop, float squareBottom, float leniency) {
  /*
  checks if the 8 equadistant points from the given x and y enter the rectangle boundaries
   */
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
class Dir {
  float left = 0, right = 0, up = 0, down = 0;
  boolean isLeft = false, isRight= false, isUp= false, isDown= false;
  Dir(float left, float right, float up, float down) {
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
  }
  Dir(boolean isLeft, boolean isRight, boolean isUp, boolean isDown) {
    this.isLeft = isLeft;
    this.isRight = isRight;
    this.isUp = isUp;
    this.isDown = isDown;
  }
  Dir(float left, float right, float up, float down, boolean isLeft, boolean isRight, boolean isUp, boolean isDown) {
    this.isLeft = isLeft;
    this.isRight = isRight;
    this.isUp = isUp;
    this.isDown = isDown;
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
  }
  boolean isMoving() {
    return(isLeft || isRight || isUp || isDown);
  }
}
