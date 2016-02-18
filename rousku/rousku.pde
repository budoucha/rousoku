
import processing.sound.*;

AudioIn input;
Amplitude amp;
PImage img;

int scale=1;
int maxs=0;
int back=128;
int timer=0;

void setup() {
  frameRate(30);
  size(1480, 480);
  background(0);

  //Create an Audio input and grab the 1st channel
  input = new AudioIn(this, 0);
  input.start();

  // create a new Amplitude analyzer
  amp = new Amplitude(this);

  // Patch the input to an volume analyzer
  amp.input(input);
  img=loadImage("rousoku.png");
  imageMode(CENTER);
}      


void draw() {
  fill(back, 36);
  rect(0, 0, width, height);
  if (back>=128) {
    image(img, width/2, height/2);
    timer=0;
  }
  if (back<128) {
    timer++;
  }
  if (timer>60) {
    timer=0;
    back=128;
  }  
  scale=int(map(amp.analyze(), 0, 1, 0, 255));

  if (scale>64) {
    back=0;
  }
  if (scale>maxs) {
    maxs=scale;
  }
  println(maxs, timer);
}