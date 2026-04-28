class Enemy implements Renderable {
  PVector posn, firstPosn, size = new PVector(50, 50, 100);
  float rotation = 0, baseSpeed = 3, speedDuringAttack = baseSpeed*3, speed = baseSpeed, attackingRange = 300;
  int currentTime, initialTimeReadying, initialTimeAttacking, attackWindUp = 500, attackDuration = 200,
    attackCooldown = 500, damage = 15, hp = 50, initialSpawnTime, timeToSpawn = 2000, hitDist = 200, walkFrame = 0,
    attackFrame = 0, windupFrame = 0;
  boolean isAttacking = false, isDead = true, isReadyingAttack = false, isSpawning = false, isShooter = false, isWalkAnimated = false,
    isAttackAnimated = false, isWindupAnimated = false, isAnimated = false;
  color c, attackingC = color(200, 100, 100);
  SoundFile attackSound;
  ArrayList<Enemy> projectiles = new ArrayList<>();
  PShape[] walk, windup, attack;

  Enemy(PVector posn, color c) {
    firstPosn = posn.copy();
    this.posn = firstPosn.copy();
    this.c = c;
  }
  Enemy(PVector posn, color c, SoundFile attackSound) {
    firstPosn = posn.copy();
    this.posn = firstPosn.copy();
    this.c = c;
    this.attackSound = attackSound;
  }
  Enemy(PVector posn, color c, SoundFile attackSound, PShape[] walk) {
    firstPosn = posn.copy();
    this.posn = firstPosn.copy();
    this.c = c;
    this.attackSound = attackSound;
    this.walk = walk;
    isWalkAnimated = true;
  }
  Enemy(PVector posn, color c, SoundFile attackSound, PShape[] walk, PShape[] attackAnim) {
    firstPosn = posn.copy();
    this.posn = firstPosn.copy();
    this.c = c;
    this.attackSound = attackSound;
    this.walk = walk;
    isWalkAnimated = true;
    this.attack = attackAnim;
    isAttackAnimated = true;
  }

  Enemy(PVector posn, color c, SoundFile attackSound, PShape[] walk, PShape[] windup, PShape[] attackAnim) {
    firstPosn = posn.copy();
    this.posn = firstPosn.copy();
    this.c = c;
    this.attackSound = attackSound;
    this.walk = walk;
    isWalkAnimated = true;
    this.windup = windup;
    isWindupAnimated = true;
    this.attack = attackAnim;
    isAttackAnimated = true;
  }

  void reset() {
    posn = firstPosn;
    size = new PVector(50, 50, 100);
    rotation = 0;
    baseSpeed = 3;
    speedDuringAttack = baseSpeed*3;
    speed = baseSpeed;
    attackingRange = 300;
    currentTime=0;
    initialTimeReadying=0;
    initialTimeAttacking=0;
    attackWindUp = 500;
    attackDuration = 200;
    attackCooldown = 500;
    damage = 15;
    hp = 50;
    initialSpawnTime = 0;
    timeToSpawn = 2000;
    hitDist = 200;
    isAttacking = false;
    isDead = true;
    isReadyingAttack = false;
    isSpawning = false;
    isShooter = false;
    projectiles = new ArrayList<>();
  }

  void lookAtPlayer(Player p) {
    if (!isAttacking && !isDead) {
      pushMatrix();
      translate(posn.x, posn.y, posn.z);
      rotation = atan2(p.posn.x-posn.x, p.posn.z-posn.z);
      popMatrix();
    }
  }

  void render() {
    isAnimated = (isWalkAnimated || isAttackAnimated || isWindupAnimated);
    currentTime = millis();
    if (!isDead) {
      pushMatrix();

      if (isReadyingAttack || isAttacking) {
        fill(attackingC);
        //scale(1,1-map(initialTime+attackDuration-currentTime,0,1000,0,0.5),1);
      } else {
        fill(c);
      }

      translate(posn.x, posn.y, posn.z);
      rotateY(rotation);
      if (!isAnimated) {
        scale(2);
        box(size.x, size.y, size.z);
      } else {
        renderFrame();
      }
      popMatrix();
      isDead = (hp <= 0);
    } else if (isSpawning) {
      pushMatrix();
      translate(posn.x, 250, posn.z);
      fill(150, 0, 255);
      sphere(200);
      popMatrix();
      if (currentTime > initialSpawnTime+timeToSpawn) {
        isDead = false;
        isSpawning = false;
      }
    }
  }

  void renderFrame() {
    if (isAttackAnimated && isAttacking) {
      shape(attack[attackFrame]);
      attackFrame = (attackFrame+1)%walk.length;
    }else if(isWindupAnimated && isReadyingAttack){
      shape(windup[windupFrame]);
      windupFrame = (windupFrame+1)%walk.length;
    }else{
        shape(walk[walkFrame]);
        walkFrame = (walkFrame+1)%walk.length;
    }
  }

  void move() {
    if (!isDead) {
      pushMatrix();
      translate(posn.x, posn.y, posn.z);
      rotateY(rotation);
      posn.x = modelX(0, 0, speed);
      posn.z = modelZ(0, 0, speed);
      popMatrix();
    }
  }

  void attack(Player p) {
    if (!isDead) {
      currentTime = millis();
      //attackingC = color(int(map(initialTimeAttacking+attackDuration-currentTime,1000,0,100,255)),
      //                   100,
      //                   100);


      if ((dist(p.posn.x, p.posn.z, posn.x, posn.z) < attackingRange) && !isAttacking && !isReadyingAttack
        && currentTime > initialTimeAttacking+attackDuration+attackCooldown) {
        beginAttack();
      }

      if (currentTime > initialTimeReadying+attackWindUp && isReadyingAttack
        && currentTime > initialTimeAttacking+attackDuration+attackCooldown) {
        isReadyingAttack = false;
        attackSound.play();
        isAttacking = true;
        speed = speedDuringAttack;
        initialTimeAttacking = millis();
      } else if (currentTime > initialTimeAttacking+attackDuration && isAttacking) {
        speed = baseSpeed;
        isAttacking = false;
      }
    }
  }
  void beginAttack() {
    isReadyingAttack = true;
    initialTimeReadying = millis();
    speed = 0;
  }
  void spawn() {
    isSpawning = true;
    initialSpawnTime = millis();
  }
}
