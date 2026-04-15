// PImage works for PNG/JPG. Cannot use WEBP
PImage catMarioImg;
PImage marioCatImg;
PImage[] spaceInvaderImgs = new PImage[2];
Integer spaceInvaderFrame = 0;

void setup() {
  size(800, 600);
  Float catMarScale = 2.5;

  catMarioImg = loadImage("catMario.png");
  catMarioImg.resize(int(catMarioImg.width*catMarScale),
    int(catMarioImg.height*catMarScale)); // Set resolution to x,y in PImage.resize(int x,int y);

  marioCatImg = loadImage("marioCat.png");
  marioCatImg.resize(int(marioCatImg.width*(catMarioImg.height/marioCatImg.height)),
                     catMarioImg.height);

  for (int i = 0; i<spaceInvaderImgs.length; i++) {
    spaceInvaderImgs[i] = loadImage("spaceInvader" + i + ".png");
    spaceInvaderImgs[i].resize(int(spaceInvaderImgs[i].width*(catMarioImg.height/spaceInvaderImgs[i].height)),
                     catMarioImg.height);
  }
  //spaceInvaderImgs[0] = loadImage("spaceInvader0.png");
  //spaceInvaderImgs[1] = loadImage("spaceInvader1.png");
}

void draw() {
  background(32);

  imageMode(CENTER); // x and y of image refers to the center of the image instead of the top left corner

  image(catMarioImg, width*(1.0/3.0), height/2);
  image(marioCatImg, width*(2.0/3.0), height/2);
  image(spaceInvaderImgs[spaceInvaderFrame],width/2,height/2);
  spaceInvaderFrame = (spaceInvaderFrame+1)%spaceInvaderImgs.length;
}
