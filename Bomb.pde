class Bomb {
  PVector position;
  Boolean isEaten;
  Boolean isBorn;
  int id;
  int damage = 5;
  int timer;

  Bomb() {
    isEaten = false;
    isBorn = false;
    position = new PVector();
  }

  void draw(float x, float y) {
    int bombWidth = bomb.width;
    int bombHeight = bomb.height;

    position.x = x;
    position.y = y;

    pushMatrix();
    translate(-bombWidth / 2, -bombHeight / 2);
    image(bomb, position.x, position.y);
    popMatrix();
  }

  void eatCheck() {
    float distance;
    distance = sqrt(((position.x + 15) - thePlayer.position.x) * ((position.x + 15) - thePlayer.position.x) + ((position.y + 15) - thePlayer.position.y) * ((position.y + 15) - thePlayer.position.y));

    if (distance <= 30 && isBorn == true && isEaten == false) {
      isEaten = true; 
      isBorn = false;
      thePlayer.health -= damage;
    }
  }
  
  void bornCheck(int i) {
    timer = (millis() / 1000);
    if ( timer % (i + 1) == 0 && timer % (i + 3) == 0) {
      isBorn = true;
    }
  }
}

