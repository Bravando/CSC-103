abstract class Shape implements Renderable {
  float x = 100, y = 100, size = 100, xSpeed = 5, ySpeed = 5, sizeChange = 3, speedChange = 1, previousYSpeed, previousXSpeed;
  float leftBound, rightBound, upBound, downBound;
  color fill = color(0), stroke = color(0);

  Shape() {
    setBounds();
  }
  Shape(float x, float y, float size, float xSpeed, float ySpeed, color fill, color stroke) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.fill = fill;
    this.stroke = stroke;
    setBounds();
  }
  @Override
    abstract void render();


//Broken vvv
  void collide(Shape otherShape) {
    if (boundsCollide(leftBound, rightBound, upBound, downBound,
      otherShape.leftBound, otherShape.rightBound, otherShape.upBound, otherShape.downBound)) {
      if (x < otherShape.x) {
        xSpeed = -abs(xSpeed);
      } else {
        xSpeed = abs(xSpeed);
      }
      if (y < otherShape.y) {
        ySpeed = -abs(ySpeed);
      } else {
        ySpeed = abs(ySpeed);
      }
    }
  }
  //Broken ^^^
  
  
  
  
  void setBounds() {
    leftBound = x-size/2.0;
    rightBound = x+size/2.0;
    upBound = y-size/2.0;
    downBound = y+size/2.0;
  }

  boolean boundsCollide(float leftBound1, float rightBound1, float topBound1, float bottomBound1,
    float leftBound2, float rightBound2, float topBound2, float bottomBound2) {
    return ((leftBound1 <= rightBound2 || rightBound1 >= leftBound2) && (topBound1 <= bottomBound2 || bottomBound1 >= topBound2));
  }

  boolean inBounds(float x, float y, float leftBound, float rightBound, float topBound, float bottomBound) {
    /*
  checks if the given input is within all four bounds
     */
    return ((leftBound <= x) && (x <= rightBound) && (topBound <= y) && (y <= bottomBound));
  }

  boolean inRectCentered(float x, float y, float wid, float hgt, float inputX, float inputY) {
    /*
  checks if the input is in the given rectangle centered at (x,y) with sides of wid and hgt
     */
    return inBounds(inputX, inputY, x-wid/2, x+wid/2, y-hgt/2, y+hgt/2);
  }

  void bounceAtBounds() {
    if (x + (size / 2) >= width || x - (size / 2) <= 0) {
      bounceX();
    } else if (y + (size / 2) >= height || y - (size / 2) <= 0) {
      bounceY((size / 2), height-(size / 2));
    }
  }
  void bounceX() {
    xSpeed = -xSpeed;
    x = constrain(x, (size / 2), width-(size / 2));
    //randomizeColor();
  }
  void bounceY(float zero, float max) {
    ySpeed = -ySpeed;
    y = constrain(y, zero, max);
    //randomizeColor();
  }
  void randomizeColor() {
    fill = color(random(255), random(255), random(255));
    stroke = color(random(255), random(255), random(255));
  }
  void move() {
    x += xSpeed;
    y += ySpeed;
    setBounds();
  }
  void increaseSpeed() {
    if (!(ySpeed == 0)) {
      ySpeed += (ySpeed/abs(ySpeed))*speedChange;
    } else {
      ySpeed = previousYSpeed;
    }
    if (!(xSpeed == 0)) {
      xSpeed += (xSpeed/abs(xSpeed))*speedChange;
    } else {
      xSpeed = previousXSpeed;
    }
  }
  void decreaseSpeed() {
    if (!(ySpeed == 0)) {
      previousYSpeed = ySpeed;
      ySpeed -= (ySpeed/abs(ySpeed))*speedChange;
    }
    if (!(xSpeed == 0)) {
      previousXSpeed = xSpeed;
      xSpeed -= (xSpeed/abs(xSpeed))*speedChange;
    }
  }
  void increaseDiameter() {
    size = constrain(size+sizeChange, size, size+sizeChange);
  }
  void decreaseDiameter() {
    size = constrain(size-sizeChange, 5, size);
  }
}
