//import controlP5.*;
//ControlP5 cp5;

// Important Changable Variables

int houseXPlace;
int houseYPlace;
int houseWidth;
int houseHeight;
int roofHeight;
float doorSize;
boolean roofHangover;

// Dependant Variables

int hangover;
int roofX1Place;
int roofY1Place;
int roofX2Place;
int roofY2Place;
int roofX3Place;
int roofY3Place;


float doorHeight;
float doorWidth;
int doorXPlace;
float doorYPlace;

float doorHandleDiameter;
float doorHandleXPlace;
float doorHandleYPlace;




void setup(){
  size(800,600);
//  cp5 = new ControlP5(this);
  rectMode(CENTER);
  roofHangover = true;
  
  houseXPlace = width/2;
  houseYPlace = height/2;
  houseWidth = 100;
  houseHeight = 100;
  roofHeight = 50;
  doorSize = 0.5;

// Dependant Variables

  hangover = 0;
  roofX1Place = houseXPlace-(houseWidth/2)-hangover;
  roofY1Place = houseYPlace-(houseHeight/2);
  roofX2Place = houseXPlace;
  roofY2Place = houseYPlace-(houseHeight/2)-roofHeight;
  roofX3Place = houseXPlace+(houseWidth/2)+hangover;
  roofY3Place = houseYPlace-(houseHeight/2);


  doorHeight = houseHeight*doorSize;
  doorWidth = doorHeight/2;
  doorXPlace = houseXPlace;
  doorYPlace = houseYPlace+(houseHeight/2)-(doorHeight/2);  //just in case I want to change the width

  doorHandleDiameter = (doorWidth/4);
  doorHandleXPlace = doorXPlace + (doorWidth/3);
  doorHandleYPlace = doorYPlace;
  
  //cp5.addSlider("House Width")
  //   .setValue(100)
  //   .setPosition(20,20)
  //   .setSize(10,100)
  //   .setRange(50,400)
  //   .setNumberOfTickMarks(8)
  //   ;
     
  //cp5.addSlider("House Height")
  //   .setValue(100)
  //   .setPosition(20,140)
  //   .setSize(10,100)
  //   .setRange(50,400)
  //   .setNumberOfTickMarks(8)
  //   ;
  // cp5.addSlider("Roof Height")
  //    .setValue(50)
  //   .setPosition(20,260)
  //   .setSize(10,100)
  //   .setRange(50,400)
  //   .setNumberOfTickMarks(8)
  //   ;
  //cp5.addSlider("Door Size")
  //   .setValue(0.5)
  //   .setPosition(20,380)
  //   .setSize(10,100)
  //   .setRange(50,400)
  //   .setNumberOfTickMarks(8)
  //   ;
  //cp5.addButton("Roof_Hangover")
  //   .setPosition(20,500)
  //   .setSize(50,20)
  //   ;
     
  
}

void draw() {
                                      //House
  rect(houseXPlace,houseYPlace,houseWidth,houseHeight);

                                      //Roof
  
  triangle(roofX1Place, roofY1Place,
           roofX2Place, roofY2Place,
           roofX3Place, roofY3Place);
         
                                      //Door
  rect(doorXPlace, doorYPlace,
       doorWidth, doorHeight);
                                      //Door Handle
  circle(doorHandleXPlace, doorHandleYPlace,
         doorHandleDiameter);
  

  
}

//public void controlEvent(ControlEvent theEvent) {
//  println(theEvent.getController().getName());
//}

//public void Roof_Hangover(){
//  if(roofHangover == true){
//    roofHangover = false;}
//  else{roofHangover = true;}}
