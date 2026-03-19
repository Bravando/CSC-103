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
