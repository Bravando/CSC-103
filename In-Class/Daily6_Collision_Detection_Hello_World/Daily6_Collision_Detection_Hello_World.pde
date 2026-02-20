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

color rando;

float pSpeed;
boolean isUp = false;
boolean isDown = false;
boolean isLeft = false;
boolean isRight = false;

int openingTextTimer;
int openingTextTimerCounter;

PVector enemySpawn;
float enemySize;
float enemySpeed;
int spawnRateTicks;
int spawnRate;

ArrayList<PVector> enemyPosns;
ArrayList<Integer> enemyColors;


void setup() {
  size(600, 400, P2D);
  rectMode(CENTER);
  sPosn = new PVector(width/2, height/2);
  sSide = height/6;
  sLeft = sPosn.x-sSide;
  sRight = sPosn.x+sSide;
  sTop = sPosn.y-sSide;
  sBottom = sPosn.y+sSide;
  leniency = 3;

  openingTextTimerCounter = 0;
  openingTextTimer = 600;

  c1 = new PVector(width/6, height/5);
  cD1 = height*.3;
  cC1 = color(255, 100, 0);
  c2 = new PVector(width/1.2, height/1.1);
  cD2 = height*.1;
  cC2 = color(200, 50, 200);
  c3 = new PVector(width/1.1, height/4);
  cD3 = width*.1;
  cC3 = color(0, 100, 255);

  pSpeed = 3;

  enemySize = height/16;
  enemySpawn = new PVector(0, height);
  enemySpeed = pSpeed-1;
  enemyPosns = new ArrayList<PVector>();
  enemyColors = new ArrayList<Integer>();
  spawnRateTicks = 0;
  spawnRate = 300;
}

void draw() {
  background(bkg);
  sC = color(0, 255, 0);
  stroke(0);
  strokeWeight(3);

//println(enemyPosns);                                                      // test


  drawEnemies(enemyPosns, enemyColors, enemySize,cC1, cC2, cC3);

  if (!hitByEnemy(enemyPosns, enemySize, sPosn, sSide)) {
    movePlayer();
    moveEnemy(enemyPosns, sPosn, enemySpeed);

    makeCircle(c1.x, c1.y, cD1, cC1);
    circleWasHit(c1.x, c1.y, cD1, cC1, sPosn.x, sPosn.y, sSide, leniency);

    makeCircle(c2.x, c2.y, cD2, cC2);
    circleWasHit(c2.x, c2.y, cD2, cC2, sPosn.x, sPosn.y, sSide, leniency);

    makeCircle(c3.x, c3.y, cD3, cC3);
    circleWasHit(c3.x, c3.y, cD3, cC3, sPosn.x, sPosn.y, sSide, leniency);
    makeSquare(sPosn.x, sPosn.y, sSide, sC);
    spawnRateTicks++;
    if(spawnRateTicks >= spawnRate){
      makeEnemy(enemyPosns, enemyColors, enemySpawn);
      spawnRateTicks = 0;
      if(spawnRate > 100){
        spawnRate -= 10;
      }
    }
  } else {
    textSize(64);
    fill(255, 0, 0);
    text("Game Over", width/4, height/2.3);
  }
  if (openingTextTimerCounter < openingTextTimer) {
    textSize(20);
    fill(255, 0, 0);
    text("Change your color to kill the enemies!", width/4, height/2.3);
    openingTextTimerCounter++;
  }
  //if (openingTextTimerCounter == openingTextTimer-1) {                // for testing purposes
  //  makeEnemy(enemyPosns, enemyColors, enemySpawn);
  //}

  //if(mousePressed){
  //  deathAnimation(sPosn,sSide,50,sC);
  //}
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
    killEnemy(enemyPosns, enemyColors, sC, cC1, cC2, cC3);
  }
}

boolean circleHitSquare(float cX, float cY, float cD, float sX, float sY, float sS, float leniency) {
  return octogonHitSquare(cX, cY, cD/2, sX-sS/2, sX+sS/2, sY-sS/2, sY+sS/2, leniency);
}

boolean squareHitSquare(float l1, float r1, float t1, float b1, float l2, float r2, float t2, float b2, float leniency) {
  return (l1+leniency <= r2 && r1-leniency >= l2 && t1+leniency <= b2 && b1+leniency >= t2);
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
  float pRadius = sSide/2;
  if (isUp) {
    sPosn.y = constrain(sPosn.y-pSpeed, pRadius, height-pRadius);
  }
  if (isDown) {
    sPosn.y = constrain(sPosn.y+pSpeed, pRadius, height-pRadius);
  }
  if (isLeft) {
    sPosn.x = constrain(sPosn.x-pSpeed, pRadius, width-pRadius);
  }
  if (isRight) {
    sPosn.x = constrain(sPosn.x+pSpeed, pRadius, width-pRadius);
  }
}

