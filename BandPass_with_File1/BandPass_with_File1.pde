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
}      

void draw() {
}

void keyPressed()
{
  if (key == 'a')
  {
    freq +=50.f;
  } else if (key == 'z')
  {
    freq -=50.f;
  }
  bandPass.freq(freq);
  println(freq);
}
