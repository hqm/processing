// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector vdisp;
  float G = 10;
  float mass = 30;
  
  
  

  Mover(PVector l) {
    location = l;
    velocity = new PVector(0, 1.5);
    acceleration = new PVector();
    vdisp = new PVector();
  }
  

  void update() {
    PVector delta;
    delta = new PVector(width/2, height/2);
    delta.sub(location);
    float r = delta.mag();
    float f = G*mass/(r*r);
    delta.normalize();
    delta.mult(f);

    acceleration = delta;
    velocity.add(delta); //<>//
    velocity.limit(8);
    location.add(velocity);
    
  }
  int c = 0;
  void display() {
    stroke(0);
    strokeWeight(0.5);

    fill(127);
    ellipse(location.x, location.y, 20, 20);
    // draw velocity vector
    vdisp = velocity.get();
    vdisp.mult(10.0);
    vdisp.add(location);
    //  line(location.x, location.y, vdisp.x, vdisp.y);
    //draw acceleration vector
    stroke(255, 0, 0);
    vdisp = acceleration.get();
    vdisp.mult(5000.0);
    vdisp.add(location);
    line(location.x, location.y, vdisp.x, vdisp.y);
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } 
    else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    } 
    else if (location.y < 0) {
      location.y = height;
    }
  }
}
