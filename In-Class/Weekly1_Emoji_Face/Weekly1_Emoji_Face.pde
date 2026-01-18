size(200,200);

int x = 0;
int y = 0;

fill(#34A4F7);
stroke(#34A4F7);
translate(100, 50);

rotate(PI/8);
beginShape();
vertex(x,y);
bezierVertex(x + 9,y + 39, x + 21,y + 51, x,y + 54);
bezierVertex(x - 12,y + 54, x - 24,y + 42, x,y);
endShape();
