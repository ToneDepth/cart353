//class decleration
WhiteNoise aWhiteNoise;
EdgeDetect aEdgeDetect;
Blend aBlend;

//Images and possible mods to them stored as an img variable
PImage alexT;
PImage alexTMod;
PImage trendyM;
PImage trendyMMod;

//Variable that track the position of X twice, Y once, and sets the opacity.
int tempX1;
int tempX2;
int tempY;
int opa;

//Variable that established which effect is active
int palletSwap = 1;

void setup() {
  size(450, 450);

  alexT = loadImage("AlexTrebek.jpg");
  alexTMod = createImage(alexT.width, alexT.height, RGB);
  trendyM = loadImage("TrendyMeme.jpg");
  trendyMMod = createImage(trendyM.width, trendyM.height, RGB);

  aWhiteNoise = new WhiteNoise();
  aEdgeDetect = new EdgeDetect();
  aBlend = new Blend();
}

void draw() {
  if (palletSwap == 1) {
    //Displays the whiteNoise effect
    aWhiteNoise.display(false);
  } else if (palletSwap == 2) {
    //Displays the edge detection effect
    aEdgeDetect.display(true);
    //Allows the box to be drawn
    aEdgeDetect.posSwap();
  } else if (palletSwap == 3) {
    //Displays the different blend options
    aBlend.display(false);
    //Swaps between the effects
    aBlend.blendSwap();
  }
}

//When pressed, store the current position of the mouse as tempX1 and tempY
void mousePressed() {
  tempX1 = mouseX;
  tempY = mouseY;
  println(tempX1);
}

//When released, store the current position of the mouseX as tempX2
void mouseReleased() { 
  tempX2 = mouseX;
  println(tempX2);

  //Sets the opacity according to the value of X1+X2 in relation to 255 for the WhiteNoise class
  opa = floor(tempX1+tempX2*255/900);
}

//If c/C is pressed, the pallets will change between the 3 available options
void keyPressed() {
  if (key == 'c' || key == 'C') {
    palletSwap ++;
    if (palletSwap > 3) {
      palletSwap = 1;
    }
  }
  //If s/S is pressed, the current visual will be saved in the sketch folder
  if (key == 's' || key == 'S') {
    save("editedImage.jpg");
  }
}