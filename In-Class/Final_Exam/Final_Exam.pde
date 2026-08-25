ArrayList<Expander> expanders = new ArrayList<>();

void setup(){
  size(800,600);
  background(32);
}

void draw(){
  for(int i = 0;i<expanders.size();i++){
    expanders.get(i).render();
    expanders.get(i).xpand();
  }
}

void keyPressed(){
 expanders.add(new Expander(false));
}

void mousePressed(){
 expanders.add(new Expander(true));
}
