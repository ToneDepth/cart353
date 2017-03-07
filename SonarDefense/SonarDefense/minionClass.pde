//establishes minion type and behavior
class Minion {
  //Sets location, acceleration, and velocity for fluid movement.
  PVector location, acceleration, velocity;
  //Caps speed, established angle and theta.
  float topSpeed, angle, theta;  
  //Array storing different unit types.
  PImage[] minionType;
  //Establishes which lane a unit spawns in
  float lane;

  Minion(int posX, int posY) {
    //Sets location to posX and posY.
    location = new PVector(posX, posY);
    //Acceleration and Velocity set to 0
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);

    //Caps speed to 3
    topSpeed = 3;

    //Array loading in different minion types.
    minionType = new PImage[4];
    for (int i = 0; i < minionType.length; i++) {
      minionType[i] = loadImage(i + ".png");
    }

    //Sets varaible between 0 and 1 (including decibels).
    lane = random(0, 1);
  }

  void display(int i) { 
    //Condition established which lane a minion spawns in based off of lane value.
    if (lane < 0.50) {
      image(minionType[i], 180, location.y);
    } else if (lane < 1) {
      image(minionType[i], 600, location.y);
    }
    //FOR PATHING 
    /*
    //Gets the hypotenuse value based off of x and y.
     angle = velocity.heading();
     
     //Process that allows the object to rotate exclusively. 
     //FINISH when you start pathing*******
     pushMatrix();
     rectMode(CENTER);
     translate(location.x, location.y);
     rotate(theta);
     rect(0, 0, 30, 10);
     popMatrix();
     */
  }

  //Adds movement to the minion
  void update() {
    location.add(0, 1);

    //FINISH when you start pathing*******
    /*
    velocity.add(acceleration);
     velocity.limit(topSpeed);
     location.add(velocity);
     acceleration.mult(0);
     */
  }

  //Unnecessary for now (for proper movement)
  void applyForce(PVector force) {
    acceleration.add(force);
  }
}