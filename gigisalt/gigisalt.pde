import java.util.ArrayList;

class Cell {
  int val = 0;
  ArrayList swaps = new ArrayList();

  Cell (int v) {
    this.val = v;
  }
}


int X = 500;
int cellsx = 100;
int cellsy = 100;
Cell state [] = new Cell [cellsx*cellsy];
Cell getcell(Cell a[], int x, int y) {
  return a[y*cellsx+x];
}

void setcell(Cell a[], int x, int y, Cell v) {
  a[y*cellsx+x] = v;
}
//   0 0 0 
//   0 1 0
//   0 0 0 


//int[] rules = {0,0,0,1,1,0,0,0};    // An initial rule system
int n = 0;
int cellwidth = 10;

void setup() {
  size(1000, 500);
  clearArray(state);
  setcell(state, 25, 25, new Cell(1));
  setcell(state, 26, 25, new Cell(1));
  setcell(state, 27, 25, new Cell(1));
}

boolean step = true;
boolean run = false;

void draw() {

  for (int x = 0; x<cellsx; x++) {
    for (int y = 0; y<cellsy; y++) {
      Cell c  = getcell(state, x, y);
      if (c.val == 0) {
        fill(0);
      } 
      else {
        if ((x+y) % 2 == 0) {
          fill(255, 0, 0);
        } 
        else {
          fill(0, 0, 255);
        }
      }
      rect(x*cellwidth, y*cellwidth, cellwidth, cellwidth);
    }
  }
  if (step || run) {
    update();
    step = false;
  }
}

void update() {
  for (int x = 1; x<cellsx-1; x++) {
    for (int y = 1; y<cellsy-1; y++) {
      Cell c  = getcell(state, x, y);
    }
  }
}


void keyPressed() {
  if (key == ENTER) {
    run = true;
  }
  else if (key == ' ') {
    step = true;
    run = false;
  } 
  else if (key == 'c') {
    clearArray(state);
  }
}

void clearArray(Cell a[]) {
  for (int i = 0; i < a.length; i++) {
    a[i] = new Cell(0);
  }
}

int prevx = -1;
int prevy = -1;
void mouseDragged() {
  int cx = mouseX/cellwidth;
  int cy = mouseY/cellwidth;
  if (prevx != cx || prevy != cy) {

    Cell c = getcell(state, cx, cy);
    if (c.val == 1) {
      c.val = 0;
    }
    else {
      c.val = 1;
    }
    prevx = cx;
    prevy = cy;
  }
}

