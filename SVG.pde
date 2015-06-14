// global variables
RShape grp;
String svgFile;
ArrayList ve;
int nve = 1;
int colo;

// global params
float pl = 4.0; // maximum segments length

void initSVG() {
  ve= new ArrayList();

  // Choice of colors
  background(255);
  fill(255, 102, 0);
  stroke(100);
  strokeWeight(1);

  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  //svgFile = selectInput();
  svgFile = "brick.svg";
  grp = RG.loadShape(svgFile);
  //grp = RG.centerIn(grp, g);
  // Set the origin to draw in the middle of the sketch
  //translate(width/2, 3*height/4);
  // Enable smoothing
  smooth();

  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pl);

  exVert(grp);
  println("tot points: " + ve.size());
  println(grp.getTopLeft().x);
}

void drawSVG() {
  if (nve < ve.size()) {
    //strokeWeight(map(mouseY, 0, height, 1, 10));
    if (((Point) ve.get(nve)).z != -10.0) {
      if (mousePressed) {
        ((Point) ve.get(nve-1)).x += random(-5, +5);
        ((Point) ve.get(nve-1)).y += random(-5, +5);
        //line(((Point) ve.get(nve)).x, ((Point) ve.get(nve)).y, ((Point) ve.get(nve)).x+random(-10, +10), ((Point) ve.get(nve)).y+random(-10, +10));
      }
      line(((Point) ve.get(nve-1)).x, ((Point) ve.get(nve-1)).y, ((Point) ve.get(nve)).x, ((Point) ve.get(nve)).y);
    }
    nve++;
  }
  else { // restart drawing
    delay(3000);
    background(255);
    nve = 1;
  }
}


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// recursively find RShape children and "flattens", by putting vertices inside an array
//
void exVert(RShape s) {
  RShape[] ch; // children
  int n, i, j;
  RPoint[][] pa;

  n = s.countChildren();
  if (n > 0) {
    ch = s.children;
    for (i = 0; i < n; i++) {
      exVert(ch[i]);
    }
  }
  else { // no children -> work on vertex
    pa = s.getPointsInPaths();
    n = pa.length;
    for (i=0; i<n; i++) {
      for (j=0; j<pa[i].length; j++) {
        //ellipse(pa[i][j].x, pa[i][j].y, 2,2);
        if (j==0)
          ve.add(new Point(pa[i][j].x, pa[i][j].y, -10.0));
        else
          ve.add(new Point(pa[i][j].x, pa[i][j].y, 0.0));
      }
    }
    //println("#paths: " + pa.length);
  }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Class for a 3D point

class Point { 
  float x, y, z; 
  Point(float x, float y, float z) { 
    this.x = x; 
    this.y = y;
    this.z = z;
  } 

  void set(float x, float y, float z) { 
    this.x = x; 
    this.y = y;
    this.z = z;
  }
}

