class PathFinder {
  //Pvectors establishing the location of spawnPoints, and intersectionPoints
  PVector spawnTL, spawnTR, spawnBL, spawnBR;
  PVector inter1, inter2, inter3, inter4, inter5, inter6;
  PVector leftPoint1, leftPoint2, leftPoint3, leftPoint4, leftPoint5;
  PVector rightPoint1, rightPoint2, rightPoint3, rightPoint4, rightPoint5;
  PVector botPoint1, botPoint2, botPoint3;
  PVector midPoint, destination;

  //Bool that etsablishes the where a minion spanws and resets it in the next round
  boolean pathCooldown;

  //floats that establishes statistically a new path for each round. Ever. :D
  float r;
  float laner;

  //Variables establishes chance
  float half = 0.50;
  float sixth = 0.17;
  //Location for direction
  float dirX, dirY;

  //bool that allows a process to only loop once
  boolean loop;

  //Bool that get new random values, decide spawn, and where the spawn is, as well as close lanes (example topleft spawn goes right instead of down)
  boolean getRandom = false;
  boolean decideSpawn = false;
  boolean spawnTLeft, spawnTRight, spawnBLeft, spawnBRight = false;
  boolean laneClosed;

  //Initiates a process and ends it
  boolean initiate, end;

  PathFinder() {
    loop = true;
    pathCooldown = true;

    //Four spawn points located at each corner
    spawnTL = new PVector(-480, -320);
    spawnTR = new PVector(2400, -320);
    spawnBL = new PVector(-480, 1400);
    spawnBR = new PVector(2400, 1400);
    //The six extremity intersections.
    inter1 = new PVector(226, -320);
    inter2 = new PVector(1700, -320);
    inter3 = new PVector(2400, 874);
    inter4 = new PVector(1300, 1400);
    inter5 = new PVector(626, 1400);
    inter6 = new PVector(-480, 874);
    //Pathing for the left side
    leftPoint1 = new PVector(226, 874);
    leftPoint2 = new PVector(226, 550);
    leftPoint3 = new PVector(50, 550);
    leftPoint4 = new PVector(50, 350);
    leftPoint5 = new PVector(225, 350);
    //Pathing for the right side
    rightPoint1 = new PVector(1700, 874);
    rightPoint2 = new PVector(1700, 552);
    rightPoint3 = new PVector(1875, 552);
    rightPoint4 = new PVector(1875, 350);
    rightPoint5 = new PVector(1700, 350);
    //Pathing for the bottom points
    botPoint1 = new PVector(626, 501);
    botPoint2 = new PVector(971, 501);
    botPoint3 = new PVector(1300, 501);
    //Last path before destination
    midPoint = new PVector(971, 350);
    //Final destination
    destination = new PVector(971, 154);

    laner = random(1);
  }

  //Managing function of all the functions within the pathFinder class
  void pathFinderManager() {
    //finds the spawn location
    locateSpawn();
    //Spawns the minions there
    spawnMinion();
    //Allows for fluid movement towards destination
    startRotation();

    //Enables the correct function according to spawn point
    if (spawnTLeft == true) {
      spawnTopLeft();
    }
    if (spawnTRight == true) {
      spawnTopRight();
    }
    if (spawnBLeft == true) {
      spawnBotLeft();
    }
    if (spawnBRight == true) {
      spawnBotRight();
    }
  }

  //Function that sets the spawn location of minions.
  void locateSpawn() {
    if (loop) {
      getRandom = true;
      getNewNumber(0);
      //println(r);
      if (r < 0.25) {
        spawnTLeft = true;
        spawnTRight = false;
        spawnBLeft = false;
        spawnBRight = false;

        getRandom = true;
        getNewNumber(0);
      } else if (r < 0.50) {
        spawnTLeft = false;
        spawnTRight = true;
        spawnBLeft = false;
        spawnBRight = false;

        getRandom = true;
        getNewNumber(0);
      } else if (r < 0.75) {
        spawnTLeft = false;
        spawnTRight = false;
        spawnBLeft = true;
        spawnBRight = false;

        getRandom = true;
        getNewNumber(0);
      } else if (r < 1) {
        spawnTLeft = false;
        spawnTRight = false;
        spawnBLeft = false;
        spawnBRight = true;

        getRandom = true;
        getNewNumber(0);
      }
      loop = false;
    }
  }

