import processing.sound.*;

WhiteNoise noise;
BandPass bandPass;

float amp=0.0;
float freq = 100;
void setup() {
  size(640, 360);
  background(255);

  // Create a noise generator and a bandpass filter
  noise = new WhiteNoise(this);
  bandPass = new BandPass(this);

  noise.play(0.5);
  bandPass.process(noise, freq, 50);
}      

void draw() {
}

void keyPressed()
{
  if (key == 'a')
  {
    freq +=25.f;
  } else if (key == 'z')
  {
    freq -=25.f;
  }
  bandPass.freq(freq);
  println(freq);
}
