float side1 = 100,side2 = 50;
color c1 = color(155),c2 = color(255,0,0);
PVector posn1,posn2;
ArrayList<PVector> triSquares = new ArrayList<PVector>();
ArrayList<Integer> triSquareColors = new ArrayList<Integer>();
ArrayList<Float> triSquareSides = new ArrayList<Float>();


void setup(){
  size(800,600);
  side1 = height/10;
  posn1 = new PVector(width/2,height-side1/2);
}

void draw(){
  background(42);
  makeTriSquareColumn(posn1.x,posn1.y,side1,c2,int(height/side1));
  for(int i = 0;i<triSquares.size();i++){
   makeTriSquare(triSquares.get(i).x,
                 triSquares.get(i).y,
                 triSquareSides.get(i),
                 triSquareColors.get(i)); 
  }
}

color randomColor(){
 return color(random(255),random(255),random(255));
}

void makeTriSquare(float x, float y, float sideLength, color c){
 rectMode(CENTER);
 fill(c);
 square(x,y,sideLength);
 square(x-sideLength/2,y-sideLength,sideLength);
 square(x+sideLength/2,y-sideLength,sideLength);
}

void makeTriSquareColumn(float x, float y, float sideLength, color c,int howMany){
 for(int i = 0;i<howMany;i++){
  makeTriSquare(x,y-(sideLength*2*i),sideLength,c);
 }
}

void keyPressed(){
 c2 = randomColor(); 
}

void mousePressed(){
  triSquares.add(new PVector(mouseX,mouseY));
  triSquareColors.add(randomColor());
  triSquareSides.add(random(10,100));
}
