class Enemy implements Renderable {
  PVector posn,firstPosn, size = new PVector(50, 50, 100);
  float rotation = 0, baseSpeed = 3, speedDuringAttack = baseSpeed*3, speed = baseSpeed, attackingRange = 300;
  int currentTime, initialTimeReadying, initialTimeAttacking, attackWindUp = 500, attackDuration = 200,
    attackCooldown = 500, damage = 15, hp = 50, initialSpawnTime, timeToSpawn = 2000, hitDist = 200;
  boolean isAttacking = false, isDead = true, isReadyingAttack = false, isSpawning = false, isShooter = false;
  color c, attackingC = color(200, 100, 100);
  SoundFile attackSound;
  ArrayList<Enemy> projectiles = new ArrayList<>();

  Enemy(PVector posn, color c) {
    firstPosn = posn.copy();
    this.posn = firstPosn.copy();
    this.c = c;
  }
  Enemy(PVector posn, color c,SoundFile attack) {
    firstPosn = posn.copy();
    this.posn = firstPosn.copy();
    this.c = c;
    attackSound = attack;
  }
  
  void reset(){
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
      scale(2);
      box(size.x, size.y, size.z);
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
