class Button {
  boolean isPressed = false, isRounded = false, eachRounded = false, isRect = true;
  float roundSize,topLeftRound,topRightRound,botLeftRound,botRightRound,roundness;
  PVector loc, rectSize;
  color c;
  
  //    --------------------------------    Initialize Circular Button    --------------------------------
  Button(PVector location,float diameter,color c){
    // makes a round button at the given PVector with the given diameter
  loc = location;
  roundSize = diameter;
  isRect = false;
  this.c = c;
  }
  Button(float x,float y,float size,color c){
    // makes a round button at the given x and y positions with the given diameter
  loc = new PVector(x,y);
  roundSize = size;
  isRect = false;
  this.c = c;
  }
  
  //    --------------------------------    Initialize Rectangular Button    --------------------------------
  Button(PVector location,PVector size,color c){
    // makes a rectangular button at the given location with the given size
  loc = location;
  rectSize = size;
  this.c = c;
  }
  Button(float x,float y,PVector size,color c){
    // makes a rectangular button at the given x and y positions with the given size
  loc = new PVector(x,y);
  rectSize = size;
  this.c = c;
  }
  Button(PVector location,float wid,float hgt,color c){
    // makes a rectangular button at the given location with the given width and height
  loc = location;
  rectSize = new PVector(wid,hgt);
  this.c = c;
  }
  Button(float x,float y,float wid,float hgt,color c){
    // makes a rectangular button at the given x and y positions with the given width and height
  loc = new PVector(x,y);
  rectSize = new PVector(wid,hgt);
  this.c = c;
  }
  Button(float x,float y,float wid,float hgt,float howRounded,color c){
    // makes a rectangular button at the given x and y positions with the given width and height
  loc = new PVector(x,y);
  rectSize = new PVector(wid,hgt);
  roundness = howRounded;
  isRounded = true;
  this.c = c;
  }
  Button(float x,float y,float wid,float hgt,float topLeftRound,float topRightRound,float botLeftRound,float botRightRound,color c){
    // makes a rectangular button at the given x and y positions with the given width and height
  loc = new PVector(x,y);
  rectSize = new PVector(wid,hgt);
  this.topLeftRound = topLeftRound;
  this.topRightRound = topRightRound;
  this.botLeftRound = botLeftRound;
  this.botRightRound = botRightRound;
  eachRounded = true;
  this.c = c;
  }
  
  //    ----------------------------------------------------------------    Functions    ----------------------------------------------------------------
  boolean mouseInButton(){
   if(isRect){
     return(inRectCentered(loc.x,loc.y,rectSize.x,rectSize.y,mouseX,mouseY));
   }else{
     return(inDist(loc.x,loc.y,roundSize,mouseX,mouseY));
   }
  }
  void render(){
    if(isRect){
     renderRectButton(); 
    }else{
     renderCircleButton(); 
    }
  }
  void renderCircleButton(){
    if(isPressed){
     fill(darken(c)); 
    }else{fill(c);}
    noStroke();
    circle(loc.x,loc.y,roundSize);
  }
  void renderRectButton(){
    rectMode(CENTER);
    if(isPressed){
     fill(darken(c)); 
    }else{fill(c);}
    noStroke();
    rect(loc.x,loc.y,rectSize.x,rectSize.y);
  }
  
  boolean mousePressed(){
    isPressed = mouseInButton();
    return isPressed;
  }
  void mouseReleased(){
    isPressed = false;
  }
  boolean mouseClicked(){
   return mouseInButton(); 
  }
  color darken(color c){
   return color(red(c)/2,green(c)/2,blue(c)/2); 
  }
  //    --------------------------------------------------------    Helper Functions    --------------------------------------------------------
  
  boolean inDist(float x, float y, float hitRadius, float foundX, float foundY) {
    return (dist(x, y, foundX, foundY) < hitRadius);
  }
  boolean inBounds(float x, float y, float leftBound, float rightBound, float topBound, float bottomBound) {
    /*
  checks if the given input is within all four bounds
     */
    return ((leftBound <= x) && (x <= rightBound) && (topBound <= y) && (y <= bottomBound));
  }
  boolean inRectCentered(float x, float y, float wid, float hgt, float inputX, float inputY) {
    /*
  checks if the input is in the given rectangle centered at (x,y) with sides of wid and hgt
     */
    return inBounds(inputX, inputY, x-wid/2, x+wid/2, y-hgt/2, y+hgt/2);
  }
}
