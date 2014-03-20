/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */
int cursory = 32;
int cursorx = 32;

int nextcursorx = 0;
int nextcursory = 0;

int cursorx2 = 34;
int cursory2 = 34;

int nextcursorx2 = 0;
int nextcursory2 = 0;

int SQUARE  = 8;
int SIZEX = 128;
int SIZEY = 100;
int board[][] = new int[SIZEX][SIZEY];
int clock = 0;
int age = 0;

int dir =UP;
int dir2 = DOWN;
boolean run = false;
void setup() {
  size(128*SQUARE, 100*SQUARE);

  for (int y = 0; y < SIZEY; y++) {
    for (int x = 0; x < SIZEX; x++) {
      board[x][y] = 0;
    }
  }


  rectMode(CORNER);
  frameRate(15);
}

int myabs(int n) {
  if (n >= 0) {
    return n;
  } 
  else { 
    return (-n);
  }
}

void draw() {
  if (run == false) {
    return;
  }

  background(0);
  stroke(255);

  updatePlayer1();
  updatePlayer2();

  int tries = 0;
  int val;
  while (tries++ < 20) {
    val = myabs(board[nextcursorx][nextcursory]);
    if (val > (clock - age)) {
      if (dir == UP || dir == DOWN) {
        dir = random(1) > 0.5 ? LEFT : RIGHT;
      } 
      else {
        dir = random(1) > 0.5 ? UP : DOWN;
      }
      updatePlayer1();
    } 
    else {
      break;
    }
  }

  if (tries >= 19) {
    run = false;
    println("player 1 dies");
  }
  tries = 0;

  int val2;
  while (tries++ < 20) {
    val2 = myabs(board[nextcursorx2][nextcursory2]);
    if (val2 > (clock - age)) {
      if (dir2 == UP || dir2 == DOWN) {
        dir2 = random(1) > 0.5 ? LEFT : RIGHT;
      } 
      else {
        dir2 = random(1) > 0.5 ? UP : DOWN;
      }
      updatePlayer2();
    } 
    else {
      break;
    }
  }
  if (tries >= 19) {
    run = false;
    println("player 2 dies");
  }

  cursorx = nextcursorx;
  cursory = nextcursory;

  board[cursorx][cursory]=clock;

  cursorx2 = nextcursorx2;
  cursory2 = nextcursory2;
  board[cursorx2][cursory2]=-clock;
  clock=clock+1;
  age = age+1;
  if (clock % 5 == 0) { 
    // age = age+1;
  }


  for (int y = 0; y <SIZEY; y++) {
    for (int x = 0; x < SIZEX; x++) {
      if (myabs(board[x][y]) > (clock - age)) {
        if (board[x][y] > 0) {
          fill (255, 0, 0);
        } 
        else {
          fill(0, 0, 255);
        }
        rect(x*SQUARE, y*SQUARE, SQUARE-2, SQUARE-2);
      }
    }
  }
} 

void updatePlayer1() {
  nextcursorx = cursorx;
  nextcursory = cursory;
  if (dir == UP) {
    nextcursory=cursory-1;
    if (nextcursory<0) {
      nextcursory=SIZEY-1;
    }
  } 
  else if (dir == DOWN) {
    nextcursory=cursory+1;
    if (nextcursory>SIZEY-1) {
      nextcursory=0;
    }
  } 
  else if (dir == LEFT ) {
    nextcursorx=cursorx-1;
    if (nextcursorx<0) {
      nextcursorx=SIZEX-1;
    }
  } 
  else if (dir == RIGHT) {
    nextcursorx=cursorx+1;
    if (nextcursorx>SIZEX-1) {
      nextcursorx=0;
    }
  }
}


void updatePlayer2() {
  nextcursorx2 = cursorx2;
  nextcursory2 = cursory2;
  if (dir2 == UP) {
    nextcursory2=cursory2-1;
    if (nextcursory2<0) {
      nextcursory2=SIZEY-1;
    }
  } 
  else if (dir2 == DOWN) {
    nextcursory2=cursory2+1;
    if (nextcursory2>SIZEY-1) {
      nextcursory2=0;
    }
  } 
  else if (dir2 == LEFT ) {
    nextcursorx2=cursorx2-1;
    if (nextcursorx2<0) {
      nextcursorx2=SIZEX-1;
    }
  } 
  else if (dir2 == RIGHT) {
    nextcursorx2=cursorx2+1;
    if (nextcursorx2>SIZEX-1) {
      nextcursorx2=0;
    }
  }
}
void clearboard() {
  for (int y = 0; y <SIZEY; y++) {
    for (int x = 0; x < SIZEX; x++) {
      board[x][y] = 0;
    }
  }
  cursorx = 32;
  cursory = 32;
  cursorx2 = 34;
  cursory2 = 34;
  dir = UP;
  dir2 = DOWN;
}

void keyPressed() {
  if (keyCode==UP && dir != DOWN) {
    dir=UP;
  } 
  else if (keyCode==DOWN && dir != UP) {
    dir=DOWN;
  } 
  else if (keyCode==LEFT && dir != RIGHT) {
    dir=LEFT;
  } 
  else if (keyCode==RIGHT && dir != LEFT) {
    dir=RIGHT;
  } 
  else  if (key=='w' && dir2 != DOWN) {
    dir2=UP;
  } 
  else if (key=='s' && dir2 != UP) {
    dir2=DOWN;
  } 
  else if (key=='a' && dir2 != RIGHT) {
    dir2=LEFT;
  } 
  else if (key=='d' && dir2 != LEFT) {
    dir2=RIGHT;
  } 
  else if (key == ' ') {
    clearboard();
    run = true;
  }
}

