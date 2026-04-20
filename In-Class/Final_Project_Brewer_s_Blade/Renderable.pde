interface Renderable {
// An Object that can be rendered to the window
  void render();

}
void render(Renderable[] items){
  for(int i = 0;i<items.length;i++){
    items[i].render();
  }
}
void render(ArrayList <? extends Renderable> items){
  for(int i = 0;i<items.size();i++){
    items.get(i).render();
  }
}
void render(Renderable item){
 item.render(); 
}
