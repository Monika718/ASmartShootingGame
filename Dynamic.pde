PImage right_stand, left_stand, back_stand, front_stand;
PImage robot, robot2, robot3, robot4, boss;
PImage earth, startscreen, win;
PImage heart, bomb;

float x, y;

int num_heart = 50;
int num_enemy = 50;
int num_enemy2 = 50;
int num_enemy3 = 50;
int num_enemy4 = 50;
int num_bomb = 10;

boolean gameStart = false;
boolean gameWin = false;
boolean gameLose = false;

float cameraOffsetX, cameraOffsetY;
int timer;

int level1 = 0;
int level2 = 0;
int level3 = 0;
int level4 = 0;

int wave2 = 0;
int wave3 = 0;
int wave4 = 0;
int wave5 = 0;

int e11 = 10;
int e12 = 20;
int e13 = 30;
int e14 = 40;

int e22 = 5;
int e23 = 10;
int e24 = 15;
int e33 = 3;
int e34 = 6;

int e44 = 3;

Player thePlayer = new Player();
Keyboard theKeyboard = new Keyboard();
World theWorld = new World();
Enemy1[] theEnemy1 = new Enemy1[num_enemy];
Enemy2[] theEnemy2 = new Enemy2[num_enemy];
Enemy3[] theEnemy3 = new Enemy3[num_enemy];
Enemy4[] theEnemy4 = new Enemy4[num_enemy];
Boss theBoss = new Boss();
Heart[] theHeart = new Heart[num_heart];
Bomb[][] theBomb = new Bomb[num_enemy2][num_bomb];
Timer theTimer = new Timer(5);


void setup() {
  size(900, 600);

  right_stand = loadImage("right_stand.png");
  left_stand = loadImage("left_stand.png");
  back_stand = loadImage("back_stand.png");
  front_stand = loadImage("front_stand.png");
  earth = loadImage("earth.png");
  boss = loadImage("boss.png");
  robot = loadImage("robot.png");
  robot2 = loadImage("robot2.png");
  robot3 = loadImage("robot3.png");
  robot4 = loadImage("robot4.png");
  heart = loadImage("heart.png");
  bomb = loadImage("bomb.png");
  startscreen = loadImage("startscreen.png");
  win = loadImage("win.png");

  cameraOffsetX = 0.0;
  cameraOffsetY = 0.0;

  frameRate(24);

  for (int i = 0; i < num_enemy; i++) {
    theEnemy1[i] = new Enemy1();
  }

  for (int i = 0; i < num_enemy2; i++) {
    theEnemy2[i] = new Enemy2();
  }

  for (int i = 0; i < num_enemy3; i++) {
    theEnemy3[i] = new Enemy3();
  }

  for (int i = 0; i < num_enemy4; i++) {
    theEnemy4[i] = new Enemy4();
  }

  for (int i = 0; i < num_heart; i++) {
    theHeart[i] = new Heart(i, random(theWorld.GRID_UNITS_WIDE * theWorld.GRID_UNIT_SIZE), random(theWorld.GRID_UNITS_HIGH * theWorld.GRID_UNIT_SIZE));
  }

  for (int i = 0; i < num_enemy2; i++) {
    for (int j = 0; j < num_bomb; j++) {
      theBomb[i][j] = new Bomb();
    }
  }
}

void updateCameraPosition() {
  int rightEdge = theWorld.GRID_UNITS_WIDE * theWorld.GRID_UNIT_SIZE - width;
  int downEdge = theWorld.GRID_UNITS_HIGH * theWorld.GRID_UNIT_SIZE - height;

  cameraOffsetX = thePlayer.position.x - width / 2;
  if (cameraOffsetX < 0) {
    cameraOffsetX = 0;
  }

  if (cameraOffsetX > rightEdge) {
    cameraOffsetX = rightEdge;
  }

  cameraOffsetY = thePlayer.position.y - height / 2;
  if (cameraOffsetY < 0) {
    cameraOffsetY = 0;
  }

  if (cameraOffsetY > downEdge) {
    cameraOffsetY = downEdge;
  }
}

void reset() {

  thePlayer.reset();
}

