class Projectile extends Enemy {
  
  PVector size = new PVector(25,25,25);
  float baseSpeed = 5, speed = baseSpeed, hitDist = 50;
  int damage = 25, hp = 1000;
  boolean isDead = false, isAttacking = true;

  Projectile(PVector posn, color c, float rotation) {
    super(posn, c);
    this.posn = posn;
    this.c = c;
    attackingC = c;
    this.rotation = rotation;
  }
  void despawn(PVector lowerExtent,PVector upperExtent){
    if(posn.x <= lowerExtent.x || posn.y <= lowerExtent.y || posn.z <= lowerExtent.z
       || posn.x >= upperExtent.x || posn.y >= upperExtent.y || posn.z >= upperExtent.z){
        isDead = true; 
       }
  }
}
