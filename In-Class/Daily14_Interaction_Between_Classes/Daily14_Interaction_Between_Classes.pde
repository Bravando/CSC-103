ArrayList<Shape> shapes = new ArrayList<>();
void setup(){
  size(800,600);
}

void draw(){
  background(32);
  
  renderAll(shapes);
  
  for(int i = 0; i<shapes.size();i++){
    shapes.get(i).move();
    shapes.get(i).bounceAtBounds();
    
    for(int j = 0; j<shapes.size();j++){
      
      if(!(shapes.get(j) == shapes.get(i))){
    shapes.get(i).collide(shapes.get(j));
      }
      
    }
  }
}

void keyPressed(){
  if(key == 'b'){
   shapes.add(new Ball(random(200,width-200),random(100,height-100),random(5,50),randomizeColor()));
  }
  if(key == 's'){
   shapes.add(new Square(random(200,width-200),random(100,height-100),random(5,50),randomizeColor()));
  }
  if(key == 't'){
   shapes.add(new Triangle(random(200,width-200),random(100,height-100),random(5,50),randomizeColor()));
  }
}

color randomizeColor() {
    return color(random(255), random(255), random(255));
  }
