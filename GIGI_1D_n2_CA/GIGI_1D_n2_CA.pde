int X = 500;
int state [] = new int [X];
int state1 [] = new int [X];
int rules [] = {
// 000  000  000  000  000  000  000  000
// 000  001  010  011  100  101  110  111
    0,   1,   0,   1,   1,   0,   1,   1,

// 001  001  001  001  001  001  001  001
// 000  001  010  011  100  101  110  111
    0,   1,   0,   1,   1,   0,   1,   0,

// 010  010  010  010  010  010  010  010
// 000  001  010  011  100  101  110  111
    0,   1,   1,   1,   0,   1,   1,   0,

// 011  011  011  011  011  011  011  011
// 000  001  010  011  100  101  110  111
    0,   1,   0,   0,   1,   1,   1,   0,

// 100  100  100  100  100  100  100  100
// 000  001  010  011  100  101  110  111
    1,   0,    1,  0,   1,   0,   1,   0,

// 101  101  101  101  101  101  101  101
// 000  001  010  011  100  101  110  111
    1,   0,    1,  0,   1,   0,   1,   0,

// 110  110  110  110  110  110  110  110
// 000  001  010  011  100  101  110  111
    1,   0,    1,  0,   1,   1,   0,   0,

// 111  111  111  111  111  111  111  111
// 000  001  010  011  100  101  110  111
    0,   0,    0,  0,   1,   0,   0,   0,


};


//   0 0 0 
//   0 1 0
//   0 0 0 


//int[] rules = {0,0,0,1,1,0,0,0};    // An initial rule system
int nextstate [] = new int [X];
int n = 0;
int cellwidth = 6;

void setup() {
  size(1000, 500);
  state[50] = 1;
  state[100] = 1;
}

void draw() {
  for(int i=0; i<state.length; i++){
    int cell = state[i];
    if(cell == 0){
      fill(0);
    }
    else{
      fill(255,0,0);
    }
    rect(i*cellwidth,n*cellwidth,cellwidth,cellwidth);
   
    
  }
  dorule();
  
  n++;
}

void dorule(){
  for(int i=1; i<state.length-1; i++){
    int left = state[i-1];
    int right = state[i+1];
    int me = state[i];
    int left1 = state1[i-1];
    int right1 = state1[i+1];
    int me1 = state1[i];
    int index = left*4+me*2+right+left1*16+me1*8+right1*4;
    int value = rules[index];
    nextstate[i] = value;
    
  }
  for(int i=1; i<state.length-1; i++){
    state1[i] = state[i];
    state[i] = nextstate[i];
    
    
  }
}
