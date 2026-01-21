size(600,600);

int x = 0;
int y = 0;
int smallSide;
if(width < height){smallSide = width;}
else{smallSide = height;}
float teethScale = 780.0/smallSide;
float extraTeethWidth = -39.0/smallSide;
float extraLipWidth = -37.0/smallSide;


// It was supposed to be scalable, but I messed with up the teeth and lip


// Head
fill(#F4F528);
stroke(#F4F528);
circle(width/2,height/2, smallSide*(2.0/3.0));
// Left eye
noFill();
stroke(#71715F);
strokeWeight(smallSide/30);
arc(width/2.5,height/2.2,smallSide/5,smallSide/6,PI+QUARTER_PI,PI+HALF_PI+0.5);
strokeWeight(smallSide/40);
arc(width/2.7,height/2.5,smallSide/6,smallSide/5,PI+QUARTER_PI/2,PI+QUARTER_PI+0.5);
// Right eye
strokeWeight(smallSide/30);
arc(width/1.6,height/2.2,smallSide/5,smallSide/6,PI+HALF_PI-0.5,PI+HALF_PI+QUARTER_PI);
strokeWeight(smallSide/40);
arc(width/1.55,height/2.5,smallSide/6,smallSide/5,PI+HALF_PI+QUARTER_PI-0.5,TWO_PI-QUARTER_PI/2);
// Mouth
strokeWeight(smallSide/150);
fill(#C8C902);
arc(width/2,height/1.8,smallSide/2.2,smallSide/3,-QUARTER_PI/4,PI+QUARTER_PI/4);
noFill();
stroke(#F4F528);
strokeWeight(smallSide/30);
arc(width/2,height/2.5,teethScale*smallSide/2,teethScale*smallSide/4.5,QUARTER_PI-extraLipWidth,PI-QUARTER_PI+extraLipWidth);
// Teeth
noFill();
strokeWeight(smallSide/30);
stroke(255,255,255);
arc(width/2,height/2.3,teethScale*smallSide/2,teethScale*smallSide/4.5,QUARTER_PI-extraTeethWidth,PI-QUARTER_PI+extraTeethWidth);
stroke(#71715F);
strokeWeight(smallSide/150);
arc(width/2,height/1.8,smallSide/2.2,smallSide/3,-QUARTER_PI/4,PI+QUARTER_PI/4);
// Upper Lip
strokeWeight(12);
arc(width/2,height/2.41,teethScale*smallSide/2,teethScale*smallSide/4.5,QUARTER_PI-extraLipWidth,PI-QUARTER_PI+extraLipWidth);



// Left Tear
strokeWeight(smallSide/150);
fill(#34A4F7);
stroke(#34A4F7);
translate(width/3.2, height/2.5);

rotate(PI/8);
beginShape();
vertex(x,y);
bezierVertex(x + width/50,y + height*(13.0/150.0), x + width*(7.0/150.0),y + height*(17.0/150.0), x,y + height*(18.0/150.0));
bezierVertex(x - width*(2.0/75.0),y + height*(18.0/150.0), x - width/20,y + height*(9.0/100.0), x,y);
endShape();
// Right Tear
translate(width/2.71, -height/6.8);
rotate(-PI/4);
//x = int(width/2.7);
//y = int(-height/7); //if you activate these lines of code, it bugs out in a way I don't understand
beginShape();
vertex(x,y);
bezierVertex(x - width/50,y + height*(13.0/150.0), x - width*(7.0/150.0),y + height*(17.0/150.0), -x,y + height*(18.0/150.0));
bezierVertex(x + width*(2.0/75.0),y + height*(18.0/150.0), x + width/20,y + height*(9.0/100.0), -x,y);
endShape();
