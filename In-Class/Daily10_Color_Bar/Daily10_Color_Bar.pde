
ColorBar bar;
PVector place, size;
color c1, c2, c3;
Button button1;
boolean redPressed = false, bluePressed = false, greenPressed = false;

void setup() {
  size(800, 600);
  size = new PVector(width, height/8);
  place = new PVector(width/2, height*.875);
  bar = new ColorBar(place, size, color(255));
  c1 = color(255, 0, 0);
  c2 = color(0, 255, 0);
  c3 = color(0, 0, 255);
  button1 = new Button(new PVector(width/4, height/4), height/8, true, true, c1);
}

void draw() {
  background(42);
  strokeWeight(0);
  bar.newButton(new PVector(width/4, height/4), height/8, true, true, c1);
  bar.newButton(new PVector(width/2, height/4), height/8, true, true, c2);
  bar.newButton(new PVector(width*.75, height/4), height/8, true, true, c3);
  //bar.addButton(button1);
  bar.drawAll();
  textSize(30);
  text("Click buttons to change", width/4, height/2-30);
  text("Press the spacebar to reset", width/4, height/2+30);

  bar.scaleIntensityByMouseX();
}

void mousePressed() {
  bar.changeBar();
}

void keyPressed() {
  if (key == ' ') {
    bar.resetBar();
  }
}

//-----------------------------------------------------------------------------------------  isInButton  -------------------------------------------
boolean isInButton(float x, float y, float wid){
 return(inSquareCentered(x,y,wid,mouseX,mouseY));
}
//--------------------------------------------------------------------------------------------------------------------------------------------------


  boolean inSquareCentered(float x, float y, float side, float inputX, float inputY) {
    /*
  checks if the input is in the given square centered at (x,y) with sides of side
     */
    float radius = side/2;
    return inBounds(inputX, inputY, x-radius, x+radius, y-radius, y+radius);
  }
    boolean inBounds(float x, float y, float leftBound, float rightBound, float topBound, float bottomBound) {
    /*
  checks if the given input is within all four bounds
     */
    return ((leftBound <= x) && (x <= rightBound) && (topBound <= y) && (y <= bottomBound));
  }

class ColorBar {
  /*
  A bar that is a certain color. That color can be changed to the color of the button
   */
  ArrayList<Button> buttons = new ArrayList<Button>();
  PVector posn, size;
  color c, initial;
  float intensity = 1;

  ColorBar(ArrayList<Button> buttons, PVector centerOfBar, PVector size, color theDefault) {
    this.buttons = buttons;
    posn = centerOfBar;
    this.size = size;
    c = theDefault;
    initial = theDefault;
  }
  ColorBar(PVector centerOfBar, PVector size, color theDefault) {
    posn = centerOfBar;
    this.size = size;
    c = theDefault;
    initial = theDefault;
  }

  void drawBar() {
    rectMode(CENTER);
    fill(red(c)*intensity, green(c)*intensity, blue(c)*intensity);
    rect(posn.x, posn.y, size.x, size.y);
    
    //-------------------------------------------------------------------------------------------  See, the booleans are in the function -----------------------------
    if (redPressed) {
      c = color(255, 0, 0);
    } else if (greenPressed) {
      c = color(0, 255, 0);
    } else if (bluePressed) {
      c = color(0, 0, 255);
    }
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------
  }
void drawButtons() {
  for (int i = 0; i<buttons.size(); i++) {
    buttons.get(i).drawButton();
  }
}

//----------------------------------------------------------------------------  Using the Map function  ---------------------------------------------
void scaleIntensityByMouseX() {
  intensity = map(mouseX, 0, width, 0, 1);
}
//---------------------------------------------------------------------------------------------------------------------------------------------------

void drawAll() {
  drawBar();
  drawButtons();
}
void newButton(PVector posn, float size, boolean isSquare, boolean isOn, color c) {
  buttons.add(new Button(posn, size, isSquare, isOn, c));
}
void addButton(Button b) {
  buttons.add(b);
}
Button buttonClicked() {
  Button jeff = new Button(c);
  for (int i = 0; i<buttons.size(); i++) {
    if (buttons.get(i).isOn && buttons.get(i).wasClicked()) {
      jeff = buttons.get(i);
    }
  }
  return jeff;
}
void changeBar() {
  c = buttonClicked().c;
}
void resetBar() {
  c = initial;
}
/*
   -----------------------------------------------------------------  Helper Function  --------------------------------------------------------------------
 */
void fillWith(ArrayList list, Object added) {
  /*
    fills the given ArrayList with the given object in place of every value it contains
   */
  int howMany = list.size();
  for (int i = howMany-1; i>=0; i--) {
    list.remove(i);
  }
  for (int i = 0; i<howMany; i++) {
    list.add(added);
  }
}
void shortenTo(ArrayList chungus, ArrayList shorty) {
  /*
    removes the initial values of the first given ArrayList
   until it is the same length as the second given ArrayList
   */
  for (int i = 0; i<(chungus.size()-shorty.size()); i++) {
    chungus.remove(i);
  }
}
}
class Button {
  PVector posn = new PVector(0, 0);
  float size = 0;
  boolean isOn = false, isSquare = false;
  color c = 0;
  Button(PVector posn, float size, boolean isSquare, boolean isOn, color c) {
    this.posn = posn;
    this.size = size;
    this.isSquare = isSquare;
    this.isOn = isOn;
    this.c = c;
  }
  Button(color c) {
    this.c = c;
  }
  Button() {
  }

  void drawButton() {
    if (isOn) {
      fill(c);

      if (isSquare) {
        rectMode(CENTER);
        square(posn.x, posn.y, size);
      } else {
        circle(posn.x, posn.y, size);
      }
    }
  }

  //-----------------------------------------------------------------------------------------  drawButton for assignment  ---------------------------------------
  void drawButtonButDumb(float buttonX, float buttonY, float buttonWidth, color buttonColor) {
    fill(buttonColor);
    rectMode(CENTER);
    square(buttonX, buttonY, buttonWidth);
  }
  //-------------------------------------------------------------------------------------------------------------------------------------------------------------
  boolean onButton(float x, float y) {
    if (isSquare) {
      return inSquareCentered(posn.x, posn.y, size, x, y);
    } else {
      return inDistance(posn.x, posn.y, size, x, y);
    }
  }
  boolean wasClicked() {
    return onButton(mouseX, mouseY);
  }

  //
  //----------------------------------------------------------  Helper Functions ------------------------------------------------------------
  //
  boolean inBounds(float x, float y, float leftBound, float rightBound, float topBound, float bottomBound) {
    /*
  checks if the given input is within all four bounds
     */
    return ((leftBound <= x) && (x <= rightBound) && (topBound <= y) && (y <= bottomBound));
  }
  boolean inSquareCentered(float x, float y, float side, float inputX, float inputY) {
    /*
  checks if the input is in the given square centered at (x,y) with sides of side
     */
    float radius = side/2;
    
    return inBounds(inputX, inputY, x-radius, x+radius, y-radius, y+radius);
  }
  boolean inDistance(float centerX, float centerY, float distance, float checkedX, float checkedY) {
    /*
  Checks if a given point is within a given distance of another point
     */
    return distance >= dist(centerX, centerY, checkedX, checkedY);
  }
}
