import processing.video.*;
import java.util.Random;

Random generator;
Movie video;

//Foreground image to be filtered through
PImage noise;

//range determines the how much the gaussian radius will be multiplied by
int gaussianRange = 60;
//Size of the ellipses
float size = 30;
//Controls the 2d offset off the noise value
float offX = 0;
float offY = 1000;

//Instantiate the foreground effect, and video as well as allowing a loop to occur.
void setup() {
  size(720, 480);
  noise = createImage(width, height, ALPHA);
  video = new Movie(this, "vod.mov");
  video.loop();

  generator = new Random();
}

void movieEvent(Movie video) {
  video.read();
}

void draw() {
  //Video needs to be drawn first as the effects must occur over it. 
  image(video, 0, 0);


  loadPixels();
  video.loadPixels();
  //loop to acquire all pixel information as well as reseting offX/Y to maintain consistancy
  offX = 0;
  for (int posX = 0; posX < video.width; posX++) {
    offY = 0;
    for (int posY = 0; posY < video.height; posY++) {
      int loc = posX + posY * video.width;
      //Creates basic perlin noise brightness to the noise image
      float bright = map(noise(offX, offY), 0, 1, 0, 255);
      noise.pixels[posX+posY*width] = color(bright);

      //Creates the area that will display the gaussian effect.
      float space = abs(randomGaussian() * gaussianRange);
      //Creates a perlin noise effect linked to the gaussian space
      size = noise(offX, offY) * 20;

      //Condition that checks if the a pixel is within range of the mouse established by the gaussianRange
      if (dist (posX, posY, mouseX, mouseY) < space) {
        float r = red(video.pixels[loc]);
        float g = green(video.pixels[loc]);
        float b = blue(video.pixels[loc]);     
        fill(r, g, b);
        noStroke();
        ellipse(posX, posY, size, size);
      }
      offX += 0.01;
    }
    offY += 0.01;
  }
  noise.updatePixels();

  //Calculation that adds small movement to the noise image.
  float num = (int) generator.nextGaussian();
  float sd = 0.01;
  float mean = 0.05;
  float magicNumber = sd * num + mean;

  //Darkens and lowers the opacity of the noise image
  tint(200, 1);
  //Displays the noise image
  image(noise, magicNumber, magicNumber);
}