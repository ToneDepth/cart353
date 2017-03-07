//Enables sonar location
class Sonar {
  //Position of the sonar
  PVector position;
  //Size of sonar ring
  float r;
  //rewinds sound cue
  boolean rewindTime;

  Sonar(float x, float y, float r_) {
    //Sets location based off of x and y.
    position = new PVector(x, y);
    //sets r to r (from constructor).
    r = r_;
    //Starts rewindTime as false.
    rewindTime = false;
  }

  void display() {
    //Setss stroke to white(255)
    stroke(255);
    //Sets strokeWeight to 5px.
    strokeWeight(5);
    //noFill for further objects.
    noFill();
    //Draws an ellipse that acts as the sonar visual.
    ellipse(position.x, position.y, r*2, r*2);
  }

  //Makes sonar ellipse grow larger.
  void update() {
    //Adds to the size of the sonar.
    r += 5;
  }

  //Gets info between two targets to cue in sound.
  void objectCollision(Minion other) {
    //Calculations to established magnitude between two targets.
    PVector bVect = PVector.sub(other.location, position);
    float BVectMag = bVect.mag();

    //If mag is small enough, cues sound.
    if (BVectMag < r) {
      song.play();
      //Sets rewindTime to true, rewinding the sound cue for re-use.
      rewindTime = true;
    }
  }
}