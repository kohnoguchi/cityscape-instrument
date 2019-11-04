/*
* Trigger a sound in processing via Serial comms
 */
//--------------------------------------------------------------------------
import processing.serial.*;
import processing.sound.*;
//--------------------------------------------------------------------------
Serial arduino;
int serialData; //collects serial data
int previousSerialData; //collects serial data
int baudRate = 9600;
int portNumber= 0; // serial port number printed out in Setup Mode
//--------------------------------------------------------------------------
SoundFile currentSound;
//--------------------------------------------------------------------------
boolean setupMode = false;
PImage photo;
//--------------------------------------------------------------------------
void setup() 
{
  size(2000, 1000); //link processing to serial port
  if (setupMode)
  {    
    printArray(Serial.list());
    while (true) {
    }
  }
  String arduinoPort = Serial.list()[portNumber]; 
  arduino = new Serial(this, arduinoPort, baudRate); // number here should match the begin series from the arduinoPort
  delay(10000);
  arduino.clear();
  arduino.read();
}
//--------------------------------------------------------------------------
void draw() 
{
  while (arduino.available() > 0)
  {    
    serialData = arduino.read(); // in this case it will stop when it reaches number 10
    println(serialData);
    if (previousSerialData != serialData)
    {            
      previousSerialData = serialData;
      setNewSoundandImage(str(serialData));
    }
  }
}
//--------------------------------------------------------------------------
void stop() 
{
  currentSound.stop();
}
//--------------------------------------------------------------------------
void setNewSoundandImage(String fileNumber)
{
  if (currentSound != null)
  {
    stop();
  }
  ////Picture  
  //photo = loadImage("Image" + fileNumber + ".jpg");
  //image(photo, 0, 0, width, height);
    //Picture  
  photo = loadImage("blank page.jpg");
  image(photo, 0, 0, width, height);


  //Sound
  println("File" + fileNumber + ".wav");
  currentSound = new SoundFile(this, "File" + fileNumber + ".wav");  
  currentSound.play();
}
