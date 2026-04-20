// declare objects
Player p1;

// declare image arrays
PImage[] upImages;
PImage[] downImages;
PImage[] leftImages;
PImage[] rightImages;
PImage[] idleImages;

// declare animation objects
Animation upAnim;
Animation downAnim;
Animation leftAnim;
Animation rightAnim;
Animation idleAnim;


void setup(){
  size(1000,800);
  imageMode(CENTER);
  
  // initialize objects
  p1 = new Player();
  
  // initialize image arrays
  upImages = new PImage[4];
  downImages = new PImage[4];
  leftImages = new PImage[4];
  rightImages = new PImage[4];
  idleImages = new PImage[4];
  
  for (int index=0; index<= upImages.length-1; index++){
    upImages[index] = loadImage("up" + index + ".png");
  }
  for (int index=0; index<= downImages.length-1; index++){
    downImages[index] = loadImage("down" + index + ".png");
  }
  for (int index=0; index<= leftImages.length-1; index++){
    leftImages[index] = loadImage("left" + index + ".png");
  }
  for (int index=0; index<= rightImages.length-1; index++){
    rightImages[index] = loadImage("right" + index + ".png");
  }
   for (int index=0; index<= idleImages.length-1; index++){
    idleImages[index] = loadImage("idle" + index + ".png");
  }
  
  // initialize animation objects
  upAnim = new Animation(upImages, 0.05, 1);
  downAnim = new Animation(downImages, 0.05, 1);
  leftAnim = new Animation(leftImages, 0.05, 1);
  rightAnim = new Animation(rightImages, 0.05, 1);
  idleAnim = new Animation(idleImages, 0.05, 1);
}



void draw(){
  background(42);
  
  p1.render();
  p1.move();
  
  //upAnim.isAnimating = true;
  //upAnim.display();
  //downAnim.isAnimating = true;
  //downAnim.display();
  //leftAnim.isAnimating = true;
  //leftAnim.display();
  //rightAnim.isAnimating = true;
  //rightAnim.display();
  //idleAnim.isAnimating = true;
  //idleAnim.display();
  
  
}



void keyPressed(){
  if (key == 'w'){
    p1.movingUp = true; 
  }
  
  else if (key == 's'){
    p1.movingDown = true; 
  }
  
  else if (key == 'a'){
    p1.movingLeft = true; 
  }
  
  else if (key == 'd'){
    p1.movingRight = true; 
  }
}



void keyReleased(){
  if (key == 'w'){
    p1.movingUp = false; 
  }
  
  else if (key == 's'){
    p1.movingDown = false; 
  }
  
  else if (key == 'a'){
    p1.movingLeft = false; 
  }
  
  else if (key == 'd'){
    p1.movingRight = false; 
  }
}
