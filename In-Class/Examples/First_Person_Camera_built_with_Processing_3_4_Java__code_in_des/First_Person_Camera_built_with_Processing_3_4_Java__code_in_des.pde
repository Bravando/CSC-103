FPCamera mainCamera;

// Enables all camera transformations.
boolean cameraEnabled = false;

void setup() {
  size(1280, 600, P3D);
  // Creates a new camera.
  mainCamera = new FPCamera();
  // Camera transformations are enabled.
  cameraEnabled = true;
}

void draw() {
  background(0);

  // Tells the program that boolean cameraEnabled controls camera transformations.
  if (cameraEnabled == true) {
    mainCamera.camTransformations();
    // Updates and stores the cameras position every frame.
    //debugCamPos();
  }
  // Just some blocks so i can see things move.
  renderEnvironment();
}

// Creats a ground plain.
void renderEnvironment() {
  // number of boxes that are placed along each axis (X and Z only) to form the ground plain.
  int boxNumberPerAxis = 25;

  fill(198, 101, 35);
  // Forming the celling plain.
  for (int z = 0; z < boxNumberPerAxis; z++ ) {
    for (int x = 0; x < boxNumberPerAxis; x++) {
      block(x*50, 0, z*50, 50);
    }
  }

  // Forming the ground plain.
  fill(105, 88, 114);
  for (int z = 0; z < boxNumberPerAxis; z++ ) {
    for (int x = 0; x < boxNumberPerAxis; x++) {
      block(x*50, height-height/3, z*50, 50);
    }
  }
}

void block(float x, float y, float z, float s){
  pushMatrix();
  translate(x, y, z);
  box(s);
  popMatrix();
}

void ball(float x, float y, float z, float s){
  pushMatrix();
  translate(x, y, z);
  sphere(s);
  popMatrix();
}
