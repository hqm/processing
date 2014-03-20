/**
  * primitive array example
 */
 
 
size(640, 1000);
background(0);

// two fixed length arrays of floats
float[] m1 = new float[256];
float[] m2 = new float[256];

// initialize the arrays with random values
for (int i = 0; i < m1.length; i++) {
  m1[i] = random(1);
  m2[i] = random(1);
}
for (int i = 0; i <m1.length; i++){
  float g = m1[i]*m2[i];
  float v = map(g, 0, 1, 0, height/2);
  println("i = " + m1[i]*m2[i]); 
  float v2 = map(m1[i], 0, 1, 0, height/2);
  stroke(0, 0, 255, 105);
  line(i*2, height/2, i*2, (height/2)-v2);
  float v3 = map(m2[i], 0, 1, 0, height/2);
  stroke(0, 255, 0 , 105);
  line(i*2, height/2, i*2, (height/2)-v3);
  stroke(255, 0, 0, 255);
  line(i*2, height/2, i*2, (height/2)-v);
}




// iterate over the arrays, printing the product of the two arrays
println("hi gigi!");



