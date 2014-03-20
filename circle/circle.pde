
float x = 200;
float y = 200;

void setup() {
  size(1024, 1024);
  frameRate(30);
  translate(512, 512);
  background(0);
  fill(255,255,255);
  ellipse(0,0,10,10);

}
float x1 = 200.0;
float y1 = 200.0;
float x2;
float y2;
float e = 50.0;
void draw() {
  translate(512, 512);
  fill(255,0,0);
  ellipse(x,y,4,4);
  println("x = "+x+", y = "+y);
  
  y = y - x / e;
  x = x + y / e;
  
  
  /*
  y2 = y1 - x1 / e;
  x2 = x1 + y1 / e;
  y1 = y2;
  x1 = x2;
  */
}
