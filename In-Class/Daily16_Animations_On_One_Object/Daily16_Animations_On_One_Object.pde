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


void setup() {
  size(800, 600);
  imageMode(CENTER);



  // initialize image arrays

  upImages = new PImage[8];
  downImages = new PImage[8];
  leftImages = new PImage[8];
  rightImages = new PImage[8];
  idleImages = new PImage[5];
  
  upImages = loadAnimation(4,"up","png");
  
  
  downImages = loadAnimation(4,"down","png");
  
 
  leftImages = loadAnimation(4,"left","png");
  
  
  rightImages = loadAnimation(4,"right","png");
  
  
  idleImages = loadAnimation(4,"idle","png");

  // initialize objects
  p1 = new Player(upImages,downImages,leftImages,rightImages,idleImages);
  p1.runSpeed = 2;
}



void draw() {
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



void keyPressed() {
  if (key == 'w') {
    p1.movingUp = true;
  } else if (key == 's') {
    p1.movingDown = true;
  } else if (key == 'a') {
    p1.movingLeft = true;
  } else if (key == 'd') {
    p1.movingRight = true;
  }
}



void keyReleased() {
  if (key == 'w') {
    p1.movingUp = false;
  } else if (key == 's') {
    p1.movingDown = false;
  } else if (key == 'a') {
    p1.movingLeft = false;
  } else if (key == 'd') {
    p1.movingRight = false;
  }
}
