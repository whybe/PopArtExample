import gab.opencv.*;

PImage img;
PopArtFilter popArtFilter;

float targetWidth = 100.0;
float targetHeight = 100.0;

void setup() {
//  size(720, 480, P2D);
  background(255);
  
  img = loadImage("02.jpg"); //<>//
  popArtFilter = new PopArtFilter(this, img);
  
  if (!popArtFilter.detect()) {
    noLoop();
    exit();
  } else {
    if (!popArtFilter.resize(300, 400, 0.7)) {
      noLoop();
      exit();
    } else {
//      popArtFilter.blur(5);
//      popArtFilter.threshold(90);
//      popArtFilter.adaptiveThreshold(31, 3);
//      popArtFilter.invert();
//      popArtFilter.dilate(2);
//      popArtFilter.canny(25, 75);
//      popArtFilter.dilate(5);
//      popArtFilter.erode(5);
//      popArtFilter.useColor();
//      popArtFilter.blur(5);

      size(popArtFilter.img.width, popArtFilter.img.height, P2D);
      image(popArtFilter.img, 0, 0);
//      save("resize/resize_02.png");
    }
  }
}

void draw() {
//  popArtFilter.update();
//  smooth();
//  image(popArtFilter.img, 0, 0);
}
