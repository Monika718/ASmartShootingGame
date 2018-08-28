class Heart {
  PVector position;
  Boolean isEaten;
  Boolean isBorn;
  int id;
  int heartValue = 20;
  int timer;

  Heart(int heart_id, float x, float y) {
    isEaten = false;
    isBorn = false;
    position = new PVector();
    position.x = x;
    position.y = y;
    id = heart_id;
  }

  void draw() {
    int heartWidth = heart.width;
    int heartHeight = heart.height;

    if (position.x <= 30) {
      position.x += 100;
    }
    if (position.y <= 30) {
      position.y += 100;
    }
    if (position.x >= (theWorld.GRID_UNITS_WIDE * theWorld.GRID_UNIT_SIZE - 30)) {
      position.x -= 100;
    }
    if (position.y >= (theWorld.GRID_UNITS_HIGH * theWorld.GRID_UNIT_SIZE - 30)) {
      position.y -= 100;
    }
    pushMatrix();

    translate(-heartWidth / 2, -heartHeight / 2);
    image(heart, position.x, position.y);
    popMatrix();
  }

  void eatCheck() {
    //  float heartWidth = width / 2;
    //  float playerHeight = right_stand.height / 2;

    float distance;
    distance = sqrt(((position.x + 20) - thePlayer.position.x) * ((position.x + 20) - thePlayer.position.x) + ((position.y + 20) - thePlayer.position.y) * ((position.y + 20) - thePlayer.position.y));

    if (distance <= 30 && isBorn == true && isEaten == false) {
      isEaten = true; 
      isBorn = false;
      thePlayer.health += heartValue;
    }
  }

  void bornCheck(int i) {
    timer = (millis() / 1000);
    if ( timer % (i + 2) == 0) {
      isBorn = true;
    }
  }
}

