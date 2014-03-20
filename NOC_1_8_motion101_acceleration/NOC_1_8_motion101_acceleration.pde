// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover mover;

void setup() {
  size(800,800);
  mover = new Mover(); 
}

void draw() {
 // background(255);
  fill(255,2);
  rect(0,0,width,height);
  
  mover.update();
  mover.checkEdges();
  mover.display(); 
}  
  

