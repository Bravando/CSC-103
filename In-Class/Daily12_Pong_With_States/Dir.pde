class Dir {
  float left = 0, right = 0, up = 0, down = 0;
  boolean isLeft = false, isRight= false, isUp= false, isDown= false;
  Dir(float left, float right, float up, float down) {
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
  }
  Dir(boolean isLeft, boolean isRight, boolean isUp, boolean isDown) {
    this.isLeft = isLeft;
    this.isRight = isRight;
    this.isUp = isUp;
    this.isDown = isDown;
  }
  Dir(float left, float right, float up, float down, boolean isLeft, boolean isRight, boolean isUp, boolean isDown) {
    this.isLeft = isLeft;
    this.isRight = isRight;
    this.isUp = isUp;
    this.isDown = isDown;
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
  }
  boolean isMoving() {
    return(isLeft || isRight || isUp || isDown);
  }
}
