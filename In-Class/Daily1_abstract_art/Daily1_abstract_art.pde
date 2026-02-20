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

Square circle1;
Square circle2;
Square square1;
Square square2;
Square triangle1;
Square triangle2;


void setup() {
size(800,600);
rectMode(CENTER);
circle1 = new Square(100,200,50,3,3,color(#5CE6F7),color(#F71E22));
circle2 = new Square(300,450,75,2,-4,color(#DD1EF7),color(#1EF75D));
square1 = new Square(12,14,14,4,2,color(#F77C1E),color(#FF50B6));
square2 = new Square(200,290,82,-3,1,color(#FF50B6),color(#50FFAC));
triangle1 = new Square(500,100,80,5,4,color(#50FF57),color(#EA6715));
triangle2 = new Square(700,400,30,4,-3,color(#15EAAC),color(#D8EA15));
}

void draw() {
  background(#990EE0);
  circle1.makecircle(circle1);//makecircle(circle1);
  circle2.makecircle(circle2);
  square1.makesquare(square1);
  square2.makesquare(square2);
  triangle1.maketriangle(triangle1);
  triangle2.maketriangle(triangle2);
  circle1.move();
  circle2.move();
  square1.move();
  square2.move();
  triangle1.move();
  triangle2.move();
  circle1.bounceatbounds();
  circle2.bounceatbounds();
  square1.bounceatbounds();
  square2.bounceatbounds();
  triangle1.tribounceatbounds(triangle1);
  triangle2.tribounceatbounds(triangle2);
}
