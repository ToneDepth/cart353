Camera worldCamera;
PImage img;

void setup() {
  size(640, 640);
  worldCamera = new Camera();
  img = loadImage("333573.jpg");
}

void draw() {
  background(255);
  //for the camera to work evrything must be done after you translate by its negative position
  //You make it negative so it works the right way, left is left and up is up
  translate(-worldCamera.pos.x, -worldCamera.pos.y);
  worldCamera.display();
  image(img,0,0);
}