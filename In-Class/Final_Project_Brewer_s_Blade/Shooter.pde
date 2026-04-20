class Shooter extends Enemy{
  
  PVector size = new PVector(75,200,75);
  float baseSpeed = 0,speed = baseSpeed,speedDuringAttack = baseSpeed;
  int attackCooldown = 3000, damage = 0, hp = 20,hitDist = 0;
  color attackingC = c;
  boolean isShooter = true;
  
  
  Shooter(PVector posn, color c) {
    super(posn,c);
  }
  Shooter(PVector posn, color c,SoundFile attack) {
    super(posn,c,attack);
  }
  
  
    void attack(Player p) {
      
    if (!isDead) {
      currentTime = millis();


      if (!isAttacking && !isReadyingAttack
        && currentTime > initialTimeAttacking+attackDuration+attackCooldown) {
        beginAttack();
      }

      if (currentTime > initialTimeReadying+attackWindUp && isReadyingAttack) {
        isReadyingAttack = false;
        attackSound.play();
        projectiles.add(new Projectile(posn,color(150,0,255),rotation));               // Warning: uses Global Variable
        isAttacking = true;
        initialTimeAttacking = millis();
      } else if (currentTime > initialTimeAttacking+attackDuration && isAttacking) {
        isAttacking = false;
      }
    }
  }
}
