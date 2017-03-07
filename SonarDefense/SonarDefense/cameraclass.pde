//Enables the camera
class Camera {
  //Location of the camera
  PVector pos;

  Camera() {
    //Sets pos
    pos = new PVector(0, 0);
  }

  //Move camera around using wasd
  void display() {
    if (keyPressed) {
      if (key == 'w') pos.y -= 5;
      if (key == 's') pos.y += 5;
      if (key == 'a') pos.x -= 5;
      if (key == 'd') pos.x += 5;
    }
  }
}