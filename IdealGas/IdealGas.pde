// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// PBox2D example

// Basic example of controlling an object with our own motion (by attaching a MouseJoint)
// Also demonstrates how to know which object was hit

import pbox2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.callbacks.ContactImpulse;

// A reference to our box2d world
PBox2D box2d;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

Boundary wall;
Boundary leftwall;
Boundary rightwall;
Box box;
PFont f;
float temperature = 0;
float pressure = 0;
int clock = 0;
float s = 0;

void setup() {
  size(1000, 500);
  smooth();
  f = createFont("Arial", 16, true); // STEP 3 Create Font


  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld(); //<>//

  // Turn on collision listening!
  box2d.listenForCollisions();

  // Create the empty list
  particles = new ArrayList<Particle>();

  wall = new Boundary(width/2, height-5, width, 10);
  leftwall = new Boundary(width*0.25, height/2, 10, height);
  rightwall = new Boundary(width*0.75, height/2, 10, height);
  box = new Box(((width*0.25)+(width*0.75))/2, height/2, (rightwall.x-leftwall.x)-10, 40);
  box.body.setFixedRotation(true);
  //box.body.setType(BodyType.STATIC);
}

void draw() {
  clock = clock + 1;
  if(clock % 600 == 0){
    pressure = s/600;
    s = 0;
  }
  background(255);
  textFont(f, 16);                 // STEP 4 Specify font to be used
  fill(0);                        // STEP 5 Specify font color 
  text("temperature =" + temperature, 10, 100);  // STEP 6 Display Text
  text("pressure =" + pressure, 10, 50);
  text("clock=" + clock, 10, 20);
  text("s=" + s, 10, 150);

  if (random(1) < 0.1) {
    float sz = 5;
    Particle p = (new Particle((leftwall.x)+random((rightwall.x)-(leftwall.x)), height-20, sz));
    particles.add(p);
    float vx = 10;
    float vy =10;
    p.body.setLinearVelocity(new Vec2(vx, vy));
  }


  // We must always step through time!
  temperature = 0;
  box2d.step();

  // Look at all particles
  temperature = 0;
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    Vec2 v = p.body.getLinearVelocity();
    temperature = temperature + v.lengthSquared();


    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      particles.remove(i);
    }
  }

  wall.display();
  leftwall.display();
  rightwall.display();
  box.display();
}

/*
// Collision event functions!
void beginContact(Contact cp) {
  // Get both fixtures

  if (o1.getClass() == Particle.class && o2.getClass() == Particle.class) {
    Particle p1 = (Particle) o1;
    p1.change();
    Particle p2 = (Particle) o2;
    p2.change();
  }
}
*/

 void postSolve(Contact cp, ContactImpulse ci) {
     Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies

    if(b1 == box.body|| b2 == box.body){
      float [] ni = ci.normalImpulses;
      for(int i = 0; i < ni.length; i ++){
        float impulse = ni[i]; 
          if (impulse < 0) print(" ,"+impulse);
        s = impulse + s;
      }
    }
 }
  

// Objects stop touching each other
void endContact(Contact cp) {
  
}
