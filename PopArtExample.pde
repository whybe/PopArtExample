import gab.opencv.*;

PImage img;
PopArtFilter popArtFilter;

float targetWidth = 100.0;
float targetHeight = 100.0;

void setup() {
  size(720, 480, P2D);
  background(255);
  
  img = loadImage("yb.jpg"); //<>//
  popArtFilter = new PopArtFilter(img, this);
  
  if (!popArtFilter.detect()) {
    noLoop();
    exit();
  } else {
    if (!popArtFilter.resize(200, 80, 0.1)) {
      noLoop();
      exit();
    } else {
      
    }
  }
}

void draw() {
  image(popArtFilter.img, 0, 0);
}
