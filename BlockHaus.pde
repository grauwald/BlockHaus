import processing.video.*;

Capture cam;
int camWidth = 10;
int camHeight = 46;


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

  cam = new Capture(this);
  cam.start();

  buildBlocks();

  bricksGradient = loadImage("bricksGradient.png");

  fadeLines = new FadeLine[totalLines];

  for (int i=0; i<totalLines; i++) fadeLines[i] = new FadeLine();
}

void draw() {  
  //background(0);
  noStroke();
  fill(0, 4);
  //rect(0,0,width,height);

  if (cam.available() == true) {
    cam.read();
    cam.resize(camWidth, camHeight);
    cam.updatePixels();
  }

  //for (int i=0; i<totalLines; i++) fadeLines[i].render();

  for (int i=0; i<blocks.length; i++) blocks[i].render();


  image(bricksGradient, 0, 0);

  saveFrame("output/blockhaus_blocks-######.jpg");
  if(frameCount == 60*60) exit();
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


class FadeLine {
  
  float _y;

   FadeLine() {
     _y = random(height);
     println("new fadeline! "+_y);
   }
   
   void render(){
     _y -= random(0.025,0.05);
     if(_y<=0) _y = height;
     
     float c = (1-(_y/height))*255;
     
     strokeWeight(blockHeight);
     stroke(255 , 0, c*.77, c*.15);
     
     line(0,_y,width,_y);
     

   }

}
