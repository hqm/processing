/**
  * This sketch demonstrates how to monitor the currently active audio input 
  * of the computer using an <code>AudioInput</code>. What you will actually 
  * be monitoring depends on the current settings of the machine the sketch is running on. 
  * Typically, you will be monitoring the built-in microphone, but if running on a desktop
  * its feasible that the user may have the actual audio output of the computer 
  * as the active audio input, or something else entirely.
  * <p>
  * When you run your sketch as an applet you will need to sign it in order to get an input. 
  */

import ddf.minim.*;

Minim minim;
AudioInput in;

void setup()
{
  size(1500, 500, P3D);

  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  
  // uncomment this line to *hear* what is being monitored, in addition to seeing it
  in.enableMonitoring();
}

void draw()
{
  background(0);
  stroke(255);
  boolean display
  
  // draw the waveforms so we can see what we are monitoring
 println(in.bufferSize());
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
    line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 );
  }
}
