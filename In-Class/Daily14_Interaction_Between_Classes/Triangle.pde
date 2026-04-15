class Triangle extends Shape {

  Triangle(float x, float y, float size, color fill) {
    super();
    this.x = x;
    this.y = y;
    this.size = size;
    this.fill = fill;
    stroke = fill;
  }

  @Override
    void render() {
    fill(fill);
    stroke(stroke);
    triangle(x,
      y,
      x - (size / 2),
      y + size,
      x + (size / 2),
      y + size);
  }

  @Override
    void bounceAtBounds() {
    if (x + (size / 2) >= width || x - (size / 2) <= 0) {
      bounceX();
    }
    if (y + size >= height || y <= 0) {
      bounceY(0, height);
    }
  }
}
