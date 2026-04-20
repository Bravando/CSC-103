class Player {
  // variables
  int x;
  int y;
  int size;

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

  // functions

  ///////////// rendering stuff
  void render() {
    stroke(255);
    fill(0, 255, 255);
    square(x, y, size);
  }


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
  
  void move(){
    moveLeft();
    moveRight();
    moveUp();
    moveDown();
  }
}
