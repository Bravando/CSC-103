size(800,600);
background(#286F9D);
rectMode(CENTER);

stroke(#FF6FD6);
// Important Changable Variables

int houseXPlace = width/2;
int houseYPlace = height/2;
int houseWidth = 300;
int houseHeight = 300;
int roofHeight = 100;
float doorSize = 0.5;
boolean roofHangover = false;

// Dependant Variables

int hangover = 0;

roofHangover = true;

if(roofHangover == true){hangover = houseWidth/10;}
else{hangover = 0;}

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
  
