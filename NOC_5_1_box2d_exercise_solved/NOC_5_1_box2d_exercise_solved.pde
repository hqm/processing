// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import bsh.Interpreter;




// A list for all of our rectangles
ArrayList<Box> boxes;
// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
Boundary b3;
PBox2D box2d;		



void setupBsh() {
  Interpreter i = new Interpreter();
  try {
    i.set( "myapp", this );  // Provide a reference to your app
    i.set( "portnum", 1234 );  
    i.eval("setAccessibility(true)"); // turn off access restrictions
    i.set("b3", b3);
    i.set("boundaries", boundaries);
    i.set("box2d", box2d);
    i.eval("server(portnum)");
  } 
  catch (Exception e) {
    println("exception "+e);
  }
}





void setup() {
  size(640, 360);

  // Initialize and create the Box2D world
  box2d = new PBox2D(this);	
  box2d.createWorld();

  // Create ArrayLists
  boxes = new ArrayList<Box>();

  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/4, height-5, width/2-50, 10));
  boundaries.add(new Boundary(3*width/4, height-50, width/2-50, 10));
  b3 =   new Boundary(3*width/4, height-200, width/2-50, 10);
  b3.b.setTransform(new Vec2(0, 0), (float) (45+offset*10 / (180 / Math.PI)));
  b3.b.setAngularVelocity(1.0);
  b3.b.setGravityScale(0.0);
  boundaries.add(b3);
  setupBsh();
}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();



  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }


  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }
}
float offset = 0;

void mouseClicked() {
  // When the mouse is clicked, add a new Box object
  Box p = new Box(mouseX, mouseY);
  boxes.add(p);
}

