class Terrain {
  int rows, cols;
  float scl, wdh, hgt,howMountainous = 10.0;
  float[][] zVals;

  Terrain(int rows, int cols, float scl, float wdh, float hgt){
   this.rows = rows; 
   this.cols = cols; 
   this.scl = scl; 
   this.wdh = wdh; 
   this.wdh = wdh; 
   zVals = new float[rows][cols];
   for(int y = 0; y<cols;y++){
    for(int x = 0; x<rows;x++){
      zVals[x][y] = map(noise(x/howMountainous,y/howMountainous),0,1,0,50); // !!! howMountainous may not force Float Division
    }
   }
  }
  
  void render(){
    beginShape();
    for(int y = 0; y<cols-1;y++){
     for(int x = 0; x<rows;x++){
       
     }
    }
    endShape();
  }
}
