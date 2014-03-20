/**
 * Array. 
 * 
 * An array is a list of data. Each piece of data in an array 
 * is identified by an index number representing its position in 
 * the array. Arrays are zero based, which means that the first 
 * element in the array is [0], the second element is [1], and so on. 
 * In this example, an array named "coswav" is created and
 * filled with the cosine values. This data is displayed three 
 * separate ways on the screen.  
 */

void setup() {
  noLoop();
  size(200,200);
}
void swap (int i,int j){
  int a=A[i];
  int b=A[j];
  A[i]=b; 
  A[j]=a;
}
int[] A =  {2,23,45,1,3,68,103,89,69,20,};

int small=java.lang.Integer.MAX_VALUE;
int big = java.lang.Integer.MIN_VALUE;

void draw() {
  for(int k=0; k<10; k++){
    

  for (int i = 0; i < 9; i++) {
    if (A[i]>A[i+1]){
      swap (i,i+1);
    }
  }
  }
  for (int i = 0; i < 9; i++) {
    println("A[" + i + "] is " + A[i]);
  }
}


