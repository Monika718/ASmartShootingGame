class Boss {
  PVector position, velocity;
  float health, damage;
  float speed;
  boolean finished = false;
  boolean teleport = false;
  boolean shield = false;

  float attackDistance = 700;
  int shieldCount = 0;

  boolean isAlive = true;

  int timer = millis() / 1000;
  int gamble = 0;

  Boss () {
    health = 100;
    damage = 0.8;
    speed = 1;
    position = new PVector();
    velocity = new PVector();
    position.x = random(0, 1200);
    position.y = random(0, 1200);
  }

  void move() {
    if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x > thePlayer.position.x + right_stand.width / 2 + robot.width / 2 && position.y > thePlayer.position.y)) {
      position.x = position.x - speed;
      position.y = position.y -speed;
    }

    if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x < thePlayer.position.x - right_stand.width / 2 - robot.width / 2 && position.y < thePlayer.position.y)) {
      position.x = position.x + speed;
      position.y = position.y + speed;
    }

    if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x < thePlayer.position.x - right_stand.width / 2 - robot.width / 2 && position.y > thePlayer.position.y)) {
      position.x = position.x + speed;
      position.y = position.y - speed;
    }

    if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x > thePlayer.position.x + right_stand.width / 2 + robot.width / 2 && position.y < thePlayer.position.y)) {
      position.x = position.x - speed;
      position.y = position.y + speed;
    }

    if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x > thePlayer.position.x && position.y > thePlayer.position.y + right_stand.height / 2 + robot.height / 2)) {
      position.x = position.x - speed;
      position.y = position.y - speed;
    }

    if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x < thePlayer.position.x && position.y > thePlayer.position.y + right_stand.height / 2 + robot.height / 2)) {
      position.x = position.x + speed;
      position.y = position.y - speed;
    }

    if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x < thePlayer.position.x && position.y < thePlayer.position.y - right_stand.height / 2 - robot.height / 2)) {
      position.x = position.x + speed;
      position.y = position.y + speed;
    }

    if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x > thePlayer.position.x && position.y < thePlayer.position.y - right_stand.height / 2 - robot.height / 2)) {
      position.x = position.x - speed;
      position.y = position.y + speed;
    }

    if (teleport == true) {
      teleport = false;
      int gamble = (int)random(0, 5);
      switch(gamble) {
      case 1: 
        position.x += 200; 
        break;
      case 2: 
        position.x -= 200; 
        break;
      case 3: 
        position.y += 200; 
        break;
      case 4: 
        position.y -= 200; 
        break;
      }
    }
  }

  void attack() {
    float distance = sqrt((position.x - thePlayer.position.x) * (position.x - thePlayer.position.x) + (position.y - thePlayer.position.y) * (position.y - thePlayer.position.y));
    if (distance <= attackDistance) {
      stroke(0, 0, 255);
      line(position.x, position.y, thePlayer.position.x, thePlayer.position.y);
      thePlayer.health -= damage * (attackDistance - distance) / attackDistance;
    }
/*
    int i = (int)random(1, 10);

    if (timer % i == 0) {
      for (int j = 0; j < num_bomb; j++) {
        theBomb[40][j].eatCheck(); 
        theBomb[40][j].bornCheck(i);
        if (theBomb[40][j].isBorn == true && theBomb[40][j].isEaten == false) {
          theBomb[40][j].draw(position.x, position.y);
        }
      }
    }*/
  }

  void draw() {
    int bossWidth = boss.width;
    int bossHeight = boss.height;
    if (aliveCheck()) {
      pushMatrix();

      int timer = (millis() / 1000);
      int i = (int)random(1, 10);
      if (timer % (i + 3) == 0) {
        shield = true;
      }

      if (shield == true) {
        noStroke();
        fill(255, 255, 255, 80);
        ellipse(position.x, position.y, 150, 150);
      }

      translate(-bossWidth / 2, -bossHeight / 2);
      image(boss, position.x, position.y);
      move();
      popMatrix();

      textSize(15);
      fill(0);
      textAlign(CENTER);
      text((int)health, position.x, position.y - 30);
    }
  }

  boolean aliveCheck() {
    if (health <= 0) {
      return false;
    } 
    else 
      return true;
  }
}

