class Block {

  float x, y;
  float angleSpeed = .0001;
  float angleOffset;

  Block(float _x, float _y) {
    x = _x;
    y = _y;

    angleOffset =  random(x + y); //x + y;
    angleSpeed = random(.0001, .001);
  }

  void render() {

    gfx.pushMatrix();
    gfx.translate(x, y);
    drawRect();

    // tint(255, 64);
    gfx.image(brick, 0, 0);
    gfx.popMatrix();
    
  }

  void drawRect() {
    float angle = (millis()*angleSpeed) + angleOffset;
    float bright = (sin(angle)+1.0)*.5;

    gfx.pushStyle();
    gfx.noStroke();

    gfx.fill(255.0*bright );
    gfx.rect(0, 0, blockWidth, blockHeight);

    gfx.popStyle();
  }
}
