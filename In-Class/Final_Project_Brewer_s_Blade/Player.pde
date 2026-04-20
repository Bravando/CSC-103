class Player {
  PVector posn, // the point where the camera is
    velX, // how fast the camera is moving in the X direction
    velZ, // how fast the camera is moving in the Z direction
    forwardAcc, // how fast the camera is accelerating in the direction it is looking
    sidewaysAcc, // how fast the camera is accelerating PI/2 radians of the direction it is looking
    dir, // the point where the camera is looking
    rotation = new PVector(600, 10.5);  // how much the camera is rotated over the x and y axies respectively
  float topSpeed, hitRadius = 200;
  boolean isForward = false,
    isBackward = false,
    isLeft = false,
    isRight = false,
    isDead = false;
  int maxHp = 100,
    hp = maxHp,
    currentTime = 0,
    initialTimeHit = 0,
    initialTimeAttack = 0,
    hitBuffer = 500,
    timeBetweenAttacks = 200,
    damage = 10;


  Player() {
    posn = new PVector(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0));
    dir = new PVector(width/2.0, height/2.0, 0);
    velX = new PVector(0, 0);
    velZ = new PVector(0, 0);
    topSpeed = 7;
  }

  void makeCam() {
    camera(posn.x, posn.y, posn.z, dir.x, dir.y, dir.z, 0, 1, 0);
    isDead = hp<=0;
  }

  void turnCam() {
    // Rotate camera horizontally
    pushMatrix();
    translate(posn.x, posn.y, posn.z);

    rotation.y += ((-mouseX+width/2)*0.007);
    rotateY(rotation.y);

    translate(0, 0, -200);

    dir.x = modelX(0, 0, 0);
    dir.z = modelZ(0, 0, 0);
    popMatrix();

    // Rotate camera vertically
    pushMatrix();
    translate(posn.x, posn.y, posn.z);

    rotation.x = constrain(rotation.x+((mouseY-height/2)*0.01), -PI/2, PI/2);
    rotateX(rotation.x);

    translate(0, 0, -200);

    dir.y = modelY(0, 0, 0);
    popMatrix();
  }

  void move() {
    PVector placeLookingHorizontally = new PVector(dir.x, posn.y, dir.z);
    forwardAcc = PVector.sub(placeLookingHorizontally, posn);

    Runnable moveZ = new Runnable() {
      void run() {
        velZ.add(forwardAcc);
        velZ.limit(topSpeed);
        posn.add(velZ);
      }
    };

    pushMatrix();
    translate(posn.x, posn.y, posn.z);
    rotateY(rotation.y+PI/2);
    translate(0, 0, -200);
    float leftX = modelX(0, 0, 0);
    float leftZ = modelZ(0, 0, 0);
    popMatrix();

    PVector rightOfPlaceLookingHorizontally = new PVector(leftX, posn.y, leftZ);
    sidewaysAcc = PVector.sub(rightOfPlaceLookingHorizontally, posn);

    Runnable moveX = new Runnable() {
      void run() {
        velX.add(sidewaysAcc);
        velX.limit(topSpeed);
        posn.add(velX);
      }
    };

    if (isForward) {
      forwardAcc.setMag(5);
      moveZ.run();
    } else if (isBackward) {
      forwardAcc.setMag(-5);
      moveZ.run();
    }
    if (isLeft) {
      sidewaysAcc.setMag(5);
      moveX.run();
    } else if (isRight) {
      sidewaysAcc.setMag(-5);
      moveX.run();
    }
  }

  void startMovement() {
    if (key == 'w' || keyCode == UP) {
      isForward = true;
    } else if (key == 's' || keyCode == DOWN) {
      isBackward = true;
    }
    if (key == 'a' || keyCode == LEFT) {
      isLeft = true;
    } else if (key == 'd' || keyCode == RIGHT) {
      isRight = true;
    }
  }
  void stopMovement() {
    if (key == 'w' || keyCode == UP) {
      isForward = false;
    } else if (key == 's' || keyCode == DOWN) {
      isBackward = false;
    }
    if (key == 'a' || keyCode == LEFT) {
      isLeft = false;
    } else if (key == 'd' || keyCode == RIGHT) {
      isRight = false;
    }
  }

  void attackedBy(Enemy e) {
    currentTime = millis();
    if (e.isAttacking && (dist(e.posn.x, e.posn.z, posn.x, posn.z) < e.hitDist) && (currentTime > initialTimeHit+hitBuffer)) {
      hp -= e.damage;
      initialTimeHit = millis();
      println(hp);
    }
  }
  void attackedBy(ArrayList<Enemy> es){
   for(int i = 0;i<es.size();i++){
    attackedBy(es.get(i)); 
   }
  }
  void attack(Enemy e) {
    currentTime = millis();
      if (currentTime > initialTimeAttack+timeBetweenAttacks) {
      initialTimeAttack = millis();
      
      //println("attack!");
      
      if (dist(e.posn.x, e.posn.z, dir.x, dir.z)<hitRadius) {
        e.hp -= damage;
        // !!! Play feedback
        println("Hit!");
        print("  " + e.hp);
      }
    }
  }
  void attack(ArrayList<Enemy> es){
    for(int i = 0;i<es.size();i++){
    attack(es.get(i)); 
   }
  }
  void healthBar(){
    hp = constrain(hp,0,maxHp);
   pushMatrix();
   hint(DISABLE_DEPTH_TEST);
   camera();
   
   rectMode(CORNER);
   noStroke();
   
   float wid = width/3,hgt = height/20,widsFromRight = 0.25,hgtsFromBottom = 2;
   fill(200,0,0);
   rect(width-(wid*(1 + widsFromRight)),height-(hgt*hgtsFromBottom),wid,hgt);
   fill(100,255,5);
   rect(width-(wid*(1 + widsFromRight)),height-(hgt*hgtsFromBottom),wid*map(maxHp-hp,100,0,0,1),hgt);
   
   hint(ENABLE_DEPTH_TEST);
   popMatrix();
  }
}
