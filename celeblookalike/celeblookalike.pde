import shiffman.box2d.*; //<>// //<>//
import controlP5.*;
import java.io.*;

ControlP5 cp5;

DropdownList d1;

int myColor = color(255);

int c1, c2;

import java.util.*;

PImage img;  // Declare variable "a" of type PImage

ArrayList<Face> faces = new ArrayList<Face>();



Face findFace(String name) {
  for (int i = 0; i<faces.size(); i++) {
    Face f = faces.get(i);
    if ( f.name.equals(name)) {
      return f;
    }
  }

  return null;
}




PVector p1;
PVector p2;
PVector p3;
PVector p4;

State state = State.GET_LEFT_EYE;
State p_state = State.P_IDLE;


void clearPoints() {
  p1 = new PVector(-100, -100);
  p2 = new PVector(-100, -100);
  p3 = new PVector(-100, -100);
  p4 = new PVector(-100, -100);
}

void writeFaces(String pathname) {
  try
  {
    FileOutputStream fileOut =
      new FileOutputStream(pathname);
    ObjectOutputStream out = new ObjectOutputStream(fileOut);
    out.writeObject(faces);
    out.close();
    fileOut.close();
    println("Serialized data is saved in "+pathname);
  }
  catch(IOException i)
  {
    i.printStackTrace();
  }
}





Face face = new Face();

String celebs[] = {
  "Jennifer Aniston", "janiston.jpeg", 
  "Jake Gyllenhaal", "jgyllenhaal.jpeg", 
  "Angelina Jolie", "angelinajolie.jpeg", 
  "Beyonce", "beyonce.jpg"
};

void setup() {
  size(800, 800);
  // The image file must be in the data folder of the current sketch 
  // to load successfully

  for (int i = 0; i < celebs.length; i = i+2) {
    faces.add(new Face(celebs[i], celebs[i+1]));
  }



  img = loadImage("janiston.jpeg");  // Load the image into the program  
  state = State.PICK_PERSON;
  p_state = State.P_IDLE;
  clearPoints();


  // pulldown menu initialization
  cp5 = new ControlP5(this);
  // create a DropdownList
  d1 = cp5.addDropdownList("myList-d1")
    .setPosition(10, 100)
      ;

  customize(d1); // customize the first list


  cp5.addButton("saveFaces")
    .setPosition(200, 80)
      .setSize(100, 19);

  cp5.addButton("loadFaces")
    .setPosition(260, 80)
      .setSize(100, 19);
}



void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.captionLabel().set("Celibrity Image");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  for (int i = 0; i < celebs.length; i+=2) {
    ddl.addItem(celebs[i], i);
  }

  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void mouseClicked() {
  println("mouseClicked p_state="+p_state);
  switch (p_state) {
  case P4_1:
    p1 = new PVector(mouseX, mouseY);
    p_state = State.P4_2;
    break;
  case P4_2: 
    p2 = new PVector(mouseX, mouseY);
    p_state = State.P4_3;
    break;
  case P4_3:
    p3 = new PVector(mouseX, mouseY);
    p_state = State.P4_4;
    break;
  case P4_4:
    p4 = new PVector(mouseX, mouseY);
    p_state = State.P_FINISH;
    break;
  case P3_1:
    p1 = new PVector(mouseX, mouseY);
    p_state = State.P3_2;
    break;
  case P3_2:
    p2 = new PVector(mouseX, mouseY);
    p_state = State.P3_3;
    break;
  case P3_3:
    p3 = new PVector(mouseX, mouseY);
    p_state = State.P_FINISH;
    break;
  case P3_0:
    p_state = State.P3_1;
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
  text("state = "+state, 0, 20);
  text("p_state = "+p_state, 0, 40);
  fill(255, 0, 0);
  ellipse(p1.x, p1.y, 10, 10);
  ellipse(p2.x, p2.y, 10, 10);
  ellipse(p3.x, p3.y, 10, 10);
  ellipse(p4.x, p4.y, 10, 10);
  if (state == State.GET_LEFT_EYE && p_state == State.P_FINISH) {

    state = State.GET_RIGHT_EYE;
    p_state = State.P3_1;
    face.leftEye = getPoly3();
  }
  else if (state == State.GET_RIGHT_EYE && p_state == State.P_FINISH) {
    state = State.GET_NOSE;
    p_state = State.P4_1;
    face.rightEye = getPoly3();
  }
  else if (state == State.GET_NOSE && p_state == State.P_FINISH) {
    state = State.GET_MOUTH;
    p_state = State.P4_1;
    face.nose = getPoly4();
  }
  else if (state == State.GET_MOUTH && p_state == State.P_FINISH) {
    state = State.GET_FACE;
    p_state = State.P4_1;
    face.mouth = getPoly4();
  }
  else if (state == State.GET_FACE && p_state == State.P_FINISH) {
    state = State.MATCH;
    p_state = State.P4_1;
    face.face = getPoly4();
  } 
  else if (state == State.MATCH) {
  }
  fill(255, 0, 0, 99);
  drawPoly3(face.leftEye);
  drawPoly3(face.rightEye);
  drawPoly4(face.nose);
  drawPoly4(face.mouth);
  fill(0, 0, 255, 50);
  drawPoly4Circle(face.face);
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
void drawPoly4Circle(Poly4 p) {
  ellipseMode(CORNERS);
  ellipse(p.left.x, p.top.y, p.right.x, p.bottom.y);
  ellipseMode(CENTER);
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
Poly4 getPoly4() {
  PVector[] points = {
    p1, p2, p3, p4
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

  Poly4 p = new Poly4();

  p.left = points[0];
  p.right= points[3];
  Arrays.sort(points, new Comparator<PVector>() 
  {
    @Override 
      public int compare(PVector p1, PVector p2) 
    {
      return (int) p2.y -  (int) p1.y;
    }
  }    
  );

  p.top = points[0];
  p.bottom = points[3];
  clearPoints();
  return p;
}



void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
    int i = (int) theEvent.getGroup().getValue();
    String name = celebs[i];
    println(name);
    face = faces.get(i/2);
    img = loadImage(face.filename);
    state = State.GET_LEFT_EYE;
    p_state = State.P3_0;
  } 
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}

public void saveFaces(int theValue) {
  println("a button event from saveFaces: "+theValue);

  writeFaces("/tmp/faceslib.ser");
  c1 = c2;
  c2 = color(255, 255, 0);
}

public void loadFaces(int theValue) {
  println("a button event from loadFaces: "+theValue);

  loadFaces("/tmp/faceslib.ser");
  c1 = c2;
  c2 = color(255, 255, 0);
}

