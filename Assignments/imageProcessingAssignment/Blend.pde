class Blend {
  //Array storing all the available blending options
  int[]blendModes = {BLEND, ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, 
    OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};
  //Variable that simply establishes the first blendMode randomly
  int rand;                

  Blend() {
    rand = floor(random(13));
  }

  void display(boolean imageSet) {
    //condition that establishes which image is the one affected by the blending options
    if (imageSet) {
      background(loadImage("TrendyMeme.jpg")); 
      blend(alexT, 0, 0, 450, 450, 0, 0, 450, 450, blendModes[rand]);
    } else {
      background(loadImage("AlexTrebek.jpg")); 
      blend(trendyM, 0, 0, 450, 450, 0, 0, 450, 450, blendModes[rand]);
    }
  }

  //
  void blendSwap() {
    if (mousePressed) {
      rand = floor(random(13));
    } else if (keyPressed) {
      if (key == 'b' || key == 'B') {
        rand = floor(random(13));
      }
    }
  }
}