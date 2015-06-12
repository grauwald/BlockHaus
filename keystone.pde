

int corner;

void moveCorner() {
  if(topLeft == 1.0) corner = CornerPinSurface.TL;
  surface.moveMeshPointBy(corner, horizontal, vertical);
}

