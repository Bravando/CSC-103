
float cellSize;
float lineLength;
float ofCell;
color oC;
color xC;
color bkg;
int topLeft;
int topMid;
int topRight;
int midLeft;
int midMid;
int midRight;
int botLeft;
int botMid;
int botRight;
float leftX;
float rightX;
float topY;
float botY;
boolean xLast;

void setup(){
  size(800,600);
  
  cellSize = 150;
  lineLength = cellSize*3;
  ofCell = 0.8;
  oC = color(#38FA2B);
  xC = color(#DE1414);
  bkg = color(100);
  background(bkg);
  topLeft = 0;
  topMid = 0;
  topRight = 0;
  midLeft = 0;
  midMid = 0;
  midRight = 0;
  botLeft = 0;
  botMid = 0;
  botRight = 0;
  leftX = (width-cellSize)/2;
  rightX = (width+cellSize)/2;
  topY = (height-cellSize)/2;
  botY = (height+cellSize)/2;
  xLast = false;
  
  
  
}

void draw(){
  stroke(255);
  drawTikTakToeBoard(cellSize,lineLength);
}

void drawTikTakToeBoard(float cellSize,float lineLength){
  
  line((width-cellSize)/2,(height-lineLength)/2,(width-cellSize)/2,(height+lineLength)/2);
  line((width+cellSize)/2,(height-lineLength)/2,(width+cellSize)/2,(height+lineLength)/2);
  line((width-lineLength)/2,(height-cellSize)/2,(width+lineLength)/2,(height-cellSize)/2);
  line((width-lineLength)/2,(height+cellSize)/2,(width+lineLength)/2,(height+cellSize)/2);
  
}

void drawXShape(float midX,float midY,float cellSize,float ofCell,color xC){
  stroke(xC);
  line(midX-(cellSize/2*ofCell),midY-(cellSize/2*ofCell),midX+(cellSize/2*ofCell),midY+(cellSize/2*ofCell));
  line(midX-(cellSize/2*ofCell),midY+(cellSize/2*ofCell),midX+(cellSize/2*ofCell),midY-(cellSize/2*ofCell));
}

void drawOShape(float midX,float midY, float cellSize, float ofCell,color oC,color bkg){
  fill(bkg);
  stroke(oC);
  circle(midX,midY,cellSize*ofCell);
}

void mousePressed(){
  if(mouseX < leftX && mouseY < topY){
    placeLocation(topLeft);
  }
}

boolean checkPlace(int place){
  /*
  checks if the place is occupied by checking if it is greater than 0
  */
  
  return place > 0;
}
void placeLocation(int place){
  if(!checkPlace(place)){
      if(xLast){
  drawOShape(leftX-cellSize/2,topY-cellSize/2,cellSize,ofCell,oC,bkg);
      }
      else{
        drawXShape(leftX-cellSize/2,topY-cellSize/2,cellSize,ofCell,xC);
      }
    }
}
