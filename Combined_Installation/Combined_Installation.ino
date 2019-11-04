//code for crit
#include <MPU6050_tockn.h>
#include <Wire.h>
int state = 0; //connect to Bluetooth
//------------------------------------------------------
MPU6050 mpu6050(Wire);
int angleToNumber;
float angleZ;
int wrapTo180(int degrees)
{
  float radians = float(degrees) * (3.1415963 / 180.f);
  float wrappedToPi = atan2(sin(radians), cos(radians));
  int wrappedTo180 = (wrappedToPi * (180.f / 3.1415963f));
  return wrappedTo180;
}

//-------------------------------------------------------

void setup()
{
  Serial.begin(9600);
  Wire.begin();
  mpu6050.begin();
  mpu6050.calcGyroOffsets(true);
}

void loop() {

  if (Serial.available() > 0) { // Checks whether data is comming from the serial port
    state = Serial.read();
  }// Reads the data from the serial port


  mpu6050.update();
  angleZ = mpu6050.getAngleZ();
//  Serial.print("angleZ : ");
  angleZ = wrapTo180(angleZ);
//  Serial.println(angleZ);
  angleToNumber = map(angleZ, -180, 180, 1, 9);
  Serial.write(angleToNumber);
  delay(1000);
}
