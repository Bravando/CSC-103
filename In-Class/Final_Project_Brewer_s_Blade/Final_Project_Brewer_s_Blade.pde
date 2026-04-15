import com.jogamp.newt.opengl.GLWindow;
import processing.sound.*;
Player character;
GLWindow cursorControls;
Enemy wolf1;
int currentState = 0;
PGraphics pain;
SoundFile wolfAttack;
SoundFile bgMusic;


void setup(){
  size(800,500,P3D);
  smooth(0);
  character = new Player();
  wolf1 = new Enemy(new PVector(-635,250,-655),color(100,100,120));
  cursorControls = (GLWindow) surface.getNative();
  cursorControls.setPointerVisible(false);
  cursorControls.confinePointer(true);
  cursorControls.warpPointer(width,height);
  pain = createGraphics(width, height);
  wolfAttack = new SoundFile(this,"Wolf Growl 4 10 26.mp3");
  bgMusic = new SoundFile(this,"deuslower-medieval-ambient-236809.mp3");
}

void draw(){
  background(32);
  if(!bgMusic.isPlaying()){
   bgMusic.play(); 
  }
  
  lights();
  pointLight(200,200,240,-300,300,-300);
  //if(mousePressed){
  //  directionalLight(128,128,128, 0.5, .5, -1);  // light from viewer
  //} else {
  //  directionalLight(128,128,128, 0, 1, 0);   // light from above
  //}
  
  pushMatrix();
  translate(0,250,0);
  //fill(100,200,100);
  //sphere(100);
  popMatrix();
  //directionalLight(100,50,200,0,0,1);
  //directionalLight(128,128,128, 0, 0, -1);
  //directionalLight(100,50,100,.5,-.8,-.7);
  
  strokeWeight(.1);
  //noStroke();
  
  //renderEnvironment();
  squarePlane(-1000,400,-1000,30,color(200,100,100));
  squarePlane(-1000,100,-1000,30,color(100,100,200));
  cursorControls.warpPointer(width,height);
  character.makeCam();
  character.posn.x = constrain(character.posn.x,-950,500);
  character.posn.z = constrain(character.posn.z,-950,500);
  wolf1.render();
  character.turnCam();
  switch(currentState){
    case 0:
  character.move();
  character.attacked(wolf1);
  wolf1.lookAtPlayer(character);
  wolf1.move();
  wolf1.attackInRange(character,wolfAttack);
  if(character.isDead){
   currentState = 1; 
  }
  break;
  case 1:
  pushMatrix();
  translate(character.dir.x,character.dir.y,character.dir.z);
  translate(-width/2,-height/2,0);
  rotateX(character.rotation.x);
  rotateY(atan2(character.posn.x-character.dir.x,character.posn.z-character.dir.z));
  textAlign(CENTER);
  textSize(200);
  fill(200,15,60);
  pain.beginDraw();
  pain.background(240,0,0,100);
  pain.endDraw();
  image(pain,0,0);
  text("You Died",width/2,height/3);
  popMatrix();
  break;
  }
}

void keyPressed(){
 character.startMovement();
}
void keyReleased(){
 character.stopMovement(); 
}
void mousePressed(){
 //println(character.posn); 
 character.hp -= 20;
}

void squarePlane(float x, float y, float z, int howMany,color c){
    pushMatrix();
    fill(c);
    //translate(howMany,0,howMany);
    translate(x,y,z);
  for(int i = 0;i<howMany;i++){
    translate(50,0,0);
    for(int j = 0;j<howMany;j++){
      translate(0,0,50);
      box(50);
    }
    translate(0,0,-(howMany*50));
  }
  popMatrix();
}
