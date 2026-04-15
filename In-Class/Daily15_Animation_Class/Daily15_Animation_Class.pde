// PImage works for PNG/JPG. Cannot use WEBP
PImage catMarioImg;
PImage marioCatImg;
PImage[] sIImgs = new PImage[2];
Integer sIFrame = 0;
Animation sIAnim;

void setup() {
  size(800, 600);
  Float catMarScale = 2.5;

  catMarioImg = loadImage("catMario.png");
  catMarioImg.resize(int(catMarioImg.width*catMarScale),
    int(catMarioImg.height*catMarScale)); // Set resolution to x,y in PImage.resize(int x,int y);

  marioCatImg = loadImage("marioCat.png");
  marioCatImg.resize(int(marioCatImg.width*(catMarioImg.height/marioCatImg.height)),
                     catMarioImg.height);

  for (int i = 0; i<sIImgs.length; i++) {
    sIImgs[i] = loadImage("spaceInvader" + i + ".png");
    sIImgs[i].resize(int(sIImgs[i].width*(catMarioImg.height/sIImgs[i].height)),
                     catMarioImg.height);
  }
  
  sIAnim = new Animation(sIImgs,0.1,1);
  
  //spaceInvaderImgs[0] = loadImage("spaceInvader0.png");
  //spaceInvaderImgs[1] = loadImage("spaceInvader1.png");
}

void draw() {
  background(32);

  imageMode(CENTER); // x and y of image refers to the center of the image instead of the top left corner

  image(catMarioImg, width*(1.0/3.0), height/2);
  image(marioCatImg, width*(2.0/3.0), height/2);
  //image(sIImgs[sIFrame],width/2,height/2);
  //sIFrame = (sIFrame+1)%sIImgs.length;
  sIAnim.display(width/2,height/2);
}

void mouseClicked(){
 sIAnim.isAnimating = true; 
}
