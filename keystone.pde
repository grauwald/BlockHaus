

int corner;

void moveCorner() {
  if(topLeft == 1.0) corner = CornerPinSurface.TL;
  if(topRight == 1.0) corner = CornerPinSurface.TR;
  if(lowerLeft == 1.0) corner = CornerPinSurface.BL;
  if(lowerRight == 1.0) corner = CornerPinSurface.BR;
  surface.moveMeshPointBy(corner, horizontal, vertical);
}

