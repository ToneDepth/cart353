import ddf.minim.*;

//Declares the camera and map classes
Camera worldCamera;
Map map;
//Declares the sonar class
Sonar primeSonar;
//Declares sound stuff
Minim minim;
AudioPlayer song;
//Declares the Tower and Minion class
Tower[] tower;
Minion demo;

//Variables related to sound cues
PVector mousePos;
PVector targetPos;
float distance;
float volume;

//Declares the fog and controls images
PImage fog;
PImage controls;

//Variables related to tower/minion counts and other prototype functions
int towerCount = 4;
int minionCount = 0;
int towerKey;
int x = 100;
int rand = floor(random(0, 3));

void setup() {
  size(800, 800);
  //Loads the fog image
  fog = loadImage("fogGreen.jpg");
  //Loads the controls image
  controls = loadImage("controls-01.png");

  //Instantiates the sonar class
  primeSonar = new Sonar(width/2, 400, 0);

  //Instantiations for sound cues.
  minim = new Minim(this);
  // this loads mysong.wav from the data folder
  song = minim.loadFile("allright.wav");

  //Instantiates the towers based off of towerCount
  tower = new Tower[towerCount];
  for (int i = 0; i < towerCount; i++) {
    tower[i] = new Tower(x, 550);
    x += 150;
    if (i == 1) {
      x += 125;
    }
  }

  //Instantiates the demo minion
  demo =  new Minion(width/2, 50);

  //Instantiates camera and map.
  worldCamera = new Camera();
  map = new Map();
}

void draw() {
  //For moving the camera
  translate(-worldCamera.pos.x, -worldCamera.pos.y);
  worldCamera.display();

  //Displays the map
  map.display();
  
  //Displays towers based on towerCount
  for (int i = 0; i < towerCount; i++) {
    tower[i].display(towerKey);
    tower[i].towerStats();
  }
  
  //Displays the demo minion
  demo.display(rand);
  //adds movespeed to the demo minion
  demo.update();

  //Displays the fog and where it is pierced.
  map.clearFog();
  //Displays the controls image.
  image(controls, width/2-150, height-250);
  //Displays the sonar ellipse.
  primeSonar.display();

  //Conditions concerning the sonar
  if (mousePressed) {
    //If mouse is pressed, the sonar grows bigger
    primeSonar.update();
  } else {
    //When released, the sonar disapears.
    primeSonar.r = 0;
  }
  //Checks for collision between sonar and demo minion.
  primeSonar.objectCollision(demo);
}

//Various functions that trigger when keys are pressed.
//Changes the type depending on which button is pressed.
void keyPressed() {
  if (keyCode == UP) {
    towerKey = 0;
  }
  if (keyCode == DOWN) {
    towerKey = 1;
  }
  if (keyCode == RIGHT) {
    towerKey = 2;
  }
  if (keyCode == LEFT) {
    towerKey = 3;
  }
}

//Various functions triggered from pressing down on mouse.
void mousePressed() {
  //Sets value to position of mouse.
  mousePos = new PVector(mouseX, mouseY);
  //Sets value to the position of target
  targetPos = new PVector(demo.location.x, demo.location.y);

  //Acquires distance between both targets
  distance = dist(mousePos.x, mousePos.y, targetPos.x, targetPos.y);
  //Maps the volume based off of the distance for volume by distance.
  volume = map(distance, 500, 0, -65, 0);

  //If close enough, a sound will cue. Sound intensity is based off of distance.
  if (distance < 200) {
    song.setGain(volume);
    song.pause();
    song.rewind();
    song.play();
  }
}

//Various functions triggered by releasing the mouse button.
void mouseReleased() {
  //Rewinds the soundcue when rewindTime is true.
  if (primeSonar.rewindTime == true) {
    song.pause();
    song.rewind();
  }
}