float racketWidth, racketHeight, widthFromEdge, ballSize, racketSpeed, racketLeniency, ballLeniency, startButtonRoundness = 70;
int initialBallTimer, pointsToWin = 3, currentState = 0; // currentState: 0 = startScreen ; 1 = game ; 2 = winScreen
Racket left, right;
PVector leftRacketStart, rightRacketStart, ballStart, ballSpeed;
int[] rightRacketControls= new int[2], leftRacketControls = new int[2];
PingPongBall ball;
color startButtonC = color(255, 0, 0), leftRacketC = color(0, 255, 0), rightRacketC = color(0, 0, 255), winnerC = color(255);
Button startButton;
String winner = "";

void setup() {
  size(800, 600);
  rectMode(CENTER);
  widthFromEdge = width*(1.0/16.0);
  racketWidth = width/80.0;
  racketHeight = height/6;
  racketSpeed = 6;
  racketLeniency = 1;

  leftRacketStart = new PVector(widthFromEdge, height/2);
  leftRacketControls[0] = 'w';
  leftRacketControls[1] = 's';
  left = new Racket(leftRacketStart, "left", racketSpeed, leftRacketControls, new PVector(racketWidth, racketHeight), racketLeniency, leftRacketC);
  left.isActive = false;

  rightRacketStart = new PVector(width-widthFromEdge, height/2);
  rightRacketControls[0] = UP;
  rightRacketControls[1] = DOWN;
  right = new Racket(rightRacketStart, "right", racketSpeed, rightRacketControls, new PVector(racketWidth, racketHeight), racketLeniency, rightRacketC);
  right.isActive = false;

  ballSize = 10;
  ballStart = new PVector(width/2, height/2);
  ballSpeed = new PVector(width/(800.0/3.0), height/400);
  ballLeniency = 2;
  ball = new PingPongBall(ballStart, ballSpeed, ballSize, ballLeniency, left, right);
  initialBallTimer = 150;
  ball.isActive = false;

  startButton = new Button(new PVector(width/2, height*(2.0/3.0)), new PVector(width/3, height/6), startButtonRoundness, startButtonC);
}


void draw() {
  background(50, 3, 3);
  game();
}
void game() {
  renderGame();
  runGame();
}
void runGame() {
  switch (currentState) {
  case 0:
    runStartScreen();
    break;
  case 1:
    runActiveScreen();
    break;
  case 2:
    runEndScreen();
    break;
  }
}
void renderGame() {
  switch (currentState) {
  case 0:
    renderStartScreen();
    break;
  case 1:
    renderActiveScreen();
    break;
  case 2:
    renderEndScreen();
    break;
  }
}
void mouseReleased() {
  switch (currentState) {
  case 0:
    startButton.whenReleased(() -> activeScreen());
    break;
  case 2:
    startButton.whenReleased(() -> startScreen());
    break;
  }
}
void startScreen() {
  currentState = 0;
  startButton.active = true;
  left.points = 0;
  right.points = 0;
  ball.reset();
  left.reset();
  right.reset();
  renderStartScreen();
  runStartScreen();
}
void runStartScreen() {
  left.isActive = false;
  right.isActive = false;
  ball.isActive = false;
  startButton.beingPressed();
}

void renderStartScreen() {
  startButton.render();
  textAlign(CENTER);
  fill(255);
  textSize(startButton.rectSize.y*1.5);
  text("PONG", width/2, height/3);
  fill(0, 255, 0);
  textSize(startButton.rectSize.y/2);
  text("START", startButton.loc.x, startButton.loc.y+startButton.rectSize.y/8);
}
void activeScreen() {
  currentState = 1;
  ball.reset();
  left.reset();
  right.reset();
    left.posn.y = height/2.0;
    right.posn.y = height/2.0;
  renderActiveScreen();
  runActiveScreen();
}
void renderActiveScreen() {
  left.render();
  right.render();
  ball.render();

  textAlign(CENTER);
  textSize(height/5);
  fill(right.c);
  text(right.points, right.posn.x-widthFromEdge, height*(11.0/12.0));
  fill(left.c);
  text(left.points, left.posn.x+widthFromEdge, height*(11.0/12.0));
}
void runActiveScreen() {
  left.isActive = true;
  right.isActive = true;
  ball.isActive = true;
  left.move();
  right.move();
  ball.move();

  ball.smackedHor(left);
  ball.smackedHor(right);
  ball.score();

  win();
}
void keyPressed() {
  switch (currentState) {
  case 0:
    if (key == 'r') {
      activeScreen();
    }
    break;
  case 1:

    left.startMovement();
    right.startMovement();

  case 2:

    if (key == 'r') {
      startScreen();
    }

    break;
  }
}
void keyReleased() {
  switch (currentState) {
  case 1:
    left.stopMovement();
    right.stopMovement();
    break;
  }
}
void endScreen() {
  currentState = 2;
  renderEndScreen();
  runEndScreen();
}
void renderEndScreen() {
  startButton.render();
  textAlign(CENTER);
  fill(winnerC);
  textSize(height/5);
  text(winner+" wins!", width/2, height/3, startButton.rectSize.y);
  fill(255);
  textSize(startButton.rectSize.y/2);
  text("Go Again?", startButton.loc.x, startButton.loc.y+startButton.rectSize.y/8, startButton.rectSize.y/2);
}
void runEndScreen() {
  left.isActive = false;
  right.isActive = false;
  ball.isActive = false;
  startButton.beingPressed();
}
boolean anyWon() {
  return(left.points >= pointsToWin || right.points >= pointsToWin);
}

void win() {
  left.name = "Left";
  right.name = "Right";
  if (anyWon()) {
    if (left.points >= pointsToWin) {
      winner = left.name;
      winnerC = left.c;
    } else {
      winner = right.name;
      winnerC = right.c;
    }
    currentState++;
  }
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
boolean inDist(float x, float y, float hitRadius, float foundX, float foundY) {
  return (dist(x, y, foundX, foundY) < hitRadius);
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
