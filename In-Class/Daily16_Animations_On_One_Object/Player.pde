class Player {
  // variables
  int x;
  int y;
  int size;
  Animation upAnim, downAnim, leftAnim, rightAnim, idleAnim;
  boolean isAnimated = false;

  // speeds
  float runSpeed;

  // moving booleans
  boolean movingLeft;
  boolean movingRight;
  boolean movingUp;
  boolean movingDown;


  // constructor
  Player() {
    size = 50;
    x = width/2;
    y = height-size;

    runSpeed = 10;


    // moving booleans
    movingLeft = false;
    movingRight = false;
    movingUp = false;
    movingDown = false;
  }
  Player(Animation up, Animation down, Animation left, Animation right, Animation idle) {
    size = 50;
    x = width/2;
    y = height-size;

    runSpeed = 10;

    upAnim = up;
    downAnim = down;
    leftAnim = left;
    rightAnim = right;
    idleAnim = idle;
    isAnimated = true;


    // moving booleans
    movingLeft = false;
    movingRight = false;
    movingUp = false;
    movingDown = false;
  }

  Player(PImage[] upImages, PImage[] downImages, PImage[] leftImages, PImage[] rightImages, PImage[] idleImages) {
    size = 50;
    x = width/2;
    y = height-size;

    runSpeed = 10;

    //for (int index=0; index<= upImages.length-1; index++) {
    //  upImages[index] = loadImage("up" + index + ".png");
    //}
    //for (int index=0; index<= downImages.length-1; index++) {
    //  downImages[index] = loadImage("down" + index + ".png");
    //}
    //for (int index=0; index<= leftImages.length-1; index++) {
    //  leftImages[index] = loadImage("left" + index + ".png");
    //}
    //for (int index=0; index<= rightImages.length-1; index++) {
    //  rightImages[index] = loadImage("right" + index + ".png");
    //}
    //for (int index=0; index<= idleImages.length-1; index++) {
    //  idleImages[index] = loadImage("idle" + index + ".png");
    //}

    upAnim = new Animation(upImages, 0.1, 1);
    downAnim = new Animation(downImages, 0.1, 1);
    leftAnim = new Animation(leftImages, 0.1, 1);
    rightAnim = new Animation(rightImages, 0.1, 1);
    idleAnim = new Animation(idleImages, 0.1, 1);
    isAnimated = true;


    // moving booleans
    movingLeft = false;
    movingRight = false;
    movingUp = false;
    movingDown = false;
  }

  // functions

  ///////////// rendering stuff
  void render() {
    if (!((upAnim == null) || (downAnim == null) || (leftAnim == null) || (rightAnim == null) || (idleAnim == null))) {
      renderAnimated();
    } else {
      renderSquare();
    }
  }
  
  
  void renderSquare() {
    stroke(255);
    fill(0, 255, 255);
    square(x, y, size);
  }
  
  
  void renderAnimated() {
    if (movingUp) {
      upAnim.isAnimating = true;
      upAnim.display(x, y);
    } else if (movingDown) {
      downAnim.isAnimating = true;
      downAnim.display(x, y);
    } else if (movingLeft) {
      leftAnim.isAnimating = true;
      leftAnim.display(x, y);
    } else if (movingRight) {
      rightAnim.isAnimating = true;
      rightAnim.display(x, y);
    } else {
      idleAnim.isAnimating = true;
      idleAnim.display(x, y);
    }
  }
  // Movement Functions

  void moveRight() {
    if (movingRight) {
      x += runSpeed;
    }
  }

  void moveLeft() {
    if (movingLeft) {
      x -= runSpeed;
    }
  }

  void moveUp() {
    if (movingUp) {
      y -= runSpeed;
    }
  }

  void moveDown() {
    if (movingDown) {
      y += runSpeed;
    }
  }

  void move() {
    moveLeft();
    moveRight();
    moveUp();
    moveDown();
  }
}
