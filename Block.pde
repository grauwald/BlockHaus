class Block {

  float x, y;
  int camX, camY;
  float pbright, bright, brightDiff;
  float angleSpeedModifier = .0001;
  float angleOffset;

  Block(float _x, float _y) {
    x = _x;
    y = _y;
    
    angleOffset =  random(x + y); //x + y;

    camX = round((x/width)*(camWidth-1));
    if(camX<0) camX = 0;
    camY = round((y/width)*(camHeight-1));
  }

  void render() {
    pushMatrix();
    translate(x, y);
    drawRect();
    
   // tint(255, 64);
    image(brick, 0, 0);
    popMatrix();
  }

  void drawRect() {


    if (cam.available() == true) {
      color c = cam.get(camX, camY);
      bright = brightness(c);
      bright = bright/255.0;

      brightDiff = bright-pbright;

      pbright = bright;
    }


    //angleOffset += bright*.0001;
    angleSpeedModifier += brightDiff*.000001;
    float angle = (millis()*angleSpeedModifier) + angleOffset;
    float rectWidth = ((sin(angle)+1)*.5)*blockWidth;
    
    noStroke();
    
    fill((223.0*bright + 128.0) * (1-(y/height)) );
    rect(0, 0, rectWidth, blockHeight);
  }
}
