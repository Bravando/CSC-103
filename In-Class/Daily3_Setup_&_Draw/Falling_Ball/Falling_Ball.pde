
float v;
float g;
float ballY;
int ballX;
int ballDiameter;
color ballColor;
boolean isColored;
int ballRadius;
int bgR = 0;
int bgG = 0;
int bgB = 0;
int rI = 1;
int gI = 2;
int bI = 3;


void setup(){
  size(800,600);
  ballDiameter = 50;
  ballX = width/2;
  ballY = ballDiameter/2;
  ballColor = color(100);
  isColored = false;
  g = 9.8;
  v = 0;
  ballRadius = ballDiameter/2;
  textSize(30);
  
  
}

void draw(){
  background(bgR,bgG,bgB);
  
  bgR = bgR + rI;
  if(bgR >= 255){
    rI = -rI;
  }
  if(bgR <= 0){
    rI = -rI;
  }
  
  bgG = bgG + gI;
if(bgG >= 255){
    gI = -gI;
  }
  if(bgG <= 0){
    gI = -gI;
  }
  
  bgB = bgB + bI;
if(bgB >= 255){
    bI = -bI;
  }
  if(bgB <= 0){
    bI = -bI;
  }
  
  fill(ballColor);
  stroke(ballColor);
  
  
  text("Click to reset",100,200);
  if(isColored){
    fill(234,24,24);
    text("Press any key to change color | Uses: 0",100,400);
    fill(ballColor);
  }
  else{
    text("Press any key to change color | Uses: 1",100,400); 
  }
  
  v = v+(g/60);
  fall();
  if(ballY >= height-ballRadius){
    v = -v + v/5;
    circle(ballX,height-ballRadius,ballDiameter);
  }
  else{
    circle(ballX,ballY,ballDiameter);
  }
}


void onClick(){
  ballY = ballDiameter/2;
  
}

void keyPressed(){
  
  if(isColored == false){
    ballColor = color(random(255),random(255),random(255));
    isColored = true;
  }
  
}

void fall(){
  ballY = ballY+v;
}

void mousePressed(){
  ballY = ballRadius;
  v = 0;
}
void invertColorIncrement(int C, int I){
  if(C >= 255){
    I = -I;
  }
  if(C <= 0){
    I = -I;
  }
}
