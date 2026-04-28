import com.jogamp.newt.opengl.GLWindow;
import processing.sound.*;
GLWindow cursorControls;

Player character;
Enemy wolf1,wolf1Base, wolf2,wolf2Base, wolf3,wolf3Base, wolf4,wolf4Base, bearBoss;
//Shooter deer1, deer2, deer3;
PVector wolf1Start = new PVector(-835, 300, -855), wolf2Start = new PVector(-835, 300, 300),
        wolf3Start = new PVector(300, 300, -855), wolf4Start = new PVector(300, 300, 300);
ArrayList<Enemy> enemies;
ArrayList<Projectile> projectiles = new ArrayList<>();
PShape[] wolfAnim, bearWalk, bearWindup, bearAttackAnim;
ArrayList[] waves = new ArrayList[5];
Weapon stick;
PShape sword;
PImage swordTexture;
color wolfC, deerC, bearC;

int currentState = 0;
boolean canPointerEscape = false;
PGraphics end;
SoundFile wolfAttack, bgMusic, bearAttack, swordSwing, swordHit;


void setup() {
  size(800, 500, P3D);
  smooth(0);
  cursorControls = (GLWindow) surface.getNative();
  if(!canPointerEscape){
  cursorControls.setPointerVisible(false);
  cursorControls.confinePointer(true);
  cursorControls.warpPointer(width, height);
  }
  wolfAttack = new SoundFile(this, "Wolf Growl 4 10 26.mp3");
  bgMusic = new SoundFile(this, "deuslower-medieval-ambient-236809.mp3");
  bearAttack = new SoundFile(this, "bear growl 4 27 26.mp3");
  swordSwing = new SoundFile(this, "sword swing.mp3");
  swordHit = new SoundFile(this, "sword slash.mp3");
  wolfAnim = load3DAnimation(25,"low_poly_wolf_animated","obj");
  bearWalk = load3DAnimation(40,"low_poly_bear_walk","obj");
  bearWindup = load3DAnimation(10,"low_poly_bear_windup","obj");
  bearAttackAnim = load3DAnimation(16,"low_poly_bear_attack","obj");
  wolfC = color(100, 100, 120);
  deerC = color(126, 37, 191);
  bearC = color(152, 120, 55);
  character = new Player(swordSwing,swordHit);
  wolf1 = new Enemy(wolf1Start, wolfC, wolfAttack, wolfAnim);
  wolf1Base = wolf1;
  wolf2 = new Enemy(wolf2Start, wolfC, wolfAttack, wolfAnim);
  wolf2Base = wolf2;
  wolf3 = new Enemy(wolf3Start, wolfC, wolfAttack, wolfAnim);
  wolf3Base = wolf3;
  wolf4 = new Enemy(wolf4Start, wolfC, wolfAttack, wolfAnim);
  wolf4Base = wolf4;
  //deer1 = new Shooter(new PVector(-835, 300, -855), deerC, wolfAttack);
  //deer2 = new Shooter(new PVector(-835, 300, 300), deerC, wolfAttack);
  //deer3 = new Shooter(new PVector(300, 300, 300), deerC, wolfAttack);
  bearBoss = new Enemy(new PVector(-835, 300, -855), bearC, bearAttack, bearWalk, bearWindup, bearAttackAnim);
  bearBoss.hp = 300;
  bearBoss.damage = 30;
  bearBoss.attackWindUp *= 2;
  bearBoss.attackDuration *= 2.5;
  bearBoss.size = new PVector(100, 100, 200);
  bearBoss.attackingRange = 500;
  bearBoss.scale = 50;
  sword = loadShape("Sword.obj");
  swordTexture = loadImage("Sword_texture.png");
  stick = new Weapon(character, new PVector(25, 200, 50)/*sword, swordTexture*/);
  end = createGraphics(width, height);
  for (int i = 0; i<waves.length; i++) {
    waves[i] =  new ArrayList<Enemy>();
  }
  waves[0].add(wolf1());
  waves[1].add(wolf2());
  waves[1].add(wolf3());
  //waves[1].add(deer1);
  waves[2].add(wolf1());
  waves[2].add(wolf2());
  waves[2].add(wolf3());
  //waves[2].add(deer3);
  waves[3].add(wolf1());
  waves[3].add(wolf2());
  waves[3].add(wolf3());
  waves[3].add(wolf4());
  //waves[3].add(deer1);
  //waves[3].add(deer3);
  waves[4].add(bearBoss);
  waves[4].add(wolf2);
  waves[4].add(wolf3);
  //waves[4].add(deer2);
  //waves[4].add(deer3);
}

