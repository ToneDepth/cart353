//Sets the background and fog of war
class Map {
  //Map image
  PImage map;

  Map() {
    //Loads the map
    map = loadImage("green.jpg");
  }

  //Displays the map
  void display() {
    image(map, 0, 0);
  }

  //Function that acts as a fog of war as well as clears said fog
  void clearFog() {
    //Displays the fog image
    image(fog, 0, 0);

    //Loads fog image pixels.
    fog.loadPixels();
    for (int x = 0; x < fog.width; x++) {
      for (int y = 0; y < fog.height; y++) {      
        int loc = x + y * fog.width;

        //Sets RGB as variables
        float r = red   (fog.pixels[loc]);
        float g = green (fog.pixels[loc]);
        float b = blue  (fog.pixels[loc]);

        //Gets distance between a selected area and surrounded pixels.
        float distance = dist(width/2, height+100, x, y);
        /*500-600 -> play with those for smaller cirlce (100, 255/2)*/
        //Maps the distance value to an appropriae value in between 0 and 255.
        float newDist = map(distance, 500, 600, 0, 200);

        //Sets the opacity of each pixels according to newDist
        fog.pixels[loc] = color(r, g, b, newDist);
      }
    }
    //Updates the fog image pixels.
    fog.updatePixels();
  }
}