void setup() {
  size(640, 480);
  background(255,255,100);
}

void draw() {
 background(255,255,100);
 
  float x = mouseX;
  float y = mouseY;
  float xDiameter = 80;
  float yDiameter = 40;
  
  noStroke();
  fill(180, 180, 255);
  ellipse(x, y, xDiameter, yDiameter);
}















