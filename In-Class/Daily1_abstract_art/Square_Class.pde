class Square {
  int x, y, size, xSpeed, ySpeed;
  color fill, stroke;

  Square(int x, int y, int size, int xSpeed, int ySpeed, color fill, color stroke) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.fill = fill;
    this.stroke = stroke;
  }

  void bounceatbounds() {
    if (x + (size / 2) >= width || x - (size / 2) <= 0) {
      bounceX();
    } else if (y + (size / 2) >= height || y - (size / 2) <= 0) {
      bounceY((size / 2),height-(size / 2));
    }
  }
  void bounceX() {
    xSpeed = -xSpeed;
    x = constrain(x, (size / 2), width-(size / 2));
    randomizeColor();
  }
  void bounceY(int zero, int max) {
    ySpeed = -ySpeed;
    y = constrain(y, zero, max);
    randomizeColor();
  }
  void randomizeColor() {
    fill = color(random(255), random(255), random(255));
    stroke = color(random(255), random(255), random(255));
  }
  void move() {
    x += xSpeed;
    y += ySpeed;
  }
  void makesquare(Square squ) {
    fill(squ.fill);
    stroke(squ.stroke);
    rect(squ.x, squ.y, squ.size, squ.size);
  }
  void makecircle(Square squ) {
    fill(squ.fill);
    stroke(squ.stroke);
    ellipse(squ.x, squ.y, squ.size, squ.size);
  }
  void maketriangle(Square squ) {
    fill(squ.fill);
    stroke(squ.stroke);
    triangle(squ.x,
      squ.y,
      squ.x - (squ.size / 2),
      squ.y + squ.size,
      squ.x + (squ.size / 2),
      squ.y + squ.size);
  }
  void tribounceatbounds(Square squ) {
    if (squ.x + (squ.size / 2) >= width || squ.x - (squ.size / 2) <= 0) {
      bounceX();
    }
    if (squ.y + squ.size >= height || squ.y <= 0) {
      bounceY(0,height);
    }
  }
}
