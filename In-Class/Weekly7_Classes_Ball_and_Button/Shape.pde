abstract class Shape implements Renderable {
  int x = 100, y = 100, size = 100, xSpeed = 5, ySpeed = 5, sizeChange = 3, speedChange = 1, previousYSpeed, previousXSpeed;
  color fill = color(0), stroke = color(0);

  Shape() {
  }
  Shape(int x, int y, int size, int xSpeed, int ySpeed, color fill, color stroke) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.fill = fill;
    this.stroke = stroke;
  }
  @Override
    abstract void render();

  void bounceatbounds() {
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
  void bounceY(int zero, int max) {
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
