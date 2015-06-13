Kinect kinect;
TSPSPerson[] people;


void initKinect() {
  kinect = new Kinect();
}

void updateKinect() {

  kinect.update();

  println("total people: "+kinect.people.length);
}



class Kinect {

  TSPS tsps;
  TSPSPerson[] people;

  float kinectLeft, kinectRight;
  float screenLeft, screenRight;


  PVector crowdCentroid, crowdVelocity;


  Kinect() {

    tsps = new TSPS(_this, 12000);

    crowdCentroid = new PVector(.5, .5);
    crowdVelocity = new PVector(0, 0);
  }

  void update() {
    TSPSPerson[] _people = tsps.getPeopleArray();
    people = _people;

    findCrowdAttributes();
  }

  void findCrowdAttributes() {
    crowdCentroid.x = .5;
    crowdCentroid.y = .5;

    crowdVelocity.x = 0;
    crowdVelocity.y = 0;  

    if (people.length > 0) {

      crowdCentroid.x = 0;
      crowdCentroid.y = 0;


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
  
  
}
