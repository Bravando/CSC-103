class Weapon implements Renderable {
  Player p;
  PVector size;
  PShape model;
  boolean isShape = true;

  Weapon(Player p, PVector size) {
    this.p = p;
    this.size = size;
  }
  Weapon(Player p, PShape model) {
    this.p = p;
    this.model = model;
    isShape = false;
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
    box(size.x, size.y, size.z);
    popMatrix();
  }
  void renderModel() {
    // !!! Blah blah blah PShape stuff
  }
}
