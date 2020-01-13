import ddf.minim.*;

Minim minim;
AudioPlayer song;
AudioSample laser;

public Boss boss;
PFont font, font_small, font_japanese;
public boolean gameover, start=true, setting=true, ship_shape=true; //ship_shape true->△ fales->□
public float ft, basic_time;
public int boss_time = 10, frame_num;
public int num=0, enemy_judge=1, hit_num=0;

void setup() {
  minim = new Minim( this );
  song = minim.loadFile( "digitalworld.mp3" );
  laser = minim.loadSample( "laser2.mp3" );
  size(320, 640);
  frameRate(20);
  noCursor();  // clear mouse cursor
  setting = true;
  flag = 0; 
  hit_num=0;
  boss = new Boss(random(320), 0);
  enemy_HP = new int [50];
  num = 0;
  enemy = new Enemy[50];
  for (int i=0; i<50; i++) {
    Enemy en = new Enemy(random(10, width-9), 0);
    enemy[i] = en;
    enemy_HP[i] = 90;
  }
  ship = new Ship();
  gameover = false; 
  start = true;
  ft = 0; 
  frame_num=30;
  HP = 400; 
  Boss_HP = 1000;
  boss.shoot();
  font = loadFont("AgencyFB-Reg-48.vlw");
  font_small = loadFont("AgencyFB-Reg-24.vlw");
  font_japanese = loadFont("MS-PGothic-24.vlw");
  textFont(font);
}

float green2=255, blue2=255, green1=200 * sin(frameCount), blue1=200 * cos(frameCount);
String l_or_r = "left";
int flag=0;

void draw() {
  background(0);
  if (start) { //start
    song.play();
    textAlign(CENTER);
    fill(255, 200 * sin(frameCount), 200 * cos(frameCount));
    text("Shooting Game", width / 2, height / 2);
    text("Press Enter key", width/2, height/2 + 52);
    keyReleased();
  } else if (setting) {
    textAlign(CENTER);
    fill(255, 255, 255);
    text("Select your Airframe", width / 2, height / 2);
    if (flag==1) {
      fill(255, green1, blue1);
      text("triangle", width / 2 -70, height / 2 + 52);
      fill(255, green2, blue2);
      text("square", width / 2 +70, height / 2 + 52);
      ship.update(width/2, height*4/5);
      flag=0;
    } else {
      fill(255, green1, blue1);
      text("triangle", width / 2 -70, height / 2 + 52);
      fill(255, green2, blue2);
      text("square", width / 2 +70, height / 2 + 52);
      fill(255, 255, 255);
      textFont(font_small);
      text("Use the left and right arrow keys to select",width /2, height/2 + 104);
      textFont(font);
      ship.update(width/2, height*4/5);
      if ((keyPressed==true && keyCode==LEFT) || l_or_r=="left") {
        green1 = 200 * sin(frameCount); 
        blue1 = 200 * cos(frameCount);
        green2 = blue2 = 255; 
        l_or_r = "left";
        ship_shape = true;
        if (keyPressed==true && key==ENTER) {
          flag = 1;
          ship.fire();
          flag = 0;
          setting = false;
          basic_time = millis();
          draw();
        }
      }
    }
    if ((keyPressed==true && keyCode==RIGHT) || l_or_r=="right") {
      green2 = 200 * sin(frameCount); 
      blue2 = 200 * cos(frameCount);
      green1 = blue1 = 255;
      l_or_r = "right";
      ship_shape = false;
      if (keyPressed==true && key==ENTER) {
        flag = 1;
        ship.fire();
        flag = 0;
        setting = false;
        basic_time = millis();
        draw();
      }
    }
  } else {
    if (gameover) {  // game over
      laser.close();
      song.close();
      minim.stop();
      textAlign(CENTER);
      gameover();
    } else {
      life_point();
      print_time();
      ship.update(mouseX, mouseY);
      if (num==49) {
        boss.fire_360();
        if (frameCount % 30 == 0) {
          boss.shoot();
        }
      }
      for (int i=0; i<=num; i++) {
        enemy[i].fire();
      }
      if (frameCount % frame_num == 0) {
        if (enemy_judge==1&&num>=20) {
          enemy_judge = (int)random(2);
        } else {
          enemy_judge = 1;
        }
        for (int j=0; j<=num; j++)
          enemy[j].shoot();
        if (enemy_judge==1 && num<49)
          num++;
      }
    }
  }
}


void keyReleased() {
  if (keyPressed==true && key==ENTER) {
    start = false;
    key=SHIFT;
    flag = 1;
  }
}


void gameover() {
  if (HP <= 0) {
    fill(255, 255, 255);
    text("YOU LOSE", width / 2, height / 2);
    text("SCORE  "+hit_num*100, width / 2, height / 2 + 48);
    textFont(font_small);
    text("If you continue, please press Tab key", width/2, height/2 + 96);
    textFont(font);
    if (keyPressed==true && key==TAB) {  
      setup();
    }
  } else if (Boss_HP <= 0) {
    fill(255 * sin(frameCount), 255, 255 * cos(frameCount));
    text("YOU WIN!", width / 2, height / 2);
    text("SCORE  "+(hit_num*100+1000), width / 2, height / 2 + 48);
    textFont(font_small);
    text("If you continue, please press Tab key", width/2, height/2 + 96);
    textFont(font);
    if (keyPressed==true && key==TAB) {  
      setup();
    }
  }
}

void print_time() {
  ft = (float)(millis()-basic_time) / 1000;
  fill(255, 255, 255);
  textAlign(RIGHT);
  text(nf(ft, 2, 1), width, 48);
}

void life_point() {
  fill(255, 255, 255);
  textAlign(LEFT);
  if (HP<=100)
    text("*", 10, 48);
  else if (HP<=200)
    text("**", 10, 48);
  else
    text("***", 10, 48);
}
