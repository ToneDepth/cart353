//Establishes tower type and location
class Tower {
  //Location of tower
  PVector location;
  //Type of tower
  PImage[] towerType;

  Tower(int posX, int posY) {
    //Creates an array storing 4 different types of towers
    towerType = new PImage[4];
    for (int i = 0; i < towerType.length; i++) {
      towerType[i] = loadImage(i + ".png");
    }
    //Sets location of tower based off of posX and posY
    location = new PVector(posX, posY);
  }

  //Displays the selected tower
  void display(int i) {
    //Displays tower
    image(towerType[i], location.x, location.y);
    /*
    fog.loadPixels();
     for (int x = 0; x < fog.width; x++) {
     for (int y = 0; y < fog.height; y++) {      
     int loc = x + y * fog.width;
     
     float r = red   (fog.pixels[loc]);
     float g = green (fog.pixels[loc]);
     float b = blue  (fog.pixels[loc]);
     
     float distance = dist(location.x+22, location.y+20, x, y);
     float newDist = map(distance, 100, 255/2, 0, 200);
     
     fog.pixels[loc] = color(r, g, b, newDist);
     }
     }
     fog.updatePixels();
     */
  }

  //Grants specific stats and qualities based on the tower type.
  void towerStats() {
    if (towerKey == 0) {
    }
    if (towerKey == 1) {
    }
    if (towerKey == 2) {
    }
    if (towerKey == 3) {
    }
  }
}