int X = 500;
int state [] = new int [X];
int nextstate [] = new int [X];
int n = 0;
int cellwidth = 6;

// An initial rule system
int[] rules = {
//  Left  Me Right
//  0     0    0 // previous state of me and my left and right neighbor
          0,      // new state of 'me'

//  0     0    1
          1,

//  0     1    0
          0,

//  0     1    1
          0,

//  1     0    0
          1,

//  1     0    1
          0,

//  1     1    0
          1,

//  1     1    1
          0
};    


void setup() {
  size(1000, 500);
  // set up some initial values
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
    rect(i*cellwidth,(n*cellwidth)%height,cellwidth,cellwidth);
   
    
  }
  dorule();
  
  n++;
}

void dorule(){
  for(int i=1; i<state.length-1; i++){
    int left = state[i-1];
    int right = state[i+1];
    int me = state[i];
   
    int index = left*4+me*2+right;
    int value = rules[index];
    nextstate[i] = value;
    
  }
  for(int i=1; i<state.length-1; i++){
    state[i] = nextstate[i];
    
    
  }
}
