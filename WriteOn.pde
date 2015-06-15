WriteOn[] writeOns;
int totalActiveWriteOns = 0;

void initWriteOns() {
  writeOns = new WriteOn[5];

  for (int i=0; i<writeOns.length; i++) writeOns[i] = new WriteOn("stroke"+(i+1)+".mov");
}

void renderWriteOns() {
  for (int i=0; i<writeOns.length; i++) writeOns[i].render();
}


class WriteOn {

  Movie movie;

  float x, y;

  Boolean active = false;

  WriteOn (String _fileName) {
    movie = new Movie(_this, _fileName);
    movie.stop();
  }

  void render() {

    if (random(1000.0)>999.0 && !active && totalActiveWriteOns < 4) {
      totalActiveWriteOns++;

      int index = round( random(blocks.length-1) );
      Block choosenBlock = blocks[index];

      x = choosenBlock.x;
      y = choosenBlock.y;

      movie.jump(0);
      movie.play();

      active = true;
    } 
    else if (active) {
      if (movie.available()) movie.read();

      //gfx.tint(255, 32);
      gfx.image(movie, x, y, blockWidth, blockHeight);
      
      if (movie.time() > movie.duration()-.1) {
        active = false;
        totalActiveWriteOns--;
      }
    }
  }
}

