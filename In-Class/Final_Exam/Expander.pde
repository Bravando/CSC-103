class Expander {
  PVector posn, size = new PVector(50, 50);
  float speed = 5;
  color c;
  boolean isGrowingTaller;

  Expander(PVector posn, boolean isGrowingTaller) {
    c = randomColor();
    this.posn = posn;
    this.isGrowingTaller = isGrowingTaller;
  }
  Expander(float x, float y, boolean isGrowingTaller) {
    c = randomColor();
    posn = new PVector(x, y);
    this.isGrowingTaller = isGrowingTaller;
  }
  Expander(boolean isGrowingTaller) {
    c = randomColor();
    posn = new PVector(mouseX, mouseY);
    this.isGrowingTaller = isGrowingTaller;
  }

  void render() {
    rectMode(CENTER);
    fill(c);
    rect(posn.x, posn.y, size.x, size.y);
  }
  void xpand() {
    if (isGrowingTaller) {
      growTaller();
    } else {
      growWider();
    }
  }
  void growTaller() {
    size.y += speed;
  }
  void growWider() {
    size.x += speed;
  }
}

color randomColor() {
  return color(random(255), random(255), random(255));
}
