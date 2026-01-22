size(800,600);
rectMode(CENTER);


// Important Changable Variables

int houseXPlace = width/2;
int houseYPlace = height/2;
int houseWidth = 100;
int houseHeight = 100;
int roofHeight = 50;
float doorSize = 0.5;
boolean roofHangover;

// Dependant Variables

int hangover = 0;
int roofX1Place = houseXPlace-(houseWidth/2)-hangover;
int roofY1Place = houseYPlace-(houseHeight/2);
int roofX2Place = houseXPlace;
int roofY2Place = houseYPlace-(houseHeight/2)-roofHeight;
int roofX3Place = houseXPlace+(houseWidth/2)+hangover;
int roofY3Place = houseYPlace-(houseHeight/2);


float doorHeight = houseHeight*doorSize;
float doorWidth = doorHeight/2;
int doorXPlace = houseXPlace;
float doorYPlace = houseYPlace+(houseHeight/2)-(doorHeight/2);  //just in case I want to change the width

float doorHandleDiameter = (doorWidth/4);
float doorHandleXPlace = doorXPlace + (doorWidth/3);
float doorHandleYPlace = doorYPlace;





roofHangover = true;


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
  
