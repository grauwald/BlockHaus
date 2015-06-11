class FadeLine {

  float _y;

  FadeLine() {
    _y = random(height);
    //println("new fadeline! "+_y);
  }

  void render() {
    _y -= random(0.025, 0.05);
    if (_y<=0) _y = height;

    float c = (1-(_y/height))*255;

    gfx.pushStyle();

    gfx.strokeWeight(blockHeight);
    gfx.stroke(255, 0, c*.77, c*.15);

    gfx.line(0, _y, width, _y);

    gfx.popStyle();
  }
}