void draw() {
  if (gameStart == false) {
    image(startscreen, 0, 0);
  } 
  else {
    timer = millis() / 1000;

    pushMatrix();
    translate(-cameraOffsetX, -cameraOffsetY);

    updateCameraPosition();

    theWorld.render();

    scoreDisplay();

    if (thePlayer.health <= 0) {
      gameLose = true;
      //gameOver();
    } 
    else {
      gameLose = false;
    }

    if (gameWin == true) {
      gameWin();
    } 
    else {
      thePlayer.inputCheck();
      thePlayer.move();
      thePlayer.draw();
      thePlayer.shooting();
      thePlayer.diffChange();
      println("wave2");

      if (wave2 == 0) {
        level1();
      }

      if (wave2 != 0 && wave3 == 0) {
        if (wave2 == 1) {
          reset();
          println("wave 2");
          wave2 = 2;
        } 
        else {
          level2();
          bombGenerate();
        }
      }

      if (wave2 != 0 && wave3 != 0 && wave4 == 0) {
        if (wave3 == 1) {
          reset();
          println("wave 3");
          wave3 = 2;
        } 
        else {
          level3();
          bombGenerate();
        }
      }

      if (wave2 != 0 && wave3 != 0 && wave4 != 0 && wave5 == 0) {
        if (wave4 == 1) {
          reset();
          println("wave 4");
          wave4 = 2;
        } 
        else {
          level4();
          bombGenerate();
        }
      }

      if (wave2 != 0 && wave3 != 0 && wave4 != 0 && wave5 != 0) {
        if (wave5 == 1) {
          reset();
          println("wave 5");
          wave5 = 2;
        } 
        else {
          level5();
        }
      }
    }
    popMatrix();
  }
}

void keyPressed() {
  theKeyboard.pressKey(key, keyCode);
  if (keyCode == ' ') {
    if (wave2 == 0 && wave3 == 0 && wave4 == 0 && wave5 == 0  && level1 == e11)
      wave2 = 1;
    if (wave2 == 2 && wave3 == 0 && wave4 == 0 && wave5 == 0 && level1 == e12 && level2 == e22)
      wave3 = 1;
    if (wave2 == 2 && wave3 == 2 && wave4 == 0 && wave5 == 0 && level1 == e13 && level2 == e23 && level3 == e33)
      wave4 = 1;
    if (wave2 == 2 && wave3 == 2 && wave4 == 2 && wave5 == 0 && level1 == e14 && level2 == e24 && level3 == e34 && level4 == e44)
      wave5 = 1;
  }
}

void keyReleased() {
  theKeyboard.releaseKey(key, keyCode);
}

void mouseClicked() {
  if (gameStart == false) {
    gameStart = true;
  }

  if (thePlayer.mouse == false) {
    thePlayer.mouse = true;
    // println("mouse clicked");
  }
}

void gameOver() {
  textSize(40);
  textAlign(CENTER);
  fill(0);
  text("GAME OVER!", width / 2 + cameraOffsetX, height / 2 + cameraOffsetY);

  stop();
  noLoop();
}

void scoreDisplay() {
  textSize(20);
  textAlign(LEFT);
  fill(0);
  text("SCORE: " + thePlayer.score, 10 + cameraOffsetX, height - 10 + cameraOffsetY);
}

void bombGenerate() {
  for (int i = 0; i < num_enemy2; i++) {
    for (int j = 0; j < num_bomb; j++) {

      theBomb[i][j].eatCheck(); 
      theBomb[i][j].bornCheck(i);
      if (theBomb[i][j].isBorn == true && theBomb[i][j].isEaten == false) {
        theBomb[i][j].draw(theEnemy2[i].position.x, theEnemy2[i].position.y);
      }
    }
  }
}

void gameWin() {
  image(win, 0, 0);
  stop();
  noLoop();
}

