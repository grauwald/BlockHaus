Kinect kinect;
TSPSPerson[] people;


void initKinect() {
  kinect = new Kinect();
}

void updateKinect() {

  kinect.update();
}



class Kinect {

  TSPS tsps;
  TSPSPerson[] people;

  float kinectLeft, kinectRight;
  float screenLeft, screenRight;

  XML kinectXML;

  PVector crowdCentroid, crowdVelocity;


  Kinect() {

    tsps = new TSPS(_this, 12000);


  }

  void update() {
    people = tsps.getPeopleArray();

    for (int i=0; i<people.length; i++) {
      float _x = people[i].centroid.x;
      people[i].centroid.x = map(_x, kinectLeft, kinectRight, screenLeft, screenRight);
    }
    
   // findCrowdAttributes();
  }

  void findCrowdAttributes() {
    crowdCentroid.x = 0;
    crowdCentroid.y = 0;

    crowdVelocity.x = 0;
    crowdVelocity.y = 0;  

    for (int i=0; i<people.length; i++) {
      crowdCentroid.x += people[i].centroid.x;
      crowdCentroid.y += people[i].centroid.y;

      crowdVelocity.x += people[i].velocity.x;
      crowdVelocity.y += people[i].velocity.y;
    }

    crowdCentroid.x /= people.length;
    crowdCentroid.y /= people.length;

    crowdVelocity.x /= people.length;
    crowdVelocity.y /= people.length;
  }
  
}
