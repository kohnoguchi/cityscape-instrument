/*
  Moving Average analog input and send over serial
  Reference voltage set to 1V
  NOTE: May be worth setting External Reference to 0.1V
*/



// these variables will change:
const uint8_t numPiezo = 2;
const int knockSensor[2] = {A0, A1}; // the piezo is connected to analog pin 0
unsigned long sensorReading[numPiezo] = {0};      // variable to store the value read from the sensor pin
const unsigned long piezoAverage  = 30;
unsigned int movingAverage[numPiezo][piezoAverage] = {{0}};
unsigned int windowIndex[numPiezo] = {0};

void setup()
{
  Serial.begin(115200);       // use the serial port
  analogReference(INTERNAL);
  for (int k = 0; k < numPiezo; ++k)
  {
    for (int i = 0; i < piezoAverage; ++i)
    {
      movingAverage[k][i] = 0;
    }
  }
}

void loop()
{
  for (int k = 0; k < numPiezo; ++k)
  {
    addToWindow(analogRead(knockSensor[k]), k);

    sensorReading[k] = 0;
    for (int i = 0; i < piezoAverage; ++i)
    {
      sensorReading[k] += movingAverage[k][i];
    }
    sensorReading[k] /= piezoAverage;

  }

  for (int k = 0; k < numPiezo; ++k)
  {
    uint8_t piezoReading = map(constrain((sensorReading[k] * 3) / 2, 0 , 255), 0, 30, 0, 5);
    Serial.write(sensorReading[k]);
  }

  delay(33);  // delay to avoid overloading the serial port buffer
}


void addToWindow(unsigned int newValue, uint8_t windowNumber)
{
  movingAverage[windowNumber][windowIndex[windowNumber]] = newValue;
  windowIndex[windowNumber]++;
  windowIndex[windowNumber] %= piezoAverage;
}
