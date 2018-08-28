class Enemy1 {
  PVector position, velocity;
  float health, damage;
  int id;
  float speed;
  int diff = 0;
  boolean finished = false;

  float attackDistance = 500;

  boolean isAlive = true;

  Enemy1 () {
    health = 100;
    damage = random(0.2, 0.5);
    speed = 1.5;
    position = new PVector();
    velocity = new PVector();
    position.x = random(0, 1200);
    position.y = random(0, 1200);
    velocity.x = random(-speed, speed);
    velocity.y = random(-speed, speed);
  }

  void move() {
    float distance = sqrt((position.x - thePlayer.position.x) * (position.x - thePlayer.position.x) + (position.y - thePlayer.position.y) * (position.y - thePlayer.position.y));
    if (distance > attackDistance) {
      if (position.x > theWorld.GRID_UNITS_WIDE * theWorld.GRID_UNIT_SIZE || position.x < 0) {
        velocity.x *= -1;
      }
      if (position.y > theWorld.GRID_UNITS_HIGH * theWorld.GRID_UNIT_SIZE || position.y < 0) {
        velocity.y *= -1;
      }
      position.add(velocity);
    } 
    else {
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

    /*
    else {
     if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x > thePlayer.position.x + right_stand.width / 2 + robot.width / 2 && position.y > thePlayer.position.y)) {
     velocity.x = -speed;
     velocity.y = -speed;
     }
     
     if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x < thePlayer.position.x - right_stand.width / 2 - robot.width / 2 && position.y < thePlayer.position.y)) {
     velocity.x = speed;
     velocity.y = speed;
     }
     
     if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x < thePlayer.position.x - right_stand.width / 2 - robot.width / 2 && position.y > thePlayer.position.y)) {
     velocity.x = speed;
     velocity.y = - speed;
     }
     
     if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x > thePlayer.position.x + right_stand.width / 2 + robot.width / 2 && position.y < thePlayer.position.y)) {
     velocity.x = -speed;
     velocity.y = speed;
     }
     
     if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x > thePlayer.position.x && position.y > thePlayer.position.y + right_stand.height / 2 + robot.height / 2)) {
     velocity.x = -speed;
     velocity.y = -speed;
     }
     
     if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x < thePlayer.position.x && position.y > thePlayer.position.y + right_stand.height / 2 + robot.height / 2)) {
     velocity.x = speed;
     velocity.y = -speed;
     }
     
     if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x < thePlayer.position.x && position.y < thePlayer.position.y - right_stand.height / 2 - robot.height / 2)) {
     velocity.x = speed;
     velocity.y = speed;
     }
     
     if ((position.x != thePlayer.position.x || position.y != thePlayer.position.y) && (position.x > thePlayer.position.x && position.y < thePlayer.position.y - right_stand.height / 2 - robot.height / 2)) {
     velocity.x = -speed;
     velocity.y = speed;
     }
     }
     position.add(velocity);
     
     
     
     if (abs(position.x - thePlayer.position.x) < right_stand.width / 2 + robot.width / 2
     && abs(position.y - thePlayer.position.y) < right_stand.height / 2 + robot.height / 2) {
     velocity.x = 0;
     velocity.y = 0;
     }*/
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
    int robotWidth = robot.width;
    int robotHeight = robot.height;
    if (aliveCheck()) {
      pushMatrix();

      translate(-robotWidth / 2, -robotHeight / 2);
      image(robot, position.x, position.y);
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

