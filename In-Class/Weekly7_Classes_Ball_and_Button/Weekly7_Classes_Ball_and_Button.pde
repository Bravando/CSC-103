Ball circle1;
Ball circle2;
Square square1;
Square square2;
Triangle triangle1;
Triangle triangle2;
Button but1, but2, but3, but4;
PVector buttonsDistFromTopLeft;
float buttonSize, buttonEdgeRoundness = 100;

void setup() {
size(800,600);
rectMode(CENTER);
buttonsDistFromTopLeft = new PVector(width/16.0,height/8.0);
buttonSize = height/16.0;
circle1 = new Ball(100,200,50,color(#5CE6F7)); 

but1 = new Button(buttonsDistFromTopLeft.x,
                  buttonsDistFromTopLeft.y,
                  buttonSize,
                  color(100,255,0));

but2 = new Button(buttonsDistFromTopLeft.x,
                  buttonsDistFromTopLeft.y*2,
                  buttonSize,
                  color(255,0,0));

but3 = new Button(buttonsDistFromTopLeft.x,
                  buttonsDistFromTopLeft.y*3,
                  buttonSize,
                  color(255,100,150));

but4 = new Button(buttonsDistFromTopLeft.x,
                  buttonsDistFromTopLeft.y*4,
                  buttonSize,
                  color(50,0,100));
}

void draw() {
  background(132);
  circle1.move();
  circle1.bounceatbounds();
  
  but1.whenPressed(() -> circle1.increaseSpeed());
  but2.whenPressed(() -> circle1.decreaseSpeed());
  but3.whenPressed(() -> circle1.increaseDiameter());
  but4.whenPressed(() -> circle1.decreaseDiameter());
  renderAll(new Renderable[] {circle1,but1,but2,but3,but4});
}
