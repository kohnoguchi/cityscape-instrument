import processing.serial.*;
Serial myPort;
int val;
int serialData; //collects serial data
int previousSerialData; //collects serial data
int baudRate = 115200;
int portNumber= 0; // serial port number printed out in Setup Mode

import processing.sound.*;
SoundFile file;
BandPass bandPass;

float amp=0.0;
float freq = 100;

void setup() {
  size(640, 360);
  background(255);

  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "File1.wav");
  bandPass = new BandPass(this);
  file.play();
  bandPass.process(file, freq, 50);

  String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
  printArray(Serial.list());
  myPort = new Serial(this, portName, 115200);
}      

//void draw() 
//{
//  background(50);
//    if ( myPort.available() > 0)
//  {
//    val = myPort.read();
//  }
//  println(val); //print it out in the console
//  ellipse(width/2, height/2, val, val);
//}

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
