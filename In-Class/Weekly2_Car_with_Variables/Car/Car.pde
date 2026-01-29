size(800,600);

rectMode(CENTER);
fill(0);
float carHeight = height/4;
float carButtX = width/4;
float carButt = width/3;
float carButtHeight = height/5;
float carMid = width/4;
float carMidX = carButtX+carButt/2+carMid/2;
float carMidHeight = height/3;
float carFront = width/6;
float carFrontX = carButtX+carButt/2+carMid+carFront/2;
float carFrontHeight = height/5;
float backWheelSize = 50;
float frontWheelSize = 50;
pushMatrix();
rotate(PI);

rect(carButtX,(height/1.5)-(backWheelSize/2)-(carButtHeight/2),carButt,carButtHeight);
rect(carMidX,(height/1.5)-(backWheelSize/4)-(frontWheelSize/4)-(carMidHeight/2),carMid,carMidHeight);
rect(carFrontX,(height/1.5)-(frontWheelSize/2)-(carFrontHeight/2),carFront,carFrontHeight);
popMatrix();
circle(carButtX,height/1.5,backWheelSize);
circle(carFrontX-carFront/2,height/1.5,frontWheelSize);
