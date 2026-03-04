class Bubble{
 float radius = random(5,50),
       timeToNormalize = 1000,
       timeNow = millis(),
       timeStartX = millis(),
       delay = 1,
       xShift = 0;
 PVector loc = new PVector(random(radius,width-radius),height+radius), 
         speed = new PVector(5,10);
 color c = color(145,198,240);
 boolean hitLeft = false,
         hitRight = false;
 
 Bubble(PVector location, PVector velocities, color c,float size,float timeToNormalize){
   loc = location;
   speed = velocities;
   this.c = c;
   radius = size/2;
   this.timeToNormalize = timeToNormalize;
 }
 Bubble(PVector location, PVector velocities, color c,float size,float xShift,boolean isLeftBound, float timeToNormalize){
   loc = location;
   speed = velocities;
   this.c = c;
   radius = size/2;
   this.xShift = xShift;
   hitLeft = isLeftBound;
   hitRight = !isLeftBound;
   this.timeToNormalize = timeToNormalize;
 }
 Bubble(float xShift,boolean isLeftBound){
   if(isLeftBound){
     loc.x = -radius;
   }else{
    loc.x = width+radius; 
   }
   this.xShift = xShift;
   hitLeft = isLeftBound;
   hitRight = !isLeftBound;
 }
 Bubble(){}
 
 void render(){
  moveNoXBound();
  fill(c);
  circle(loc.x,loc.y,radius*2);
 }
 
 // ------------------------------------------------------------  Movement  ---------------------------------------------------------
 
 void moveNoXBound(){
   timeNow = millis();
   loc = shiftXNoBound(loc);
   loc.y += speed.y;
   resetPastHeightNoBound();
 }
 
 void moveXBound(){
   loc = shiftXBounded(loc);
   loc.y += speed.y;
   resetPastHeightBounded();
 }
 
 void resetPastHeightNoBound(){
  if(loc.y <= -radius*delay+1){
   loc.y = height+radius*delay+1;
  }
 }
 
 void resetPastHeightBounded(){
  if(loc.y <= -radius*delay+1){
   loc.y = height+radius*delay+1;
   if(hitLeft){
     loc.x = width+radius*delay;
   }else{
    loc.x = -radius*delay; 
   }
  }
 }
 
 PVector shiftXNoBound(PVector loc){
   float movement = random(-speed.x,speed.x);
   loc = bounceOffWidth(loc,movement);
   if(hitLeft){
     movement = random(0,speed.x);
   }else if(hitRight){
     movement = random(-speed.x,0);
   }
   loc.x += movement;
   return loc;
 }
 
 PVector shiftXBounded(PVector loc){
   loc.x += random(-speed.x+xShift,speed.x+xShift);
   return loc;
 }
 
 PVector bounceOffWidth(PVector loc, float movement){
   loc.x += movement;
   if(loc.x <= radius){
     loc.x = radius;
     hitLeft = true;
     hitRight = false;
     timeStartX = millis();
   }else if(loc.x >= width-radius){
     loc.x = width-radius;
     hitRight = true;
     hitLeft = false;
     timeStartX = millis();
   }else if(hitLeft){
     hitLeft = (timeNow <= timeStartX+timeToNormalize);
   }else if(hitRight){
     hitRight = (timeNow <= timeStartX+timeToNormalize);
   }
   return loc;
 }
 PVector resetOffWidth(PVector loc, float movement){
   loc.x += movement;
   if(loc.x <= -radius && hitLeft){
     loc.x = width+radius*delay;
   }else if(loc.x >= width+radius && hitRight){
     loc.x = -radius*delay;
   }
   return loc;
 }
 
 // --------------------------------------------------------------------------------------------------------------------------------
 
 float inWidth(float input, float radius){
  return constrain(input,radius,width-radius);
 }
}
