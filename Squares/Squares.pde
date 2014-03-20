/**
 * Loop. 
 * 
 * The loop() function causes draw() to execute
 * continuously. If noLoop is called in setup()
 * the draw() is only executed once. In this example
 * click the mouse to execute loop(), which will
 * cause the draw() the execute continuously. 
 */
 
// The statements in the setup() function 
//}execute once when the program begins
void setup() 
{
  size(600, 600);  // Size should be the first statement
  stroke(255);     // Set stroke color to white
  noLoop();
}

float y = 100;
int A[] = {25, 35, 45, 2, 15, 18, 11, 40, 29, 8};


// The statements in draw() are run until the 
// program is stopped. Each statement is run in 
// sequence and after the last line is read, the first 
// line is run again.
void draw() 
{ 
  int i=0;
    while(i<10){
     print(i);
     print (": ");
     println (A[i]);
     i=i+1;
  
  
  }
} 

void mousePressed() 
{
  loop();
}
