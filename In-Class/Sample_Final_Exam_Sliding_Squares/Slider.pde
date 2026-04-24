class Slider {

  PVector posn = new PVector(0, 0), size = new PVector(50, 50);
  Boolean isMovingDownRight, isMovingVertical;
  float speed = 5;
  color c;

  Slider(PVector posn, String dirKey, PVector size, color c, float speed) {
    processDir(dirKey);
    this.posn = posn;
    this.c = c;
    this.speed = speed;
    this.size = size;
  }
  Slider(PVector posn, String dirKey, color c, float speed) {
    processDir(dirKey);
    this.posn = posn;
    this.c = c;
    this.speed = speed;
  }
  Slider(PVector posn, String dirKey, color c) {
    processDir(dirKey);
    this.posn = posn;
    this.c = c;
  }
  Slider(int dirKey, float size, color c) {
    processDir(dirKey);
    randomPosn();
    this.c = c;
    this.size.x = size;
    this.size.y = size;
  }
  Slider(float posn, int dirKey) {
    processDir(dirKey);
    posnAtEdge(posn);
    c = randomColor();
  }
  Slider(int dirKey) {
    processDir(dirKey);
    randomPosn();
    c = randomColor();
  }
  Slider() {
    randomDir();
    randomPosn();
    c = randomColor();
  }
  //     Functions for Initialization
  void processDir(int dirKey) {
    if (isAcceptableKey(dirKey)) {
      if (dirKey == 'a' || dirKey == LEFT || dirKey == 'A') {
        isMovingDownRight = false;
        isMovingVertical = false;
      } else if (dirKey == 'd' || dirKey == RIGHT || dirKey == 'D') {
        isMovingDownRight = true;
        isMovingVertical = false;
      } else if (dirKey == 'w' || dirKey == UP || dirKey == 'W') {
        isMovingDownRight = false;
        isMovingVertical = true;
      } else {
        isMovingDownRight = true;
        isMovingVertical = true;
      }
    } else {
      randomDir();
    }
  }
  void processDir(String dirKey) {
    if (dirKey == "left") {
      isMovingDownRight = false;
      isMovingVertical = false;
    } else if (dirKey == "right") {
      isMovingDownRight = true;
      isMovingVertical = false;
    } else if (dirKey == "up") {
      isMovingDownRight = false;
      isMovingVertical = true;
    } else {
      isMovingDownRight = true;
      isMovingVertical = true;
    }
  }
  void randomDir() {
    Integer dirKey = int(random(4));
    if (dirKey == 0) {
      isMovingDownRight = false;
      isMovingVertical = false;
    } else if (dirKey == 1) {
      isMovingDownRight = true;
      isMovingVertical = false;
    } else if (dirKey == 2) {
      isMovingDownRight = false;
      isMovingVertical = true;
    } else {
      isMovingDownRight = true;
      isMovingVertical = true;
    }
  }
  void randomPosn() {
    if (isMovingVertical) {
      this.posn.x = random(width);
      if (isMovingDownRight) {
        this.posn.y = 0;
      } else {
        this.posn.y = height;
      }
    } else {
      this.posn.y = random(height);
      if (isMovingDownRight) {
        this.posn.x = 0;
      } else {
        this.posn.x = width;
      }
    }
  }
  void posnAtEdge(float posn) {
    if (isMovingVertical) {
      this.posn.x = constrain(posn, 0, width);
      if (isMovingDownRight) {
        this.posn.y = 0;
      } else {
        this.posn.y = height;
      }
    } else {
      this.posn.y = constrain(posn, 0, height);
      if (isMovingDownRight) {
        this.posn.x = 0;
      } else {
        this.posn.x = width;
      }
      c = randomColor();
    }
  }
  boolean isAcceptableKey(int dirKey) {
    return (dirKey == 'a' || dirKey == LEFT || dirKey == 'A' || dirKey == 'd' || dirKey == RIGHT || dirKey == 'D'
      || dirKey == 'w' || dirKey == UP || dirKey == 'W' || dirKey == 's' || dirKey == DOWN || dirKey == 'S');
  }

  //  Movement

  void move() {
    if (isMovingVertical) {
      if (isMovingDownRight) {
        moveDown();
      } else {
        moveUp();
      }
    } else {
      if (isMovingDownRight) {
        moveRight();
      } else {
        moveLeft();
      }
    }
  }
  void moveUp() {
    if (!outOfBounds()) {
      posn.y-=speed;
    }
  }
  void moveDown() {
    if (!outOfBounds()) {
      posn.y+=speed;
    }
  }
  void moveLeft() {
    if (!outOfBounds()) {
      posn.x-=speed;
    }
  }
  void moveRight() {
    if (!outOfBounds()) {
      posn.x+=speed;
    }
  }

  // Rendering

  void render() {
    rectMode(CENTER);
    fill(c);
    rect(posn.x, posn.y, size.x, size.y);
  }
  boolean outOfBounds() {
    return (posn.x+size.x/2<0 || posn.y+size.y/2<0
      || posn.x-size.x/2>width || posn.y-size.y/2>height);
  }
}
color randomColor() {
  return color(random(255), random(255), random(255));
}
boolean outOfBounds(PVector posn, PVector size) {
  return (posn.x+size.x/2<0 || posn.y+size.y/2<0
    || posn.x-size.x/2>width || posn.y-size.y/2>height);
}
