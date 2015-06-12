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

     b = (1-(_y/height))*255;
     a += random(-1.0, 1.0); 

    gfx.pushStyle();

    gfx.strokeWeight(blockHeight*.3333);
    gfx.stroke(143, 198, b, a);

    gfx.line(0, _y, width, _y);

    gfx.popStyle();
  }
}
