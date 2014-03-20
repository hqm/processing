import shiffman.box2d.*; //<>// //<>//

import java.util.*;
/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */

// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="moonwalk.jpg"; */

PImage img;  // Declare variable "a" of type PImage

final int START = 0;
final int GET_LEFT_EYE = 1;
final int GET_RIGHT_EYE = 2;
final int GET_NOSE = 3;
final int GET_MOUTH = 4;
final int GET_FACE = 5;
final int P3_1 = 6;
final int P3_2 = 7;
final int P3_3 = 8;
final int P4_1 = 9;
final int P4_2 = 10;
final int P4_3 = 11;
final int P4_4 = 12;
final int P_DONE = 13;
final int MATCH = 14;


int states[] = {
  START, GET_LEFT_EYE, GET_RIGHT_EYE, GET_NOSE, 
  GET_MOUTH, GET_FACE, 
  P3_1, P3_2, P3_3, 
  P4_1, P4_2, P4_3, P4_4, 
  P_DONE, 
  MATCH
};
String stateNames[] = {
  "START", "GET_LEFT_EYE", "GET_RIGHT_EYE", "GET_NOSE", 
  "GET_MOUTH", "GET_FACE", 
  "P3_1", "P3_2", "P3_3", 
  "P4_1", "P4_2", "P4_3", "P4_4", 
  "P_DONE", "MATCH"
};



String nameForState(int state) {
  for (int i = 0; i < states.length; i++) {
    if (states[i] == state) {
      return stateNames[i];
    }
  }
  return "unknown state: "+state;
}
PVector p1;
PVector p2;
PVector p3;
PVector p4;
int state = GET_LEFT_EYE;
void clearPoints() {
  p1 = new PVector(-100, -100);
  p2 = new PVector(-100, -100);
  p3 = new PVector(-100, -100);
  p4 = new PVector(-100, -100);
}
int p_state = 0;

class Face {
  Poly3 leftEye = new Poly3();
  Poly3 rightEye = new Poly3();
  Poly4 nose = new Poly4();
  Poly4 mouth = new Poly4();
  Poly4 face = new Poly4();
}
class Poly3 {
  PVector left = new PVector(-100, -100);
  PVector right = new PVector(-100, -100);
  PVector center = new PVector(-100, -100);
}
class Poly4 {
  PVector left = new PVector(-100, -100);
  PVector right = new PVector(-100, -100);
  PVector top = new PVector(-100, -100);
  PVector bottom = new PVector(-100, -100);
}
Face face = new Face();

void setup() {
  size(800, 800);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("beyonce.jpg");  // Load the image into the program  
  state = GET_LEFT_EYE;
  p_state = P3_1;
  clearPoints();
}

void mouseClicked() {
  println("mouseClicked p_state="+nameForState(p_state));
  switch (p_state) {
  case P4_1:
    p1 = new PVector(mouseX, mouseY);
    p_state = P4_2;
    break;
  case P4_2: 
    p2 = new PVector(mouseX, mouseY);
    p_state = P4_3;
    break;
  case P4_3:
    p3 = new PVector(mouseX, mouseY);
    p_state = P4_4;
    break;
  case P4_4:
    p4 = new PVector(mouseX, mouseY);
    p_state = P_DONE;
    break;
  case P3_1:
    p1 = new PVector(mouseX, mouseY);
    p_state = P3_2;
    break;
  case P3_2:
    p2 = new PVector(mouseX, mouseY);
    p_state = P3_3;
    break;
  case P3_3:
    p3 = new PVector(mouseX, mouseY);
    p_state = P_DONE;
    break;
  }
}
void draw() {
  background(0);
  // Displays the image at its actual size at point (0,0)
  float scale = (float)width/(float)img.width;
  float newWidth = width;
  float newHeight = img.height*scale;
  imageMode(CENTER);
  image(img, width/2, height/2, newWidth, newHeight);
  // Displays the image at point (0, height/2) at half of its size
  // println(img.width+", "+newWidth+", "+newHeight);
  fill(255);
  text("state = "+nameForState(state), 0, 20);
  text("p_state = "+nameForState(p_state), 0, 40);
  fill(255, 0, 0);
  ellipse(p1.x, p1.y, 10, 10);
  ellipse(p2.x, p2.y, 10, 10);
  ellipse(p3.x, p3.y, 10, 10);
  ellipse(p4.x, p4.y, 10, 10);
  if (state == GET_LEFT_EYE && p_state == P_DONE) {

    state = GET_RIGHT_EYE;
    p_state = P3_1;
    face.leftEye = getPoly3();
  }else if (state == GET_RIGHT_EYE && p_state == P_DONE){
    state = GET_NOSE;
    p_state = P4_1;
    face.rightEye = getPoly3();
  }  
  drawPoly3(face.leftEye);
  drawPoly3(face.rightEye);
}
void drawPoly3(Poly3 p) {
  ellipse(p.center.x, p.center.y, p.right.x-p.left.x, (p.right.x-p.left.x)/2);
}
void drawPoly4(Poly4 p) {
  beginShape();
  vertex(p.left.x, p.left.y);
  vertex(p.top.x, p.top.y);
  vertex(p.right.x, p.right.y);
  vertex(p.bottom.x, p.bottom.y);
  endShape(CLOSE);
}
Poly3 getPoly3() {
  PVector[] points = {
    p1, p2, p3
  };

  Arrays.sort(points, new Comparator<PVector>() 
  {
    @Override 
      public int compare(PVector p1, PVector p2) 
    {
      return (int) p2.x -  (int) p1.x;
    }
  }    
  );
  
  Poly3 p = new Poly3();
  
  p.left = points[0];
  p.right= points[2];
  p.center = points[1];
  clearPoints();
  return p;
}
