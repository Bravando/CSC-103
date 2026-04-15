class Enemy {
  PVector posn;
  float rotation = 0, speed = 5, attackingRange = 300;
  int currentTime, initialTime, attackLength = 2000,damage = 15,hp = 50;
  boolean isAttacking = false,isDead = false;
  color c, attackingC = color(200, 100, 100);

  Enemy(PVector posn, color c) {
    this.posn = posn;
    this.c = c;
  }

  void lookAtPlayer(Player p) {
    if (!isAttacking) {
      pushMatrix();
      translate(posn.x, posn.y, posn.z);
      rotation = atan2(p.posn.x-posn.x, p.posn.z-posn.z);
      popMatrix();
    }
  }

  void render() {
    if(!isDead){
    pushMatrix();

    if (isAttacking) {
      fill(attackingC);
    } else {
      fill(c);
    }

    translate(posn.x, posn.y, posn.z);
    rotateY(rotation);
    box(50, 50, 100);
    popMatrix();
    isDead = (hp <= 0);
    }
  }

  void move() {
    pushMatrix();
    translate(posn.x, posn.y, posn.z);
    rotateY(rotation);
    posn.x = modelX(0, 0, speed);
    posn.z = modelZ(0, 0, speed);
    popMatrix();
  }

  void attackInRange(Player p,SoundFile s) {
    currentTime = millis();
    
    if ((dist(p.posn.x, p.posn.z, posn.x, posn.z) < attackingRange) && !isAttacking) {
      s.play();
      isAttacking = true;
      initialTime = millis();
    }
    
    if (currentTime > initialTime+attackLength) {
      isAttacking = false;
    }
    
  }
}
