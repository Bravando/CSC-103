ArrayList<Slider> sliders = new ArrayList<>();
Boolean erasingOldFrames = true,isMakingSliders = false;
//int initialTime, timeBeforeSlider = 200;
//char lastKey;

void setup() {
  size(600, 400, P2D);
  if (!erasingOldFrames) {
    background(32);
  }
  noStroke();
}

void draw() {
  if (erasingOldFrames) {
    background(32);
  }
  removeOutOfBoundsSliders(sliders);
  renderAndMoveSliders(sliders);
  //makeMoreSliders();
}

void keyPressed() {
  if (key == BACKSPACE) {
    if (!erasingOldFrames) {
      background(32);
    }
    sliders = new ArrayList<>();
  } else if (key == ' ') {
    erasingOldFrames = !erasingOldFrames;
  } else {
    //if(isMakingSliders){
      if(key == CODED){
        sliders.add(new Slider(keyCode, 30,randomColor()));
      }else{
        sliders.add(new Slider(key, 30,randomColor()));}
    //}
    //isMakingSliders = true;
    //lastKey = key;
  }
}
void keyReleased(){
    isMakingSliders = false;
}

//void makeMoreSliders(){
// if(millis() >= initialTime+timeBeforeSlider && isMakingSliders){
//    sliders.add(new Slider(lastKey, 30)); 
//    initialTime = millis();
// }
//}

void removeOutOfBoundsSliders(ArrayList<Slider> sList) {
  for (int i = 0; i<sList.size(); i++) {
    if (sList.get(i).outOfBounds()) {
      sList.remove(i).render();
    }
  }
}
void renderAndMoveSliders(ArrayList<Slider> sList) {
  for (int i = 0; i<sList.size(); i++) {
    sList.get(i).render();
    sList.get(i).move();
  }
}
