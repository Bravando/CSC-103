


void setup(){
  
}

void draw(){
  
}

class CircusTriangles{
 PVector center = new PVector(width/2,height/2), emphasis = center;
 float radius = width,interval = 1000,timeStart = 0,timeNow = 0;
 color[] colors = {color(255),color(255,0,0)};
 boolean runYet = false;
 int numOfTri = 18;
 
 CircusTriangles(PVector center, PVector emphasis, float radius, float rotationsPerSec, color[] colors,int numOfTri){
   this.center = center;
   this.emphasis = emphasis;
   this.radius = radius;
   interval = 1000/rotationsPerSec;
   this.colors = colors;
   this.numOfTri = numOfTri;
 }
 CircusTriangles(PVector center, float radius, float rotationsPerSec, color[] colors, int numOfTri){
   this.center = center;
   emphasis = center;
   this.radius = radius;
   interval = 1000/rotationsPerSec;
   this.colors = colors;
   this.numOfTri = numOfTri;
 }
 CircusTriangles(){}
  
 void drawCircus(){
   if(!runYet){
   timeStart = millis(); 
   }
   timeNow = millis();
   int whichColor = 0;
   for (int i = 0; i<numOfTri; i++) {
     fill(colors[i%colors.length]);
     makeTriToRadius(i);
      
    }
  }
  void makeTriToRadius(int whichTri){
    
  }
 
 
}
