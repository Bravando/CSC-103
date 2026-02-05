
color bkg;
void setup(){
  size(800,600);
  bkg = color(200);
  background(bkg);
  
  textSize(100);
  fill(20);
  text("Click to NERD",width/10,height/8);
}


void draw(){
  
}


void drawNerd(float headSize,float locX,float locY,color headC,color glassesC,color eyeC,color mouthC){
  /*
  draws a Nerd Emoji of the given size and colors at the given location
  */
  float lEyeX = locX-headSize/4;
  float eyeY = locY-headSize/5;
  float rEyeX = locX+headSize/4;
  float eyeSize = headSize/5;
  float mouthSize = headSize*2/3;
  float toothSize = mouthSize/5;
  //head
  fill(headC);
  stroke(50);
  strokeWeight(3);
  circle(locX,locY,headSize);
  
  //eyes
  fill(eyeC);
  strokeWeight(0);
  ellipse(lEyeX,eyeY,eyeSize/2,eyeSize);
  ellipse(rEyeX,eyeY,eyeSize/2,eyeSize);
  
  //glasses
  stroke(glassesC);
  strokeWeight(5);
  noFill();
  line(locX-headSize/2,eyeY-eyeSize/2,locX+headSize/2,eyeY-eyeSize/2);
  
  arc(lEyeX,eyeY,eyeSize,eyeSize,0,PI);
  line(lEyeX-eyeSize/2,eyeY,lEyeX-eyeSize/2,eyeY-eyeSize/2);
  line(lEyeX+eyeSize/2,eyeY,lEyeX+eyeSize/2,eyeY-eyeSize/2);
  
  arc(rEyeX,eyeY,eyeSize,eyeSize,0,PI);
  line(rEyeX-eyeSize/2,eyeY,rEyeX-eyeSize/2,eyeY-eyeSize/2);
  line(rEyeX+eyeSize/2,eyeY,rEyeX+eyeSize/2,eyeY-eyeSize/2);
  
  //mouth
  stroke(eyeC);
  arc(locX,locY-headSize/10,mouthSize,mouthSize,HALF_PI/2,PI-HALF_PI/2);
  strokeWeight(1);
  fill(255);
  arc(locX-toothSize/16,locY-headSize/10+mouthSize/2,toothSize,toothSize*2,HALF_PI-PI/9,PI+PI/36);
  arc(locX+toothSize/16,locY-headSize/10+mouthSize/2,toothSize,toothSize*2,-PI/36,HALF_PI+PI/9);
  strokeWeight(2);
  line(locX,locY-headSize/10+mouthSize/2-toothSize/8,locX,locY-headSize/10+mouthSize/2+toothSize);
  
}

void mousePressed(){
 drawNerd(random(50,200),mouseX,mouseY,randomColor(),randomColor(),color(random(255)),color(random(0,100)));
}

color randomColor(){
  return color(random(255),random(255),random(255));
}
