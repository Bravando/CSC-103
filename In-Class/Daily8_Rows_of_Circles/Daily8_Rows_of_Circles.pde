float size0, size1;
PVector place0, place1, place2, place3;
int number0, number1, number2, number3;
color c1 = color(255, 0, 0), c2 = color(0, 255, 0), c3 = color(0, 0, 255);
color[] colors = {c1,c2,c3};
void setup() {
  size(800, 600);
  size0 = 50;
  size1 = 75;
  place0 = new PVector(width/2, size0/2);
  place1 = new PVector(size0/2, height/2);
  place2 = new PVector(width/2, height-size1*.5);
  place3 = new PVector(width-size1/2, height/2);
  number0 = ceil(width/size0);
  number1 = ceil(height/size0);
  number2 = ceil(width/size1);
  number3 = ceil(height/size1);
  //makeAlternatingCircleColumn(place1, size0, number1, c1, c2, c3);
  //makeCircleRowFor(place0, size0, number0, c1, c2, c3);
  //makeCircleRowWhile(place2, size1, number2, c1, c3, c2);
  //makeAlternatingCircleColumn(place3, size1, number3, c2, c1, c3);
  makeAlternatingCircleColumnA(new PVector(25,height/2),50,height/50,colors);
}

void draw() {
}


void makeCircle(float x, float y, float d, color c) {
  fill(c);
  circle(x, y, d);
}

void makeAlternatingCircleColumn(PVector posn, float size, int howMany, color c1, color c2, color c3) {

  for (int i = 0; i<howMany; i++) {
    if (i%3 == 0) {
      makeCircle(posn.x, posn.y-(size*((float(howMany-1)/2)-i)), size, c1);
    } else if (i%3 == 1) {
      makeCircle(posn.x, posn.y-(size*((float(howMany-1)/2)-i)), size, c2);
    } else {
      makeCircle(posn.x, posn.y-(size*((float(howMany-1)/2)-i)), size, c3);
    }
  }
}
void makeCircleRowFor(PVector posn, float size, int howMany, color c1, color c2, color c3) {

  for (int i = 0; i<howMany; i++) {
    if (i%3 == 0) {
      makeCircle(posn.x-(size*((float(howMany-1)/2)-i)), posn.y, size, c1);
    } else if (i%3 == 1) {
      makeCircle(posn.x-(size*((float(howMany-1)/2)-i)), posn.y, size, c2);
    } else {
      makeCircle(posn.x-(size*((float(howMany-1)/2)-i)), posn.y, size, c3);
    }
  }
}
void makeCircleRowWhile(PVector posn, float size, int howMany, color c1, color c2, color c3) {
  int i = 0;
  while (i<howMany) {
    if (i%3 == 0) {
      makeCircle(posn.x-(size*((float(howMany-1)/2)-i)), posn.y, size, c1);
    } else if (i%3 == 1) {
      makeCircle(posn.x-(size*((float(howMany-1)/2)-i)), posn.y, size, c2);
    } else {
      makeCircle(posn.x-(size*((float(howMany-1)/2)-i)), posn.y, size, c3);
    }
    i++;
  }
}

void makeAlternatingCircleColumnA(PVector posn, float size, int howMany, color[] colors) {

  for (int i = 0; i<howMany; i++) {
    for (int j = 0; j<colors.length; j++) {
      if (i % colors.length == j) {
        makeCircle(posn.x, posn.y-(size*((float(howMany-1)/2)-i)), size, colors[j]);
      }
    }
  }
}
