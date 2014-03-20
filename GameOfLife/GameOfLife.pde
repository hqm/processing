/**
 * A Processing implementation of Game of Life
 * By Joan Soler-Adillon
 *
 * Press SPACE BAR to pause and change the cell's values with the mouse
 * On pause, click to activate/deactivate cells
 * Press R to randomly reset the cells' grid
 * Press C to clear the cells' grid
 *
 * The original Game of Life was created by John Conway in 1970.
 */

// Size of cells
int cellSize =16;

final int N_MULTI_STEPS = 10;

// How likely for a cell to be alive at start (in percentage)
float probabilityOfAliveAtStart = 15;

// Variables for timer
int interval = 100;
int lastRecordedTime = 0;

// Colors for  cells
color ccolor[] = {
  /* 0  even down */  color(0), 
  /* 1  even up   */  color(200, 0, 0), 
  /* 2  odd down  */  color(10), 
  /* 3  odd up    */  color(0, 200, 0)
};

color downEven=0;
color upEven=1;
color downOdd=2;
color upOdd = 3;



// Array of cells
int[][] cells; 
// Buffer to record the state of the cells and use this while changing the others in the interations
int[][] cellsBuffer; 

// Pause
boolean run = false;
boolean singleStep = true;
// Step N clock cycles
boolean multiStep = true;
int clock = 0;
int ncells_h, ncells_v;

void setup() {
  size (1024, 1024);
  frameRate(5000);
  ncells_h = width/cellSize;
  ncells_v = height/cellSize;
  // Instantiate arrays 
  cells = new int[ncells_h][ncells_v];
  cellsBuffer = new int[ncells_h][ncells_v];

  // This stroke will draw the background grid
  stroke(48);

  noSmooth();

  // Initialization of cells
  for (int x=0; x<ncells_h; x++) {
    for (int y=0; y<ncells_v; y++) {
      float state = random (100);
      if (state > probabilityOfAliveAtStart) { 
        state = 0;
      }
      else {
        state = 1;
      }
      cells[x][y] = int(state); // Save state of each cell
    }
  }
  background(0); // Fill in black in case cells don't cover all the windows
}


void draw() {


  //Draw grid
  for (int x=0; x<ncells_h; x++) {
    for (int y=0; y<ncells_v; y++) {
      int val = cells[x][y];
      fill(ccolor[val]); // If alive
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
  // Iterate if timer ticks
  if (run || singleStep || multiStep) {
    iteration();
    singleStep = false;
    if (clock % N_MULTI_STEPS == 0) {
      multiStep = false;
    }
  }



  // Create  new cells manually on pause
  if ((!run || singleStep) && mousePressed) {
    // Map and avoid out of bound errors
    int xCellOver = int(map(mouseX, 0, width, 0, ncells_h));
    xCellOver = constrain(xCellOver, 0, ncells_h-1);
    int yCellOver = int(map(mouseY, 0, height, 0, ncells_v));
    yCellOver = constrain(yCellOver, 0, ncells_v-1);

    boolean even = ((xCellOver + yCellOver) % 2) == 0;
    int val = cellsBuffer[xCellOver][yCellOver];
    // Check against cells in buffer
    if ( val == upEven || val == upOdd ) { // Cell is alive
      cells[xCellOver][yCellOver]= even ? downEven : downOdd; // Kill
    }  
    else { // Cell is dead, toggle to alive
      cells[xCellOver][yCellOver]= even ? upEven  : upOdd; // alive
    }
  }
  else if (!run  && !mousePressed) { // And then save to buffer once mouse goes up
    // Save cells to buffer (so we opeate with one array keeping the other intact)
    for (int x=0; x<ncells_h; x++) {
      for (int y=0; y<ncells_v; y++) {
        cellsBuffer[x][y] = cells[x][y];
      }
    }
  }
}

void iteration() { 
  iterationSalt();
}

void iterationConway() { // When the clock ticks
  // Save cells to buffer (so we opeate with one array keeping the other intact)
  for (int x=0; x<ncells_h; x++) {
    for (int y=0; y<ncells_v; y++) {
      cellsBuffer[x][y] = cells[x][y];
    }
  }

  // Visit each cell:
  for (int x=0; x<ncells_h; x++) {
    for (int y=0; y<ncells_v; y++) {
      // And visit all the neighbours of each cell
      int neighbours = 0; // We'll count the neighbours
      for (int xx=x-1; xx<=x+1;xx++) {
        for (int yy=y-1; yy<=y+1;yy++) {  
          if (((xx>=0)&&(xx<ncells_h))&&((yy>=0)&&(yy<ncells_v))) { // Make sure you are not out of bounds
            if (!((xx==x)&&(yy==y))) { // Make sure to to check against self
              if (cellsBuffer[xx][yy]==1) {
                neighbours ++; // Check alive neighbours and count them
              }
            } // End of if
          } // End of if
        } // End of yy loop
      } //End of xx loop
      // We've checked the neigbours: apply rules!
      if (cellsBuffer[x][y]==1) { // The cell is alive: kill it if necessary
        if (neighbours < 2 || neighbours > 3) {
          cells[x][y] = 0; // Die unless it has 2 or 3 neighbours
        }
      } 
      else { // The cell is dead: make it live if necessary      
        if (neighbours == 3 ) {
          cells[x][y] = 1; // Only if it has 3 neighbours
        }
      } // End of if
    } // End of y loop
  } // End of x loop
} // End of function


void iterationSalt() { // When the clock ticks
  // Save cells to buffer (so we opeate with one array keeping the other intact)
  for (int x=0; x<ncells_h; x++) {
    for (int y=0; y<ncells_v; y++) {
      cellsBuffer[x][y] = cells[x][y];
    }
  }

  // Visit each cell in the odd plane:
  for (int x=3; x<ncells_h-3; x+=2) {
    for (int y=3; y<ncells_v-3; y+=2) {
      // compute the eight knights moves   
    }
  }   
} // End of function

void keyPressed() {
  if (key == ' ') { // SPACE char means single step at action level
    run = false;
    singleStep = true;
  } 
  else if (keyCode == ENTER) {
    run = true;
    singleStep = false;
    multiStep = false;
  }

  if (key=='c' || key == 'C') { // Clear all
    for (int x=0; x<ncells_h; x++) {
      for (int y=0; y<ncells_v; y++) {
        cells[x][y] = 0; // Save all to zero
      }
    }
  }
}

