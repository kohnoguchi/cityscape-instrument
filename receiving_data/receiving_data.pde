/*
 Read raw byte data from serial connection
 */

import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;     // Data received from the serial port

void setup()
{
  size(400,400);
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
  }
  println(val); //print it out in the console
  ellipse(width/2, height/2, val, val);
}
