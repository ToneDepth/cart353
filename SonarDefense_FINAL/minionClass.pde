//establishes minion type and behavior
class Minion {
  //Sets location, acceleration, and velocity for fluid movement.
  PVector location, acceleration, velocity;
  PVector destination;
  //Caps speed, established angle and theta.
  float topSpeed, angle, theta;  
  //Establishes the spawnBot
  float spawnPointX, spawnPointY;
  //Float to decide the distance left between paths
  float distanceLeft;
  //Array storing different unit types.
  PImage[] minionType;

  //Allows direction change
  boolean changeDir;
  //Starts the spawn process
  boolean spawnOn;
  //Estalishes the stats
  boolean statEstablished = false;
  //Establishes if a minion is dead or not
  boolean dead = false;

  //Variables for the stats of a minion
  float healthPoints, moveSpeed;
  boolean isFlying, isHeavy;
  boolean generic, heavy, swarm, fast, flying;
  int currencyValue;
  int hp;
  //Value that helps direct a minions path
  int checkPoint;

  Minion() {
    //Sets location to posX and posY.
    location = new PVector(-4000, -4000);
    //The location that the minion is moving towards
    destination = new PVector(0, 0);
    //Acceleration and Velocity set to 0
    acceleration = new PVector(0, 0);
    //The velocity of the minion
    velocity = new PVector(0, 0);

    //Caps speed to 3
    topSpeed = random(8, 10);

    checkPoint = 0;
    //Test health for science
    healthPoints = 1;

    //Array loading in different minion types.
    minionType = new PImage[4];
    for (int i = 0; i < minionType.length; i++) {
    }
    spawnOn = true;
    changeDir = false;
  }

  void minionStats(int minionClass) {
    //Stats for the generic minion
    if (minionClass == 1 && statEstablished == false) {
      healthPoints = 1;
      moveSpeed = 9;
      isHeavy = false;
      isFlying = false;
      currencyValue = 5;

      statEstablished = true;

      //stats for the heavy minion
    } else if (minionClass == 2 && statEstablished == false) {
      healthPoints = 1;
      moveSpeed = 9;
      isHeavy = true;
      isFlying = false;
      currencyValue = 5;

      statEstablished = true;

      //stats for the swarm minion
    } else if (minionClass == 3 && statEstablished == false) {
      healthPoints = 1;
      moveSpeed = 9;
      isHeavy = false;
      isFlying = false;
      currencyValue = 5;

      statEstablished = true;

      //stats for the fast minion
    } else if (minionClass == 4 && statEstablished == false) {
      healthPoints = 1;
      moveSpeed = 9;
      isHeavy = false;
      isFlying = false;
      currencyValue = 5;

      statEstablished = true;

      //stats for the flying minion
    } else if (minionClass == 5 && statEstablished == false) {
      healthPoints = 1;
      moveSpeed = 9;
      isHeavy = false;
      isFlying = true;
      currencyValue = 5;

      statEstablished = true;
    }
  }

  //Function that displays the minion as well as movements
  void display(int i) { 
    //Death condition, moving it off screen and adding to the deathCount if hp is at 0
    if (healthPoints <= 0 && dead == false) {
      location.x = -1000;
      location.y = -1000; 
      levelManager.deathCount++;
      dead = true;
    } else {

      //Process that updates the minions movement through fluid transition of location and rotation
      angle = atan2(destination.y - location.y, destination.x - location.x);
      float dir = (angle - theta) / TWO_PI;
      dir -= round( dir );
      dir *= TWO_PI;
      theta += dir;

      //Process that allows the object to rotate exclusively. 
      pushMatrix();
      rectMode(CENTER);
      translate(location.x, location.y);
      rotate(theta);
      stroke(0, 255);
      ellipse(0, 0, 40, 40);
      popMatrix();

      // use cos and sin on mover.theta angle to derive y and x components
      float x = 10 * cos(theta);
      float y = 10 * sin(theta);

      // turn this into an acceleration vector and apply it to mover
      PVector force = new PVector(x, y);
      applyForce(force);
    }
  }

  //Adds movement to the minion
  void update() {
    //basic stuff, if dead there will be no application of movement
    if (dead == false) {
      velocity.add(acceleration);
      velocity.limit(topSpeed);
      location.add(velocity);
      acceleration.mult(0);
    }
  }

  //Function that applys a force for movement
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  //function that establishes the new destination
  void newDirection(PVector newDest) {
    destination.x = newDest.x;
    destination.y = newDest.y;
  }
}