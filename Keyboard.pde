class Keyboard {
  Boolean holdingUp, holdingDown, holdingLeft, holdingRight, holdingSpace;

  Keyboard() {
    holdingUp = holdingDown = holdingLeft = holdingRight = holdingSpace = false;
  }

  void pressKey(int key, int keyCode) {
    if (key == 'w') {
      holdingUp = true;
      //println("UP");
    }
    if (key == 's') {
      holdingDown = true;
      //println("DOWN");
    }
    if (key == 'a') {
      holdingLeft = true;
      //println("LEFT");
    }
    if (key == 'd') {
      holdingRight = true;
      // println("RIGHT");
    }
  }

  void releaseKey(int key, int keyCode) {
    if (key == 'w') {
      holdingUp = false;
    }
    if (key == 's') {
      holdingDown = false;
    }
    if (key == 'a') {
      holdingLeft = false;
    }
    if (key == 'd') {
      holdingRight = false;
    }
  }
}

