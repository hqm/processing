/**
 * sample the audio input, display and threshold
 */

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.SourceDataLine;
import javax.sound.sampled.TargetDataLine;
import javax.sound.sampled.LineUnavailableException;

TargetDataLine line = null;
SourceDataLine pline = null;

float sampleRate = 8000;
boolean trigger = false;

int BUFSIZE=1024;
int TRIGGER_THRESHOLD = 3;

int sampleSizeInBits = 8;
int channels = 1;
boolean signed = true;
boolean bigEndian = true;

AudioFormat format = new AudioFormat(sampleRate, sampleSizeInBits, channels, signed, bigEndian); 

ByteArrayOutputStream out;
int numBytesRead;


int SAMPLE_LENGTH = 24000;


byte[] data = null;
int[] samples = new int[SAMPLE_LENGTH];

void setup()
{
  size(1440, 600, P3D);
  initialize_audio();
  textFont(createFont("Arial", 12));
  text("display buffer size = "+BUFSIZE, 5, 15);
}

void initialize_audio() {
  DataLine.Info info = new DataLine.Info(TargetDataLine.class, 
  format); // format is an AudioFormat object
  if (!AudioSystem.isLineSupported(info)) {
    println("Error: unsupported audio format "+format);
    // Handle the error ...
  }
  // Obtain and open the line.
  try {
    line = (TargetDataLine) AudioSystem.getLine(info);
    line.open(format);
  } 
  catch (LineUnavailableException ex) {
    // Handle the error ...
    println("input Line unavailable "+ex.getMessage());
  }

  // Assume that the TargetDataLine, line, has already
  // been obtained and opened.

  data = new byte[line.getBufferSize()];
  line.start();
}

int clap = 20;

void draw()
{
  background(0);
  stroke(255);

  float hscale = width / float(SAMPLE_LENGTH);
  float scale = 2.5;

  if (trigger) {
    record_on_trigger();
  }

  for (int y = height; y > 0; y -= 10) {
    line(0, y, 5, y);
  }

  stroke(255, 0, 0, 128);
  // draw the waveforms so we can see what we are monitoring
  for (int i = 0; i < SAMPLE_LENGTH-1; i++)
  {
    line( i*hscale, height/2 + samples[i]*scale, (i+1)*hscale, height/2 + samples[i+1]*scale );
  }

  stroke(255);
  for (int i = 0; i < SAMPLE_LENGTH; i++) {
    if (samples[i] > clap) {
      rect(i*hscale, height/2-100, 2, 200);
    }
  }
}

int MAX_EVENTS = 32;

void findEvents() {
  int[] events = new int[MAX_EVENTS];
  int noevent = 0;
  int eventstart = 1; 
  int eventtail = 2;
  int state = noevent; 
  int counter = 0;
  int eventn = 0;
  for (int i = 0; i < SAMPLE_LENGTH; i++) {
    if (eventn > 31) break;
    if (state == noevent) {
      if (samples[i]>clap) { 
        state = eventstart;
      }
    } 
    else if (state == eventstart) {
      counter = 0;
      if (samples[i]<clap) {
        state = eventtail;
      }
    }
    else if (state == eventtail) {
      if (samples[i]>clap) {
        events[eventn]=counter;
        eventn = eventn+1;
        state = eventstart;
      }
    }
    counter = counter+1;
  }
  print("events = ");
  for (int k = 0; k < events.length; k++) {
    print(events[k] + ", ");
  }
  println("");
}

void record_on_trigger() {
  byte monitor[] = new byte[2];
  numBytesRead =  line.read(monitor, 0, 1);
  if (numBytesRead > 0) {
    int level = (int)monitor[0];
    if (level > TRIGGER_THRESHOLD) {
      println("threshold level "+level);
      captureSound();
    }
  }
}
void keyReleased()
{

  if ( key == 'r' ) 
  {         
    captureSound();
  }
  if (key == 'a') {
    findEvents();
  }

  if ( key == 'q' ) {
    System.exit(0);
  }
}

void captureSound() {
  out = new ByteArrayOutputStream();
  int nbytes = 0;
  // Begin audio capture.
  println("recording: line buffersize = "+data.length+", "+line.getBufferSize());
  // Here, stopped is a global boolean set by another thread.
  while (nbytes < SAMPLE_LENGTH) {
    // Read the next chunk of data from the TargetDataLine.
    numBytesRead =  line.read(data, 0, data.length);
    nbytes += numBytesRead;
    print(numBytesRead +",");
    // Save this chunk of data.
    out.write(data, 0, numBytesRead);
  }
  println("recording done.");
  line.flush();
  // copy byte stream and convert to integers
  samples = new int[SAMPLE_LENGTH];
  byte captured[] = out.toByteArray();
  for (int i = 0; i < samples.length; i++) {
    samples[i] = (int) captured[i];
  }
  //saveFile(samples, "/Users/hqm/src/steps/samples/samples.obj");
}

public static int[] loadFile(String filename) {
  int arr[] = null;
  try {
    FileInputStream fis = new FileInputStream(filename);
    ObjectInputStream in = new ObjectInputStream(fis);
    arr = (int[])in.readObject();
    in.close();
  }
  catch (Exception e) {
    System.out.println(e);
  }
  return arr;
}

public static void saveFile(int samples[], String filename) {
  try {
    FileOutputStream fos = new FileOutputStream(filename);
    ObjectOutputStream out = new ObjectOutputStream(fos);
    out.writeObject(samples);
    out.flush();
    out.close();
    System.out.println("saved file "+filename + ", "+samples.length + " bytes");
  }
  catch (IOException e) {
    System.out.println(e);
  }
}
