
import processing.sound.*;

AudioIn input;
Amplitude amp;
PImage img;

int micLevel=1;
int micLevelMax=0;
int dark=0;
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
  update();
  background(128);
  image(img, width/2, height/2);

  fill(0, dark);
  rect(0, 0, width, height);
}

void update() {
  micLevel=int(map(amp.analyze(), 0, 1, 0, 255));

  if (micLevel>64) {
    timer = 60;
  }

  if (timer > 0) {
    dark=constrain(dark+36, 0, 255);
    timer--;
  } else {
    dark=constrain(dark-36, 0, 255);
    timer = 0;
  }

  if (micLevel>micLevelMax) {//to hold the biggest value.
    micLevelMax=micLevel;
  }
  println(micLevel, micLevelMax);
}