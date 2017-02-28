//class for the planet
class Spaceship {
  //PVector's for position and movement.
  PVector location, velocity, acceleration;
  //Variable for planet image.
  PImage planet;
  //Variables establishing gravitational pull and speed if planet.
  float mass;
  float pull;
  float speed;
  //array of bools to dictate movement.
  boolean[] direction = {false, false, false, false};

  Spaceship(float posX, float posY, float m) {
    //Mass is established by m
    mass = m;
    //Strength of pull of the planet
    pull = 10;
    //Speed of the planet when specifics keys are pressed.
    speed = 0.05;

    //Establishing numbers to each PVector for position and movement.
    location = new PVector(posX, posY);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    //Load image and resize to appropriate size. 
    planet = loadImage("1.png");
    planet.resize(70, 70);
  }

  //Displays the planet and its movements.
  void display() {
    image(planet, location.x, location.y);
    //Limits the velocity to 0.05.
    velocity.limit(0.05);
    velocity.add(acceleration);
    location.add(velocity);
    //Resets acceleration to floor top speed.
    acceleration.mult(0);
  }

  //Applies various forces in the program. 
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  //PVector that finds a star and attracts it using gravitational pull. 
  PVector attract(Star i) {
    //Gets direction
    PVector force = PVector.sub(location, i.location);  

    //Adjusts the pivot point of the image to its center
    PVector adjustement = new PVector(30, 30);
    force.add(adjustement);

    //Gets the distance between objects
    float d = force.mag();                              
    //Limit the space in which a star can effectively travel once attracted to the planet.
    d = constrain(d, 15.0, 60.0);                        
    //Establishes the direction of force.
    force.normalize();                                  

    //Sets the force magnitude
    float strength = (pull * mass * i.mass) / (d * d);      
    //Sets force vector
    force.mult(strength);                                  

    //Returns final value to dedicated class.
    return force;
  }

  //Function that will always push the planet back within window constraints. 
  void edgeDetection() {
    //Condition for width
    if (location.x < 0) {
      applyForce(new PVector(0.3, 0));
    } else if (location.x > width) {
      applyForce(new PVector(-0.3, 0));
    }
    //Condition for height
    if (location.y < 0) {
      applyForce(new PVector(0, 0.3));
    } else if (location.y > height) {
      applyForce(new PVector(0, -0.3));
    }
  }
  
  //Function that sets a drag to the planet established by the float c.
  void setDrag(float c) {
    float area = mass * 16 * 0.1;

    float speed = velocity.mag();
    float dragMagnitude = c * speed * speed * area;

    PVector dragForce = velocity.get();
    dragForce.mult(-1);

    dragForce.normalize();
    dragForce.mult(dragMagnitude);
    applyForce(dragForce);
  }
}