
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
//  mpu6050.calcGyroOffsets(true);
}

void loop()
{
  mpu6050.update();
  angleZ = mpu6050.getAngleZ();
  //  Serial.print("angleZ : ");
  angleZ = wrapTo180(angleZ);
  //  Serial.println(angleZ);
  angleToNumber = map(angleZ, -180, 180, 1, 9);
  Serial.println(mpu6050.getAngleZ());
  delay(100);
}
