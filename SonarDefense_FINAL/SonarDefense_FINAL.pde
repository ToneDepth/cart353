import ddf.minim.*;
//Declares sound stuff
Minim minim;
AudioPlayer song, generic, swarm, heavy, flying, ambient;

//Declares the sonar class
Sonar primeSonar;
//Declares the level management system
LevelManager levelManager;
//Declares the map
Map map;
//Declares the user interface
Interface ui;
//Declares pathing for the minions
PathFinder pathFinder;
//Declares the Tower,Minion, and grid class
Tower[] tower;
Minion[] minion;
Grid[] grid;

//Variables related to sound cues
PVector mousePos;
PVector targetPos;

//Variables related to tower/minion counts and other prototype functions
int towerCount = 100;
int minionCount = 131;
int gridX, gridY;
int gridCount;

boolean towerBuild = false;
boolean buildTower = false;

void setup() {
  fullScreen();

  //Instantiations for sound cues.
  minim = new Minim(this);
  //Loads in the various sounds of the game
  song = minim.loadFile("sound/ping.mp3");
  generic = minim.loadFile("sound/generic.wav");
  swarm = minim.loadFile("sound/swarm.wav");
  heavy = minim.loadFile("sound/heavy.mp3");
  flying = minim.loadFile("sound/flying.mp3");
  ambient = minim.loadFile("sound/ambientSound.mp3");

  //Instantiates the level manager class
  levelManager = new LevelManager();
  //Instantiates the sonar class
  primeSonar = new Sonar();
  //Instantiates the map class
  map = new Map();
  //Instantiates the Interface class
  ui = new Interface();
  //Instantiates the pathfinder class
  pathFinder = new PathFinder();

  //Instantiates the towers based off of towerCount
  tower = new Tower[towerCount];
  for (int i = 0; i < towerCount; i++) {
    tower[i] = new Tower();
  }

  //Instantiates the minion minion
  minion =  new Minion[minionCount];
  for (int i = 0; i < minionCount; i++) {
    minion[i] = new Minion();
  }

  //Establishes gridCount according to the size of the screen
  gridCount = (width/20) * (height/20);
  //Instantiates the grid system
  grid = new Grid[gridCount];
  for (int i = 0; i < gridCount; i++) {
    //Instantiates the grid class
    grid[i] = new Grid (gridX, gridY);
    gridX += 25;

    if (gridX >= width) {
      //Resets x to 0 but pushes y down 25.
      gridX = 0;
      gridY += 25;
    }
  }
}

void draw() {  
  //Displays the map
  map.display();

  //Establishes the level and which minions spawn.
  levelManager.updateLevel();
  //Global function associated to the pathFinder class.
  pathFinder.pathFinderManager();

  //Displays the fog and where it is pierced.
  //map.clearFog();

  //Displays all functions related to the grid
  for (int i = 0; i < gridCount; i ++) {
    //Stores grid information
    grid[i].gridSelect();
    //Displays the grid
    grid[i].display();
  }

  //Displays towers based on towerCount
  for (int i = 0; i < towerCount; i++) {
    //displays towers
    tower[i].display();
    //Establishes tower stats
    tower[i].towerStats();
    //Allows the custom setting of tower position
    tower[i].towerPlacement();
    //Allows the tower to attack
    tower[i].activeAttack();
  }
  ui.uiManager();
  //Allows the use off sonar and sound
  primeSonar.display();
  //Updates the sonar animation
  primeSonar.update();
}

void mousePressed() {
  //finalizes the placement of a tower
  if (towerBuild == true) {
    buildTower = true;
  }
}