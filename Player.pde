class Player {
  PVector position, velocity;

  float speed = 8.0;
  Boolean facingRight, facingDown, mouse;
  float TRIVIAL_SPEED = 1.0;

  int score = 0;

  int AIM = 20;
  int FAIL = 50;
  int MISS = 20;
  int PO = 20;
  int COLLID = 20;

  float health = 80;
  float damage = 20;

  int gamble = 0;

  Boolean isDead = false;

  float shootDistance = 700;

  //Detect the performance of the player
  int aniFrame = 0;  
  int missCount = 0;
  int aimCount = 0;
  int collidCount = 0;
  int pointCount = 0;

  int isAimed= 0;  //if 0, the player doesn't aim it; if 1, the player misses it but close to the target; if 2, the player aims it.


  Player() {
    position = new PVector();
    velocity = new PVector();
    position.x = 900 / 2;
    position.y = 600 / 2;
    reset();
  }

  void reset() {
    velocity.x = 0;
    velocity.y = 0;

    mouse = false;
    facingRight = true;
    facingDown = true;
    aniFrame = 0;  
    missCount = 0;
    aimCount = 0;
    collidCount = 0;
    pointCount = 0;
    isAimed= 0; 
    health += 20;
  }

  void inputCheck() {
    if (theKeyboard.holdingLeft) {
      velocity.x = -speed;
    } 
    else {
      if (theKeyboard.holdingRight) {
        velocity.x = speed;
      } 
      else {
        if (theKeyboard.holdingUp) {
          velocity.y = -speed;
        } 
        else {
          if (theKeyboard.holdingDown) {
            velocity.y = speed;
          }
        }
      }
    }

    if (position.x < 0) {
      position.x = 0;
    }
    if (position.y < 0) {
      position.y = 0;
    }
    if (position.x > (theWorld.GRID_UNITS_WIDE * theWorld.GRID_UNIT_SIZE - 30)) {
      position.x = theWorld.GRID_UNITS_WIDE * theWorld.GRID_UNIT_SIZE - 30;
    }
    if (position.y > (theWorld.GRID_UNITS_HIGH * theWorld.GRID_UNIT_SIZE - 30)) {
      position.y = theWorld.GRID_UNITS_HIGH * theWorld.GRID_UNIT_SIZE - 30;
    }


    for (int i = 0; i < num_enemy; i++) {
      if (abs(position.x - theEnemy1[i].position.x) < right_stand.width / 2 + robot.width / 2
        && abs(position.y - theEnemy1[i].position.y) < right_stand.height / 2 + robot.height / 2) {
        //position.x = theEnemy1[i].position.x - right_stand.width / 2 + robot.width / 2;
        //position.y = theEnemy1[i].position.y - right_stand.height / 2 + robot.height / 2;
        //health -= 10;
      }
    }

    velocity.x *= 0.9;
    velocity.y *= 0.9;
  } 

  void move() {
    position.add(velocity);
  }

  void draw() {
    int playerWidth = right_stand.width;
    int playerHeight = right_stand.height;

    if (velocity.x < -TRIVIAL_SPEED) {
      facingRight = false;
    } 
    else if (velocity.x > TRIVIAL_SPEED) {
      facingRight = true;
    }

    if (velocity.y < -TRIVIAL_SPEED) {
      facingDown = false;
    } 
    else if (velocity.y > TRIVIAL_SPEED) {
      facingDown = true;
    }


    pushMatrix();

    translate(-playerWidth / 2, -playerHeight / 2);

    if (theKeyboard.holdingUp) {
      image(back_stand, position.x, position.y);
    } 
    else {
      if (theKeyboard.holdingLeft) {
        image(left_stand, position.x, position.y);
      } 
      else {
        if (theKeyboard.holdingRight) {
          image(right_stand, position.x, position.y);
        } 
        else {
          image(front_stand, position.x, position.y);
        }
      }
    }

    popMatrix();
    textSize(15);
    fill(0);
    textAlign(CENTER);
    text((int)health, position.x, position.y - 25);
  }


  void shooting() {
    if (mouse == true) {
      float x = mouseX + cameraOffsetX;
      float y = mouseY + cameraOffsetY;
      //      println("mouse pressed");
      //  println(mouseX, "   ", mouseY);
      stroke(255, 0, 0);
      strokeWeight(2);
      line(position.x, position.y, x, y);

      for (int i = 0; i < num_enemy; i++) {

        //   println(theEnemy1[i].position);

        float distance = sqrt((position.x - theEnemy1[i].position.x) * (position.x - theEnemy1[i].position.x) + (position.y - theEnemy1[i].position.y) * (position.y - theEnemy1[i].position.y));
        //println("distance: " + distance);
        float distance1 = sqrt((x - theEnemy1[i].position.x) * (x - theEnemy1[i].position.x) + (y - theEnemy1[i].position.y) * (y - theEnemy1[i].position.y));

        //Detect the aiming
        if (distance1 <= 20 && distance <= shootDistance && theEnemy1[i].aliveCheck()) {
          theEnemy1[i].health = theEnemy1[i].health - damage * (shootDistance - distance) / shootDistance;
          score += 10; 
          aimCount++;
          //println("aim Count: " + aimCount);
        } 
        else {
          if (distance1 <= 40 && distance1 > 20 && distance <= shootDistance && theEnemy1[i].aliveCheck()) {
            //aimCount = 0;
            missCount++;
            // println("miss Count: " + missCount);
          }
        }

        if (distance1 <= 5 && theEnemy1[i].aliveCheck()) {
          pointCount++;
        }

        if (distance <= 20 && theEnemy1[i].aliveCheck()) {
          collidCount += 1;
          score -= 20;
          //println(collidCount);
        }     

        mouse = false;
      }

      for (int i = 0; i < num_enemy2; i++) {
        float distance = sqrt((position.x - theEnemy2[i].position.x) * (position.x - theEnemy2[i].position.x) + (position.y - theEnemy2[i].position.y) * (position.y - theEnemy2[i].position.y));
        float distance1 = sqrt((x - theEnemy2[i].position.x) * (x - theEnemy2[i].position.x) + (y - theEnemy2[i].position.y) * (y - theEnemy2[i].position.y));

        //Detect the aiming
        if (distance1 <= 20 && distance <= shootDistance && theEnemy2[i].aliveCheck()) {
          theEnemy2[i].health = theEnemy2[i].health - damage * (shootDistance - distance) / shootDistance;
          score += 10; 
          aimCount++;
        } 
        else {
          if (distance1 <= 40 && distance1 > 20 && distance <= shootDistance && theEnemy2[i].aliveCheck()) {
            missCount++;
          }
        }

        if (distance1 <= 5 && theEnemy2[i].aliveCheck()) {
          pointCount++;
        }

        if (distance <= 20 && theEnemy2[i].aliveCheck()) {
          collidCount += 1;
          score -= 20;
        } 

        mouse = false;
      }

      for (int i = 0; i < num_enemy3; i++) {
        float distance = sqrt((position.x - theEnemy3[i].position.x) * (position.x - theEnemy3[i].position.x) + (position.y - theEnemy3[i].position.y) * (position.y - theEnemy3[i].position.y));
        float distance1 = sqrt((x - theEnemy3[i].position.x) * (x - theEnemy3[i].position.x) + (y - theEnemy3[i].position.y) * (y - theEnemy3[i].position.y));

        //Detect the aiming
        if (distance1 <= 20 && distance <= shootDistance && theEnemy3[i].aliveCheck()) {
          theEnemy3[i].health = theEnemy3[i].health - damage * (shootDistance - distance) / shootDistance;
          score += 10; 
          aimCount++;

          gamble = (int)random(0, 4);
          if (gamble == 1) {
            theEnemy3[i].teleport = true;
            theEnemy3[i].health = theEnemy3[i].health + damage * (shootDistance - distance) / shootDistance;
          }
        } 
        else {
          if (distance1 <= 40 && distance1 > 20 && distance <= shootDistance && theEnemy3[i].aliveCheck()) {
            missCount++;
          }
        }

        if (distance1 <= 5 && theEnemy3[i].aliveCheck()) {
          pointCount++;
        }

        if (distance <= 20 && theEnemy3[i].aliveCheck()) {
          collidCount += 1;
          score -= 20;
        }     
        mouse = false;
      }

      for (int i = 0; i < num_enemy4; i++) {
        float distance = sqrt((position.x - theEnemy4[i].position.x) * (position.x - theEnemy4[i].position.x) + (position.y - theEnemy4[i].position.y) * (position.y - theEnemy4[i].position.y));
        float distance1 = sqrt((x - theEnemy4[i].position.x) * (x - theEnemy4[i].position.x) + (y - theEnemy4[i].position.y) * (y - theEnemy4[i].position.y));

        //Detect the aiming
        if (theEnemy4[i].shield == false) {
          if (distance1 <= 20 && distance <= shootDistance && theEnemy4[i].aliveCheck()) {
            theEnemy4[i].health = theEnemy4[i].health - damage * (shootDistance - distance) / shootDistance;
            score += 10; 
            aimCount++;
          } 
          else {
            if (distance1 <= 40 && distance1 > 20 && distance <= shootDistance && theEnemy4[i].aliveCheck()) {
              missCount++;
            }
          }

          if (distance1 <= 5 && theEnemy4[i].aliveCheck()) {
            pointCount++;
          }

          if (distance <= 20 && theEnemy4[i].aliveCheck()) {
            collidCount += 1;
            score -= 20;
          }
        } 
        else {
          if (distance1 <= 20 && distance <= shootDistance && theEnemy4[i].aliveCheck()) {
            theEnemy4[i].shieldCount ++;
          }

          if (theEnemy4[i].shieldCount == 5) {
            theEnemy4[i].shield = false;
          }
        }
        mouse = false;
      }

      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //boss
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      float distance = sqrt((position.x - theBoss.position.x) * (position.x - theBoss.position.x) + (position.y - theBoss.position.y) * (position.y - theBoss.position.y));
      float distance1 = sqrt((x - theBoss.position.x) * (x - theBoss.position.x) + (y - theBoss.position.y) * (y - theBoss.position.y));

      //Detect the aiming
      if (theBoss.shield == false) { 
        if (distance1 <= 20 && distance <= shootDistance && theBoss.aliveCheck()) {
          theBoss.health = theBoss.health - damage * (shootDistance - distance) / shootDistance;
          score += 10; 
          aimCount++;
        } 
        else {
          if (distance1 <= 40 && distance1 > 20 && distance <= shootDistance && theBoss.aliveCheck()) {
            missCount++;
          }
        }

        if (distance1 <= 5 && theBoss.aliveCheck()) {
          pointCount++;
          score += 30;
        }

        if (distance <= 20 && theBoss.aliveCheck()) {
          collidCount += 1;
          score -= 20;
        }

        theBoss.gamble = (int)random(0, 4);
        if (theBoss.gamble == 1) {
          theBoss.teleport = true;
          theBoss.health = theBoss.health + thePlayer.damage * (thePlayer.shootDistance - distance) / thePlayer.shootDistance;
        }
      }

      else if (theBoss.shield == true) {
        if (distance1 <= 20 && distance <= shootDistance && theBoss.aliveCheck()) {
          theBoss.shieldCount ++;
          println(theBoss.shieldCount);
        }

        if (theBoss.shieldCount >= 8) {
          theBoss.shield = false;
        }
      }
      mouse = false;
    }
  }

  void diffChange() {
    if (aimCount == AIM && missCount <= MISS) {
      for (int i = 0; i < num_enemy; i++) {
        if (theEnemy1[i].diff == 1 && theEnemy1[i].damage <= 1) {
          theEnemy1[i].damage *= 1.2;
          theEnemy1[i].diff = 0;
        }
        if (theEnemy2[i].diff == 1 && theEnemy2[i].damage <= 1) {
          theEnemy2[i].damage *= 1.2;
          theEnemy2[i].diff = 0;
        }
        if (theEnemy3[i].diff == 1 && theEnemy3[i].damage <= 1) {
          theEnemy3[i].damage *= 1.2;
          theEnemy3[i].diff = 0;
        }
        if (theEnemy4[i].diff == 1 && theEnemy4[i].damage <= 1) {
          theEnemy4[i].damage *= 1.2;
          theEnemy4[i].diff = 0;
        }
      }
      theBoss.damage *= 1.2;
      aimCount = 0;
      //println("difficulty highered");
    } 
    else { 
      if (missCount == MISS && missCount <= FAIL) {
        for (int i = 0; i < num_enemy; i++) {
          if (theEnemy1[i].diff == 1 && theEnemy1[i].damage >= 0.1) {
            theEnemy1[i].damage *= 0.8;
            theEnemy1[i].diff = 0;
          }
          if (theEnemy2[i].diff == 1 && theEnemy2[i].damage >= 0.1) {
            theEnemy2[i].damage *= 0.8;
            theEnemy2[i].diff = 0;
          }
          if (theEnemy3[i].diff == 1 && theEnemy3[i].damage >= 0.1) {
            theEnemy3[i].damage *= 0.8;
            theEnemy3[i].diff = 0;
          }
          if (theEnemy4[i].diff == 1 && theEnemy4[i].damage >= 0.1) {
            theEnemy4[i].damage *= 0.8;
            theEnemy4[i].diff = 0;
          }
        }
        theBoss.damage *= 0.8;
        missCount = 0;
        //println("difficulty lowered");
      }
      else {
        if (missCount == FAIL) {

          for (int i = 0; i < num_enemy; i++) {
            if (theEnemy1[i].diff == 1 && theEnemy1[i].damage >= 0.1) {
              theEnemy1[i].damage *= 0.6;
              theEnemy1[i].diff = 0;
            }
            if (theEnemy2[i].diff == 1 && theEnemy1[i].damage >= 0.1) {
              theEnemy2[i].damage *= 0.6;
              theEnemy2[i].diff = 0;
            }
            if (theEnemy3[i].diff == 1 && theEnemy3[i].damage >= 0.1) {
              theEnemy3[i].damage *= 0.6;
              theEnemy3[i].diff = 0;
            }
            if (theEnemy4[i].diff == 1 && theEnemy4[i].damage >= 0.1) {
              theEnemy4[i].damage *= 0.6;
              theEnemy4[i].diff = 0;
            }
          }
          theBoss.damage *= 0.6;
          missCount = 0;
          //println("difficulty lowered");
        }
      }
    }

    if (collidCount == COLLID) {
      //println("collid count");
      collidCount = 0;
      speed += 1;
      for (int i = 0; i < num_enemy; i++) {
        theEnemy1[i].speed -= 0.1;
        theEnemy2[i].speed -= 0.1;
        theEnemy3[i].speed -= 0.1;
        theEnemy4[i].speed -= 0.1;
      }
      theBoss.speed *= 0.9;
    }

    if (pointCount == PO) {
      for (int i = 0; i < num_enemy; i++) {
        theEnemy1[i].speed *= 1.2;
        theEnemy2[i].speed *= 1.2;
        theEnemy3[i].speed *= 1.2;
        theEnemy4[i].speed *= 1.2;
      }
      theBoss.speed *= 1.2;
      pointCount = 0;
    }

    if (health <= 25) {
      for (int i = 0; i < num_heart; i++) {
        theHeart[i].heartValue *= 2;
      }
    }
  }
}

