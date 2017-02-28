/* 
Use WASD to move your planet around and gather all the stars into your orbit. Asteroids aren't a threat but their 
gavitational pull stops your planet from drifting in space.

Art assets re-used from an old project and were created by Ben Jacob. 

code inspired from example 2.6 in "The Nature of Code".
*/

//controlable planet, originally a spaceship.
Spaceship spaceship;
//Array lists that represent the stars and asteroids in the code. 
Star[] stars = new Star[300];
Asteroid[] asteroids = new Asteroid[4];

//Declare the background.
PImage space;
//Float that establishes the difference between spaceship and star. 
float attractZone;

void setup() {
  size(875, 875);
  //loads and instantiates the planet.
  space = loadImage("space.png");
  spaceship = new Spaceship(width/2, height/2, 50);

  //Loops that instantiates the stars.
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star(random(width), random(height), 1);
  }
  
  //Instantiation of the 4 random asteroids. 
  asteroids[0] = new Asteroid(random(50, 150), random(50, 150), floor(random(2, 15)));
  asteroids[1] = new Asteroid(random(width-200, width-300), random(50, 150), floor(random(2, 15)));
  asteroids[2] = new Asteroid(random(50, 150), random(height-200, height-300), floor(random(2, 15)));
  asteroids[3] = new Asteroid(random(width-200, width-300), random(height-200, height-300), floor(random(2, 15)));
}

void draw() {
  //Sets background to a space stock image. 
  image(space, 0, 0);
  //Allows the controls to work.
  controls();

  //Loop that displays the asteroids. 
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i].display();
  }

  //Loops that checks if the planet is close enough to an asteroid, triggering the drag function.
  for (Asteroid i : asteroids) {
    //Gets the distance between both objects.
    float objDist = dist(spaceship.location.x, spaceship.location.y, i.location.x, i.location.y); 
    //If objDist is small enough, spaceDrag is triggered.
    if (objDist < 200) {
      spaceship.setDrag(20);
    }
  }

  //Loops that displays the stars. 
  for (int i = 0; i < stars.length; i++) {
    stars[i].display();
  }

  //Loop that checks if a star is close enough to the planet to trigger gravitational pull. 
  for (Star i : stars) {
    //Gets the distance between both objects.
    attractZone = dist(i.location.x, i.location.y, spaceship.location.x, spaceship.location.y);
    //If attractZone is small enough, attracted is set to true.
    if (attractZone < 50) {
      i.attracted = true;
    }
    //When true, force is applied to the stars to pull them towards the planet. 
    if (i.attracted == true) {
      PVector f = spaceship.attract(i);
      i.applyForce(f);
      spaceship.display();
    }
  }
  //Makes a force that pushes the planet back into the canvas once the directional key is released. 
  spaceship.edgeDetection();
}

//Controls activated by direction bool allowing for planet to move.
void controls() {
  if (spaceship.direction[0] == true) {
    spaceship.applyForce(new PVector(0, -0.05 * spaceship.mass));
  }
  if (spaceship.direction[1] == true) {
    spaceship.applyForce(new PVector(-0.05 * spaceship.mass, 0));
  }
  if (spaceship.direction[2] == true) {
    spaceship.applyForce(new PVector(0, 0.05 * spaceship.mass));
  }
  if (spaceship.direction[3] == true) {
    spaceship.applyForce(new PVector(0.05 * spaceship.mass, 0));
  }
} 


//checks if WASD has been pressed.
void keyPressed() {
  if (key == 'w') spaceship.direction[0] = true;
  if (key == 'a') spaceship.direction[1] = true;
  if (key == 's') spaceship.direction[2] = true;
  if (key == 'd') spaceship.direction[3] = true;
}

//Checks if WASD has been released.
void keyReleased() {
  if (key == 'w') spaceship.direction[0] = false;
  if (key == 'a') spaceship.direction[1] = false;
  if (key == 's') spaceship.direction[2] = false;
  if (key == 'd') spaceship.direction[3] = false;
}