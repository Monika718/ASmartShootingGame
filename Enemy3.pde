class Enemy3 {
  PVector position, velocity;
  float health, damage;
  int id;
  float speed;
  int diff = 0;
  boolean finished = false;
  boolean teleport = false;

  float attackDistance = 500;

  boolean isAlive = true;

  Enemy3 () {
    health = 100;
    damage = random(0.7, 1);
    speed = random(0.5, 1);
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

  void attack()
  {
    float distance = sqrt((position.x - thePlayer.position.x) * (position.x - thePlayer.position.x) + (position.y - thePlayer.position.y) * (position.y - thePlayer.position.y));
    if (distance <= attackDistance) {
      stroke(0, 0, 255);
      line(position.x, position.y, thePlayer.position.x, thePlayer.position.y);
      thePlayer.health -= damage * (attackDistance - distance) / attackDistance;
    }
  }

  void draw() {
    int robot3Width = robot3.width;
    int robot3Height = robot3.height;
    if (aliveCheck()) {
      pushMatrix();

      translate(-robot3Width / 2, -robot3Height / 2);
      image(robot3, position.x, position.y);
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

