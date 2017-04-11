//Establishes tower type and location
class Tower {
  //Location of tower
  PVector location;
  //Type of tower
  PImage[] towerSet = new PImage[5];

  //Represents the visuals of the tower
  int towerKey;
  //current ammount of tower
  int currentTowerCount;
  //Plays a process once
  boolean doItOnce = true;
  //Displays the tower
  boolean towerActive;

  //Booleans that establish the tower type mechanicaly
  boolean genericTower;
  boolean swarmTower;
  boolean piercingTower;
  boolean splashTower;
  boolean frostTower;

  //Bools that establish tower special attributes
  boolean canAtkAir;
  boolean frostDamage;
  boolean splashDamage;
  boolean attackType;

  //Generic tower Stats
  float atkDamage;
  float atkSpeed;
  float atkRange;
  float buildTime;
  float buildCost;
  float vision;

  //Variables that get a towers index (according to its space relative to grid.
  int towerIndex;
  int setIndex;
  float minionDist;
  boolean enableAttack = false;

  float tDist;

  boolean on;
  boolean getTime;

  int atkCool;

  Tower() {
    //Failed attempts at attack cooldown. I miss Unity sometimes... 
    on = false;
    getTime = false;
    atkCool = millis();

    //Loads in the tower assets
    towerSet[0] = loadImage("Towers/genericTowerB.png");
    towerSet[1] = loadImage("Towers/swarmTowerB.png");
    towerSet[2] = loadImage("Towers/heavyTowerB.png");
    towerSet[3] = loadImage("Towers/frostTowerB.png");
    towerSet[4] = loadImage("Towers/fireTowerB.png");


    //Sets location of tower based off of posX and posY
    location = new PVector(-10000, -10000);

    //Counts the current total amount of towers.
    currentTowerCount = 0;

    //Bools that establish if a tower deals frost or splash damage, and if it can attack air units.
    canAtkAir = false;
    frostDamage = false;
    splashDamage = false;
  }


  /*==================FOR RILLA====================*/
  /*hi again, I actually mannaged to code a hierarchy system of layering for the 
   towers. I encountered a major problem though... my solution was to fill every
   grid space with a none displayed tower. the total ammount came to about 5100. 
   this pretty much caused the game to never run in any capacity and I could not
   find a work around with the time I had left. I tried slowly implementating the 
   tower count, but that caused issues with for loops and such. So like the fog of
   war, if you have a solution for this, I would to have it because I feel this 
   shouldn't be a problem. Or maybe it is for processing, I don't know...*/

  //Displays the selected tower
  void display() {
    //Displays tower   
    //image(towerSet[i], location.x, location.y);
    tower[0].towerIndex = 0;
    /*for (int i = 0; i < towerCount-1; i++) {
     tower[i].location.x = grid[i].location.x;
     tower[i].location.y = grid[i].location.y-17;
     }
     if (towerActive == true) {*/
    image(towerSet[towerIndex], location.x, location.y);
    /*}*/
  }

  //Function that sets a built tower to the appropriate grid space clicked on.
  void towerPlacement() {
    //if the build is commence, a tower shadow will follow the mouse, showing which tower is selected to be built.
    if (towerBuild) {
      if (ui.genericBuild == true) {
        tower[currentTowerCount].towerIndex = 0;
        image(towerSet[towerIndex], mouseX, mouseY);
      } else if (ui.swarmBuild == true) { 
        tower[currentTowerCount].towerIndex = 1;
        image(towerSet[towerIndex], mouseX, mouseY);
      } else if (ui.heavyBuild == true) {
        tower[currentTowerCount]. towerIndex = 2;
        image(towerSet[towerIndex], mouseX, mouseY);
      } else if (ui.frostBuild == true) {
        tower[currentTowerCount].towerIndex = 3;
        image(towerSet[towerIndex], mouseX, mouseY);
      } else if (ui.fireBuild == true) {
        tower[currentTowerCount].towerIndex = 4;
        image(towerSet[towerIndex], mouseX, mouseY);
      }
    }
    //image(towerType[1], mouseX, mouseY);
    //If tower build commence, sets tower to appropriate grid cell and begins its construction.
    if (towerBuild && buildTower) {
      for (int i = 0; i < gridCount; i ++) {    
        if (grid[i].gridSelect && grid[i].gridUsed == false) {
          //Sets mouseX,Y positions to appropriate grid cell positions.
          tower[currentTowerCount].location.x = grid[i].tempLocation.x;
          tower[currentTowerCount].location.y = grid[i].tempLocation.y-12;
          //Increases current tower ammount.
          currentTowerCount ++;
          //Sets grid to use, so that further towers cannot be built on it.
          //tower[i].towerActive = true; /*Used for porper layering of towers on grid*/
          grid[i].gridUsed = true;
        }
      }
      //resets the designated stat for the next tower
      ui.genericBuild = false;
      ui.swarmBuild = false;
      ui.heavyBuild = false;
      ui.frostBuild = false;
      ui.fireBuild = false;
      //Sets both bools to false, to allow further tower builds.
      buildTower = false;
      towerBuild = false;
    }
  }

  //Function that allows an attack if within range
  void activeAttack() {
    for (int i = 0; i < minionCount; i++) {      
      //Gets the distance between the tower and minion
      minionDist = dist(location.x, location.y, minion[i].location.x, minion[i].location.y); 
      //If close enough, the tower attacks
      if (minionDist <= 200 && minion[i].dead == false) {
        minion[i].healthPoints --;
      }
    }
  }

  //Grants specific stats and qualities based on the tower type.
  void towerStats() {
    //Generic Tower Stats
    if (genericTower) {
      atkDamage = 10;
      atkSpeed = 0.5;
      atkRange = 100;

      buildTime = 5;
      buildCost = 50;
      vision = 150;

      frostDamage = false;
      splashDamage = false;

      if (attackType) {
        canAtkAir = true;
      } else if (!attackType) {
        canAtkAir = false;
      }
    }
    //Swarm Tower Stats
    if (swarmTower) {
      atkDamage = 10;
      atkSpeed = 0.5;
      atkRange = 100;

      buildTime = 5;
      buildCost = 50;
      vision = 150;

      frostDamage = false;
      splashDamage = false;

      if (attackType) {
        canAtkAir = true;
      } else if (!attackType) {
        canAtkAir = false;
      }
    }
    //Piercing Tower Stats
    if (piercingTower) {
      atkDamage = 10;
      atkSpeed = 0.5;
      atkRange = 100;

      buildTime = 5;
      buildCost = 50;
      vision = 150;

      frostDamage = false;
      splashDamage = false;

      if (attackType) {
        canAtkAir = true;
      } else if (!attackType) {
        canAtkAir = false;
      }
    }
    //Splash Damage Tower Stats
    if (splashTower) {
      atkDamage = 10;
      atkSpeed = 0.5;
      atkRange = 100;

      buildTime = 5;
      buildCost = 50;
      vision = 150;

      frostDamage = false;
      splashDamage = false;

      if (attackType) {
        canAtkAir = true;
      } else if (!attackType) {
        canAtkAir = false;
      }
    }
    //Frost Damage Tower Stats
    if (frostTower) {
      atkDamage = 10;
      atkSpeed = 0.5;
      atkRange = 100;

      buildTime = 5;
      buildCost = 50;
      vision = 150;

      frostDamage = false;
      splashDamage = false;

      if (attackType) {
        canAtkAir = true;
      } else if (!attackType) {
        canAtkAir = false;
      }
    }
  }
}