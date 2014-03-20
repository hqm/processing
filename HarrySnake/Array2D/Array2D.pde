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

int cursorx2 = 34;
int cursory2 = 34;

int age = 0;
int SQUARE  = 8;
int SIZEX = 128;
int SIZEY = 100;
int board[][] = new int[SIZEX][SIZEY];
int clock = 0;

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
  } else { 
    return (-n);
  }
}

void draw() {
  if (run == false) {
    return;
  }

  background(0);
  stroke(255);




  for (int y = 0; y <SIZEY; y++) {
    for (int x = 0; x < SIZEX; x++) {
      if (myabs(board[x][y]) > (clock - age)) {
        if (board[x][y] > 0) {
            fill (255, 0, 0);
        } else {
          fill(0,0,255);
        }
          rect(x*SQUARE, y*SQUARE, SQUARE-2, SQUARE-2);
          
      }
    }
  }

  int val = myabs(board[cursorx][cursory]);
  if (val > (clock - age)) {
    println(clock+": player 1 died: game over at "+cursorx+","+cursory+ "clock-age="+(clock-age)+" val="+val);
    run = false;
  }
  int val2 = myabs(board[cursorx2][cursory2]);
  if (val2 > (clock - age)) {
    println(clock+": player 2 died: game over at "+cursorx+","+cursory+ "clock-age="+(clock-age)+" val="+val);
    run = false;
  }
  
  
  
  
  board[cursorx][cursory]=clock;
  board[cursorx2][cursory2]=-clock;
  updatePlayer1();
  updatePlayer2();
  clock=clock+1;
  if (clock % 5 == 0) { 
    age = age+1;
  }
} 

void updatePlayer1() {
  
  if (dir == UP) {
    cursory=cursory-1;
    if (cursory<0) {
      cursory=SIZEY-1;
    }
  } 
  else if (dir == DOWN) {
    cursory=cursory+1;
    if (cursory>SIZEY-1) {
      cursory=0;
    }
  } 
  else if (dir == LEFT ) {
    cursorx=cursorx-1;
    if (cursorx<0) {
      cursorx=SIZEX-1;
    }
  } 
  else if (dir == RIGHT) {
    cursorx=cursorx+1;
    if (cursorx>SIZEX-1) {
      cursorx=0;
    }
  } 
  
  
  
}


void updatePlayer2() {
  if (dir2 == UP) {
    cursory2=cursory2-1;
    if (cursory2<0) {
      cursory2=SIZEY-1;
    }
  } 
  else if (dir2 == DOWN) {
    cursory2=cursory2+1;
    if (cursory2>SIZEY-1) {
      cursory2=0;
    }
  } 
  else if (dir2 == LEFT ) {
    cursorx2=cursorx2-1;
    if (cursorx2<0) {
      cursorx2=SIZEX-1;
    }
  } 
  else if (dir2 == RIGHT) {
    cursorx2=cursorx2+1;
    if (cursorx2>SIZEX-1) {
      cursorx2=0;
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
  if (keyCode==UP) {
    dir=UP;
  } 
  else if (keyCode==DOWN) {
    dir=DOWN;
  } 
  else if (keyCode==LEFT) {
    dir=LEFT;
  } 
  else if (keyCode==RIGHT) {
    dir=RIGHT;
  } else  if (key=='w') {
    dir2=UP;
  } 
  else if (key=='s') {
    dir2=DOWN;
  } 
  else if (key=='a') {
    dir2=LEFT;
  } 
  else if (key=='d') {
    dir2=RIGHT;
  } 
  else if (key == ' ') {
    clearboard();
    run = true;
  } 
}

