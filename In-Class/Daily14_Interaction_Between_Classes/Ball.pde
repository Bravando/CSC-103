class Ball extends Shape {

  Ball(float x, float y, float size, color fill) {
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
    circle(x, y, size);
  }
}
