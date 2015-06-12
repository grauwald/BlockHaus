class FadeLine {

  float _y;
  float h, s, b, a;

  FadeLine() {
    _y = random(height);
    
    a = random(16);
  }

  void render() {
    _y -= random(0.025, 0.25);
    if (_y<=0) _y = height;
    
     h = (1-(_y/height));
     h = map(h, 0,1, 255, 143);

     b = (1-(_y/height))*128+128;
     a += random(-1.0, 1.0); 

    gfx.pushStyle();

    gfx.strokeWeight(blockHeight*.3333);
    gfx.stroke(h, 255, b, a);

    gfx.line(0, _y, width, _y);

    gfx.popStyle();
  }
}