void draw() {
  background(color(100, 130, 200));
  if (!bgMusic.isPlaying()) {
    bgMusic.play();
  }

  lights();
  pointLight(20, 20, 60, -1000, 200, 0); // BackLeftWall torches

  pointLight(20, 20, 60, -500, 200, -1000); //BackRightWall torches

  pointLight(20, 20, 60, -500, 200, 500); //FrontLeftWall torches

  pointLight(20, 20, 60, 500, 200, 0); //FrontRightWall torches
  //if(mousePressed){
  //  directionalLight(128,128,128, 0.5, .5, -1);  // light from viewer
  //} else {
  //  directionalLight(128,128,128, 0, 1, 0);   // light from above
  //}

  pushMatrix();
  translate(0, 250, 0);
  //fill(100,200,100);
  //sphere(100);
  popMatrix();
  //directionalLight(100,50,200,0,0,1);
  //directionalLight(128,128,128, 0, 0, -1);
  //directionalLight(100,50,100,.5,-.8,-.7);

  strokeWeight(.1);
  //noStroke();

  makeRoom();
  if(!canPointerEscape){
  cursorControls.warpPointer(width, height);
  }
  character.makeCam();
  character.posn.x = constrain(character.posn.x, -950, 500);
  character.posn.z = constrain(character.posn.z, -950, 500);
  //wolf1.render();
  switch(currentState) {
  case 0:
    startScreen();
    break;
  case 1:
  case 2:
  case 3:
  case 4:
  case 5:
    character.move();
    character.turnCam();
    character.attackedBy(enemies);
    character.healthBar();
    render(enemies);
    stick.render();
    //if(wolf1.isDead && !wolf1.isSpawning && wolf1.hp > 0){
    // wolf1.spawn();
    //}
    for (int i = 0; i<enemies.size(); i++) {
      enemies.get(i).lookAtPlayer(character);
      enemies.get(i).move();
      enemies.get(i).attack(character);
      //render(enemies.get(i).projectiles);
      //character.attackedBy(enemies.get(i).projectiles);
      //for (int j = 0; i<projectiles.size(); j++) {
      //  enemies.get(i).projectiles.get(j).move();
      //  //projectiles.get(i).despawn(new PVector(-1100, 0, -1100), new PVector(600, 1000, 600));
      //}
    }
    //wolf1.lookAtPlayer(character);
    //wolf1.move();
    //wolf1.attackInRange(character, wolfAttack);
    if (character.isDead) {
      currentState = 7;
    }
    removeIfDead(enemies);
    if (enemies.size()==0) {
      nextWave();
    }
    break;
  case 6:
    winScreen();
    break;
  case 7:
    deathScreen();
    break;
  }
}

void keyPressed() {
  switch(currentState) {
  case 0:
    if (key == 's' || key == 'S') {
      nextWave();
      character.rotation = new PVector(0, 7);
    }
    break;
  case 1:
  case 2:
  case 3:
  case 4:
  case 5:
    character.startMovement();

    if (key == 'k') {
      //enemies = new ArrayList<Enemy>();  // For Testing
      for (int i = 0; i<enemies.size(); i++) {
      enemies.get(i).hp = 0;
    }
    }

    break;
  }
}
void keyReleased() {
  switch(currentState) {
  case 1:
  case 2:
  case 3:
  case 4:
  case 5:
    character.stopMovement();
    break;
  }
}
void mousePressed() {
  switch(currentState) {
  case 1:
  case 2:
  case 3:
  case 4:
  case 5:
    character.attack(enemies);
    //println(character.posn);
    //character.hp -= 20;
    break;
  }
}

