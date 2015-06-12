import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

import deadpixel.keystone.*;

import controlP5.*;


Keystone ks;
CornerPinSurface surface;

PGraphics gfx;

Boolean calibrating = false;
Boolean aligning = false;

PImage bricksGradient;

FadeLine[] fadeLines;
int totalLines = 100;

Tracer tracer;

void setup() {
  size(displayWidth, displayHeight, P3D);
  background(0);
  noCursor();
  frameRate(60);
  colorMode(HSB, 255);


  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20);
  gfx = createGraphics(width, height, P3D);
  ks.load();

  initControlP5();

  initBlocks();

  bricksGradient = loadImage("bricksGradient.png");

  fadeLines = new FadeLine[totalLines];
  for (int i=0; i<totalLines; i++) fadeLines[i] = new FadeLine();


  Ani.init(this);
  tracer = new Tracer();
}

void draw() {  

  if (calibrating || aligning) {
    cursor();
    background(0);
  } else noCursor();
 

  gfx.beginDraw();
  gfx.noSmooth();
  if (aligning || calibrating) gfx.background(0);

  gfx.noStroke();
  gfx.fill(0, 4);

  tracer.render();

  for (int i=0; i<blocks.length; i++) blocks[i].render();


  if (!aligning && !calibrating) gfx.image(bricksGradient, 0, 0, width, height);


  gfx.endDraw();



  surface.render(gfx);

  renderControlP5();


  //saveFrame("output/blockhaus_blocks-######.jpg");
  //if(frameCount == 60*60) exit();
}



void keyPressed() {
  switch(key) {

  case 'a':
    aligning = !aligning;
    if (!aligning) { 
      hideControls();
      gfx.beginDraw();
      gfx.background(0, 0);
      gfx.endDraw();
      background(0);
    } else {
      showControls();
    }

    break;

  case 'c':
    ks.toggleCalibration();
    calibrating = !calibrating;
    if (!calibrating){
      gfx.beginDraw();
      gfx.background(0, 0);
      gfx.endDraw();
      background(0);
    }

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

boolean sketchFullScreen() {
  return true;
}
