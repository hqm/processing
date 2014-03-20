int X = 500;
int cellsx = 100;
int cellsy = 100;
int state [] = new int [cellsx*cellsy];
int getcell(int a[], int x, int y) {
  return a[y*cellsx+x];
}
void dorule(int from[], int to[], int x, int y) {
  int neighbors = 0;
  if (getcell(from, x-1, y-1) == 1) {
    neighbors ++;
  }
  if (getcell(from, x, y-1) == 1) {
    neighbors ++;
  }
  if (getcell(from, x+1, y-1) == 1) {
    neighbors ++;
  }
  if (getcell(from, x-1, y) == 1) {
    neighbors ++;
  }
  if (getcell(from, x+1, y) == 1) {
    neighbors ++;
  }
  if (getcell(from, x-1, y+1) == 1) {
    neighbors ++;
  }
  if (getcell(from, x, y+1) == 1) {
    neighbors ++;
  }
  if (getcell(from, x+1, y+1) == 1) {
    neighbors ++;
  }
  int v = getcell(from, x, y);
  if (v == 0) {
    if (neighbors == 3) {
      setcell(to, x, y, 1);
    }
  }
  else {
    if (neighbors<2) {
      setcell(to, x, y, 0);
    }
    else if (neighbors<4) {
      setcell(to, x, y, 1);
    }
    else {
      setcell(to, x, y, 0);
    }
  }
}
void setcell(int a[], int x, int y, int v) {
  a[y*cellsx+x] = v;
}
//   0 0 0 
//   0 1 0
//   0 0 0 


//int[] rules = {0,0,0,1,1,0,0,0};    // An initial rule system
int nextstate [] = new int [cellsx*cellsy];
int n = 0;
int cellwidth = 6;

void setup() {
  size(1000, 500);
  setcell(state, 25, 25, 1);
  setcell(state, 26, 25, 1);
  setcell(state, 27, 25, 1);
}

boolean step = true;
boolean run = true;

void draw() {

  for (int x = 0; x<cellsx; x++) {
    for (int y = 0; y<cellsy; y++) {
      int v  = getcell(state, x, y);
      if (v == 0) {
        fill(0);
      }
      else {
        fill(255, 0, 0);
      }
      rect(x*cellwidth, y*cellwidth, cellwidth, cellwidth);
    }
  }
  if (step || run) {
    update();
    swaparrays();
    step = false;
  }
}

void update() {
  for (int x = 1; x<cellsx-1; x++) {
    for (int y = 1; y<cellsy-1; y++) {
      dorule(state, nextstate, x, y);
    }
  }
}
void swaparrays() {
  for (int i = 0; i<state.length; i++) {
    state[i] = nextstate[i];
  }
}

void keyPressed() {
  if (key == ENTER) {
    run = true;
  }
  else if (key == ' ') {
    step = true;
    run = false;
  } else if (key == 'c') {
    clearArray(state);
  }
}

void clearArray(int a[]) {
  for (int i = 0; i < a.length; i++) {
      a[i] = 0;
  }
}

int prevx = -1;
int prevy = -1;
void mouseDragged() {
  int cx = mouseX/cellwidth;
  int cy = mouseY/cellwidth;
  if (prevx != cx || prevy != cy) {

    int val = getcell(state, cx, cy);
    if (val == 1) {
      setcell(state, cx, cy, 0);
    }
    else {
      setcell(state, cx, cy, 1);
    }
    prevx = cx;
    prevy = cy;
  }
}

