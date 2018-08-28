class Enemy2 {
  PVector position, velocity;
  float health, damage;
  int id;
  float speed;
  int diff = 0;
  boolean finished = false;
  int timer;

  float attackDistance = 500;

  boolean isAlive = true;

  Enemy2 () {
    health = 100;
    damage = random(0.5, 0.7);
    speed = random(0.5, 0.7);
    position = new PVector();
    velocity = new PVector();
    position.x = random(0, 1200) + cameraOffsetX;
    position.y = random(0, 1200) + cameraOffsetY;
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
    int robot2Width = robot2.width;
    int robot2Height = robot2.height;
    if (aliveCheck()) {
      pushMatrix();

      translate(-robot2Width / 2, -robot2Height / 2);
      image(robot2, position.x, position.y);
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

