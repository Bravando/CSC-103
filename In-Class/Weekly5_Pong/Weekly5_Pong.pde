
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
  racketWidth = 10;
  racketHeight = 100;
  racketSpeed = 6;
  racketLeniency = 1;

  leftRacketStart = new PVector(width/8, height/2);
  leftRacketControls[0] = 'w';
  leftRacketControls[1] = 's';
  left = new Racket(leftRacketStart, "left", racketSpeed, leftRacketControls, new PVector(racketWidth, racketHeight), racketLeniency);

  rightRacketStart = new PVector(width*7/8, height/2);
  rightRacketControls[0] = UP;
  rightRacketControls[1] = DOWN;
  right = new Racket(rightRacketStart, "right", racketSpeed, rightRacketControls, new PVector(racketWidth, racketHeight), racketLeniency);

  ballSize = 10;
  ballStart = new PVector(width/2, height/2);
  ballSpeed = new PVector(3, 1.5);
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
class Racket {
  PVector posn, size, trueSize;
  float speed, leniency;
  int[] keys = new int[2];
  Dir dir;
  color c = color(50);

  Racket(PVector firstPosn, String leftOrRight, float speed, int[] upDown, PVector size, float leniency) {
    posn = firstPosn;
    this.speed = speed;
    keys = upDown;
    this.size = size;
    this.leniency = leniency;
    trueSize = addToPVector(leniency, size);
    if (leftOrRight == "left") {
      dir = new Dir(true, false, false, false);
    } else {
      dir = new Dir(false, true, false, false);
    }
  }
  Racket(PVector firstPosn, String leftOrRight, float speed, int[] upDown, PVector size, float leniency, color c) {
    posn = firstPosn;
    this.speed = speed;
    keys = upDown;
    this.size = size;
    this.leniency = leniency;
    trueSize = addToPVector(leniency, size);
    if (leftOrRight == "left") {
      dir = new Dir(true, false, false, false);
    } else {
      dir = new Dir(false, true, false, false);
    }
    this.c = c;
  }

  void move() {
    if (dir.isUp) {
      posn.y=constrain(posn.y-speed, size.y/2, height-size.y/2);
    } else if (dir.isDown) {
      posn.y=constrain(posn.y+speed, size.y/2, height-size.y/2);
    }
  }
  void startMovement() {
    if (key == keys[0] || keyCode == keys[0]) {
      dir.isUp = true;
    } else if (key == keys[1] || keyCode == keys[1]) {
      dir.isDown = true;
    }
  }
  void stopMovement() {
    if (key == keys[0] || keyCode == keys[0]) {
      dir.isUp = false;
    } else if (key == keys[1] || keyCode == keys[1]) {
      dir.isDown = false;
    }
  }
  boolean hit(float inputX, float inputY) {
    /*
  checks if the input has hit the Racket
     */
    return inBounds(inputX, inputY, posn.x-size.x/2, posn.x+size.x/2, posn.y-size.y/2, posn.y+size.y/2);
  }
  void make() {
    makeRect(posn.x, posn.y, size.x, size.y, c);
  }
}




