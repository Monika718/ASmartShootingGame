class World {
  static final int TILE_EARTH = 0;
  
  static final int GRID_UNIT_SIZE = 60;
  
  static final int GRID_UNITS_WIDE = 20;
  static final int GRID_UNITS_HIGH = 20;
  
  int[][] worldGrid = new int[GRID_UNITS_WIDE][GRID_UNITS_HIGH];
  
  World() {
    for (int i = 0; i < GRID_UNITS_WIDE; i++) {
      for (int j = 0; j < GRID_UNITS_HIGH; j++) {
        worldGrid[i][j] = TILE_EARTH;
      }
    }
  }
  
  void render() {
    for (int i = 0; i < GRID_UNITS_WIDE; i++) {
      for (int j = 0; j < GRID_UNITS_HIGH; j++) {
        if (worldGrid[i][j] == TILE_EARTH) {
          stroke(40);
          image(earth, i * GRID_UNIT_SIZE, j * GRID_UNIT_SIZE, GRID_UNIT_SIZE - 1,GRID_UNIT_SIZE - 1);
          //fill(255);
        }
        
   //     image(i * GRID_UNIT_SIZE, j * GRID_UNIT_SIZE, GRID_UNIT_SIZE - 1,GRID_UNIT_SIZE - 1);
      }
    }
    
  }
}
