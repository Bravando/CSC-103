int startTime, currentTime, interval, whichColor;
float smallerSide, spacing, lightSize;
color c1, c2, c3, off;
PVector stopLightPosn;
color[] colors1, colors2;
StopLight oldHighway5;

/*
When grading, uncomment the longer definition and change the interval variable to change the time interval.

Comment out the second line, which uses the natural interval of the class (2500 milliseconds)
*/

void setup() {
  size(800, 600);
  //if (width < height) {
  //  smallerSide = width;
  //} else {
  //  smallerSide = height;
  //}
  whichColor = 0;
  //startTime = millis();
  interval = 1000;
  c1 = color(255, 0, 0);
  c2 = color(255, 255, 0);
  c3 = color(0, 255, 0);
  off = color(0);
  colors1 = new color[] {c1, c2, c3};
  colors2 = new color[] {c1, c2, c3, off};
  stopLightPosn = new PVector(width*0.5, height*0.5);
  spacing = height/5;
  lightSize = height/4;
  //oldHighway5 = new StopLight(stopLightPosn, lightSize, spacing, colors1, off, whichColor, interval);
  oldHighway5 = new StopLight(stopLightPosn, lightSize, spacing, colors2);
}

void draw() {
  background(42);
  //currentTime = millis();

  //if (currentTime-startTime >= interval) {

  //  if (whichColor >= 2) {
  //    whichColor = 0;
  //  } else {
  //    whichColor++;
  //  }

  //  startTime = currentTime;
  //}
  //makeStopLight(stopLightPosn.x, stopLightPosn.y, lightSize, spacing, c1, c2, c3, off, whichColor);
  oldHighway5.drawStopLight();
}

//void makeCircle(float x, float y, float d, color c) {
//  fill(c);
//  circle(x, y, d);
//}
//void makeStopLight(float x, float y, float dia, float dist, color c1, color c2, color c3, color off, int whichIsOn) {
//  color[] colors = {c1, c2, c3};
//  colors = whichLight(colors, off, whichIsOn);
//  for (int i = 0; i < 3; i++) {
//    makeCircle(x, y+(dist+dia/2)*(-1+i), dia, colors[i]);
//  }
//}
//void makeStopLightA(float x, float y, float dia, float dist, color[] colors, color off, int whichIsOn) {
//  colors = whichLight(colors, off, whichIsOn % colors.length);
//  for (int i = 0; i < 3; i++) {
//    makeCircle(x, y+(dist+dia/2)*(-1+i), dia, colors[i]);
//  }
//}
//color[] whichLight(color[] cs, color off, int whichIsOn) {
//  /*
//  Takes a given Array of colors and sets all of them to the given Color off
//   unless they are in the position corresponding to the given Integer whichIsOn
//   */
//  for (int i = 0; i < cs.length; i++) {
//    if (!(i == whichIsOn)) {
//      cs[i] = off;
//    }
//  }
//  return cs;
//}
int[] addToIntArray(int[] initialA, int addedValue) {
  int[] newA = new int[initialA.length+1];
  for (int i = 0; i<initialA.length; i++) {
    newA[i] = initialA[i];
  }
  newA[initialA.length] = addedValue;
  return newA;
}

int[] removeLastValue(int[] initialA) {
  int[] newA = new int[initialA.length-1];
  for (int i = 0; i<initialA.length-1; i++) {
    newA[i] = initialA[i];
  }
  return newA;
}

class StopLight {
  color[] colors;
  color off = color(0);
  PVector posn;
  float spacing = 100, lightSize = 100;
  int startT = millis(), currentT, interval = 2500, whichIsOn = 0;

  StopLight(PVector centerCoor, float lightSize, float spacing, color[] colors, color off, int whichIsOn, int timeColorChange) {
    posn = centerCoor;
    this.lightSize = lightSize;
    this.spacing = spacing;
    this.colors = colors;
    this.off = off;
    this.whichIsOn = whichIsOn;
    interval = timeColorChange;
  }
  StopLight(PVector centerCoor, float lightSize, float spacing, color[] colors) {
    posn = centerCoor;
    this.lightSize = lightSize;
    this.spacing = spacing;
    this.colors = removeLastValue(colors);
    off = colors[colors.length-1];
  }

  void drawStopLight() {
    currentT = millis();
    if (currentT-startT >= interval) {
      whichIsOn = (whichIsOn+1)%colors.length;
      startT = currentT;
    }
    for (int i = 0; i < colors.length; i++) {
      if (i == whichIsOn) {
        makeCircle(posn.x, posn.y+(spacing+lightSize/2)*(-1+i), lightSize, colors[i]);
      } else {
        makeCircle(posn.x, posn.y+(spacing+lightSize/2)*(-1+i), lightSize, off);
      }
    }
  }

  // ----------------------------------------------------  Helper Functions  ----------------------------------------------------
  void makeCircle(float x, float y, float d, color c) {
    // makes a circle using the built in function, but applies fill of the given color first
    fill(c);
    circle(x, y, d);
  }
  int[] removeLastValue(int[] initialA) {
    int[] newA = new int[initialA.length-1];
    for (int i = 0; i<initialA.length-1; i++) {
      newA[i] = initialA[i];
    }
    return newA;
  }
}
