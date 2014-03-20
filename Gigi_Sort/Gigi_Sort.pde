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

size(200,200);

int[] A =  {2,23,45,1,3,68,103,89,69,20,};

int small=java.lang.Integer.MAX_VALUE;
int big = java.lang.Integer.MIN_VALUE;
for (int i = 9; i >= 0; i--) {
  println("A[" + i + "] is " + A[i]);
  if(A[i]>big){
    big=A[i];
   
  }
  if(A[i]<small){
    small=A[i];
    
  }
}
println("the max is "+big);
println("the min is " +small);


