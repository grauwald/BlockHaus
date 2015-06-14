
int rows;
int columns = 0;
float blockWidth;
float blockHeight;
float blockOverlap;
float blockGap;
float startX;
float startXScalar;
PImage brick;

float increment;
float increments;

Block[] blocks;


void initBlocks() {
  brick = loadImage("brick.png");

  startX = blockWidth*startXScalar;

  //blockHeight = blockWidth*(15.0/114.0); // scaled by original aspect ratio
  blockOverlap = blockHeight;  
  blockGap = blockWidth-(blockOverlap*2);

  float totalWidth = width + abs(startX);
  println("totalWidth: "+totalWidth);
  columns = round(totalWidth/blockWidth)+1;
  println("columns: "+columns);

  increment = blockWidth*.051;
  increments = (width+abs(startX))/increment;

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

    gfx.tint(bright*255, bright*255);
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

      PVector centroid = kinect.crowdCentroid;
      PVector velocity = kinect.crowdVelocity;

      xTarget = lerp(xOriginal, centroid.x, velocity.x*.01);
      yTarget = lerp(yOriginal, centroid.y, velocity.y*.1);
    }

    float dx = xTarget-x;
    if (abs(dx)>1)  x += dx*easing;

    float dy = yTarget-y;
    if (abs(dy)>1)  y += dy*easing;

    float speedMod = (kinect.crowdVelocity.x + kinect.crowdVelocity.x)*.01 ;

    float angle = (millis()*angleSpeed+speedMod) + angleOffset;

    bright = (sin(angle)+1.0)*.5;

    gfx.pushStyle();
    gfx.noStroke();

    if (aligning || calibrating) gfx.fill(255.0);
    else gfx.fill(255.0*bright, 255.0*bright );

    gfx.rect(0, 0, blockWidth, blockHeight);

    gfx.popStyle();
  }
}
