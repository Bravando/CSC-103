interface Renderable {
// An Object that can be rendered to the window
  void render();

}
void renderAll(Renderable[] items){
  for(int i = 0;i<items.length;i++){
    items[i].render();
  }
}
void renderAll(ArrayList <? extends Renderable> items){
  for(int i = 0;i<items.size();i++){
    items.get(i).render();
  }
}
