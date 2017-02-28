//class for the stars
class Star {
  //PVector's for position and movement.
  PVector location, acceleration, velocity;   
  //Gravitational variable
  float mass;
  //Boolean stating if a star has been caught.
  boolean attracted;

  Star(float posX, float posY, float m) {
    //Sets mass based off of the builder.
    mass = m;

    //Establishing numbers to each PVector for position and movement.
    location = new PVector(posX, posY);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  //Displays the stars and also adds to their movements. 
  void display() {
    stroke(255);
    point(location.x, location.y);
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  //Applies various forces in the program. 
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
}