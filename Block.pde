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
    pushMatrix();
    translate(x, y);
    drawRect();
    
   // tint(255, 64);
    image(brick, 0, 0);
    popMatrix();
  }

  void drawRect() {

    pushStyle();
   float angle = (millis()*angleSpeed) + angleOffset;
   float bright = (sin(angle)+1.0)*.5;
    
    noStroke();
    
    fill(255.0*bright );
    rect(0, 0, blockWidth, blockHeight);
    
    popStyle();
  }
  
}
