import processing.serial.*;
Serial myPort;
int val;
int serialData; //collects serial data
int previousSerialData; //collects serial data
int baudRate = 115200;
int portNumber= 0; // serial port number printed out in Setup Mode

import processing.sound.*;
SoundFile file;
WhiteNoise noise;
BandPass bandPass;
TriOsc triangle;
float amp=0.0;
float freq = 100;
final int numPiezos = 1;
int[] serialBuffer = new int[numPiezos];

void setup() {
  size(640, 360);
  background(255);

  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "File2.wav");
  bandPass = new BandPass(this);
  noise = new WhiteNoise(this);
  //noise.play();
  triangle = new TriOsc(this);
  //triangle.play();
  file.play();
  bandPass.process(file, freq, 100);

  String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
  printArray(Serial.list());
  myPort = new Serial(this, portName, 115200);
}      

void draw() 
{
  background(50);
  if ( myPort.available() > 0)
  {
    val = myPort.read();
    bandPass.freq(val);


    //int j = 0;
    //while ( myPort.available() > 0)
    //{
    //  if (j >= serialBuffer.length)
    //    break;    
    //  serialBuffer[j] = myPort.read();
    //  j++;
    //val = myPort.read();    
    //println(map(val, 0, 50, 440, 1760)); //print it out in the console
    //file.loop();
    //((map(val, 0, 50, 440, 1760));
    //file.amp((map(val, 0, 50, 440, 1760)));
    //file.amp((map(val, 0, 50, 440, 1760)));
  }
  for ( int i = 0; i < serialBuffer.length; i++)
  {
    ellipse((i*100)+100, height/2, serialBuffer[i], serialBuffer[i]);
  }
}

//void keyPressed()
//{
//  if (key == 'a')
//  {
//    freq +=100.f;
//  } else if (key == 'z')
//  {
//    freq -=100.f;
//  }
//  bandPass.freq(freq);
//  println(freq);
//}
