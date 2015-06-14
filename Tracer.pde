class Tracer {

  PVector start, end;
  float currentX, currentY;
  float duration;

  Boolean vertical = false;
  Boolean active = false;



  Tracer() {
    start = new PVector(0, 0);
    end = new PVector(0, 0);

    setPath();
  }

  void render() {
    if (random(1000)>999 && !active) setPath();

    if (active) {
      gfx.pushStyle();

      gfx.noFill();
      gfx.stroke(255, 128);
      gfx.strokeWeight(increment*.5);

      gfx.line(start.x, start.y, currentX, currentY);

      gfx.popStyle();
    }
  }


  void setPath() {


    if (random(1)>0.5) { // horizontal
      vertical = false;

      start.x = random(width);
      currentX = start.x;
      end.x = start.x*random(-width*.5, width*.5);
      if (end.x > width) end.x = width;
      if (end.x < 0) end.x  = 0;
      
      duration = abs(start.x-end.x)*random(.01, .1);// random(4, 17);

      float y = (round(random(rows)) * blockHeight) + increment*.4;

      start.y = y;
      end.y = y;
      currentY = y;
    } else { // vertical
      vertical = true;

      start.y = random(height);
      currentY = start.y;
      end.y = start.y*random(-height*.5, height*.5);
      if (end.y > height) end.y = height;
      if (end.y < 0) end.y  = 0;

      
      duration = abs(start.y-end.y)*random(.01, .1);// random(4, 17);


      float x = (round(random(increments)) * increment) + startX + (increment*.5);

      start.x = x;
      end.x = x;
      currentX = x;
    }

    Ani.to(this, duration, "currentX", end.x, Ani.LINEAR, "onEnd:reverse"); 
    Ani.to(this, duration, "currentY", end.y);

    active = true;
  }

  void reverse() {

    if (vertical) {
      currentY = start.y;
      start.y = end.y;
    } else {
      currentX = start.x;
      start.x = end.x;
    }


    Ani.to( this, duration, "currentX", end.x, Ani.LINEAR, "onEnd:deactivate"); 
    Ani.to(this, duration, "currentY", end.y);
  }

  void deactivate() {
    active = false;
  }
}