void squarePlane(float x, float y, float z, int howMany, color c) {
  pushMatrix();
  fill(c);
  //translate(howMany,0,howMany);
  translate(x, y, z);
  for (int i = 0; i<howMany; i++) {
    translate(50, 0, 0);
    for (int j = 0; j<howMany; j++) {
      translate(0, 0, 50);
      box(50);
    }
    translate(0, 0, -(howMany*50));
  }
  popMatrix();
}
void squareWall(float x, float y, float z, int howManyUp, int howManyWide, color c, boolean isDeep) {
  int moveX=0, moveZ=0;
  if (isDeep) {
    moveZ=50;
  } else {
    moveX=50;
  }
  pushMatrix();
  fill(c);
  //translate(howMany,0,howMany);
  translate(x, y, z);
  for (int i = 0; i<howManyUp; i++) {
    translate(0, 50, 0);
    for (int j = 0; j<howManyWide; j++) {
      translate(moveX, 0, moveZ);
      box(50);
    }
    translate(-(howManyWide*moveX), 0, -(howManyWide*moveZ));
  }
  popMatrix();
}
void nextWave() {
  resetWolves();
  println(wolf1Start);
  currentState++;
  character.hp+=30;
  character.damage+=5;
  if (currentState<=waves.length) {
    enemies = waves[currentState-1];
  }
  for (int i = 0; i<enemies.size(); i++) {
    enemies.get(i).spawn();
  }
}
void removeIfDead(ArrayList<Enemy> es) {
  for (int i = 0; i<es.size(); i++) {
    if (es.get(i).hp<=0) {
      es.remove(i);
    }
  }
}
void winScreen() {
  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  camera();

  textAlign(CENTER);
  textSize(150);
  fill(50);
  end.beginDraw();
  end.background(240, 240, 240, 200);
  end.endDraw();
  image(end, 0, 0);
  fill(80, 245, 44);
  text("You Win!", width/2, height/2.5);

  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}
void startScreen() {
  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  camera();

  textAlign(CENTER);
  textSize(100);
  fill(50);
  end.beginDraw();
  end.background(50, 255);
  end.endDraw();
  image(end, 0, 0);
  fill(80, 245, 44);
  text("Press 's' to Start", width/2, height/2.5);

  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}
void deathScreen() {
  pushMatrix();
  //translate(character.dir.x,character.dir.y,character.dir.z);
  //translate(-width/2,-height/2,0);
  //rotateX(character.rotation.x);
  //rotateY(atan2(character.posn.x-character.dir.x,character.posn.z-character.dir.z));
  hint(DISABLE_DEPTH_TEST);
  camera();
  textAlign(CENTER);
  textSize(150);
  fill(50);
  end.beginDraw();
  end.background(240, 240, 240, 200);
  end.endDraw();
  image(end, 0, 0);
  fill(200, 15, 60);
  text("You Died", width/2, height/2.5);
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}
void makeRoom() {
  squarePlane(-1100, 400, -1100, 34, color(200, 100, 100));
  squarePlane(-1100, 50, -1100, 34, color(100, 100, 200));
  squareWall(-1050, 0, -1050, 8, 32, color(100, 200, 100), true); // BackLeftWall (Back Walls are furthest away)
  squareWall(-1050, 0, -1050, 8, 34, color(200, 100, 200), false); //BackRightWall
  squareWall(-1050, 0, 600, 8, 34, color(100, 200, 200), false); // FrontLeftWall (Front Walls are behind camera at spawn)
  squareWall(600, 0, -1050, 8, 34, color(200, 200, 100), true); // FrontRightWall
}
void resetWolves(){
 wolf1.reset();
 //wolf1Start = new PVector(-835, 300, -855);
 //wolf1.posn = wolf1Start;
 wolf2.reset();
 //wolf2Start = new PVector(-835, 300, 300);
 //wolf2.posn = wolf2Start;
 wolf3.reset();
 //wolf3Start = new PVector(300, 300, -855);
 //wolf3.posn = wolf3Start;
 wolf4.reset();
 //wolf4Start = new PVector(300, 300, 300);
 //wolf4.posn = wolf4Start;
}

Enemy wolf1(){
  return new Enemy(wolf1Start, wolfC, wolfAttack, wolfAnim);
}
Enemy wolf2(){
  return new Enemy(wolf2Start, wolfC, wolfAttack, wolfAnim);
}
Enemy wolf3(){
  return new Enemy(wolf3Start, wolfC, wolfAttack, wolfAnim);
}
Enemy wolf4(){
  return new Enemy(wolf4Start, wolfC, wolfAttack, wolfAnim);
}

PImage[] loadAnimation(Integer frames, String fileName, String extension) {
  PImage[] animationFrames = new PImage[frames];
  for (int i=0; i<= animationFrames.length-1; i++) {
    animationFrames[i] = loadImage(fileName + i + "." + extension);
  }
  return animationFrames;
}

PShape[] load3DAnimation(Integer frames, String fileName, String extension) {
  PShape[] animationFrames = new PShape[frames];
  for (int i=0; i<= animationFrames.length-1; i++) {
    animationFrames[i] = loadShape(fileName + i + "." + extension);
  }
  return animationFrames;
}
