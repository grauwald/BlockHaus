
int rows;
float blockWidth;
float blockHeight;
float blockOverlap;
float blockGap;
float startX;
float startXScalar;
PImage brick;

Block[] blocks;


void initBlocks() {
  brick = loadImage("brick.png");

  startX = blockWidth*startXScalar;

  //blockHeight = blockWidth*(15.0/114.0); // scaled by original aspect ratio
  blockOverlap = blockHeight;  
  blockGap = blockWidth-(blockOverlap*2);


  float _bx = 0;
  float _by = 0;

  blocks = new Block[0];

  for (int row=0; row<rows; row++) {

    if (row%2 == 0) _bx = startX;//even rows
    else _bx = startX+blockGap+blockOverlap; // odd rows

    while (_bx<=width) {

      Block _block = new Block(_bx, _by);
      blocks = (Block[]) append(blocks, _block);
      _bx += (blockWidth+blockGap);
    }

    _by += blockHeight;
  }
}


//
// Block class
//

class Block {

  float x, y;
  float xOriginal, yOriginal;
  float xTarget, yTarget;
  
  float angleSpeed, angleSpeedOriginal;
  float angleSpeedTarget;
  float easing = .004;
  float angleOffset;

  float diagonal;

  float bright;

  Block(float _x, float _y) {
    x = _x;
    y = _y;
    
    xOriginal = x;
    yOriginal = y;

    angleOffset = x + y; //  random(x + y); //x + y;
    angleSpeed = angleOffset*.00000001; //random(.00001, .0001);\
    angleSpeedOriginal = angleSpeed;

    diagonal = dist(0, 0, width, height);
  }

  void render() {


    gfx.pushMatrix();
    gfx.translate(x, y);
    drawRect();

    gfx.tint(bright*255, bright*128);
    gfx.image(brick, 0, 0, blockWidth, blockHeight);
    gfx.tint(255, 255);
    gfx.popMatrix();
  }

  void drawRect() {

    if (kinect.people.length == 0) { 
      //angleSpeedTarget = angleSpeedOriginal;
      xTarget = xOriginal;
      yTarget = yOriginal;
    } else {
      
     // println("kinect.crowdCentroid: "+kinect.crowdCentroid);

      PVector centroid = kinect.crowdCentroid;
      PVector velocity = kinect.crowdVelocity;
      //float distance = dist(x, y, centroid.x*width, centroid.y*height);
      //angleSpeedTarget = ((diagonal-distance)/diagonal)*.1;
      
      xTarget = lerp(xOriginal, centroid.x, velocity.x*.01);
      yTarget = lerp(yOriginal, centroid.y, velocity.y*.01);

      /*
      for (int i=0; i<kinect.people.length; i++) {
       PVector centroid = kinect.people[i].centroid;
       float distance = dist(x, y, centroid.x*width, centroid.y*height);
       angleSpeedTarget = (diagonal-distance)*.0001;
       }
       */
    }

    float dx = xTarget-x;
    if (abs(dx)>1)  x += dx*easing;
    
    float dy = yTarget-y;
    if (abs(dy)>1)  y += dy*easing;

    float angle = (millis()*angleSpeed) + angleOffset;
    
    bright = (sin(angle)+1.0)*.5;

    gfx.pushStyle();
    gfx.noStroke();

    if (aligning || calibrating) gfx.fill(255.0);
    else gfx.fill(255.0*bright, 128.0*bright );

    gfx.rect(0, 0, blockWidth, blockHeight);

    gfx.popStyle();
  }
}
