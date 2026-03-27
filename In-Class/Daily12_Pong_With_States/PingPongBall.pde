class PingPongBall {
  PVector posn, secondLastPosn, thirdLastPosn, speed, firstPosn, firstSpeed;
  float diameter, leniency, trueSize, minX = 3, maxX = 7, minY = -5, maxY = 5, millisBeforeMove = 1000, currentTime = 0, initialTime = 0;
  boolean bounced = false, isActive = true;
  color c = color(255);
  int ballTimer = 90, maxScore = 3;
  Racket left, right;

  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, Racket left, Racket right) {
    posn = firstPosn;
    secondLastPosn = firstPosn;
    thirdLastPosn = firstPosn;
    this.firstPosn = firstPosn;
    this.speed = speed;
    firstSpeed = speed;
    diameter = size;
    this.leniency = leniency;
    trueSize = size + leniency;
    this.left = left;
    this.right = right;
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, float ballTimer, Racket left, Racket right) {
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
    this.left = left;
    this.right = right;
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, color c, Racket left, Racket right) {
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
    this.left = left;
    this.right = right;
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency,
    float minXSpeed, float maxXSpeed, float minYSpeed, float maxYSpeed, Racket left, Racket right) {
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
    this.left = left;
    this.right = right;
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, color c,
    float minXSpeed, float maxXSpeed, float minYSpeed, float maxYSpeed, Racket left, Racket right) {
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
    this.left = left;
    this.right = right;
  }
  PingPongBall(PVector firstPosn, PVector speed, float size, float leniency, color c,
    float minXSpeed, float maxXSpeed, float minYSpeed, float maxYSpeed, int ballTimer, int scoreToWin, Racket left, Racket right) {
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
    this.left = left;
    this.right = right;
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
    currentTime = millis();
    if (isActive && currentTime >= initialTime+millisBeforeMove) {
      thirdLastPosn = secondLastPosn;
      secondLastPosn = posn;
      
      speed.x = constrain(speed.x, -maxX, maxX);
      if (speed.x > 0) {
        speed.x = constrain(speed.x, minX, maxX);
      } else {
        speed.x = constrain(speed.x, -minX, -maxX);
      }
      /*    //Old Version
      speed.x = constrain(speed.x, -maxX, maxX);
      if (speed.x > 0 && speed.x < minX) {
        speed.x = minX;
      } else if (speed.x < 0 && speed.x > -minX) {
        speed.x = -minX;
      }
      */
      
      speed.y = constrain(speed.y, minY, maxY);
      
      /*
      if (speed.y > 0 && speed.y < minY) {
        speed.y = minY;
      } else if (speed.y < 0 && speed.y > minY) {
        speed.y = -minY;
      }*/
      
      posn = addPVector(posn, speed);
      if (posn.y >= height-diameter/2) {
        speed.y = -abs(speed.y);
      } else if (posn.y <= diameter/2) {
        speed.y = abs(speed.y);
      }
      posn.y = constrain(posn.y,diameter/2,height-diameter/2);
    }
  }
  void render() {
    if (isActive) {
      makeCircle(thirdLastPosn.x, thirdLastPosn.y, diameter/1.2, c);
      makeCircle(secondLastPosn.x, secondLastPosn.y, diameter/1.1, c);
      makeCircle(posn.x, posn.y, diameter, c);
    }
  }
  void score() {
    if (posn.x > width-diameter/2) {
      left.points++;
      reset();
      speed.y = firstSpeed.y+random(-1, 1);
      speed.x = 3;
    } else if (posn.x < diameter/2) {
      right.points++;
      reset();
      speed.y = firstSpeed.y+random(-1, 1);
      speed.x = -3;
    }
  }
  void reset() {
    posn = firstPosn;
    secondLastPosn = firstPosn;
    thirdLastPosn = firstPosn;
    initialTime = millis();
    //println(firstSpeed);
  }
}
