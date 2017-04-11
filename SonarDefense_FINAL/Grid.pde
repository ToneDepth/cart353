class Grid {
  PVector location;
  PVector tempLocation;
  PVector size;

  boolean gridSelect;
  boolean gridUsed = false;

  int opacity;

  Grid(int posX, int posY) {
    location = new PVector(posX, posY);
    tempLocation = new PVector(100, 100);
    size = new PVector (25, 25);
  }

  void display() {
    //Displays the grid if a tower is about to be built
    if (towerBuild == true) {
      opacity = 20;
    } else {
      opacity = 0;
    }

    //Sets strokeWeight, strokeColor and opacity, the rectMode to CORNEr and displays the grid.
    strokeWeight(1);
    stroke(0, opacity);
    rectMode(CORNER);
    rect(location.x, location.y, size.x, size.y);
  }

  void gridSelect() {
    //Condition that stores the selected grids location as a temporary value for tower placement use.
    if (mouseX > location.x && mouseX < location.x + size.x && mouseY > location.y && mouseY < location.y + size.y && towerBuild) {
      //Sets the fill to green showing that the space is usable.
      fill(10, 200, 25, 100);
      tempLocation.x = location.x;
      tempLocation.y = location.y;
      //Sets the space as unusable for further towers.
      gridSelect = true;
    } else {
      //Gets rid of the colorValue to show that no tower is about to be built.
      noFill();
      gridSelect = false;
    }
    //Condition that fills the selected grid with red to show that it is unusable
    if (mouseX > location.x && mouseX < location.x + size.x && mouseY > location.y && mouseY < location.y + size.y && gridUsed == true && towerBuild) {
      fill(200, 10, 25, 100);
    }
  }
}