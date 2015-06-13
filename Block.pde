
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
  float angleSpeed, angleSpeedOriginal;
  float angleSpeedTarget;
  float angleSpeedEasing = .004;
  float angleOffset;

  float diagonal;

  float bright;

  Block(float _x, float _y) {
    x = _x;
    y = _y;

    angleOffset = x + y; //  random(x + y); //x + y;
    angleSpeed = angleOffset*.000000001; //random(.00001, .0001);\
    angleSpeedOriginal = angleSpeed;

    diagonal = dist(0, 0, width, height);
  }

  void render() {

    //if(random(1000)>999 ) angleSpeed += random(-.00001, .00001);

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
      angleSpeedTarget = angleSpeedOriginal;
    } else {
      
     // println("kinect.crowdCentroid: "+kinect.crowdCentroid);

      PVector centroid = kinect.crowdCentroid;
      float distance = dist(x, y, centroid.x*width, centroid.y*height);
      angleSpeedTarget = (diagonal-distance)*.00057;

      /*
      for (int i=0; i<kinect.people.length; i++) {
       PVector centroid = kinect.people[i].centroid;
       float distance = dist(x, y, centroid.x*width, centroid.y*height);
       angleSpeedTarget = (diagonal-distance)*.0001;
       }
       */
    }

    float ds = angleSpeedTarget-angleSpeed;
    if (abs(ds)>1)  angleSpeed += ds*angleSpeedEasing;

    float angle = (millis()*angleSpeed) + angleOffset;
    
    bright = (sin(angle)+1.0)*.5;

    gfx.pushStyle();
    gfx.noStroke();

    if (aligning || calibrating) gfx.fill(255.0);
    else gfx.fill(255.0*bright); //, 255.0*bright );

    gfx.rect(0, 0, blockWidth, blockHeight);

    gfx.popStyle();
  }
}
