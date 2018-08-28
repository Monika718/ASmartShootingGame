class Enemy4 {
  PVector position, velocity;
  float health, damage;
  int id;
  float speed;
  int diff = 0;
  boolean finished = false;

  float attackDistance = 500;

  int shieldCount = 0;
  boolean shield = false;
  boolean isAlive = true;

  Enemy4 () {
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

    /*if (abs(position.x - thePlayer.position.x) < right_stand.width / 2 + robot.width / 2
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
    int robot4Width = robot4.width;
    int robot4Height = robot4.height;
    if (aliveCheck()) {
      pushMatrix();
      
      int timer = (millis() / 1000);
      if (timer % 2 == 0 && timer % 11 == 0) {
        shield = true;
      }

      if (shield == true) {
        noStroke();
        fill(255, 255, 255, 80);
        ellipse(position.x, position.y, 100, 100);
      }

      translate(-robot4Width / 2, -robot4Height / 2);
      image(robot4, position.x, position.y);
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

