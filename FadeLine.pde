class FadeLine {

  float _y;
  float h, s, b, a;
  
  float hMax, hMin;

  FadeLine() {
    _y = random(height);
    
    a = random(16);
    
    hMax = random(143, 255);
    hMin = random(117, 143); 
  }

  void render() {
    _y -= random(-0.25, 0.5);
    if (_y<=0) _y = height;
    
     h = (1-(_y/height));
     h = map(h, 0,1, hMax, hMin);

     b = (1-(_y/height))*128+128;
     a += random(-1.0, 1.0); 

    gfx.pushStyle();

    gfx.strokeWeight(blockHeight*.3333);
    gfx.stroke(h, 255, b, a);

    gfx.line(0, _y, width, _y);

    gfx.popStyle();
  }
}
