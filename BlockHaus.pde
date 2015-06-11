import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface;

PGraphics gfx;

Boolean calibrating = false;


int rows = 46;
float blockWidth = 104;
float blockHeight = 15;
float blockOverlap = 15;
float blockGap;

float _bx = 0;
float _by = 0;
float startX;

PImage brickMask;
PImage brick;

PImage bricksGradient;

FadeLine[] fadeLines;
int totalLines = 100;


Block[] blocks;

void setup() {
  size(905, 690, P3D);
  background(0);
  noCursor();
  frameRate(60);
  colorMode(HSB, 255);


  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20);
  gfx = createGraphics(width, height, P3D);


  buildBlocks();

  bricksGradient = loadImage("bricksGradient.png");

  fadeLines = new FadeLine[totalLines];
  for (int i=0; i<totalLines; i++) fadeLines[i] = new FadeLine();
}

void draw() {  
  background(0);

  if (calibrating) cursor();
  else noCursor();

  gfx.beginDraw();
  gfx.noSmooth();

  gfx.noStroke();
  gfx.fill(0, 4);

  for (int i=0; i<blocks.length; i++) blocks[i].render();

  gfx.image(bricksGradient, 0, 0, width, height);

  gfx.endDraw();

  surface.render(gfx);


  //saveFrame("output/blockhaus_blocks-######.jpg");
  //if(frameCount == 60*60) exit();
}

void buildBlocks() {
  brickMask = loadImage("brickMask.png");
  brick = loadImage("brick.png");

  blockGap = blockWidth-(blockOverlap*2);
  startX = blockWidth*-0.5;
  _by = 0;

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



void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    calibrating = !calibrating;
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}
