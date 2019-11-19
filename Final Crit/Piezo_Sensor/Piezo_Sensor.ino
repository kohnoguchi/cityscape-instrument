/*
  Moving Average analog input and send over serial
  Reference voltage set to 1V
  NOTE: May be worth setting External Reference to 0.1V
 */

const int knockSensor = A0; // the piezo is connected to analog pin 0
const unsigned long piezoAverage  = 100;
// these variables will change:
unsigned long  sensorReading = 0;      // variable to store the value read from the sensor pin
unsigned int movingAverage[piezoAverage] = {0};
unsigned int windowIndex = 0;

void setup()
{
  Serial.begin(115200);       // use the serial port
  analogReference(INTERNAL);
  for (int i = 0; i < piezoAverage; ++i)
    movingAverage[i] = 0;
}

void loop()
{
  addToWindow(analogRead(knockSensor));
  sensorReading = 0;

  for (int i = 0; i < piezoAverage; ++i)
  {
    sensorReading += movingAverage[i];
  }

  sensorReading /= piezoAverage;

  Serial.write(constrain((sensorReading * 3) / 2, 0 , 255));
  delay(33);  // delay to avoid overloading the serial port buffer
}


void addToWindow(unsigned int newValue)
{
  movingAverage[windowIndex] = newValue;
  windowIndex++;
  windowIndex %= piezoAverage;
}
