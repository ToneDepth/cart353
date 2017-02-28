//Class for the asteroids.
class Asteroid {
  //image array for the asteroids.
  PImage[] rockType;
  //PVector establishing the location of a given asteroid.
  PVector location;

  //Variable distating which asteroid from the array is chosen.
  int index;

  Asteroid(float posX, float posY, int ii) {
    //Loop that fills the array with each asteroid in the data folder.
    rockType = new PImage[16];
    for (int i = 0; i < rockType.length; i++) {
      rockType[i] = loadImage(i + ".png");
    }
    //Sets the location based off of the builder. 
    location = new PVector(posX, posY);
    //Sets the index based off of the builder.
    index = ii;
  }
  
  //Function that displays a given asteroid
  void display() {
    image(rockType[index], location.x, location.y);
  }
}