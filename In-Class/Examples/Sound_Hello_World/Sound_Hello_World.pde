import processing.sound.*;

SoundFile hitSound;

void setup() {
  size(800, 600);
  hitSound = new SoundFile(this, "hit.wav"); // don't need "data/hit.wav" because it looks for file in the data folder by default
  hitSound.amp(0);   // mutes the sound
  hitSound.amp(0.5); // 
  hitSound.rate(.1); // plays the sound at 1/10th the speed
}

void draw() {
  background(32);
}

void mousePressed() {
  if (!hitSound.isPlaying()) {  // won't play this sound again until the previous interation of it is finished
    hitSound.play();
  }
}