class PingPongBall {
  PVector posn, secondLastPosn, thirdLastPosn, speed, firstPosn, firstSpeed;
  float diameter, leniency, trueSize, minX = 3, maxX = 7, minY = -5, maxY = 5;
  boolean bounced = false;
  color c = color(255);
  int scoreLeft = 0, scoreRight = 0, ballTimer = 90, maxScore = 3;
  String winner = "";

  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency) {
    posn = firstPosn;
    secondLastPosn = firstPosn;
    thirdLastPosn = firstPosn;
    this.firstPosn = firstPosn;
    this.speed = speed;
    firstSpeed = speed;
    diameter = size;
    this.leniency = leniency;
    trueSize = size + leniency;
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, float ballTimer) {
    posn = firstPosn;
    secondLastPosn = firstPosn;
    thirdLastPosn = firstPosn;
    this.firstPosn = firstPosn;
    this.speed = speed;
    firstSpeed = speed;
    diameter = size;
    this.leniency = leniency;
    trueSize = size + leniency;
    this.ballTimer = int(ballTimer);
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, color c) {
    posn = firstPosn;
    secondLastPosn = firstPosn;
    thirdLastPosn = firstPosn;
    this.firstPosn = firstPosn;
    this.speed = speed;
    firstSpeed = speed;
    diameter = size;
    this.leniency = leniency;
    trueSize = size + leniency;
    this.c = c;
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, float minXSpeed, float maxXSpeed, float minYSpeed, float maxYSpeed) {
    posn = firstPosn;
    secondLastPosn = firstPosn;
    thirdLastPosn = firstPosn;
    this.firstPosn = firstPosn;
    this.speed = speed;
    firstSpeed = speed;
    diameter = size;
    this.leniency = leniency;
    trueSize = size + leniency;
    minX = minXSpeed;
    maxX = maxXSpeed;
    minY = minYSpeed;
    maxY = maxYSpeed;
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, color c, float minXSpeed, float maxXSpeed, float minYSpeed, float maxYSpeed) {
    posn = firstPosn;
    secondLastPosn = firstPosn;
    thirdLastPosn = firstPosn;
    this.firstPosn = firstPosn;
    this.speed = speed;
    firstSpeed = speed;
    diameter = size;
    this.leniency = leniency;
    trueSize = size + leniency;
    minX = minXSpeed;
    maxX = maxXSpeed;
    minY = minYSpeed;
    maxY = maxYSpeed;
    this.c = c;
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, color c, float minXSpeed, float maxXSpeed, float minYSpeed, float maxYSpeed, int ballTimer, int scoreToWin) {
    posn = firstPosn;
    secondLastPosn = firstPosn;
    thirdLastPosn = firstPosn;
    this.firstPosn = firstPosn;
    this.speed = speed;
    firstSpeed = speed;
    diameter = size;
    this.leniency = leniency;
    trueSize = size + leniency;
    minX = minXSpeed;
    maxX = maxXSpeed;
    minY = minYSpeed;
    maxY = maxYSpeed;
    this.c = c;
    this.ballTimer = ballTimer;
    maxScore = scoreToWin;
  }
  boolean didHitRacket(Racket paddle) {
    return (paddle.hit(posn.x-trueSize, posn.y) ||
      paddle.hit(posn.x+trueSize, posn.y) ||
      paddle.hit(posn.x, posn.y-trueSize) ||
      paddle.hit(posn.x, posn.y+trueSize) ||
      paddle.hit(posn.x-trueSize/sqrt(2), posn.y-trueSize/sqrt(2)) ||
      paddle.hit(posn.x+trueSize/sqrt(2), posn.y-trueSize/sqrt(2)) ||
      paddle.hit(posn.x-trueSize/sqrt(2), posn.y+trueSize/sqrt(2)) ||
      paddle.hit(posn.x+trueSize/sqrt(2), posn.y+trueSize/sqrt(2)));
  }
  void smackedHor(Racket paddle) {
    if (didHitRacket(paddle)) {
      if (paddle.dir.isRight) {
        speed.x = constrain(-abs(speed.x/*+random(-3, 3)*/), -minX, -maxX);
        if (paddle.dir.isUp) {
          speed.y -= constrain(paddle.speed, minY, maxY);
        } else if (paddle.dir.isDown) {
          speed.y += constrain(paddle.speed, minY, maxY);
        }
      } else {
        speed.x = constrain(abs(speed.x+random(-3, 3)), minX, maxX);
        if (paddle.dir.isUp) {
          speed.y -= constrain(paddle.speed, minY, maxY);
        } else if (paddle.dir.isDown) {
          speed.y += constrain(paddle.speed, minY, maxY);
        }
      }
    }
  }
  void move() {
    thirdLastPosn = secondLastPosn;
    secondLastPosn = posn;
    speed.x = constrain(speed.x,-maxX,maxX);
    if(speed.x > 0 && speed.x < minX){
     speed.x = minX; 
    }else if(speed.x < 0 && speed.x > -minX){
     speed.x = -minX; 
    }
    speed.y = constrain(speed.y,minY,maxY);
    if(speed.y > 0 && speed.y < minY){
     speed.y = minY; 
    }else if(speed.y < 0 && speed.y > minY){
     speed.y = -minY;}
    posn = addPVector(posn, speed);
    if (posn.y >= height-diameter/2) {
      posn.y = height-diameter/2;
      speed.y = -abs(speed.y);
    } else if (posn.y <= diameter/2) {
      posn.y = diameter/2;
      speed.y = abs(speed.y);
    }
  }
  void make() {
    makeCircle(thirdLastPosn.x, thirdLastPosn.y, diameter/1.2, c);
    makeCircle(secondLastPosn.x, secondLastPosn.y, diameter/1.1, c);
    makeCircle(posn.x, posn.y, diameter, c);
  }
  int score() {
    if (posn.x > width-diameter/2) {
      scoreLeft++;
      posn = firstPosn;
      secondLastPosn = firstPosn;
      thirdLastPosn = firstPosn;
      speed.y = firstSpeed.y+random(-1,1);
      speed.x = 3;
      return ballTimer;
    } else if (posn.x < diameter/2) {
      scoreRight++;
      posn = firstPosn;
      secondLastPosn = firstPosn;
      thirdLastPosn = firstPosn;
      speed.y = firstSpeed.y+random(-6,0);
      speed.x = -3;
      println(firstSpeed);
      return ballTimer;
      
    }else{return 0;}
  }
  boolean anyWon(){
    return(scoreLeft >= maxScore || scoreRight >= maxScore);
  }
  void win(){
    if(scoreLeft >= maxScore){
      winner = "Left";
    }else{
      winner = "Right";
    }
  }
}
