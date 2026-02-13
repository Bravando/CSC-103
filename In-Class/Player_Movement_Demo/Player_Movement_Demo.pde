color pC;
PVector player;
float pX;
float pY;
float pW;
float pH;
float pSpeed;
boolean isUp = false;
boolean isDown = false;
boolean isLeft = false;
boolean isRight = false;

void setup() {
  size(800, 600);
  pC = color(255, 0, 0);
  player = new PVector(width/2,height/2);
  pX = width/2;
  pY = height/2;
  pW = 100;
  pH = 100;
  pSpeed = 5;
}

void draw() {
  background(0);
  fill(pC);
  //rect(pX, pY, pW, pH);
  movePlayer();
  rect(player.x,player.y,pW,pH);
}

void keyPressed() {
  startMovement();
}
void keyReleased() {
  stopMovement();
}
void movePlayer() {
  if (isUp) {
    pY -= pSpeed;
  }
  if (isDown) {
    pY += pSpeed;
  }
  if (isLeft) {
    pX -= pSpeed;
  }
  if (isRight) {
    pX += pSpeed;
  }
}
void changeMovement() {
  if (key == 'w') {
    //player = PVector(player.x, player.y-pSpeed);
    isUp = !isUp;
  } else if (key == 's') {
    //player.y += pSpeed;
    isDown = !isDown;
  }
  if (key == 'a') {
    //player.x -= pSpeed;
    isLeft = !isLeft;
  } else if (key == 'd') {
    //player.x += pSpeed;
    isRight = !isRight;
  }
}
void startMovement() {
  if (key == 'w') {
    //player = PVector(player.x, player.y-pSpeed);
    isUp = true;
  } else if (key == 's') {
    //player.y += pSpeed;
    isDown = true;
  }
  if (key == 'a') {
    //player.x -= pSpeed;
    isLeft = true;
  } else if (key == 'd') {
    //player.x += pSpeed;
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
    //player = PVector(player.x, player.y-pSpeed);
    isUp = false;
  } else if (key == 's') {
    //player.y += pSpeed;
    isDown = false;
  }
  if (key == 'a') {
    //player.x -= pSpeed;
    isLeft = false;
  } else if (key == 'd') {
    //player.x += pSpeed;
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
