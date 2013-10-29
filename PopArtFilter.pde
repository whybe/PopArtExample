import gab.opencv.*;
import java.awt.Rectangle;

class PopArtFilter {
  PImage img;

  PApplet sketch;
  OpenCV opencv;

  Rectangle face;
  boolean isFaceRectVisable = true;

  PopArtFilter(PImage img, PApplet sketch) {
    this.img = img;
    this.sketch = sketch;
    opencv = new OpenCV(this.sketch, this.img);
    
    println("init image : " + img.width + "," + img.height);
  }

  boolean detect() {
    Rectangle[] faces;

    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    faces = opencv.detect();

    if (faces.length == 0) {
      println("No one face detected!!.");
      return false;
    } 
    else if (faces.length > 1) {
      println("find 1 more faces!!.");
      return false;
    }

    face = faces[0];

    //    PGraphics pg = createGraphics(img.width, img.height);
    //    pg.beginDraw();
    //    pg.image(img, 0, 0);
    //    if (isFaceRectVisable) {
    //      pg.noFill();
    //      pg.stroke(0, 255, 0);
    //      pg.strokeWeight(3);
    //      pg.rect(face.x, face.y, face.width, face.height);
    //    }
    //    pg.endDraw();
    //    
    //    img = pg.get();
    println("detect : " + face.x + "," + face.y + "," + face.width + "," + face.height);

    return true;
  }

  boolean resize(int width, int height, float faceRectRatio) {
    int newX, newY;

    if (width > img.width || height > img.height) {
      println("source image size is too small. (" + img.width + ", " + img.height + ")"); 
      return false;
    }

    if (width * faceRectRatio > face.width && height * faceRectRatio > face.height) {
      // no scale down, just crop
      println("no scale down, just crop.");
      
      newX = face.x - int((width - face.width)/2.0);
      if (newX < 0) {
        newX = 0;
      } 
      else if (newX + width > img.width) {
        newX = img.width - width;
      }

      newY = face.y - int((height - face.height)/2.0);
      if (newY < 0) {
        newY = 0;
      } 
      else if (newY + height > img.height) {
        newX = img.height - height;
      }

      img = img.get(newX, newY, int(width), int(height));
      face.x = face.x - newX;
      face.y = face.y - newY;
    } 
    else {
      // scale down by height
      int newWidth, newHeight;
      float scale, widthScale, heightScale;

      widthScale = face.width / (width * faceRectRatio);
      heightScale = face.height / (height * faceRectRatio);
      if (widthScale > heightScale) {
        scale = widthScale;
      } else {
        scale = heightScale;
      }

      newWidth = int(width * scale);
      newHeight = int(height * scale);

      if (newWidth > img.width || newHeight > img.height) {
        // no scale down, just crop
        widthScale = img.width / width;
        heightScale = img.height / height;
        if (widthScale < heightScale) {
          scale = widthScale;
        } else {
          scale = heightScale;
        }
      }
      
      newWidth = int(width * scale);
      newHeight = int(height * scale);
      if (newWidth < face.width || newHeight < face.height) {
        println("fail to resize.");
        return false;
      }
      
      println("scale(" + scale + ") down.");
      
      // scale up crop
      newX = face.x - int((width * scale - face.width)/2.0);
      if (newX < 0) {
        newX = 0;
      } else if (newX + int(width * scale) > img.width) {
        newX = img.width - int(width * scale);
      }

      newY = face.y - int((height * scale - face.height)/2.0);
      if (newY < 0) {
        newY = 0;
      } else if (newY + int(height * scale) > img.height) {
        newY = img.height - int(height * scale);
      }

      img = img.get(newX, newY, int(width * scale), int(height * scale));
      println("crop image : " + img.width + "," + img.height);
      img.resize(width, height);
      face.x = int((face.x - newX) / scale);
      face.y = int((face.y - newY) / scale);
      face.width = int(face.width / scale);
      face.height = int(face.height / scale);
    }


    if (isFaceRectVisable) {
      PGraphics pg = createGraphics(img.width, img.height, P2D);
      pg.beginDraw();
      pg.image(img, 0, 0, img.width, img.height);
      pg.noFill();
      pg.stroke(255, 0, 0);
      pg.strokeWeight(1);
      pg.rect(face.x, face.y, face.width, face.height);
      pg.endDraw();
      img = pg.get();
    }

    println("resized img : " + img.width + "," + img.height);
    println("resized face : " + face.x + "," + face.y + "," + face.width + "," + face.height);

    return true;
  }
}
