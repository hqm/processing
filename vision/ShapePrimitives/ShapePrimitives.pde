/**
 * Shape Primitives. 
 * 
 * The basic shape primitive functions are triangle(),
 * rect(), quad(), ellipse(), and arc(). Squares are made
 * with rect() and circles are made with ellipse(). Each 
 * of these functions requires a number of parameters to 
 * determine the shape's position and size. 
 */

void setup() {
  size(640, 360);
  background(255);
  noStroke();
}

void drawstuff() {
   smooth();
  fill(88, 100, 110);
  triangle(18, 18, 18, 360, 81, 360);

  fill(102);
  rect(81, 81, 63, 63);

  fill(255, 90, 9);
  quad(189, 18, 216, 18, 216, 360, 144, 360);

  fill(200);
  ellipse(252, 144, 72, 72);

  fill(100);
  triangle(288, 18, 351, 360, 288, 360); 

  fill(180, 90, 225);
  arc(479, 300, 280, 280, PI, TWO_PI);
}


void draw() {
 drawstuff();
}