void collisionCheck() {
  for (int i = 0; i < num_enemy; i++) {
    for (int j = 0; j < i; j++) {
      if (abs(theEnemy1[i].position.x - theEnemy1[j].position.x) <= robot.width
        && abs(theEnemy1[i].position.y - theEnemy1[j].position.y) <= robot.height) {
      }
    }
  }
  for (int i = 0; i < num_enemy2; i++) {
    for (int j = 0; j < i; j++) {
      if (abs(theEnemy2[i].position.x - theEnemy2[j].position.x) <= robot.width
        && abs(theEnemy2[i].position.y - theEnemy2[j].position.y) <= robot.height) {
      }
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LEVEL 1
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void level1() {
  for (int i = 0; i < e11; i++) {
    if (theEnemy1[i].aliveCheck()) {
      theEnemy1[i].draw();
      if (timer % (5 + i) ==0) {
        theEnemy1[i].attack();
      }
    }
  }


  for (int i = 0; i < 5; i++) {
    theHeart[i].heartValue = 20; 
    theHeart[i].eatCheck(); 
    theHeart[i].bornCheck(i);  
    if (theHeart[i].isEaten == false && theHeart[i].isBorn == true) {
      theHeart[i].draw();
    }
  }

  collisionCheck();  

  for (int i = 0; i < e11; i++) {
    if (theEnemy1[i].aliveCheck() == false && theEnemy1[i].finished == false) {
      theEnemy1[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level1 = level1 + 1;
      //println("DIE" + level1);
    }
  }

  if (level1 == e11) {
    textSize(30);
    fill(255, 0, 0);
    textAlign(CENTER);
    text("LEVEL 1 FINISHED\npress SPACE to continue", width / 2 + cameraOffsetX, height / 2 + cameraOffsetY);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LEVEL 2
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void level2() {
  for (int i = e11; i < e12; i++) {
    if (theEnemy1[i].aliveCheck()) {
      theEnemy1[i].draw();
      if (timer % (15 + i) ==0) {
        theEnemy1[i].attack();
      }
    }
  }

  for (int i = 0; i < e22; i++) {
    if (theEnemy2[i].aliveCheck()) {
      theEnemy2[i].draw();
      if (timer % (7 + i) ==0) {
        theEnemy2[i].attack();
      }
    }
  }

  for (int i = 5; i < 8; i++) {
    theHeart[i].heartValue = 20; 
    theHeart[i].eatCheck(); 
    theHeart[i].bornCheck(i);  
    if (theHeart[i].isEaten == false && theHeart[i].isBorn == true) {
      theHeart[i].draw();
    }
  }

  collisionCheck();  

  for (int i = e11; i < e12; i++) {
    if (theEnemy1[i].aliveCheck() == false && theEnemy1[i].finished == false) {
      theEnemy1[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level1 = level1 + 1;
      //println("DIE" + level1);
    }
  }

  for (int i = 0; i < e22; i++) {
    if (theEnemy2[i].aliveCheck() == false && theEnemy2[i].finished == false) {
      theEnemy2[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level2 = level2 + 1;
      //println("DIE" + level1);
    }
  }

  if (level1 == e12 && level2 == e22) {
    textSize(30);
    fill(255, 0, 0);
    textAlign(CENTER);
    text("LEVEL 2 FINISHED\npress SPACE to continue", width / 2 + cameraOffsetX, height / 2 + cameraOffsetY);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LEVEL 3
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void level3() {
  for (int i = e12; i < e13; i++) {
    if (theEnemy1[i].aliveCheck()) {
      theEnemy1[i].draw();
      if (timer % (5 + i) + i== 0) {
        theEnemy1[i].attack();
      }
    }
  }

  for (int i = e22; i < e23; i++) {
    if (theEnemy2[i].aliveCheck()) {
      theEnemy2[i].draw();
      if (timer % (7 + i) + i== 0) {
        theEnemy2[i].attack();
      }
    }
  }


  for (int i = 0; i < e33; i++) {
    if (theEnemy3[i].aliveCheck()) {
      theEnemy3[i].draw();
      if (timer % (11 + i) == 0) {
        theEnemy3[i].attack();
      }
    }
  }

  for (int i = 8; i < 12; i++) {
    theHeart[i].heartValue = 30; 
    theHeart[i].eatCheck();
    theHeart[i].bornCheck(i);  
    if (theHeart[i].isEaten == false && theHeart[i].isBorn == true) {
      theHeart[i].draw();
    }
  }

  collisionCheck();  

  for (int i = e12; i < e13; i++) {
    if (theEnemy1[i].aliveCheck() == false && theEnemy1[i].finished == false) {
      theEnemy1[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level1 = level1 + 1;
      //println("DIE" + level1);
    }
  }

  for (int i = e22; i < e23; i++) {
    if (theEnemy2[i].aliveCheck() == false && theEnemy2[i].finished == false) {
      theEnemy2[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level2 = level2 + 1;
      //println("DIE" + level1);
    }
  }

  for (int i = 0; i < e33; i++) {
    if (theEnemy3[i].aliveCheck() == false && theEnemy3[i].finished == false) {
      theEnemy3[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level3 = level3 + 1;
      //println("DIE" + level1);
    }
  }

  if (level1 == e13 && level2 == e23 && level3 == e33) {
    textSize(30);
    fill(255, 0, 0);
    textAlign(CENTER);
    text("LEVEL 3 FINISHED\npress SPACE to continue", width / 2 + cameraOffsetX, height / 2 + cameraOffsetY);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LEVEL 4
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void level4() {
  for (int i = e13; i < e14; i++) {
    if (theEnemy1[i].aliveCheck()) {
      theEnemy1[i].draw();
      if (timer % (15 + i) + 2 * i== 0) {
        theEnemy1[i].attack();
      }
    }
  }

  for (int i = e23; i < e24; i++) {
    if (theEnemy2[i].aliveCheck()) {
      theEnemy2[i].draw();
      if (timer % (7 + i) + i== 0) {
        theEnemy2[i].attack();
      }
    }
  }


  for (int i = e33; i < e34; i++) {
    if (theEnemy3[i].aliveCheck()) {
      theEnemy3[i].draw();
      if (timer % (12 + i) == 0) {
        theEnemy3[i].attack();
      }
    }
  }

  for (int i = 0; i < e44; i++) {
    if (theEnemy4[i].aliveCheck()) {
      theEnemy4[i].draw();
      if (timer % (17 + i) == 0) {
        theEnemy4[i].attack();
      }
    }
  }

  for (int i = 12; i < 16; i++) {
    theHeart[i].heartValue = 20; 
    theHeart[i].eatCheck();
    theHeart[i].bornCheck(i);  
    if (theHeart[i].isEaten == false && theHeart[i].isBorn == true) {
      theHeart[i].draw();
    }
  }

  collisionCheck();  

  for (int i = e13; i < e14; i++) {
    if (theEnemy1[i].aliveCheck() == false && theEnemy1[i].finished == false) {
      theEnemy1[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level1 = level1 + 1;
      //println("DIE" + level1);
    }
  }

  for (int i = e23; i < e24; i++) {
    if (theEnemy2[i].aliveCheck() == false && theEnemy2[i].finished == false) {
      theEnemy2[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level2 = level2 + 1;
      //println("DIE" + level1);
    }
  }

  for (int i = e33; i < e34; i++) {
    if (theEnemy3[i].aliveCheck() == false && theEnemy3[i].finished == false) {
      theEnemy3[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level3 = level3 + 1;
      //println("DIE" + level1);
    }
  }

  for (int i = 0; i < e44; i++) {
    if (theEnemy4[i].aliveCheck() == false && theEnemy4[i].finished == false) {
      theEnemy4[i].finished = true;
      thePlayer.score += 100;
      //println("finished:  " + theEnemy1[i].finished);
      level4 = level4 + 1;
      //println("DIE" + level1);
    }
  }
  if (level1 == e14 && level2 == e24 && level3 == e34 && level4 == e44) {
    textSize(30);
    fill(255, 0, 0);
    textAlign(CENTER);
    text("LEVEL 4 FINISHED\npress SPACE to continue", width / 2 + cameraOffsetX, height / 2 + cameraOffsetY);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LEVEL 5
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void level5() {
  if (theBoss.aliveCheck() == true) {
    theBoss.draw();
    int i = (int)random(0, 9);
    if (timer % (7 + i) == 0) {
      theBoss.attack();
    }
  }
  else {
    gameWin = true;
  }
}

