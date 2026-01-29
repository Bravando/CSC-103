float tallestSide;
float smallerWheel;
float biggerWheel;
float midDiff;
float carButtX;
float carButt;
float carButtHeight;
float carMid;
float carMidX;
float carMidHeight;
float carFront;
float carFrontX;
float carFrontHeight;
float backWheelSize;
float backWheelX;
float frontWheelSize;
float frontWheelX;
float carAngle;
float wheelSizeMultiplier;


void setup(){
  
  size(800,600);
  rectMode(CENTER);
  fill(0);

  
  midDiff = height/8;
  midDiff = height/8;
  carButtX = width/4;
  carButt = width/3;
  carButtHeight = height/5;
  carMid = width/4;
  carMidX = carButtX+carButt/2+carMid/2;
  carFront = width/6;
  carFrontX = carMid/2+carFront/2;
  carFrontHeight = height/5;
  backWheelSize = 50;
  backWheelX = carButtX;
  frontWheelSize = 50;
  frontWheelX = carMidX+carMid/2;
  carAngle = 2*atan(((backWheelSize-frontWheelSize)/2)/(frontWheelX-backWheelX));
  wheelSizeMultiplier = 1;
  
}

void draw(){
  
  if(carButtHeight > carFrontHeight){
    tallestSide = carButtHeight;
  }
  else{
   tallestSide = carFrontHeight;
  }
  if(backWheelSize < frontWheelSize){
    smallerWheel = backWheelSize;
    biggerWheel = frontWheelSize;
  }
  else{
   smallerWheel = frontWheelSize;
   biggerWheel = backWheelSize;
  }
  carMidHeight = midDiff+tallestSide;
  
  pushMatrix();

  translate(carMidX,height-((biggerWheel-smallerWheel)/2)-(smallerWheel/1.25)*((biggerWheel-smallerWheel)/100)-(carButtHeight/2));

  rotate(carAngle);

  rect(-carMid/2-carButt/2,0,carButt,carButtHeight);
  rect(0,-midDiff/2,carMid,carMidHeight);
  rect(carFrontX,0,carFront,carFrontHeight);


  popMatrix();

  circle(backWheelX,height-backWheelSize/2,backWheelSize*wheelSizeMultiplier);
  circle(frontWheelX,height-frontWheelSize/2,frontWheelSize*wheelSizeMultiplier);
  
}
