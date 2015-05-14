PImage img;
int selectedColor = color(255);
boolean drawing =false;
int wheelInset=10;
int widthColorWheel=450;
int heightColorWheel=450;
int pxlColor;
int colorToReplace = color(255);
void setup() {
  size(840, 680);
  background(255);
  img = loadImage("wheel.jpg");
}
void draw() {
  if (drawing) {
    stroke(0);
    strokeWeight(4);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  image(img, wheelInset, wheelInset);
  noStroke();
  noSmooth();
  fill(selectedColor);
  float radiusColorSwatch = 15;
  ellipse(radiusColorSwatch, radiusColorSwatch, radiusColorSwatch*2, radiusColorSwatch*2);
}

void mouseDragged( ) {
  drawing=true;
}
void mouseReleased() {
  drawing=false;
}
void mouseClicked() {
  if (mouseInColorWheel()) {
    loadPixels();
    selectedColor = pixels[width * mouseY + mouseX];
  }
  fillPxl(mouseX, mouseY);
}
boolean mouseInColorWheel() {
  return (mouseX < wheelInset + widthColorWheel && mouseY < wheelInset + heightColorWheel);
}
class Point {
  int x, y;

  Point(int x_, int y_) {
    x = x_;
    y = y_;
  }
}


void fillPxl(int x, int y) {
  loadPixels();
  ArrayList<Point> pixelsToFill = new ArrayList<Point>();
  pixelsToFill.add(new Point(x, y));

  while (pixelsToFill.size () > 0) {
    Point point = pixelsToFill.get( 0);//pixelsToFill.size() - 1);
    int pxlIndex = point.y * width + point.x;
    int pxl = pixels[pxlIndex];
    if (pxl != colorToReplace) {
      pixelsToFill.remove(point);
    } 
    else {
      pixels[pxlIndex] = selectedColor;
      for (int dx = -1; dx < 2; ++dx) {
        for (int dy = -1; dy < 2; ++dy) {
          int x_ =point.x + dx;
          int y_ =point.y + dy;
          if (x_ >= 0 && x_ < width && y_>=0 && y_ < height) {
            if (x_ != 0 || y_ != 0) {
              int pxlToAddIndex = y_ * width + x_;
              int pxl_ = pixels[pxlToAddIndex];
              if (pxl_ != selectedColor) {
                pixelsToFill.add(new Point(x_, y_));
              }
            }
          }
        }
      }
    }
  }
  updatePixels();
}


