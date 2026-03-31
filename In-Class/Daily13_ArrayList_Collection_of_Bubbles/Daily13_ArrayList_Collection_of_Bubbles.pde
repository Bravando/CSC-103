color up = color(145, 198, 240), // Color of Bubbles primarily moving upward
  right = color(255, 200, 53); // Color of Bubbles that move more to the right
float shiftToRight = 3; // by how much are the right moving Bubbles guaranteed to move to the right
boolean goingLeft = true; // if given true, the Bubbles will move to the left
ArrayList<Bubble> upBubs = new ArrayList<Bubble>();
//ArrayList<Bubble> rightBubs = new ArrayList<Bubble>();
void setup() {
  size(800, 600);
  /*
  for (int i = 0; i<3; i++) {
   upBubs.add(new Bubble(up));
   }
   */

  /*
  for(int i = 0;i<3;i++){
   rightBubs.add(new Bubble(right, shiftToRight, !goingLeft));
   }
   */
}

void draw() {
  background(42);
  drawBubList(upBubs);
  //drawBubList(rightBubs);
}

void drawBubList(ArrayList<Bubble> bubList) {
  for (int i = 0; i<bubList.size(); i++) {
    bubList.get(i).render();
  }
}
/*    // Example of a ForEach Loop
void drawBubList(ArrayList<Bubble> bubList) {
  for (Bubble aBub : bubList) {
    aBub.render();
  }
}
*/
void keyPressed() {
  if (key == 'a') {
    upBubs.add(new Bubble(randomColor()));
  }
  if (key == 'r') {
    if (upBubs.size()>0) {
      upBubs.remove(0);
    }
  }
}
color randomColor() {
  return color(random(255), random(255), random(255));
}
