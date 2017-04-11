class Interface {
  //Declares all the necessary images for the ui  
  PImage botDefaultUi, botActiveUI, topDefaultUi, topActiveUi;
  PImage genericButtonOff, swarmButtonOff, heavyButtonOff, frostButtonOff, fireButtonOff;
  PImage genericButtonAct, swarmButtonAct, heavyButtonAct, frostButtonAct, fireButtonAct;
  PImage listenIcon, pingIcon;
  PImage buttonActive, buttonPassive;
  PImage minimap;

  //Declares all locations and sizes for the ui images
  PVector topActiveUiLoc;
  PVector minimapLoc, minimapSize;
  PVector outerMapLoc, outerMapSize;
  PVector genericLoc, swarmLoc, heavyLoc, frostLoc, fireLoc, activeUi;
  PVector upgradeFlyingLoc, sellTowerLoc;
  PVector towerHover;
  PVector buttonLoc;

  //Size for the towerButtons
  int size;
  //Variables that allow the maping between minimap and window
  int tempX, tempY = 0;
  int mapX, mapY = 0;

  //Variables used to animate windows on and off the screen
  float menuDif;
  float minimapDif;
  float easing = 0.50;
  float dx;
  float dB;
  float dM;
  float dTUi;

  //Sets the minimap as active for use of interactions
  boolean minimapActive;
  //Establishes which tower was built
  boolean genericBuild, swarmBuild, heavyBuild, frostBuild, fireBuild = false;
  //Sets the buy menu as active for use of interactions
  boolean buyMenuActivate = false;
  //Activates the minimap on&&off
  boolean minimapActivate = false;

  Interface() {
    //Loads in the different ui components
    botDefaultUi = loadImage("towerInfo_Outline-01.png");
    botActiveUI = loadImage("towerBuy.png");
    topDefaultUi = loadImage("minimapIn_Outline-01.png");
    topActiveUi = loadImage("minimapOut_outline-01.png");

    //Loads in the passive button states
    genericButtonOff = loadImage("buttons/genericTower.png");
    swarmButtonOff = loadImage("buttons/swarmTower.png");
    heavyButtonOff = loadImage("buttons/heavyTower.png");
    frostButtonOff = loadImage("buttons/frostTower.png");
    fireButtonOff = loadImage("buttons/fireTower.png");

    //Loads in the active button states
    genericButtonAct = loadImage("buttons/genericTowerActive.png");
    swarmButtonAct = loadImage("buttons/swarmTowerActive.png");
    heavyButtonAct = loadImage("buttons/heavyTowerActive.png");
    frostButtonAct = loadImage("buttons/frostTowerActive.png");
    fireButtonAct = loadImage("buttons/fireTowerActive.png");

    //Loads in vanilla button states for passive&&active
    buttonActive = loadImage("buttons/buttonPassive.png");
    buttonPassive = loadImage("buttons/buttonActive.png");

    //Loads in listen and ping icons (UNUSABLE)
    listenIcon = loadImage("icons/listenIcon.png");
    pingIcon = loadImage("icons/pingIcon.png");

    minimap = loadImage("minimap.jpg");

    //Location for the minimap ui
    topActiveUiLoc = new PVector(0, -345);
    //Location for the stats image
    towerHover = new PVector(530, 895);
    //Location for the minimap and its size
    minimapLoc = new PVector(700, -315);
    minimapSize = new PVector(552, 311);
    //Location and size for the map boundaries extending beyond the window
    outerMapLoc = new PVector(-960, -640);
    outerMapSize = new PVector(3840, 2360);

    //Location for the activeUi
    activeUi = new PVector(18, 0);
    //Location for the genericTowerIcon
    genericLoc = new PVector(532, 1080);
    //Location for the swarmTowerIcon
    swarmLoc = new PVector(712, 1080);
    //Location for the heavyTowerIcon
    heavyLoc = new PVector(892, 1080);
    //Location for the frostTowerIcon
    frostLoc = new PVector(1072, 1080);
    //Location for the fireTowerLoc
    fireLoc = new PVector(1255, 1080);

    //Location for the upgradeToAttackFlying button
    upgradeFlyingLoc = new PVector(0, 0);
    //Location for the upgradeToAttackGround button
    sellTowerLoc = new PVector(0, 92);
    //Size for the towerbuttons
    size = 170;
  }

  //All ui functions go here
  void uiManager() {
    //Displays the basic UI 
    ui.display();
    //Allows the interaction with the minimap
    ui.minimapInteraction();
    //Displays the buy menu
    ui.displayBuy();
    //Allows menu animations
    ui.menuAnim();
  }

  //Displays most of the ui 
  void display() {
    //Bottom default ui
    image(botDefaultUi, 0, 0);
    //Function that establishes the information marked on the bottom ui
    botUiInfo();
    //top default ui
    image(topDefaultUi, 0, 0);
    //top minimap ui
    image(topActiveUi, topActiveUiLoc.x, topActiveUiLoc.y);
    //minimap ui
    image(minimap, minimapLoc.x, minimapLoc.y);

    //sets an image besides the mouseIcon to show if the player can hear nearby sounds or ping the map
    if (primeSonar.startListen == true) {
      image(listenIcon, mouseX+5, mouseY-5);
    } else if (primeSonar.startPing == true) {
      image(pingIcon, mouseX+5, mouseY-5);
    }
    if (primeSonar.startListen == false) {
      image(listenIcon, -50, -50);
    } else if (primeSonar.startPing == false) {
      image(pingIcon, -50, -50);
    }

    //Establishes if the minimap is active or not depending on mouse location (mouse has to be within the minimap parameters)
    if (mouseX > minimapLoc.x && mouseX < minimapLoc.x+minimapSize.x && mouseY > minimapLoc.y && mouseY < minimapLoc.y+minimapSize.y) {
      minimapActive = true;
    } else {
      minimapActive = false;
    }
  }

  //function that displays the buy menu
  void displayBuy() {
    //Various keyCode that establishes the hotkeys of the game
    if (keyPressed) {
      if (key == 'a') {     
        buyMenuActivate = true;
      }
      if (key == 's') {     
        buyMenuActivate = false;
        minimapActivate = false;
        primeSonar.startListen = false;
        primeSonar.startPing = false;
      }
      if (key == 'd') {
        minimapActivate = true;
      }
      if (key == 'z') {
        primeSonar.startPing = true;
      }
      if (key == 'x') {
        generic.rewind();
        swarm.rewind();
        heavy.rewind();
        flying.rewind();
        primeSonar.startListen = true;
      }
      if (key == 'q' && buyMenuActivate == true) {
        genericBuild = true;
        towerBuild = true;
      }
      if (key == 'w' && buyMenuActivate == true) {
        swarmBuild = true;
        towerBuild = true;
      }
      if (key == 'e' && buyMenuActivate == true) {
        heavyBuild = true;
        towerBuild = true;
      }
      if (key == 'r' && buyMenuActivate == true) {
        frostBuild = true;
        towerBuild = true;
      }
      if (key == 't' && buyMenuActivate == true) {
        fireBuild = true;
        towerBuild = true;
      }
    }

    //Displays the botactiveui and the buttons allong with it
    image(botActiveUI, activeUi.x, activeUi.y);
    image(genericButtonOff, genericLoc.x, genericLoc.y);
    image(swarmButtonOff, swarmLoc.x, swarmLoc.y);
    image(heavyButtonOff, heavyLoc.x, heavyLoc.y);
    image(frostButtonOff, frostLoc.x, frostLoc.y);
    image(fireButtonOff, fireLoc.x, frostLoc.y);

    //condition if mousepressed within the parameters of the towerbuttons that queue in the building process. 
    if (mousePressed) {
      if (mouseX > genericLoc.x && mouseX < genericLoc.x + size && mouseY > genericLoc.y && mouseY < genericLoc.y +size) {
        image(genericButtonAct, genericLoc.x, genericLoc.y);
        //print("generic");
        genericBuild = true;
        towerBuild = true;
      } else if (mouseX > swarmLoc.x && mouseX < swarmLoc.x + size && mouseY > swarmLoc.y && mouseY < swarmLoc.y +size) {
        image(swarmButtonAct, swarmLoc.x, swarmLoc.y);
        //print("swarm");
        swarmBuild = true;
        towerBuild = true;
      } else if (mouseX > heavyLoc.x && mouseX < heavyLoc.x + size && mouseY > heavyLoc.y && mouseY < heavyLoc.y +size) {
        image(heavyButtonAct, heavyLoc.x, heavyLoc.y);
        //print("heavy");
        heavyBuild = true;
        towerBuild = true;
      } else if (mouseX > frostLoc.x && mouseX < frostLoc.x + size && mouseY > frostLoc.y && mouseY < frostLoc.y +size) {
        image(frostButtonAct, frostLoc.x, frostLoc.y);
        //print("frost");
        frostBuild = true;
        towerBuild = true;
      } else if (mouseX > fireLoc.x && mouseX < fireLoc.x + size && mouseY > fireLoc.y && mouseY < fireLoc.y +size) {
        image(fireButtonAct, fireLoc.x, fireLoc.y);
        //print("fire");
        fireBuild = true;
        towerBuild = true;
      }
    }
  }

  //function that displays the tower info according to where the mouse is
  void botUiInfo() {
    //Goes through the array of towers
    for (int i = 0; i < towerCount; i++) {
      //if the mouse is within a towers parameters, information relating to it will display in the bottomPassiveUi as well as upgrade options
      if (mouseX > tower[i].location.x && mouseX < tower[i].location.x+26 && mouseY > tower[i].location.y+12 && mouseY < tower[i].location.y+37) {
        if (tower[i].towerIndex == 0) {
          image(genericButtonOff, towerHover.x, towerHover.y);
        } else if (tower[i].towerIndex == 1) {
          image(swarmButtonOff, towerHover.x, towerHover.y);
        } else if (tower[i].towerIndex == 2) {
          image(heavyButtonOff, towerHover.x, towerHover.y);
        } else if (tower[i].towerIndex == 3) {
          image(frostButtonOff, towerHover.x, towerHover.y);
        } else if (tower[i].towerIndex == 4) {
          image(fireButtonOff, towerHover.x, towerHover.y);
        }
        image(buttonPassive, upgradeFlyingLoc.x, upgradeFlyingLoc.y);
        image(buttonPassive, sellTowerLoc.x, sellTowerLoc.y);

        //If f or g is pressed, the currently selected tower will be able to attack either air or ground units
        if (keyPressed) {
          if (key == 'f') {
            image(buttonActive, upgradeFlyingLoc.x, upgradeFlyingLoc.y);
            tower[i].canAtkAir = true;
          }
          if (key == 'g') {
            image(buttonActive, sellTowerLoc.x, sellTowerLoc.y);
            tower[i].canAtkAir = false;
          }
        }
      }
    }
  }

  void menuAnim() {
    //If the menu bool is true, then the buyMenu along with its buttons will animated into the window
    if (buyMenuActivate == true) {
      dx = -200 - activeUi.y;
      dB = 896 - genericLoc.y;
      activeUi.y += dx;
      genericLoc.y += dB*easing;
      swarmLoc.y += dB*easing;
      heavyLoc.y += dB*easing;
      frostLoc.y += dB*easing;
      fireLoc.y += dB*easing;
      //If the menu bool is false, then the buyMenu along with its buttons will animated out of the window
    } else if (buyMenuActivate == false) {
      dx =  200 - activeUi.y;
      dB = 1080 - genericLoc.y;
      activeUi.y += dx;
      genericLoc.y += dB*easing;
      swarmLoc.y += dB*easing;
      heavyLoc.y += dB*easing;
      frostLoc.y += dB*easing;
      fireLoc.y += dB*easing;
    }

    //If the minimap is true, the minimap will animate into the window.
    if (minimapActivate == true) {
      dTUi = 0 - topActiveUiLoc.y;
      dM = 0 - minimapLoc.y;    
      topActiveUiLoc.y += dTUi;
      minimapLoc.y += dM*easing;
      //If the minimap is false, the minimap will animate out of the window.
    } else if (minimapActive == false) {
      dTUi = -345 - topActiveUiLoc.y;
      dM = -315 - minimapLoc.y;    
      topActiveUiLoc.y += dTUi;
      minimapLoc.y += dM*easing;
    }
  }

  //function that maps the location of the minimap onto the window
  void minimapInteraction() {
    if (minimapActive == true) {
      tempX = mouseX;
      tempY = mouseY;

      //Sets the position of the cursor from the minimap to its relative position on the gameSpapce
      mapX = int(map(tempX, minimapLoc.x, minimapLoc.x+minimapSize.x, outerMapLoc.x, outerMapLoc.x+outerMapSize.x));
      mapY = int(map(tempY, minimapLoc.y, minimapLoc.y+minimapSize.y, outerMapLoc.y, outerMapLoc.y+outerMapSize.y));
    }
  }
}