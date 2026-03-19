class GameState {
  float racketWidth, racketHeight, widthFromEdge, ballSize, racketSpeed, racketLeniency, ballLeniency;
  int initialBallTimer;
  Racket left, right;
  PVector leftRacketStart, rightRacketStart, ballStart, ballSpeed, windowSize;
  int[] rightRacketControls= new int[2], leftRacketControls = new int[2];
  PingPongBall ball;

  GameState(PVector windowSize) {
    this.windowSize = windowSize;
    widthFromEdge = 1/8;
    racketWidth = windowSize.x/80;
    racketHeight = windowSize.y/6;
    racketSpeed = 6;
    racketLeniency = 1;

    leftRacketStart = new PVector(windowSize.x*widthFromEdge, windowSize.y/2);
    leftRacketControls[0] = 'w';
    leftRacketControls[1] = 's';
    left = new Racket(leftRacketStart, "left", racketSpeed, leftRacketControls, new PVector(racketWidth, racketHeight), racketLeniency);

    rightRacketStart = new PVector(windowSize.x*(1-widthFromEdge), windowSize.y/2);
    rightRacketControls[0] = UP;
    rightRacketControls[1] = DOWN;
    right = new Racket(rightRacketStart, "right", racketSpeed, rightRacketControls, new PVector(racketWidth, racketHeight), racketLeniency);

    ballSize = 10;
    ballStart = new PVector(windowSize.x/2, windowSize.y/2);
    ballSpeed = new PVector(windowSize.x/(800/3), windowSize.y/400);
    ballLeniency = 2;
    ball = new PingPongBall(ballStart, ballSpeed, ballSize, ballLeniency);
    initialBallTimer = 150;
  }
  GameState(float windowWidth, float windowHeight) {
    windowSize = new PVector(windowWidth, windowHeight);
    widthFromEdge = 1/8;
    racketWidth = windowWidth/80;
    racketHeight = windowHeight/6;
    racketSpeed = 6;
    racketLeniency = 1;

    leftRacketStart = new PVector(windowWidth*widthFromEdge, windowHeight/2);
    leftRacketControls[0] = 'w';
    leftRacketControls[1] = 's';
    left = new Racket(leftRacketStart, "left", racketSpeed, leftRacketControls, new PVector(racketWidth, racketHeight), racketLeniency);

    rightRacketStart = new PVector(windowWidth*(1-widthFromEdge), windowHeight/2);
    rightRacketControls[0] = UP;
    rightRacketControls[1] = DOWN;
    right = new Racket(rightRacketStart, "right", racketSpeed, rightRacketControls, new PVector(racketWidth, racketHeight), racketLeniency);

    ballSize = 10;
    ballStart = new PVector(windowWidth/2, windowHeight/2);
    ballSpeed = new PVector(windowWidth/(800/3), windowHeight/400);
    ballLeniency = 2;
    ball = new PingPongBall(ballStart, ballSpeed, ballSize, ballLeniency);
    initialBallTimer = 150;
  }

  void startScreen() {
  }
  
  
  

}
