import controlP5.*;
ControlP5 cp5;



// sorry for the spaghetti code

float tallestSide;
float smallerWheel;
float biggerWheel;
float midDiff;
float carButtX;
float carButtWidth;
float carButtHeight;
float carMidWidth;
float carMidX;
float carMidHeight;
float carFrontWidth;
float carFrontX;
float carFrontHeight;
float backWheelSize;
float backWheelX;
float frontWheelSize;
float frontWheelX;
float carAngle;
float wheelSizeMultiplier;
float backWheelRatio;
float frontWheelRatio;
float buttFrontDiff;
float frontButtDiff;


void setup(){
  
  size(800,600);
  rectMode(CENTER);
  cp5 = new ControlP5(this);

  
  carMidHeight = height/8;
  carButtX = width/4;
  carButtWidth = width/3;
  carButtHeight = height/4;
  carMidWidth = 200;
  carFrontWidth = width/6;
  carFrontHeight = height/5;
  backWheelSize = 50;
  frontWheelSize = 50;
 
  wheelSizeMultiplier = 1;
  
    
  cp5.addSlider("backWheelSize")
     .setValue(50)
     .setPosition(20,20)
     .setSize(10,100)
     .setRange(50,200)
     ;
  cp5.addSlider("frontWheelSize")
     .setValue(50)
     .setPosition(20,130)
     .setSize(10,100)
     .setRange(50,200)
     ;
  cp5.addSlider("carButtWidth")
     .setValue(width/3)
     .setPosition(20,240)
     .setSize(10,100)
     .setRange(250,400)
     ;
  cp5.addSlider("carButtHeight")
     .setValue(height/4)
     .setPosition(20,350)
     .setSize(10,100)
     .setRange(125,400)
     ;
  cp5.addSlider("carMidHeight")
     .setValue(carMidHeight)
     .setPosition(200,20)
     .setSize(10,100)
     .setRange(0,200)
     ;  
  cp5.addSlider("carMidWidth")
     .setValue(200)
     .setPosition(200,130)
     .setSize(10,100)
     .setRange(200,400)
     ;
  cp5.addSlider("carFrontWidth")
     .setValue(carFrontWidth)
     .setPosition(200,240)
     .setSize(10,100)
     .setRange(100,250)
     ;
  
  
}

void draw(){
  background(200);
  
  frontWheelX = carMidX+carMidWidth/2;
  carAngle = atan(((backWheelSize-frontWheelSize)/2)/(frontWheelX-backWheelX));
  carMidX = carButtX+carButtWidth/2+carMidWidth/2;
  carFrontX = carMidWidth/2+carFrontWidth/2;
  backWheelX = carButtX;
  
  
  if(carButtHeight > carFrontHeight){
    tallestSide = carButtHeight;
    buttFrontDiff = (carButtHeight-carFrontHeight)/2;
    frontButtDiff = 0;
  }
  else{
   tallestSide = carFrontHeight;
   frontButtDiff = (carButtHeight-carFrontHeight)/2;
   buttFrontDiff = 0;
  }
  if(backWheelSize < frontWheelSize){
    smallerWheel = backWheelSize;
    biggerWheel = frontWheelSize;
  }
  else{
   smallerWheel = frontWheelSize;
   biggerWheel = backWheelSize;
  }
  
  backWheelRatio = (frontWheelX-backWheelX)/(carMidX-backWheelX);
  frontWheelRatio = (frontWheelX-backWheelX)/(frontWheelX-carMidX);
  midDiff = carMidHeight+tallestSide;
  
  fill(0);
  pushMatrix();

  translate(carMidX,height-smallerWheel-carMidHeight/2-(carButtHeight-carFrontHeight)/2);

  rotate(carAngle);

  rect(-carMidWidth/2-carButtWidth/2,frontButtDiff,carButtWidth,carButtHeight);
  rect(0,-carMidHeight/2,carMidWidth,midDiff);
  rect(carFrontX,buttFrontDiff,carFrontWidth,carFrontHeight);


  popMatrix();
   fill(#FC6E6E);

  circle(backWheelX,height-backWheelSize/2,backWheelSize*wheelSizeMultiplier);
  circle(frontWheelX,height-frontWheelSize/2,frontWheelSize*wheelSizeMultiplier);
  

  
  
}
