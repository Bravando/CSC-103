class Square {
  int x, y, size, xSpeed, ySpeed;
  color fill,stroke;
  
  Square(int x, int y, int size, int xSpeed, int ySpeed, color fill, color stroke){
    this.x = x;
    this.y = y;
    this.size = size;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.fill = fill;
    this.stroke = stroke;
  }
  
  void bounceatbounds(Square squ){
    if(squ.x + (squ.size / 2) >= width || squ.x - (squ.size / 2) <= 0) {
      squ.xSpeed = squ.xSpeed * -1;
      fill = color(random(255),random(255),random(255));
      stroke = color(random(255),random(255),random(255));
    }
    if(squ.y + (squ.size / 2) >= height || squ.y - (squ.size / 2) <= 0) {
      squ.ySpeed = squ.ySpeed * -1;
      fill = color(random(255),random(255),random(255));
      stroke = color(random(255),random(255),random(255));
    }
  }
  void move(Square squ) {
    squ.x += squ.xSpeed;
    squ.y += squ.ySpeed;
}
  void makesquare(Square squ) {
    fill(squ.fill);
    stroke(squ.stroke);
    rect(squ.x,squ.y,squ.size,squ.size);
  }
  void makecircle(Square squ) {
    fill(squ.fill);
    stroke(squ.stroke);
    ellipse(squ.x,squ.y,squ.size,squ.size);
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
    void tribounceatbounds(Square squ){
      if(squ.x + (squ.size / 2) >= width || squ.x - (squ.size / 2) <= 0) {
        squ.xSpeed = squ.xSpeed * -1;
        fill = color(random(255),random(255),random(255));
        stroke = color(random(255),random(255),random(255));
      }
      if(squ.y + squ.size >= height || squ.y <= 0) {
        squ.ySpeed = squ.ySpeed * -1;
        fill = color(random(255),random(255),random(255));
        stroke = color(random(255),random(255),random(255));
    }
}
}
