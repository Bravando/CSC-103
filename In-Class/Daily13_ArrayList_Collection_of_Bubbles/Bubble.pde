class Bubble {
  float radius = random(5, 50),  // The radius of the Bubble
    timeToNormalize = 1000,  // How many Milliseconds it takes for a bubble to stabilize after bouncing off a wall (keeps bubbles from just sticking to the walls)
    timeNow = millis(),  // The current time
    timeStartX = millis(),  // The start of the stablization timer after boucing off wall
    delay = 1,  // How many radiuses off screen an xBounded Bubble will spawn at
    xShift = 0;  // by how much an xBounded Bubble is guaranteed to move on the X-axis
  PVector loc = new PVector(random(radius, width-radius), height+radius),  // The location the Bubble is currently at
    speed = new PVector(3, -3);  // how far the bubble can move on the X-axis, left or right, AND how fast it will rise
  color c = color(145, 198, 240);  // The color of the bubble
  boolean hitLeft = false,  // if the Bubble has recently hit the left wall, OR if an xBounded Bubble is bound by the left wall
    hitRight = false,  // if the Bubble has recently hit the right wall, OR if an xBounded Bubble is bound by the right wall
    xBounded = false;  // if the Bubble is an xBounded Bubble

  Bubble(PVector location, PVector velocities, color c, float size, float timeToNormalize) {  // Makes a normal Bubble with detail
    loc = location;
    speed = velocities;
    this.c = c;
    radius = size/2;
    this.timeToNormalize = timeToNormalize;
  }
  Bubble(PVector location, PVector velocities, color c, float size, float xShift, boolean isLeftBound, float timeToNormalize) {  // Makes an XBounded Bubble with detail
    loc = location;
    speed = velocities;
    this.c = c;
    radius = size/2;
    this.xShift = xShift;
    hitLeft = isLeftBound;
    hitRight = !isLeftBound;
    this.timeToNormalize = timeToNormalize;
    xBounded = true;
  }
  Bubble(float xShift, boolean isLeftBound) {  // Makes a XBounded Bubble quickly
    if (!isLeftBound) {
      loc.x = random(-radius,width/2);
    } else {
      loc.x = random(width/2,width+radius);
    }
    this.xShift = xShift;
    hitLeft = isLeftBound;
    hitRight = !isLeftBound;
    xBounded = true;
  }
  Bubble(color c, float xShift, boolean isLeftBound) {  // Makes a XBounded Bubble with non-default color
    if (!isLeftBound) {
      loc.x = -radius;
    } else {
      loc.x = width+radius;
    }
    this.xShift = xShift;
    hitLeft = isLeftBound;
    hitRight = !isLeftBound;
    xBounded = true;
    this.c = c;
  }
  Bubble(color c) {  // Makes a normal Bubble with non-default color
    this.c = c;
    loc.x = random(radius, width-radius);
  }
  Bubble() {  // Makes a normal Bubble quickly
    loc.x = random(radius, width-radius);
  }

  void render() {  // draws a Bubble on the screen and moves it
    if (xBounded) {
      moveXBound();
    }
    moveNoXBound();
    fill(c);
    circle(loc.x, loc.y, radius*2);
  }

  // ------------------------------------------------------------  Movement  ---------------------------------------------------------

  void moveNoXBound() {  // moves a normal Bubble without leaving the window
    timeNow = millis();
    loc = shiftXNoBound(loc);
    loc.y += speed.y;
    resetPastHeightNoBound();
  }

  void moveXBound() {  // moves an xBound Bubble and resets it to keep it in the window
    loc = shiftXBounded(loc);
    loc.y += speed.y;
    resetPastHeightBounded();
  }

  void resetPastHeightNoBound() {
    if (loc.y <= -radius*delay+1) {
      loc.y = height+radius*delay+1;
    }
  }

  void resetPastHeightBounded() {
    if (loc.y <= -radius*delay+1) {
      loc.y = height+radius*delay+1;
    }
  }

  PVector shiftXNoBound(PVector loc) {
    float movement = random(-speed.x, speed.x);
    loc = bounceOffWidth(loc, movement);
    if (hitLeft) {
      movement = random(0, speed.x);
    } else if (hitRight) {
      movement = random(-speed.x, 0);
    }
    loc.x += movement;
    return loc;
  }

  PVector shiftXBounded(PVector loc) {
    loc.x += random(-speed.x+xShift, speed.x+xShift);
    return loc;
  }

  PVector bounceOffWidth(PVector loc, float movement) {
    loc.x += movement;
    if (loc.x <= radius) {
      loc.x = radius;
      hitLeft = true;
      hitRight = false;
      timeStartX = millis();
    } else if (loc.x >= width-radius) {
      loc.x = width-radius;
      hitRight = true;
      hitLeft = false;
      timeStartX = millis();
    } else if (hitLeft) {
      hitLeft = (timeNow <= timeStartX+timeToNormalize);
    } else if (hitRight) {
      hitRight = (timeNow <= timeStartX+timeToNormalize);
    }
    return loc;
  }
  PVector resetOffWidth(PVector loc, float movement) {
    loc.x += movement;
    if (loc.x <= -radius && hitLeft) {
      loc.x = width+(radius*delay);
    } else if (loc.x >= width+radius && hitRight) {
      loc.x = -radius*delay;
    }
    return loc;
  }

  // --------------------------------------------------------------------------------------------------------------------------------

  float inWidth(float input, float radius) {
    return constrain(input, radius, width-radius);
  }
}
