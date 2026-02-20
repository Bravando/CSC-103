color[] colors = new color[2];
float size;
PVector place;
int number;

void setup(){
  size(800,600);
  colors[0] = color(255,0,0);
  colors[1] = color(0,255,0);
  size = 50;
  place = new PVector(size/2,height/2);
  number = ceil(height/size);
  makeAlternatingCircleColumn(place,size,number,color(255,0,0),color(0,255,0));
  //makeAlternatingCircleColumn(new PVector(25,height/2),50,height/50,colors);
}

void draw(){
  
}


  void makeCircle(float x, float y, float d, color c) {
    fill(c);
    circle(x, y, d);
  }
  /*
  void makeAlternatingCircleColumn(PVector posn, float size, int howMany, color c1, color c2){
    
    for(int i = 0; i<howMany; i++){
      if(i%2 == 0){
        makeCircle(posn.x,posn.y-(size*((float(howMany-1)/2)-i)),size,c1);
      }else{
        makeCircle(posn.x,posn.y-(size*((float(howMany-1)/2)-i)),size,c2);
      }
    
    }
  }
  */
    void makeAlternatingCircleColumn(PVector posn, float size, int howMany, color[] colors){
    
    for(int i = 0; i<howMany; i++){
      for(int j = 0;i<colors.length;j++){
        if(i%colors.length == j){
          makeCircle(posn.x,posn.y-(size*((float(howMany-1)/2)-i)),size,colors[j]);
        }
    }
  }
  }
