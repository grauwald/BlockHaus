
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
  float angleSpeed = .0001;
  float angleOffset;
  
  float bright;

  Block(float _x, float _y) {
    x = _x;
    y = _y;

    angleOffset =  random(x + y); //x + y;
    angleSpeed = random(.00001, .001);
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
    float angle = (millis()*angleSpeed) + angleOffset;
    bright = (sin(angle)+1.0)*.5;

    gfx.pushStyle();
    gfx.noStroke();

    if(aligning || calibrating) gfx.fill(255.0);
    else gfx.fill(255.0, 255.0*bright );
    
    gfx.rect(0, 0, blockWidth, blockHeight);

    gfx.popStyle();
  }
}
