class Weapon implements Renderable {
  Player p;
  PVector size;
  PShape model;
  PImage texture;
  boolean isShape = true, isTextured = false;

  Weapon(Player p, PVector size) {
    this.p = p;
    this.size = size;
  }
  Weapon(Player p, PImage texture) {
    this.p = p;
    this.texture = texture;
    isTextured = true;
  }
  Weapon(Player p, PShape model) {
    this.p = p;
    this.model = model;
    isShape = false;
  }
  Weapon(Player p, PShape model, PImage texture) {
    this.p = p;
    this.model = model;
    this.texture = texture;
    isShape = false;
    isTextured = true;
  }

  void render() {
    if (isShape) {
      renderRect();
    } else {
      renderModel();
    }
  }

  void renderRect() {
    pushMatrix();
    fill(150, 130, 45);
    translate(p.posn.x, p.posn.y, p.posn.z);
    rotateY(p.rotation.y+1);
    translate(300, 0, 0);
    rotateX(p.rotation.x+((map(constrain(p.initialTimeAttack+p.timeBetweenAttacks-p.currentTime, 0, p.timeBetweenAttacks),
      0, p.timeBetweenAttacks, 0, PI/2))));
    if (isShape) {
      box(size.x, size.y, size.z);
    } else {
    }
    popMatrix();
  }
  void renderModel() {
    if (isTextured) {
      model.texture(texture);
    }
    scale(-20);
    shape(model);
  }
}
