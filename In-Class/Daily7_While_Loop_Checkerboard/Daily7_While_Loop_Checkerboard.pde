
float smallerSideOfWindow;
/*
Every loop needs a variable
 */
void setup() {
  size(800, 600);
  if (width < height) {
    smallerSideOfWindow = width;
  } else {
    smallerSideOfWindow = height;
  }
  drawCheckerboard(new PVector (width/2, height/2), smallerSideOfWindow/8, 8, 8, color(255, 0, 0), color(0));
}

void draw() {
}

void makeSquare(float x, float y, float side, color c) {
  fill(c);
  square(x, y, side);
}

void drawCheckerboard(PVector place, float size, int cellsAcross, int cellsDown, color c1, color c2) {
  /*
  draws a checkerboard at the given location with squares of the given size with the given number of cells
   across and down and alternating which color is applied for each
   */
  float x = place.x-(size*(cellsAcross/2));
  float y = place.y-(size*(cellsDown/2));
  color savedColor = c1;
  for (int counterY = 0; counterY < cellsDown; counterY++) {
    drawRowOfSquares(new PVector(x+size/2, y+size/2), size, cellsAcross, c1, c2);
    y += size;
    c1 = c2;
    c2 = savedColor;
    savedColor = c1;
  }
}

void drawRowOfSquares(PVector initialSquare, float size, int howMany, color c1, color c2) {
  float x = initialSquare.x-size/2;
  color nextColor = c1;
  for (int counterX = 0; counterX < howMany; counterX++) {
    rectMode(CORNER);
    makeSquare(x, initialSquare.y-size/2, size, nextColor);
    x += size;
    nextColor = swapColor(nextColor, c1, c2);
  }
}
color swapColor(color input, color option1, color option2) {
  if (input == option1) {
    return option2;
  } else {
    return option1;
  }
}



// -------------------------------------------------------------    Ignore Past This Point    ---------------------------------------------------------

class Checkerpiece {
  PVector cell;
  String verDir;
  boolean isKing;
  float cellSize;
  int dirMod = 1;
  color indicatorColor = color(255, 255, 0);
  boolean selected = false;
  PVector[] possibleMoves = new PVector[4];


