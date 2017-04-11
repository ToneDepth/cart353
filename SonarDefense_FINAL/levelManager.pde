class LevelManager {
  //Establishes the round
  int round;
  //Counts the minion deathCount
  int deathCount;
  //Captures current millis when called on
  float timer;
  //starts a pause period
  boolean postLevelPause;  
  //Captures current time + cooldowntime
  boolean setTime;
  //Resets the time
  boolean resetTime;

  LevelManager() { 
    round = 1;
    deathCount = 0;
    postLevelPause = false;
    setTime = true;
    resetTime = false;
  }

  //Function that allows the flow of rounds.
  //Depending on the round, specific minions will spawn, their stats establishes, and movements updated
  //Pinging the map is enabled through here
  void updateLevel() {
    if (round == 1) {      
      for (int i = 0; i < 25; i++) {
        minion[i].minionStats(1);
        minion[i].display(1);
        minion[i].update();
        //Gets the position of minions to establishes if a ping hits
        primeSonar.objectCollision(minion[i]);
        //Listens for the minion selected (10)
        primeSonar.checkRadar(10);
        //Once death count is 25, the round is finishes and the postLevel pause is initiated
        if (deathCount >= 25) {
          postLevelPause(10000);
        }
      }
    }
    //Rince repeat comments for all further rounds...
    if (round == 2) {
      for (int i = 26; i <= 45; i++) {
        minion[i].minionStats(4);
        minion[i].display(1);
        minion[i].update();
        primeSonar.objectCollision(minion[i]);
        primeSonar.checkRadar(31);

        if (deathCount >= 45) {
          postLevelPause(10000);
        }
      }
    }
    if (round == 3) {
      for (int i = 46; i <= 95; i++) {
        minion[i].minionStats(3);
        minion[i].display(1);
        minion[i].update();
        primeSonar.objectCollision(minion[i]);
        primeSonar.checkRadar(75);

        if (deathCount >= 95) {
          postLevelPause(10000);
        }
      }
    }
    if (round == 4) {
      for (int i = 96; i <= 105; i++) {
        minion[i].minionStats(2);
        minion[i].display(1);
        minion[i].update();
        primeSonar.objectCollision(minion[i]);
        primeSonar.checkRadar(100);

        if (deathCount >= 105) {
          postLevelPause(10000);
        }
      }
    } 
    if (round == 5) {
      for (int i = 106; i <= 130; i++) {
        minion[i].minionStats(5);
        minion[i].display(1);
        minion[i].update();
        primeSonar.objectCollision(minion[i]);
        primeSonar.checkRadar(120);

        if (deathCount >= 130) {
          println("YU WINNN");
          postLevelPause(10000);
        }
      }
    }
  }

  //Function that enables the postLevel pause
  void postLevelPause(int timerAdjustement) {
    //bools that enable further processes
    if (resetTime == true) {
      setTime = true;
      resetTime = false;
    }
    //Gets the time once
    if (setTime == true) {
      timer = millis();
      postLevelPause = true;
      setTime = false;
    }
    //compares millis and timer+timerAdjustmenent and starts the next round when by reseting pathing for a new enemy route.
    if (postLevelPause == true) {
      if (millis()>timer+timerAdjustement) {
        round++;
        pathFinder.loop = true;
        pathFinder.pathCooldown = true;
        postLevelPause = false;
        resetTime = true;
      }
    }
  }
}