  /*The next four functions are decided by the previous function. Units are spawned, and by chance, choose a direction path
   checkpoints help dictate the direction and once a minion reaches a direction checkpoint, the next location is inserted until
   the unit reaches the final destination point*/
  void spawnTopLeft() {
    for (int i = 0; i < minionCount; i++) {
      if (spawnTLeft == true) {
        if (r < 0.5 && minion[i].checkPoint == 0) { 
          minion[i].newDirection(inter1);
          laneClosed = true;
        } else if (r < 1 && minion[i].checkPoint == 0) {
          minion[i].newDirection(inter6);
          laneClosed = false;
        }
      }
      // ==========> FIRST INTERSECTION<=========== //
      if (r < sixth && minion[i].checkPoint >= 1 && laneClosed == true) {      
        minion[i].newDirection(leftPoint5);
        if (minion[i].checkPoint >= 2 && laneClosed == true) {
          minion[i].newDirection(midPoint);
          if (minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(destination);
          }
        }
      } else if (minion[i].checkPoint >= 1 && laneClosed == true) {
        minion[i].newDirection(inter2);
        // ==========> SECOND INTERSECTION<=========== //
        if (r < sixth*2 && minion[i].checkPoint >= 2 && laneClosed == true) {
          minion[i].newDirection(rightPoint5);
          if (minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(midPoint);
            if (minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(destination);
            }
          }
        } else if (minion[i].checkPoint >= 2 && laneClosed == true) {
          minion[i].newDirection(spawnTR);
          if (minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(inter3);
            // ==========> THIRD INTERSECTION<=========== //
            if (r < sixth*3 && minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(rightPoint1);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(rightPoint2);
                if (minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(rightPoint3);
                  if (minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(rightPoint4);
                    if (minion[i].checkPoint >=8 && laneClosed == true) {
                      minion[i].newDirection(midPoint);
                      if (minion[i].checkPoint >=9 && laneClosed == true) {
                        minion[i].newDirection(destination);
                      }
                    }
                  }
                }
              }
            } else if (minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(spawnBR);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(inter4);
                // ==========> FOURTH INTERSECTION<=========== //
                if (r < sixth*4 && minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(botPoint3);
                  if (minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(botPoint2);
                    if (minion[i].checkPoint >= 8 && laneClosed == true) {
                      minion[i].newDirection(destination);
                    }
                  }
                } else if (minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(inter5); 
                  // ==========> FIFTH INTERSECTION<=========== //
                  if (r < sixth*5 && minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(botPoint1);
                    if (minion[i].checkPoint >= 8 && laneClosed == true) {
                      minion[i].newDirection(botPoint2);
                      if (minion[i].checkPoint >= 9 && laneClosed == true) {
                        minion[i].newDirection(destination);
                      }
                    }
                  } else if (minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(spawnBL); 
                    if (minion[i].checkPoint >= 8) {
                      minion[i].newDirection(inter6);
                      // ==========> SIXTH INTERSECTION<=========== //
                      if (minion[i].checkPoint >= 9 && laneClosed == true) {
                        minion[i].newDirection(leftPoint1);
                        if (minion[i].checkPoint >= 10 && laneClosed == true) {
                          minion[i].newDirection(leftPoint2);
                          if (minion[i].checkPoint >= 11 && laneClosed == true) {
                            minion[i].newDirection(leftPoint3);
                            if (minion[i].checkPoint >= 12 && laneClosed == true) {
                              minion[i].newDirection(leftPoint4);
                              if (minion[i].checkPoint >= 13 && laneClosed == true) {
                                minion[i].newDirection(midPoint); 
                                if (minion[i].checkPoint >= 14 && laneClosed == true) {
                                  minion[i].newDirection(destination);
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      // ==========> FIRST INTERSECTION<=========== //
      if (r < sixth && minion[i].checkPoint >= 1 && laneClosed == false) {
        minion[i].newDirection(leftPoint1);
        if (minion[i].checkPoint >= 2 && laneClosed == false) {
          minion[i].newDirection(leftPoint2);
          if (minion[i].checkPoint >= 3 && laneClosed == false) {
            minion[i].newDirection(leftPoint3);
            if (minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(leftPoint4);
              if (minion[i].checkPoint >= 5 && laneClosed == false) {
                minion[i].newDirection(midPoint); 
                if (minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(destination);
                }
              }
            }
          }
        }
      } else if (minion[i].checkPoint >= 1 && laneClosed == false) {
        minion[i].newDirection(spawnBL);
        if (minion[i].checkPoint >= 2 && laneClosed == false) {
          minion[i].newDirection(inter5);
          // ==========> SECOND INTERSECTION<=========== //
          if  (r < sixth*2 && minion[i].checkPoint >= 3 && laneClosed == false) {
            minion[i].newDirection(botPoint1);
            if (minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(botPoint2);
              if (minion[i].checkPoint >= 5 && laneClosed == false) {
                minion[i].newDirection(destination);
              }
            }
          } else if (minion[i].checkPoint >= 3 && laneClosed == false) {
            minion[i].newDirection(inter4);
            // ==========> THIRD INTERSECTION<=========== //
            if (r < sixth*3 && minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(botPoint3);
              if (minion[i].checkPoint >= 5 && laneClosed == false) {
                minion[i].newDirection(botPoint2);
                if (minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(destination);
                }
              }
            } else if (minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(spawnBR);
              if (minion[i].checkPoint >= 5 && laneClosed == false) {
                minion[i].newDirection(inter3);
                // ==========> FOURTH INTERSECTION<=========== //
                if (r < sixth*4 && minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(rightPoint1);
                  if (minion[i].checkPoint >= 7 && laneClosed == false) {
                    minion[i].newDirection(rightPoint2);
                    if (minion[i].checkPoint >= 8 && laneClosed == false) {
                      minion[i].newDirection(rightPoint3);
                      if (minion[i].checkPoint >= 9 && laneClosed == false) {
                        minion[i].newDirection(rightPoint4);
                        if (minion[i].checkPoint >= 10 && laneClosed == false) {
                          minion[i].newDirection(midPoint); 
                          if (minion[i].checkPoint >= 11) {
                            minion[i].newDirection(destination);
                          }
                        }
                      }
                    }
                  }
                } else if (minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(spawnTR);
                  if (minion[i].checkPoint >= 7 && laneClosed == false) {
                    minion[i].newDirection(inter2);
                    // ==========> FIFTH INTERSECTION<=========== //
                    if (r < sixth*5 && minion[i].checkPoint >= 8 && laneClosed == false) {
                      minion[i].newDirection(rightPoint5);
                      if (minion[i].checkPoint >= 9 && laneClosed == false) {
                        minion[i].newDirection(midPoint); 
                        if (minion[i].checkPoint >= 10 && laneClosed == false) {
                          minion[i].newDirection(destination);
                        }
                      }
                    } else if (minion[i].checkPoint >= 8 && laneClosed == false) {
                      minion[i].newDirection(inter1);
                      // ==========> SIXTH INTERSECTION<=========== //
                      if (minion[i].checkPoint >= 9 && laneClosed == false) {
                        minion[i].newDirection(leftPoint5);
                        if (minion[i].checkPoint >= 10 && laneClosed == false) {
                          minion[i].newDirection(midPoint);
                          if (minion[i].checkPoint >= 11 && laneClosed == false) {
                            minion[i].newDirection(destination);
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  void spawnTopRight() {
    for (int i = 0; i < minionCount; i++) {
      if (spawnTRight == true) {
        if (r < 0.5 && minion[i].checkPoint == 0) { 
          minion[i].newDirection(inter3);
          laneClosed = true;
        } else if (r < 1 && minion[i].checkPoint == 0) {
          minion[i].newDirection(inter2);
          laneClosed = false;
        }
      }
      // ==========> FIRST INTERSECTION<=========== //
      if (r < sixth && minion[i].checkPoint >= 1 && laneClosed == true) {      
        minion[i].newDirection(rightPoint1);
        if (minion[i].checkPoint >= 2 && laneClosed == true) {
          minion[i].newDirection(rightPoint2);
          if (minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(rightPoint3);
            if (minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(rightPoint4);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(midPoint);
                if (minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(destination);
                }
              }
            }
          }
        }
      } else if (minion[i].checkPoint >= 1 && laneClosed == true) {
        minion[i].newDirection(spawnBR);
        if (minion[i].checkPoint >= 2 && laneClosed == true) {
          minion[i].newDirection(inter4);
          // ==========> SECOND INTERSECTION<=========== //
          if (r < sixth*2 && minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(botPoint3);
            if (minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(botPoint2);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(destination);
              }
            }
          } else if (minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(inter5);
            // ==========> THIRD INTERSECTION<=========== //
            if (r < sixth*3 && minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(botPoint1);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(botPoint2);
                if (minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(destination);
                }
              }
            } else if (minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(spawnBL);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(inter6);
                // ==========> FOURTH INTERSECTION<=========== //
                if (r < sixth*4 && minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(leftPoint1);
                  if (minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(leftPoint2);
                    if (minion[i].checkPoint >= 8 && laneClosed == true) {
                      minion[i].newDirection(leftPoint3);
                      if (minion[i].checkPoint >= 9 && laneClosed == true) {
                        minion[i].newDirection(leftPoint4);
                        if (minion[i].checkPoint >= 10 && laneClosed == true) {
                          minion[i].newDirection(midPoint);
                          if (minion[i].checkPoint >= 11 && laneClosed == true) {
                            minion[i].newDirection(destination);
                          }
                        }
                      }
                    }
                  }
                } else if (minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(spawnTL);
                  if (minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(inter1);
                    // ==========> FIFTH INTERSECTION<=========== //
                    if (r < sixth*5 && minion[i].checkPoint >= 8 && laneClosed == true) {
                      minion[i].newDirection(leftPoint5);
                      if (minion[i].checkPoint >= 9 && laneClosed == true) {
                        minion[i].newDirection(midPoint);
                        if (minion[i].checkPoint >= 10 && laneClosed == true) {
                          minion[i].newDirection(destination);
                        }
                      }
                    } else if (minion[i].checkPoint >= 8 && laneClosed == true) {
                      minion[i].newDirection(inter2);
                      // ==========> SIXTH INTERSECTION<=========== //
                      if (minion[i].checkPoint >= 9 && laneClosed == true) {
                        minion[i].newDirection(rightPoint5);
                        if (minion[i].checkPoint >= 10 && laneClosed == true) {
                          minion[i].newDirection(midPoint);
                          if (minion[i].checkPoint >= 11 && laneClosed == true) {
                            minion[i].newDirection(destination);
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      // ==========> FIRST INTERSECTION<=========== //
      if (laner < sixth && minion[i].checkPoint >= 1 && laneClosed == false) {      
        minion[i].newDirection(rightPoint5);
        if (minion[i].checkPoint >= 2) {
          minion[i].newDirection(midPoint);
          if (minion[i].checkPoint >= 3) {
            minion[i].newDirection(destination);
          }
        }
      } else if (minion[i].checkPoint >= 1 && laneClosed == false) {
        minion[i].newDirection(inter1);
        // ==========> SECOND INTERSECTION<=========== //
        if (r < sixth*2 && minion[i].checkPoint >= 2 && laneClosed == false) {
          minion[i].newDirection(leftPoint5);
          if (minion[i].checkPoint >= 3) {
            minion[i].newDirection(midPoint);
            if (minion[i].checkPoint >= 4) {
              minion[i].newDirection(destination);
            }
          }
        } else if (minion[i].checkPoint >= 2 && laneClosed == false) {
          minion[i].newDirection(spawnTL);
          if (minion[i].checkPoint >= 3 && laneClosed == false) {
            minion[i].newDirection(inter6);
            // ==========> THIRD INTERSECTION<=========== //
            if (r < sixth*3 && minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(leftPoint1);
              if (minion[i].checkPoint >= 5) {
                minion[i].newDirection(leftPoint2);
                if (minion[i].checkPoint >= 6) {
                  minion[i].newDirection(leftPoint3);
                  if (minion[i].checkPoint >= 7) {
                    minion[i].newDirection(leftPoint4);
                    if (minion[i].checkPoint >=8) {
                      minion[i].newDirection(midPoint);
                      if (minion[i].checkPoint >=9) {
                        minion[i].newDirection(destination);
                      }
                    }
                  }
                }
              }
            } else if (minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(spawnBL);
              if (minion[i].checkPoint >= 5) {
                minion[i].newDirection(inter5);
                // ==========> FOURTH INTERSECTION<=========== //
                if (r < sixth*4 && minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(botPoint1);
                  if (minion[i].checkPoint >= 7) {
                    minion[i].newDirection(botPoint2);
                    if (minion[i].checkPoint >= 8) {
                      minion[i].newDirection(destination);
                    }
                  }
                } else if (minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(inter4); 
                  // ==========> FIFTH INTERSECTION<=========== //
                  if (r < sixth*5 && minion[i].checkPoint >= 7 && laneClosed == false) {
                    minion[i].newDirection(botPoint3);
                    if (minion[i].checkPoint >= 8) {
                      minion[i].newDirection(botPoint2);
                      if (minion[i].checkPoint >= 9) {
                        minion[i].newDirection(destination);
                      }
                    }
                  } else if (minion[i].checkPoint >= 7 && laneClosed == false) {
                    minion[i].newDirection(spawnBR); 
                    if (minion[i].checkPoint >= 8 && laneClosed == false) {
                      minion[i].newDirection(inter3);
                      // ==========> SIXTH INTERSECTION<=========== //
                      if (minion[i].checkPoint >= 9 && laneClosed == false) {
                        minion[i].newDirection(rightPoint1);
                        if (minion[i].checkPoint >= 10) {
                          minion[i].newDirection(rightPoint2);
                          if (minion[i].checkPoint >= 11) {
                            minion[i].newDirection(rightPoint3);
                            if (minion[i].checkPoint >= 12) {
                              minion[i].newDirection(rightPoint4);
                              if (minion[i].checkPoint >= 13) {
                                minion[i].newDirection(midPoint); 
                                if (minion[i].checkPoint >= 14) {
                                  minion[i].newDirection(destination);
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  void spawnBotLeft() {
    for (int i = 0; i < minionCount; i++) {
      if (spawnBLeft == true) {
        if (r < 0.5 && minion[i].checkPoint == 0) { 
          minion[i].newDirection(inter6);
          laneClosed = true;
        } else if (r < 1 && minion[i].checkPoint == 0) {
          minion[i].newDirection(inter5);
          laneClosed = false;
        }
      }
      // ==========> FIRST INTERSECTION<=========== //
      if (r < sixth && minion[i].checkPoint >= 1 && laneClosed == true) {      
        minion[i].newDirection(leftPoint1);
        if (minion[i].checkPoint >= 2 && laneClosed == true) {
          minion[i].newDirection(leftPoint2);
          if (minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(leftPoint3);
            if (minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(leftPoint4);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(midPoint);
                if (minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(destination);
                }
              }
            }
          }
        }
      } else if (minion[i].checkPoint >= 1 && laneClosed == true) {
        minion[i].newDirection(spawnTL);
        if (minion[i].checkPoint >= 2 && laneClosed == true) {
          minion[i].newDirection(inter1);
          // ==========> SECOND INTERSECTION<=========== //
          if (r < sixth*2 && minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(leftPoint5);
            if (minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(midPoint);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(destination);
              }
            }
          } else if (minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(inter2);
            // ==========> THIRD INTERSECTION<=========== //
            if (r < sixth*3 && minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(rightPoint5);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(midPoint);
                if (minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(destination);
                }
              }
            } else if (minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(spawnTR);
              if (minion[i].checkPoint >= 5 && laneClosed == true) {
                minion[i].newDirection(inter3);
                // ==========> FOURTH INTERSECTION<=========== //
                if (r < sixth*4 && minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(rightPoint1);
                  if (minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(rightPoint2);
                    if (minion[i].checkPoint >= 8 && laneClosed == true) {
                      minion[i].newDirection(rightPoint3);
                      if (minion[i].checkPoint >= 9 && laneClosed == true) {
                        minion[i].newDirection(rightPoint4);
                        if (minion[i].checkPoint >= 10 && laneClosed == true) {
                          minion[i].newDirection(midPoint);
                          if (minion[i].checkPoint >= 11 && laneClosed == true) {
                            minion[i].newDirection(destination);
                          }
                        }
                      }
                    }
                  }
                } else if (minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(spawnBR);
                  if (minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(inter4);
                    // ==========> FIFTH INTERSECTION<=========== //
                    if (r < sixth*5 && minion[i].checkPoint >= 8 && laneClosed == true) {
                      minion[i].newDirection(botPoint3);
                      if (minion[i].checkPoint >= 9 && laneClosed == true) {
                        minion[i].newDirection(botPoint2);
                        if (minion[i].checkPoint >= 10 && laneClosed == true) {
                          minion[i].newDirection(destination);
                        }
                      }
                    } else if (minion[i].checkPoint >= 8 && laneClosed == true) {
                      minion[i].newDirection(inter5);
                      // ==========> SIXTH INTERSECTION<=========== //
                      if (minion[i].checkPoint >= 9 && laneClosed == true) {
                        minion[i].newDirection(botPoint1);
                        if (minion[i].checkPoint >= 10 && laneClosed == true) {
                          minion[i].newDirection(botPoint2);
                          if (minion[i].checkPoint >= 11 && laneClosed == true) {
                            minion[i].newDirection(destination);
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      // ==========> FIRST INTERSECTION<=========== //
      if (laner < sixth && minion[i].checkPoint >= 1 && laneClosed == false) {      
        minion[i].newDirection(botPoint1);
        if (minion[i].checkPoint >= 2) {
          minion[i].newDirection(botPoint2);
          if (minion[i].checkPoint >= 3) {
            minion[i].newDirection(destination);
          }
        }
      } else if (minion[i].checkPoint >= 1 && laneClosed == false) {
        minion[i].newDirection(inter4);
        // ==========> SECOND INTERSECTION<=========== //
        if (r < sixth*2 && minion[i].checkPoint >= 2 && laneClosed == false) {
          minion[i].newDirection(botPoint3);
          if (minion[i].checkPoint >= 3) {
            minion[i].newDirection(botPoint2);
            if (minion[i].checkPoint >= 4) {
              minion[i].newDirection(destination);
            }
          }
        } else if (minion[i].checkPoint >= 2 && laneClosed == false) {
          minion[i].newDirection(spawnBR);
          if (minion[i].checkPoint >= 3 && laneClosed == false) {
            minion[i].newDirection(inter3);
            // ==========> THIRD INTERSECTION<=========== //
            if (r < sixth*3 && minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(rightPoint1);
              if (minion[i].checkPoint >= 5) {
                minion[i].newDirection(rightPoint2);
                if (minion[i].checkPoint >= 6) {
                  minion[i].newDirection(rightPoint3);
                  if (minion[i].checkPoint >= 7) {
                    minion[i].newDirection(rightPoint4);
                    if (minion[i].checkPoint >=8) {
                      minion[i].newDirection(midPoint);
                      if (minion[i].checkPoint >=9) {
                        minion[i].newDirection(destination);
                      }
                    }
                  }
                }
              }
            } else if (minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(spawnTR);
              if (minion[i].checkPoint >= 5) {
                minion[i].newDirection(inter2);
                // ==========> FOURTH INTERSECTION<=========== //
                if (r < sixth*4 && minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(rightPoint5);
                  if (minion[i].checkPoint >= 7) {
                    minion[i].newDirection(midPoint);
                    if (minion[i].checkPoint >= 8) {
                      minion[i].newDirection(destination);
                    }
                  }
                } else if (minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(inter1); 
                  // ==========> FIFTH INTERSECTION<=========== //
                  if (r < sixth*5 && minion[i].checkPoint >= 7 && laneClosed == false) {
                    minion[i].newDirection(leftPoint5);
                    if (minion[i].checkPoint >= 8) {
                      minion[i].newDirection(midPoint);
                      if (minion[i].checkPoint >= 9) {
                        minion[i].newDirection(destination);
                      }
                    }
                  } else if (minion[i].checkPoint >= 7 && laneClosed == false) {
                    minion[i].newDirection(spawnTL); 
                    if (minion[i].checkPoint >= 8 && laneClosed == false) {
                      minion[i].newDirection(inter6);
                      // ==========> SIXTH INTERSECTION<=========== //
                      if (minion[i].checkPoint >= 9 && laneClosed == false) {
                        minion[i].newDirection(leftPoint1);
                        if (minion[i].checkPoint >= 10) {
                          minion[i].newDirection(leftPoint2);
                          if (minion[i].checkPoint >= 11) {
                            minion[i].newDirection(leftPoint3);
                            if (minion[i].checkPoint >= 12) {
                              minion[i].newDirection(leftPoint4);
                              if (minion[i].checkPoint >= 13) {
                                minion[i].newDirection(midPoint); 
                                if (minion[i].checkPoint >= 14) {
                                  minion[i].newDirection(destination);
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  void spawnBotRight() {
    for (int i = 0; i < minionCount; i++) {
      if (spawnBRight == true) {
        if (r < 0.5 && minion[i].checkPoint == 0) { 
          minion[i].newDirection(inter4);
          laneClosed = true;
        } else if (r < 1 && minion[i].checkPoint == 0) {
          minion[i].newDirection(inter3);
          laneClosed = false;
        }
      }
      // ==========> FIRST INTERSECTION<=========== //
      if (laner < sixth && minion[i].checkPoint >= 1 && laneClosed == true) {      
        minion[i].newDirection(botPoint3);
        if (minion[i].checkPoint >= 2) {
          minion[i].newDirection(botPoint2);
          if (minion[i].checkPoint >= 3) {
            minion[i].newDirection(destination);
          }
        }
      } else if (minion[i].checkPoint >= 1 && laneClosed == true) {
        minion[i].newDirection(inter5);
        // ==========> SECOND INTERSECTION<=========== //
        if (r < sixth*2 && minion[i].checkPoint >= 2 && laneClosed == true) {
          minion[i].newDirection(botPoint1);
          if (minion[i].checkPoint >= 3) {
            minion[i].newDirection(botPoint2);
            if (minion[i].checkPoint >= 4) {
              minion[i].newDirection(destination);
            }
          }
        } else if (minion[i].checkPoint >= 2 && laneClosed == true) {
          minion[i].newDirection(spawnBL);
          if (minion[i].checkPoint >= 3 && laneClosed == true) {
            minion[i].newDirection(inter6);
            // ==========> THIRD INTERSECTION<=========== //
            if (r < sixth*3 && minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(leftPoint1);
              if (minion[i].checkPoint >= 5) {
                minion[i].newDirection(leftPoint2);
                if (minion[i].checkPoint >= 6) {
                  minion[i].newDirection(leftPoint3);
                  if (minion[i].checkPoint >= 7) {
                    minion[i].newDirection(leftPoint4);
                    if (minion[i].checkPoint >=8) {
                      minion[i].newDirection(midPoint);
                      if (minion[i].checkPoint >=9) {
                        minion[i].newDirection(destination);
                      }
                    }
                  }
                }
              }
            } else if (minion[i].checkPoint >= 4 && laneClosed == true) {
              minion[i].newDirection(spawnTL);
              if (minion[i].checkPoint >= 5) {
                minion[i].newDirection(inter1);
                // ==========> FOURTH INTERSECTION<=========== //
                if (r < sixth*4 && minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(leftPoint5);
                  if (minion[i].checkPoint >= 7) {
                    minion[i].newDirection(midPoint);
                    if (minion[i].checkPoint >= 8) {
                      minion[i].newDirection(destination);
                    }
                  }
                } else if (minion[i].checkPoint >= 6 && laneClosed == true) {
                  minion[i].newDirection(inter2); 
                  // ==========> FIFTH INTERSECTION<=========== //
                  if (r < sixth*5 && minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(rightPoint5);
                    if (minion[i].checkPoint >= 8) {
                      minion[i].newDirection(midPoint);
                      if (minion[i].checkPoint >= 9) {
                        minion[i].newDirection(destination);
                      }
                    }
                  } else if (minion[i].checkPoint >= 7 && laneClosed == true) {
                    minion[i].newDirection(spawnTR); 
                    if (minion[i].checkPoint >= 8) {
                      minion[i].newDirection(inter3);
                      // ==========> SIXTH INTERSECTION<=========== //
                      if (minion[i].checkPoint >= 9 && laneClosed == true) {
                        minion[i].newDirection(rightPoint1);
                        if (minion[i].checkPoint >= 10) {
                          minion[i].newDirection(rightPoint2);
                          if (minion[i].checkPoint >= 11) {
                            minion[i].newDirection(rightPoint3);
                            if (minion[i].checkPoint >= 12) {
                              minion[i].newDirection(rightPoint4);
                              if (minion[i].checkPoint >= 13) {
                                minion[i].newDirection(midPoint); 
                                if (minion[i].checkPoint >= 14) {
                                  minion[i].newDirection(destination);
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      // ==========> FIRST INTERSECTION<=========== //
      if (r < sixth && minion[i].checkPoint >= 1 && laneClosed == false) {
        minion[i].newDirection(rightPoint1);
        if (minion[i].checkPoint >= 2) {
          minion[i].newDirection(rightPoint2);
          if (minion[i].checkPoint >= 3) {
            minion[i].newDirection(rightPoint3);
            if (minion[i].checkPoint >= 4) {
              minion[i].newDirection(rightPoint4);
              if (minion[i].checkPoint >= 5) {
                minion[i].newDirection(midPoint); 
                if (minion[i].checkPoint >= 6) {
                  minion[i].newDirection(destination);
                }
              }
            }
          }
        }
      } else if (minion[i].checkPoint >= 1 && laneClosed == false) {
        minion[i].newDirection(spawnTR);
        if (minion[i].checkPoint >= 2 && laneClosed == false) {
          minion[i].newDirection(inter2);
          // ==========> SECOND INTERSECTION<=========== //
          if  (r < sixth*2 && minion[i].checkPoint >= 3 && laneClosed == false) {
            minion[i].newDirection(rightPoint5);
            if (minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(midPoint);
              if (minion[i].checkPoint >= 5 && laneClosed == false) {
                minion[i].newDirection(destination);
              }
            }
          } else if (minion[i].checkPoint >= 3 && laneClosed == false) {
            minion[i].newDirection(inter1);
            // ==========> THIRD INTERSECTION<=========== //
            if (r < sixth*3 && minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(leftPoint5);
              if (minion[i].checkPoint >= 5 && laneClosed == false) {
                minion[i].newDirection(midPoint);
                if (minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(destination);
                }
              }
            } else if (minion[i].checkPoint >= 4 && laneClosed == false) {
              minion[i].newDirection(spawnTL);
              if (minion[i].checkPoint >= 5 && laneClosed == false) {
                minion[i].newDirection(inter6);
                // ==========> FOURTH INTERSECTION<=========== //
                if (r < sixth*4 && minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(leftPoint1);
                  if (minion[i].checkPoint >= 7) {
                    minion[i].newDirection(leftPoint2);
                    if (minion[i].checkPoint >= 8) {
                      minion[i].newDirection(leftPoint3);
                      if (minion[i].checkPoint >= 9) {
                        minion[i].newDirection(leftPoint4);
                        if (minion[i].checkPoint >= 10) {
                          minion[i].newDirection(midPoint); 
                          if (minion[i].checkPoint >= 11) {
                            minion[i].newDirection(destination);
                          }
                        }
                      }
                    }
                  }
                } else if (minion[i].checkPoint >= 6 && laneClosed == false) {
                  minion[i].newDirection(spawnBL);
                  if (minion[i].checkPoint >= 7 && laneClosed == false) {
                    minion[i].newDirection(inter5);
                    // ==========> FIFTH INTERSECTION<=========== //
                    if (r < sixth*5 && minion[i].checkPoint >= 8 && laneClosed == false) {
                      minion[i].newDirection(botPoint1);
                      if (minion[i].checkPoint >= 9 && laneClosed == false) {
                        minion[i].newDirection(botPoint2); 
                        if (minion[i].checkPoint >= 10 && laneClosed == false) {
                          minion[i].newDirection(destination);
                        }
                      }
                    } else if (minion[i].checkPoint >= 8 && laneClosed == false) {
                      minion[i].newDirection(inter4);
                      // ==========> SIXTH INTERSECTION<=========== //
                      if (minion[i].checkPoint >= 9 && laneClosed == false) {
                        minion[i].newDirection(botPoint3);
                        if (minion[i].checkPoint >= 10 && laneClosed == false) {
                          minion[i].newDirection(botPoint2);
                          if (minion[i].checkPoint >= 11 && laneClosed == false) {
                            minion[i].newDirection(destination);
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  //function that gets a random number once
  void getNewNumber(float i) {
    r = random(1) - i; 
    getRandom = false;
  }

  //Begins the rotation on a minion when they've come sufficiently close a destination and add to the checkoint
  void startRotation() {
    for (int i = 0; i < minionCount; i++) {
      minion[i].distanceLeft = dist(minion[i].location.x, minion[i].location.y, minion[i].destination.x, minion[i].destination.y);
      if (minion[i].distanceLeft <= 20) {
        minion[i].checkPoint += 1;
      } else {
        minion[i].checkPoint += 0;
      }
    }
  }

  //Sets the spawn point of a minion 
  void spawnMinion() {
    for (int i = 0; i < minionCount; i++) {
      if (spawnTLeft == true) {
        if (pathCooldown == true) {
          minion[i].location.x = pathFinder.spawnTL.x;
          minion[i].location.y = pathFinder.spawnTL.y;
          if (i == minionCount-1) {
            pathCooldown = false;
          }
          /* println("Top Left: " + spawnTLeft);
           println(pathCooldown);
           println(minion[0].location.x, minion[0].location.y);*/
        }
      }
    }
    for (int i = 0; i < minionCount; i++) {
      if (spawnTRight == true) {
        if (pathCooldown == true) {
          minion[i].location.x = pathFinder.spawnTR.x;
          minion[i].location.y = pathFinder.spawnTR.y;
          if (i == minionCount-1) {
            pathCooldown = false;
          }
          /*println("Top Right: " + spawnTRight);
           println(pathCooldown);
           println(minion[0].location.x, minion[0].location.y);*/
        }
      }
    }
    for (int i = 0; i < minionCount; i++) {
      if (spawnBLeft == true) {
        if (pathCooldown == true) {
          minion[i].location.x = pathFinder.spawnBL.x;
          minion[i].location.y = pathFinder.spawnBL.y;
          if (i == minionCount-1) {
            pathCooldown = false;
          }
          /*println("bottom Left: " + spawnBLeft);
           println(pathCooldown);
           println(minion[0].location.x, minion[0].location.y);*/
        }
      }
    }
    for (int i = 0; i < minionCount; i++) {
      if (spawnBRight == true) {
        if (pathCooldown == true) {
          minion[i].location.x = pathFinder.spawnBR.x;
          minion[i].location.y = pathFinder.spawnBR.y;
          if (i == minionCount-1) {
            pathCooldown = false;
          }
          /*println("bottom Right: " + spawnBRight);
           println(pathCooldown);
           println(minion[0].location.x, minion[0].location.y);*/
        }
      }
    }
  }
}