  Checkerpiece(PVector cell, String d, boolean isKing, float size) {
    this.cell = cell;
    verDir = d;
    this.isKing = isKing;
    cellSize = size;
    if (verDir == "up") {
      dirMod = -1;
    }
    possibleMoves[0] = new PVector(cell.x-size, cell.y+size*dirMod);     //left
    possibleMoves[1] = new PVector(cell.x+size*2, cell.y+size*dirMod);   //right
    possibleMoves[2] = new PVector(cell.x-size*2, cell.y+size*2*dirMod); //far left
    possibleMoves[3] = new PVector(cell.x+size*2, cell.y+size*2*dirMod); //far right
  }
  Checkerpiece(PVector cell, String d, boolean isKing, float size, color indicator) {
    this.cell = cell;
    verDir = d;
    this.isKing = isKing;
    cellSize = size;
    if (verDir == "up") {
      dirMod = -1;
    }
    indicatorColor = indicator;
    possibleMoves[0] = new PVector(cell.x-size, cell.y+size*dirMod);     //left
    possibleMoves[1] = new PVector(cell.x+size*2, cell.y+size*dirMod);   //right
    possibleMoves[2] = new PVector(cell.x-size*2, cell.y+size*2*dirMod); //far left
    possibleMoves[3] = new PVector(cell.x+size*2, cell.y+size*2*dirMod); //far right
  }
  void makeCircle(float x, float y, float d, color c) {
    fill(c);
    circle(x, y, d);
  }
  boolean inBounds(float x, float y, float leftBound, float rightBound, float topBound, float bottomBound) {
    /*
  checks if the given input is within all four bounds
     */
    return ((leftBound <= x) && (x <= rightBound) && (topBound <= y) && (y <= bottomBound));
  }
  boolean inSquareCentered(float x, float y, float side, float inputX, float inputY) {
    /*
  checks if the input is in the given square centered at (x,y) with sides of side
     */
    return inBounds(inputX, inputY, x-side, x+side, y-side, y+side);
  }
  void clicked() {
    if (mousePressed && inSquareCentered(cell.x, cell.y, cellSize, mouseX, mouseY)) {
      selected = true;
    } else {
      selected = false;
    }
  }
  void showMovement(ArrayList<Checkerpiece> dir1, ArrayList<Checkerpiece> dir2) {
    ArrayList<Checkerpiece> myTeam;
    ArrayList<Checkerpiece> myEnemies;
    if (verDir == dir1.get(0).verDir) {
      myTeam = dir1;
      myEnemies = dir2;
    } else {
      myTeam = dir2;
      myEnemies = dir1;
    }

    makeIndicator(myTeam, myEnemies, verDir, "left");
    makeIndicator(myTeam, myEnemies, verDir, "right");
    makeIndicatorPastEnemy(myTeam, myEnemies, verDir, "left");
    makeIndicatorPastEnemy(myTeam, myEnemies, verDir, "right");
  }
  void makeIndicatorPastEnemy(ArrayList<Checkerpiece> myTeam, ArrayList<Checkerpiece> myEnemies, String vertical, String horizontal) {
    int modifierX;
    int modifierY;
    if (horizontal == "left") {
      modifierX = -1;
    } else {
      modifierX = 1;
    }
    if (vertical == "up") {
      modifierY = -1;
    } else {
      modifierY = 1;
    }
    if (isAnyBlocking(myEnemies, verDir, horizontal)) {
      makeIndicatorFrom(myTeam, myEnemies, vertical, "left", new PVector(cell.x+cellSize*modifierX, cell.y+cellSize*modifierY));
      makeIndicatorFrom(myTeam, myEnemies, vertical, "right", new PVector(cell.x+cellSize*modifierX, cell.y+cellSize*modifierY));
    }
  }
  void makeIndicator(ArrayList<Checkerpiece> dir1, ArrayList<Checkerpiece> dir2, String vertical, String horizontal) {
    makeIndicatorFrom(dir1, dir2, vertical, horizontal, cell);
  }
  void makeIndicatorFrom(ArrayList<Checkerpiece> dir1, ArrayList<Checkerpiece> dir2, String vertical, String horizontal, PVector posn) {
    int modifierX;
    int modifierY;
    if (horizontal == "left") {
      modifierX = -1;
    } else {
      modifierX = 1;
    }
    if (vertical == "up") {
      modifierY = -1;
    } else {
      modifierY = 1;
    }
    if (!isAnyBlocking2(dir1, dir2, vertical, horizontal)) {
      makeCircle(posn.x+cellSize*modifierX, posn.y+cellSize*modifierY, cellSize/1.5, indicatorColor);
    }
  }
  boolean compareColors(color c1, color c2) {
    return(red(c1) == red(c2) && green(c1) == green(c2) && blue(c1) == blue(c2));
  }

  boolean isAnyBlocking(ArrayList<Checkerpiece> checkerpieces, String vertical, String horizontal) {
    return isAnyBlockingFrom(checkerpieces, vertical, horizontal, cell);
  }
  boolean isAnyBlocking2(ArrayList<Checkerpiece> dir1, ArrayList<Checkerpiece> dir2, String vertical, String horizontal) {
    return (isAnyBlockingFrom2(dir1, dir2, vertical, horizontal, cell));
  }
  boolean isAnyBlockingFrom(ArrayList<Checkerpiece> checkerpieces, String vertical, String horizontal, PVector posn) {
    int modifierX;
    int modifierY;
    if (horizontal == "left") {
      modifierX = -1;
    } else {
      modifierX = 1;
    }
    if (vertical == "up") {
      modifierY = -1;
    } else {
      modifierY = 1;
    }
    boolean anyTrue = false;
    for (int i = checkerpieces.size(); i>=0; i--) {
      if (posn.x+cellSize*modifierX == checkerpieces.get(i).cell.x && posn.y+cellSize*modifierY == checkerpieces.get(i).cell.y) {
        anyTrue = true;
      }
    }
    return anyTrue;
  }
  boolean isAnyBlockingFrom2(ArrayList<Checkerpiece> dir1, ArrayList<Checkerpiece> dir2, String vertical, String horizontal, PVector posn) {
    return(isAnyBlockingFrom(dir1, vertical, horizontal, posn) || isAnyBlockingFrom(dir2, vertical, horizontal, posn));
  }
}
class possibleTiles {
}
