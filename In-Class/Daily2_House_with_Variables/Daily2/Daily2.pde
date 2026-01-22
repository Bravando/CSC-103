import controlP5.*;
ControlP5 cp5;

// Important Changable Variables

int houseXPlace,
    houseYPlace,
    houseWidth,
    houseHeight,
    roofHeight;
float doorSize;
boolean roofHangover;

// Dependant Variables

int hangover,
    roofX1Place,
    roofY1Place,
    roofX2Place,
    roofY2Place,
    roofX3Place,
    roofY3Place;


float doorHeight,
      doorWidth;
int doorXPlace;
float doorYPlace;

float doorHandleDiameter,
      doorHandleXPlace,
      doorHandleYPlace;




void setup(){
  size(800,600);
  stroke(#FF6FD6);
  cp5 = new ControlP5(this);
  rectMode(CENTER);
  roofHangover = true;
  
  houseXPlace = width/2;
  houseYPlace = height/2;
  houseWidth = 100;
  houseHeight = 100;
  roofHeight = 50;
  doorSize = 0.5;
  hangover = 0;

  cp5.addSlider("houseWidth")
     .setValue(100)
     .setPosition(20,20)
     .setSize(10,100)
     .setRange(50,400)
     ;
     
  cp5.addSlider("houseHeight")
     .setValue(100)
     .setPosition(20,140)
     .setSize(10,100)
     .setRange(50,400)
     ;
   cp5.addSlider("roofHeight")
      .setValue(50)
     .setPosition(20,260)
     .setSize(10,100)
     .setRange(10,200)
     ;
  cp5.addSlider("doorSize")
     .setValue(0.5)
     .setPosition(20,380)
     .setSize(10,100)
     .setRange(0.01,1)
     ;
  cp5.addButton("Roof_Hangover")
     .setPosition(20,500)
     .setSize(100,20)
     ;
     
  
}

void draw() {
  background(#286F9D);
  
  if(roofHangover == true)
    {hangover = houseWidth/10;}
  else{hangover = 0;}
  
  // Dependant Variables
  roofX1Place = houseXPlace-(houseWidth/2)-hangover;
  roofY1Place = houseYPlace-(houseHeight/2);
  roofX2Place = houseXPlace;
  roofY2Place = houseYPlace-(houseHeight/2)-roofHeight;
  roofX3Place = houseXPlace+(houseWidth/2)+hangover;
  roofY3Place = houseYPlace-(houseHeight/2);


  doorHeight = houseHeight*doorSize;
  doorWidth = doorHeight/2;
  if(doorWidth > houseWidth){
    doorWidth = houseWidth;
    doorHeight = doorWidth*2;
  }
  doorXPlace = houseXPlace;
  doorYPlace = houseYPlace+(houseHeight/2)-(doorHeight/2);  //just in case I want to change the width

  doorHandleDiameter = (doorWidth/4);
  doorHandleXPlace = doorXPlace + (doorWidth/3);
  doorHandleYPlace = doorYPlace;
  
                                      //House
  fill(#86CFFF);
  rect(houseXPlace,houseYPlace,houseWidth,houseHeight);

                                      //Roof
  fill(#E0C378);
  triangle(roofX1Place, roofY1Place,
           roofX2Place, roofY2Place,
           roofX3Place, roofY3Place);
         
                                      //Door
  fill(#A57328);
  rect(doorXPlace, doorYPlace,
       doorWidth, doorHeight);
                                      //Door Handle
  fill(#F0E91B);
  circle(doorHandleXPlace, doorHandleYPlace,
         doorHandleDiameter);
  

  
}

//public void controlEvent(ControlEvent theEvent) {
//  println(theEvent.getController().getName());
//}

public void Roof_Hangover(){
  //println("It works");
  if(roofHangover == true){
    roofHangover = false;}
  else{roofHangover = true;}
}
