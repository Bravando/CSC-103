
// global state var

// you can only use 
int state = 0;
char stated = 'a';

void setup(){
 size(800,600); 
}

void draw(){
 background(42);
 
 
 switch (state){
   // each state is defined between a case and a break
   case 0:
     background(255,0,0);
   break;
   case 1:
     background(0,255,0);
   break;
   case 2:
     background(0,0,255);
   break;
 }/*
  switch (stated){
   // each state is defined between a case and a break
   case 'a':
     background(255,0,0);
   break;
   case 'b':
     background(0,255,0);
   break;
   case 'c':
     background(0,0,255);
   break;
  }*/
}

void keyPressed(){
 if(key == ' '){
  state = (state+1)%3; 
 }
}
