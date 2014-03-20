// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

ArrayList<Mover> movers = new ArrayList<Mover>();


void setup() {
  size(800,800);
  movers.add(new Mover(new PVector ((width/2)-100, height/2)));
  movers.add(new Mover(new PVector ((width/2)+100, height/2)));
  movers.add(new Mover(new PVector ((width/2)-50, height/2)));
  movers.add(new Mover(new PVector ((width/2)+50, height/2)));  
} 

void draw() {
 // background(255);
  fill(255,2);
  rect(0,0,width,height);
  
  for (Mover mover: movers){
  mover.update();
  mover.checkEdges();
  mover.display(); 
    
  }

}  
  

