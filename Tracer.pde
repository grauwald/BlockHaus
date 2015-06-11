class Tracer {

  PVector start, end;
  float currentX, currentY;
  float duration;

  Boolean active = false;

  Tracer() {
    start = new PVector(0, 0);
    end = new PVector(0, 0);



    setPath();
  }

  void render() {
    if (random(250)>249 && !active) setPath();

    if (active) {
      gfx.pushStyle();

      gfx.noFill();
      gfx.stroke(255, 128);
      gfx.strokeWeight(blockHeight);

      gfx.line(start.x, start.y, currentX, currentY);

      gfx.popStyle();
    }
    
  }


  void setPath() {

    start.x = random(width);
    currentX = start.x;
    end.x = start.x*random(-width*.5, width*.5);
    if(end.x > width) end.x = width;
    if(end.x < 0) end.x  = 0;

    println("start.x: "+start.x);
    println("end.x: "+end.x);

    float y = (round(random(rows)) * blockHeight) + blockHeight*.5;
    
    start.y = y;
    end.y = y;
    currentY = y;

    println("y: "+y);

    duration = random(4, 17);

    active = true;

    Ani.to( this, duration, "currentX", end.x, Ani.LINEAR, "onEnd:reverse"); 
    Ani.to(this, duration, "currentY", end.y);
  }
  
  void reverse() {
  
    currentX = start.x;
    start.x = end.x;
    
    Ani.to( this, duration, "currentX", end.x, Ani.LINEAR, "onEnd:deactivate"); 
    Ani.to(this, duration, "currentY", end.y);
  }

  void deactivate() {
    active = false;
  }
  
}
