import tsps.*;
import oscP5.*;
import netP5.*;

import deadpixel.keystone.*;
import controlP5.*;

import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

PApplet _this;

Keystone ks;
CornerPinSurface surface;

PGraphics gfx;

Boolean calibrating = false;
Boolean aligning = false;

PImage bricksGradient;

FadeLine[] fadeLines;
int totalLines = 100;

Tracer[] tracers;
int totalTracers = 20;

float horizontal;
float vertical;

void setup() {

  _this = this;

  size(displayWidth, displayHeight, P3D);
  background(0);
  noCursor();
  frameRate(60);
  colorMode(HSB, 255);

  initKinect();

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

  tracers = new Tracer[totalTracers];
  for (int j=0; j<totalTracers; j++) tracers[j] = new Tracer();
}

void draw() {  

  updateKinect();

  if (calibrating || aligning) {
    cursor();
    background(0);
  } 
  else noCursor();


  gfx.beginDraw();
  gfx.colorMode(HSB, 255);
  gfx.noSmooth();
  if (aligning || calibrating) gfx.background(0);

  gfx.noStroke();
  gfx.fill(0, 4);
  gfx.rect(0, 0, width, height);


  if (aligning || calibrating) { 
    int n = 0;
  } 
  else {
    for (int i=0; i<totalLines; i++) fadeLines[i].render();
  }

  for (int j=0; j<blocks.length; j++) blocks[j].render();

  if (aligning || calibrating) { 
    int o = 0;
  } 
  else { 
    for (int k=0; k<totalTracers; k++) tracers[k].render();
  }


  if (!aligning && !calibrating) {
    gfx.tint(255, 255);
    gfx.image(bricksGradient, 0, 0, width, height);
    //gfx.tint(255, 255);
  }
  



  gfx.endDraw();
  surface.render(gfx);
  renderControlP5();
  //saveFrame("output/blockhaus_blocks-######.jpg");
  //if(frameCount == 60*60) exit();
  if(aligning) {
  fill(100);
  rect(90, 60, 870, 130);
  }
}

void keyPressed() {
  if (key == CODED) { 
    // pts
    if (keyCode == UP) { 
      vertical-= 0.1;
      moveCorner();

      println("vertical++");
    } 
    else if (keyCode == DOWN) { 
      vertical+= 0.1;
      moveCorner();

      println("vertical--" + vertical);
    } 
    // extrusion length
    if (keyCode == LEFT) { 
      horizontal-= 0.1;
      moveCorner();

      println("horizonal--" + horizontal);
    } 
    else if (keyCode == RIGHT) { 
      horizontal+= 0.1;
      moveCorner();

      println("horizontal++" + horizontal);
    }
  }
  switch(key) {

  case 'a':
    aligning = !aligning;
    if (!aligning) { 
      hideControls();
      gfx.beginDraw();
      gfx.background(0, 0);
      gfx.endDraw();
      background(0);
    } 
    else {
      showControls();
    }

    break;

  case 'c':
    ks.toggleCalibration();
    calibrating = !calibrating;
    if (!calibrating) {
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
