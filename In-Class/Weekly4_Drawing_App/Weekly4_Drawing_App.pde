int strokeWidth;
int maxStroke;
color strokeC;

/*
I started doin goofy stuff, but I ran out of time
*/

void setup() {
  size(800, 600);
  background(255);
  strokeWidth = 1;
  maxStroke = 10;
}

void draw() {
  strokeWeight(strokeWidth);
  stroke(strokeC);
  if (mousePressed) {
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
void keyPressed() {
  if (key == 'r') {
    strokeC = color(255, 0, 0);
  } else if (key == 'g') {
    strokeC = color(0, 255, 0);
  } else if (key == 'b') {
    strokeC = color(0, 0, 255);
  } else if (key == 'w') {
    strokeC = color(255);
  } else if (key == 'k') {
    strokeC = color(0);
  } else if (key == 'y') {
    strokeC = color(128);
  } else if (key == 'R') {
    background(255, 0, 0);
  } else if (key == 'G') {
    background(0, 255, 0);
  } else if (key == 'B') {
    background(0, 0, 255);
  } else if (key == 'W') {
    background(255);
  } else if (key == 'K') {
    background(0);
  } else if (key == 'Y') {
    background(128);
  } else if (key == 'i' && strokeWidth < maxStroke) {
    strokeWidth ++;
  } else if (key == 'd' && strokeWidth > 1) {
    strokeWidth --;
  }
}

//void colorToPick(color c, float x, float y, float size) {
//  /*
//  draws a square that with a "clickable" icon that changes the color if the stroke or background when clicked
//   and changes to a paint bucket when holding shift. If the square is clicked, change the stroke to its assigned color, or if
//   the SHIFT key is held down, change the background color
//   */
//  fill(255);
//  stroke(0);
//  strokeWeight(2);
//  square(x, y, size);

//  fill(c);
//  stroke(c);
//  square(x+size/6, y+size/6, size*4/6);
//    if (inSquareHitbox(x, y, size, mouseX, mouseY)) {
//    if (keyCode == SHIFT) {
//      background(c);
//    } else {
//      strokeC = c;
//    }
//  }
//}

//boolean inSquareHitbox(float topLeftX, float topLeftY, float size, float inputX, float inputY) {
//  /*
//  determines if the given input location is in the box drawn from the top left
//   at the given topLeft location with side lengths equal to the given size.
//   */
//  return(inputX<topLeftX+size && inputX>topLeftX && inputY<topLeftY+size && inputY>topLeftY);
//}
//void drawClickable(float x,float y,float size){
//  /*
//  draw a mouse pointer with action lines around it centered at the given x & y
//  */
//  pushMatrix();
//  rotate(-PI/3);
//  fill(255);
//  stroke(0);
//  strokeWeight(2);
//  triangle(x-10,y-10,x+10,y-10,x,y+20);
//  line(x,y-10,x,y-30);
//  line
//}
