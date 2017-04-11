//Enables sonar location
class Sonar {
  //Position of the sonar as well as proxy position on minimap
  PVector location;
  PVector proxyLocation;
  PVector mapLoc;
  //the two different displays of sonar (on window and minimap) the values equal to the size of the ellipse
  float r1, r2, r3, r4;
  float r5, r6, r7, r8;
  //establishes unique sound volume for each sound 
  float volumeG, volumeFa, volumeS, volumeH, volumeF;

  //Bools that enable sonar, pinging, position fetching and loop intervals
  boolean getPos = true;
  boolean startRadar = false;
  boolean playLoop = false;
  boolean pingMap = false;

  //Bools that allow their respective mechanic
  boolean startPing = false;
  boolean startListen = false;

  //gets distance and sets opacity of the ellipses
  float distance;
  float opacity;

  Sonar() {
    //Sets location based off of x and y.
    location = new PVector(0, 0);
    proxyLocation = new PVector(0, 0);
    //MapLoc for proxy sonar
    mapLoc = new PVector(0, 0);
    //default resting values for sonar
    r1 = 0;
    r2 = 0;
    r3 = 0;
    r4 = 0;
    r5 = 0;
    r6 = 0;
    r7 = 0;
    r8 = 0;
    opacity = 255;
  }

  //function that displays the sonar effect
  void display() {
    //Setss stroke to white(255)
    stroke(0, opacity);
    //Sets strokeWeight to 5px.
    strokeWeight(1);
    //noFill for further objects.
    noFill();
    //Draws an ellipse that acts as the sonar visual.
    ellipse(location.x, location.y, r1*2, r1*2);
    ellipse(location.x, location.y, r2*2, r2*2);
    ellipse(location.x, location.y, r3*2, r3*2);
    ellipse(location.x, location.y, r4*2, r4*2);
    //Draws the proxy ellipses
    ellipse(mapLoc.x, mapLoc.y, r5*2, r5*2);
    ellipse(mapLoc.x, mapLoc.y, r6*2, r6*2);
    ellipse(mapLoc.x, mapLoc.y, r7*2, r7*2);
    ellipse(mapLoc.x, mapLoc.y, r8*2, r8*2);
  }

  //Makes sonar ellipse grow larger.
  void update() {
    if (mousePressed && startPing == true) {
      startRadar = true;
    }

    //Values get progressively larger
    if (startRadar == true) {
      r1+=10;
      r2+=7.5;
      r3+=5;
      r4+=2.5;

      //sets position of sonar to the position of the mouse
      if (mousePressed) {
        mapLoc.x = mouseX;
        mapLoc.y = mouseY;
      }

      //Same actions but for the proxy sonar
      if (ui.minimapActive) {  
        r5+=.2;
        r6+=.3;
        r7+=.4;
        r8+=.5;
      } else {
        r5 = 0;
        r6 = 0;
        r7 = 0;
        r8 = 0;
      }
      //Onces the r value gets big enough, it will slowly fade
      if (r1 >= 300) {
        opacity -= 25;
      }

      //Once the r value is big enough, its value is reset to 0 and the animation stops
      if (r1 >= 400) {
        r1 = 0;
        r2 = 0;
        r3 = 0;
        r4 = 0;

        r5 = 0;
        r6 = 0;
        r7 = 0;
        r8 = 0;
        startPing = false;
        opacity = 255;
        startRadar = false;
      }
    }
  }

  //function that allows sound to be heard relative to distance
  void checkRadar(int targetLoc) {   
    //Checks if proper conditions are set, and sets the mousePos to a PVector value equal to mouse position according to the window space
    if (ui.minimapActive == false && startListen == true) {
      getMousePos();
      location = mousePos;
      //Gets distance for volume variation
      distance = dist(mouseX, mouseY, minion[targetLoc].location.x, minion[targetLoc].location.y);
      //Checks if proper conditions are set, and sets the mousePos to a PVector value equal to mouse position according to the minimap space
    } else if (ui.minimapActive == true && startListen == true) {
      proxyLocation.x = ui.mapX;
      proxyLocation.y = ui.mapY;
      //Gets distance for volume variation
      distance = dist(proxyLocation.x, proxyLocation.y, minion[targetLoc].location.x, minion[targetLoc].location.y);
      //Sets volume to 0 no matter what
    } else if (startListen == false) {
      volumeG = -100;
      volumeFa = -100;
      volumeS = -100;
      volumeH = -100;
      volumeF = -100;
    }

    //Sets value to the position of target
    //Acquires distance between both targets
    //distance = dist(proxyLocation.x, location.y, minion[targetLoc].location.x, minion[targetLoc].location.y);
    //Maps the volume based off of the distance for volume by distance.

    //Unique volume settings for each sound
    volumeG = map(distance, 500, 0, -35, -10);
    volumeS = map(distance, 500, 0, -45, 0);
    volumeH = map(distance, 500, 0, -45, -25);
    volumeF = map(distance, 500, 0, -65, 0);

    //If close enough, allows sounds to be heard
    if (distance <= 500) {
      playLoop = true;
      //Else all sounds are paused
    } else {
      playLoop = false;
      generic.pause();
      swarm.pause();
      heavy.pause();
      flying.pause();
    }

    //Conditions establishing sounds to specific minions and playing them under the right conditions.
    if (playLoop == true && startListen == true && levelManager.round == 1) {         
      generic.setGain(volumeG);
      generic.play();
    } else if (playLoop == true && startListen == true && levelManager.round == 2) {
      generic.setGain(volumeG);
      generic.play();
    } else if (playLoop == true && startListen == true && levelManager.round == 3) {
      swarm.setGain(volumeS);
      swarm.play();
      generic.setGain(volumeG);
      generic.play();
    } else if (playLoop == true && !heavy.isPlaying() && startListen == true && levelManager.round == 4) {
      heavy.setGain(volumeH);
      heavy.play();
      generic.setGain(volumeG);
      generic.play();
    } else if (playLoop == true && startListen == true && levelManager.round == 5) {
      flying.setGain(volumeF);
      flying.play();
    }
    //Pasues the sounds if the listening action is cancelled
    if (startListen == false) {
      generic.pause();
      swarm.pause();
      heavy.pause();
      flying.pause();
    }
  }

  //simply gets the position of the mouse and stores its values as a PVector.
  void getMousePos() {
    if (getPos == true) {
      mousePos = new PVector(mouseX, mouseY);
      getPos = false;
    }
  }

  //Function that ping when the sonar animation comes into contact with a minion
  void objectCollision(Minion other) {
    //condition that sets the mouse position for the sonar center point. Applies to minimap as well if it is active.
    if (mousePressed) {
      if (ui.minimapActive == false) {
        location.x = mouseX;
        location.y = mouseY;
      } else if (ui.minimapActive == true) {
        location.x = ui.mapX;
        location.y = ui.mapY;
      }
    }

    //Calculations to established magnitude between two targets.
    PVector bVect = PVector.sub(other.location, location);
    float BVectMag = bVect.mag();

    //If mag is small enough, cues sound.
    if (BVectMag < r1 && !song.isPlaying()) {
      for (int i = 0; i < minionCount; i++) {
        if (levelManager.round == 1) {
          song.setGain(-15);
          song.rewind();
          song.play();
        }
      }
      pingMap = true;
    } else {
      pingMap = false;
    }
  }
}