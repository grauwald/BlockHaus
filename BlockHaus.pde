import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

import deadpixel.keystone.*;


Keystone ks;
CornerPinSurface surface;

PGraphics gfx;

Boolean calibrating = false;





PImage bricksGradient;

FadeLine[] fadeLines;
int totalLines = 100;

Tracer tracer;

void setup() {
  size(905, 690, P3D);
  background(0);
  noCursor();
  frameRate(60);
  colorMode(HSB, 255);


  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20);
  gfx = createGraphics(width, height, P3D);
  ks.load();


  initBlocks();

  bricksGradient = loadImage("bricksGradient.png");

  fadeLines = new FadeLine[totalLines];
  for (int i=0; i<totalLines; i++) fadeLines[i] = new FadeLine();


  Ani.init(this);
  tracer = new Tracer();
}

void draw() {  

  if (calibrating) cursor();
  else noCursor();

  gfx.beginDraw();
  gfx.noSmooth();

  gfx.noStroke();
  gfx.fill(0, 4);

  tracer.render();

  for (int i=0; i<blocks.length; i++) blocks[i].render();



  gfx.image(bricksGradient, 0, 0, width, height);


  gfx.endDraw();



  surface.render(gfx);


  //saveFrame("output/blockhaus_blocks-######.jpg");
  //if(frameCount == 60*60) exit();
}



void keyPressed() {
  switch(key) {
  case 'c':
    ks.toggleCalibration();
    calibrating = !calibrating;
    if (!calibrating) background(0);

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