//void deathAnimation(PVector spot,float size,float lLength,color c){
//  for(int i = 0; i < 6000; i++){
//    float lStart = size*0.1+i/100;
//    float hyToSide = 1/sqrt(2);
//    stroke(c);
//    strokeWeight(size/5);
//    line(spot.x,spot.y+lStart,spot.x,spot.y+lStart+lLength);//down
//    line(spot.x+lStart,spot.y,spot.x+lStart+lLength,spot.y);//right
//    line(spot.x,spot.y-lStart,spot.x,spot.y-lStart-lLength);//up
//    line(spot.x-lStart,spot.y,spot.x-lStart-lLength,spot.y);//left
//    line((spot.x+lStart)*hyToSide,(spot.y+lStart)*hyToSide,(spot.x+lStart+lLength)*hyToSide,(spot.y+lStart+lLength)*hyToSide);//down-right
//    line((spot.x+lStart)*hyToSide,(spot.y-lStart)*hyToSide,(spot.x+lStart+lLength)*hyToSide,(spot.y-lStart-lLength)*hyToSide);//up-right
//    line((spot.x-lStart)*hyToSide,(spot.y+lStart)*hyToSide,(spot.x-lStart-lLength)*hyToSide,(spot.y+lStart+lLength)*hyToSide);//down-left
//    line((spot.x-lStart)*hyToSide,(spot.y-lStart)*hyToSide,(spot.x-lStart-lLength)*hyToSide,(spot.y-lStart-lLength)*hyToSide);//up-left
//  }
//}


void drawEnemies(ArrayList<PVector> enemies, ArrayList<Integer> colors, float enemySize, color c1, color c2, color c3) {
  /*
  draws enemies at the posns in the given arraylist
  */
  for (int i = 0; i < enemies.size(); i++) {
    fill(chooseColor(colors.get(i),c1,c2,c3));
    triangle(enemies.get(i).x-enemySize, enemies.get(i).y+enemySize, enemies.get(i).x,
      enemies.get(i).y-enemySize, enemies.get(i).x+enemySize, enemies.get(i).y+enemySize);
  }
}

boolean hitByEnemy(ArrayList<PVector> enemies, float enemySize, PVector player, float playerSize) {

  boolean anyTrue = false;
  for (PVector enemy : enemies) {
    anyTrue = anyTrue || squareHitSquare((player.x-playerSize/2), (player.x+playerSize/2), (player.y-playerSize/2), (player.y+playerSize/2),
      (enemy.x-enemySize/2), (enemy.x+enemySize/2), (enemy.y-enemySize/2), (enemy.y+enemySize/2), leniency);
  }
  return anyTrue;
}

color chooseColor(int index, color c0, color c1, color c2) {
  //rando = int(random(3));
  if (index == 0) {
    return c0;
  } else if (index == 1) {
    return c1;
  } else {
    return c2;
  }
}

void makeEnemy(ArrayList<PVector> enemies, ArrayList<Integer> colors, PVector enemySpawnn) {
  //println(enemySpawn.x);                               // for testing
  enemies.add(enemySpawnn);
  colors.add(int(random(3)));
}

//void spawnEnemy(ArrayList<PVector> enemies, ArrayList<Integer> colors,
//  PVector enemySpawn, int spawnRate) {
//  for (int i = 0; i == spawnRate; i++) {
//    makeEnemy(enemies, colors, enemySpawn);
//    i=0;
//  }
//}

boolean compareColors(color c1, color c2){
  return(red(c1) == red(c2) && green(c1) == green(c2) && blue(c1) == blue(c2)); 
}

void killEnemy(ArrayList<PVector> enemies,  ArrayList<Integer> colors, color playerC, color c1, color c2, color c3) {
  for (int i = 0; i < enemies.size(); i++) {
    if (compareColors(playerC,chooseColor(colors.get(i),c1,c2,c3))) {
      enemies.remove(i);
      colors.remove(i);
      enemySpawn = new PVector(0, height);
      //reds.remove(i);
      //blues.remove(i);
      //greens.remove(i);
    }
  }
}

void moveEnemy(ArrayList<PVector> enemies, PVector player, float enemySpeed) {
  for (PVector enemy : enemies) {
    float moveAngle = atan((player.y-enemy.y)/(player.x-enemy.x));
    if(player.x > enemy.x){
      enemy.x += cos(moveAngle)*enemySpeed;
      enemy.y += sin(moveAngle)*enemySpeed;
    }else{
      enemy.x -= cos(moveAngle)*enemySpeed;
      enemy.y -= sin(moveAngle)*enemySpeed;
    }
  }
}
