//Sets the background and fog of war
class Map {
  //Map image
  PImage map;
  //fog image
  PImage fog;

  Map() {
    //Loads the map and fog
    map = loadImage("terrain0.01.png");
    fog = loadImage("terrainFog.png");
  }

  //Displays the map
  void display() {
    image(map, 0, 0);
  }

  /*==================FOR RILLA====================*/
  /*Images can only hold one change at a time. I fixed the odd crash and can
   manipulate where the fog goes now, but there can only be one fog clearing.
   I attempted to save the image along with its opacity values as a new file
   and use an array system to continuously update the map, but the saved image 
   would not retain the changes performed during the fog clearing process. There 
   is also no help online in regards to processing. I simply think that this 
   method is completely wrong for attempting a compelling fog of war.
   
   If you manage to scrounge up a solution while you correct this, I would
   love if you'd sent me the solution, or atleast hint towards the proper direction*/

  //Function that acts as a fog of war as well as clears said fog
  void clearFog() {
    //Displays the fog image
    image(fog, 0, 0);
    if (towerBuild == true && buildTower == true) {
      for (int x = 0; x < fog.width; x++) {
        for (int y = 0; y < fog.height; y++) {      
          int loc = x + y * fog.width;

          //Sets RGB as variables
          float r = red   (fog.pixels[loc]);
          float g = green (fog.pixels[loc]);
          float b = blue  (fog.pixels[loc]);


          //Gets distance between a selected area and surrounded pixels.
          float distance = dist(mouseX, mouseY, x, y);
          /*500-600 -> play with those for smaller cirlce (100, 255/2)*/
          //Maps the distance value to an appropriae value in between 0 and 255.
          float newDist = map(distance, 100, 150, 0, 200);

          //Sets the opacity of each pixels according to newDist
          fog.pixels[loc] = color(r, g, b, newDist);
        }
      }      
      //Updates the fog image pixels.
      fog.updatePixels();
    }
  }
}