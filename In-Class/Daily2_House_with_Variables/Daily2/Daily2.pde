
size(800,600);

int houseXPlace = width/2;
int houseYPlace = height/2;
int houseWidth = 100;
int houseHeight = 100;
int roofHeight = 50;
float doorSize = 0.5;
float doorHeight = houseHeight*doorSize;
float doorWidth = doorHeight/2;
boolean roofHangover = true;
int hangover; 
if(roofHangover){hangover = (houseWidth/10);}
else{hangover = 0;}

rectMode(CENTER);

triangle(houseXPlace-(houseWidth/2)-hangover,
         houseYPlace-(houseHeight/2),
         houseXPlace,
         houseYPlace-(houseHeight/2)-roofHeight,
         houseXPlace+(houseWidth/2)+hangover,
         houseYPlace+(houseHeight/2));
  
rect(houseXPlace,houseYPlace,houseWidth,houseHeight);
rect(houseXPlace,
     houseYPlace+(houseHeight/2)-(doorHeight/2), //just in case I want to change the width
     doorWidth,
     doorHeight);
 
