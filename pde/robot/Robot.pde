ArrayList<Robot> robots;
float numberOfRobots = 5;
float offSet = 0;

void setup() {
  float scale = 1;
  size(800, 800);
  robots = new ArrayList<Robot>();

  for (int i = 0; i < numberOfRobots; ++i) {
    //Format: Color, Scale, NeckSpeed, Opacity
    robots.add(new Robot(color(0, 210, 8, 50), scale, 0.001, 15));
    scale *= .7 ;
  }
}


void draw() {
  background(255);

  robots.get(0).draw();
  robots.get(0).moveTo(mouseX, mouseY);


  for (int i = 1; i < numberOfRobots; ++i) {

    Robot previousRobot = robots.get(i-1);
    Robot currentRobot = robots.get(i);
    currentRobot.easeTowards(previousRobot.x, previousRobot.y, 0.05);
    currentRobot.draw();
  }



  //draw a grid to elp me draw my robot
  //  translate(width/2, height/2);
  //  pushMatrix();
  //  drawGrid(-width/2, -height/2, 20, 100, 12);
  //  drawMouseCoordinates(-width/2, -height/2, 9);
  //  popMatrix();
}

class Robot {
  float y = 0; //location of robot
  float x = 0; //location of robot
  float scale = 1;
  float easing = 0.05;
  int robotColor;
 float headSpeed;
  float neckScale;
  Robot(int robotColor_, float scale_, float headSpeed_, float neckScale_) {
    robotColor = robotColor_;
    neckScale = neckScale_;
    scale = scale_;
    headSpeed = headSpeed_;
  }


  void moveTo(float x_, float y_) {
    x = x_;
    y = y_;
  }


  void draw() {
    pushMatrix();
    //draw a grid to help me draw my robot
    translate(x, y);
    fill(robotColor);
    //draw body of robot
    float bodyWidth = 120 * scale;
    float bodyHeight = 150 * scale;
    float yTopOfBody = -bodyHeight/2;
    rect(-bodyWidth/2, yTopOfBody, bodyWidth, bodyHeight);

    //draw neck of robot
    float neckWidth = 30 * scale;
    float neckHeight = neckScale * scale *(1+cos(millis() * headSpeed));
    float yTopOfNeck = yTopOfBody - neckHeight;
    rect(-neckWidth/2, yTopOfNeck, neckWidth, neckHeight);
    //draw head
    float headWidth = 140 * scale;
    float headHeight = 30 * scale;
    rect(-headWidth/2, yTopOfNeck-headHeight, headWidth, headHeight);


    //draw eyes of robot

      float eyeWidth = 10 * scale;
    float eyeHeight = 10 * scale;
    ellipse(-eyeWidth, yTopOfNeck-headHeight/2, eyeWidth, eyeHeight);
    ellipse(eyeWidth, yTopOfNeck-headHeight/2, eyeWidth, eyeHeight);
    popMatrix();
  }


  void easeTowards(float targetX, float targetY, float easing) {

    float dx = targetX - x;
    if (abs(dx) > 1) {
      x += dx * easing;
    }
    float dy = targetY - y;
    if (abs(dy) >1 ) {
      y += dy * easing;
    }
  }
}

