//// println("Hello World");

//size(800,600); // determine the size of the window

////change background color
//background(125);

////if you use control+/,
////then you can comment out
////several lines
//line(50,95,567,982); // line from one point to another (x1,y1,x2,y2)
//rect(100,200,100,300,200,200,200,300); // weird lookin rectangle.
//// documentation says it is determining the roundness of the corners
//line     ( 0, 100,    500,          400); // spaces don't affect anything

//stroke(255,30,180); // also works on lines

//rect(400,300,200,100);// way he teaches rect (x,y,width,length)
//// x and y of the top left of the rectangle (unless rectMode(CENTER);)
////  inside of rectangle is white and covers
//// lines printed before it in the code

//// inside of rect is fill
//// outside of rect is stroke

////change fill color
//fill(0,120,255); // fill(R,G,B);
//// fill(255,255,255); = fill(255);

//circle(100,100,100); // (x,y,extent) where "extent" = diameter

// class(end);

Ball circle1;
Ball circle2;
Square square1;
Square square2;
Triangle triangle1;
Triangle triangle2;
Button but1, but2, but3, but4;
PVector buttonsDistFromTopLeft;
float buttonSize, buttonEdgeRoundness = 100;
//ArrayList<Renderable> everything;

void setup() {
size(800,600);
rectMode(CENTER);
buttonsDistFromTopLeft = new PVector(width/16.0,height/8.0);
buttonSize = height/16.0;
//everything = new ArrayList<>();
circle1 = new Ball(100,200,50,color(#5CE6F7)); 
//everything.add(circle1);

but1 = new Button(buttonsDistFromTopLeft.x,
                  buttonsDistFromTopLeft.y,
                  buttonSize,
                  color(100,255,0));
//everything.add(but1);

but2 = new Button(buttonsDistFromTopLeft.x,
                  buttonsDistFromTopLeft.y*2,
                  buttonSize,
                  color(255,0,0));
//everything.add(but2);

but3 = new Button(buttonsDistFromTopLeft.x,
                  buttonsDistFromTopLeft.y*3,
                  buttonSize,
                  color(255,100,150));
//everything.add(but3);

but4 = new Button(buttonsDistFromTopLeft.x,
                  buttonsDistFromTopLeft.y*4,
                  buttonSize,
                  color(50,0,100));
//everything.add(but4);
}

void draw() {
  background(132);
  //circle1.render();
  circle1.move();
  circle1.bounceatbounds();
  
  //but1.render();
  but1.whenPressed(() -> circle1.increaseSpeed());
  //but2.render();
  but2.whenPressed(() -> circle1.decreaseSpeed());
  //but3.render();
  but3.whenPressed(() -> circle1.increaseDiameter());
  //but4.render();
  but4.whenPressed(() -> circle1.decreaseDiameter());
  renderAll(new Renderable[] {circle1,but1,but2,but3,but4});
  //new ArrayList<Renderable>(Array.asList(circle1,but1,but2,but3,but4))
  //{circle1,but1,but2,but3,but4}
}
