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
