class EdgeDetect {
  boolean imageSwap;
  boolean posSwap = true;

  int xStart;
  int yStart;
  int xEnd;
  int yEnd;

  //Matrix that sets its affected zone to detect edges. 
  float[][] matrix = {{0, 0, 0}, 
    {-1, 1, 0}, 
    {0, 0, 0}};

  EdgeDetect() {
  }

  void display(boolean imageSet) {
    //Boolean that establishes which image is active
    if (imageSet) {
      image(alexT, 0, 0); 

      /*condition that works with mousePressed down below. When the mouse is pressed, the class
      saves the current position of mouseX/Y and records new positions for mouseX/Y creating an
      adjustable window*/
      if (!posSwap) {
        xEnd = mouseX;
        yEnd = mouseY;
      }
      int matrixsize = 3;

      /*For loop that access's each pixels RGB value and changes said value according to the convolution matrix
      down below*/
      loadPixels();
      for (int x = xStart; x < xEnd; x++) {
        for (int y = yStart; y < yEnd; y++) {
          color c = convolution(x, y, matrix, matrixsize, alexT);
          int loc = x + y *alexT.width;
          pixels[loc] = c;
        }
      }
      updatePixels();
    } else {
      image(trendyM, 0, 0); 

      if (!posSwap) {
        xEnd = mouseX;
        yEnd = mouseY;
      }
      int matrixsize = 3;

      loadPixels();
      for (int x = xStart; x < xEnd; x++) {
        for (int y = yStart; y < yEnd; y++) {
          color c = convolution(x, y, matrix, matrixsize, trendyM);
          int loc = x + y *trendyM.width;
          pixels[loc] = c;
        }
      }
      updatePixels();
    }
  }
  
  /*Function that access's each pixel along with its neighbors to create blending affects depending on the 
  value of the matrix array*/
  color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img) {
    float rTotal = 0.0;
    float gTotal = 0.0;
    float bTotal = 0.0;
    int offset = matrixsize / 2;

    for (int i = 0; i < matrixsize; i++) {
      for (int j = 0; j < matrixsize; j++) {
        int xLoc = x + i - offset;
        int yLoc = y + j - offset;
        int loc = xLoc + img.width * yLoc;

        loc = constrain(loc, 0, img.pixels.length-1);

        rTotal += (red(img.pixels[loc]) * matrix[i][j]);
        gTotal += (green(img.pixels[loc]) * matrix[i][j]);
        bTotal += (blue(img.pixels[loc]) * matrix[i][j]);
      }
    }

    rTotal = constrain(rTotal, 0, 255);
    gTotal = constrain(gTotal, 0, 255);
    bTotal = constrain(bTotal, 0, 255);

    return color(rTotal, gTotal, bTotal);
  }

  //Saves current MouseX/Y and begins to track it's new position to create a window when clicked. 
  void posSwap() {
    if (mousePressed) {
      xStart = tempX1;
      yStart = tempY;
      posSwap = !posSwap;
    }
  }
}