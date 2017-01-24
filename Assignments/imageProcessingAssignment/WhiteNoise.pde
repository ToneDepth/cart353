class WhiteNoise {
  float rand;
  boolean imageSwap;

  WhiteNoise() {
    //Sets opacity and random values to 255.
    rand = 255;
    opa = 255;
  }

  void display(boolean setImage) {
    //boolean that establishes which image is shown.
    imageSwap = setImage;

    if (imageSwap) {
      //has source, and mod to allow pixel transparency to be played with.
      alexT.loadPixels();
      alexTMod.loadPixels();

      image(alexT, 0, 0);
      //Loop that locates each pixels and assigns it a random value between 0 and 255
      for (int y = 0; y < alexT.height; y++) {
        for (int x = 0; x < alexT.width; x++) {
          int loc = x + y * alexT.width;
          float rand = random(255);
          alexTMod.pixels[loc] = color(rand, opa);
        }
      }
      alexTMod.updatePixels();
      image(alexTMod, 0, 0);
    } else {
      if (!imageSwap) {
        trendyM.loadPixels();
        trendyMMod.loadPixels();

        image(trendyM, 0, 0);
        for (int y = 0; y < trendyM.height; y++) {
          for (int x = 0; x < trendyM.width; x++) {
            int loc = x + y * trendyM.width;
            float rand = random(255);

            trendyMMod.pixels[loc] = color(rand, opa);
          }
        }
        trendyMMod.updatePixels();
        image(trendyMMod, 0, 0);
      }
    }
  }
}