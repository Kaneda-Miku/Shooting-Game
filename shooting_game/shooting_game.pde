import ddf.minim.*;

Minim minim;
AudioPlayer song, laser;

public Boss boss;
PFont font, font_small;
public boolean gameover, start=true;
public float ft, basic_time;
public int boss_time = 10, frame_num;
public int num=0, enemy_judge=1;

void setup() {
   minim = new Minim( this );
   song = minim.loadFile( "digitalworld.mp3" );
   laser = minim.loadFile( "laser2.mp3" );
   size(320, 640);
   frameRate(20);
   noCursor();  // clear mouse cursor
   boss = new Boss(random(320), 0);
   enemy_HP = new int [50];
   num = 0;
    enemy = new Enemy[50];
    for(int i=0; i<50; i++){
     Enemy en = new Enemy(random(10, width-9), 0);
     enemy[i] = en;
     enemy_HP[i] = 90;
   }
   ship = new Ship();
   gameover = false; 
   start = true;
   ft = 0; frame_num=50;
   HP = 400; Boss_HP = 1000;
   boss.shoot();
   font = loadFont("AgencyFB-Reg-48.vlw");
   font_small = loadFont("AgencyFB-Reg-24.vlw");
   textFont(font);
}

void draw() {
  background(0);
  if(start){ //start
    song.play();
    textAlign(CENTER);
    fill(255, 200 * sin(frameCount), 200 * cos(frameCount));
    text("Shooting Game", width / 2, height / 2);
    text("Press Enter key", width/2, height/2 + 52);
    if(keyPressed==true && key==ENTER){
      start = false;
      basic_time = millis();
      draw();
    }
  }else{
    if (gameover) {  // game over
      song.close();
      minim.stop();
      textAlign(CENTER);
      if (HP <= 0) {
        fill(255, 255, 255);
        text("YOU LOSE", width / 2, height / 2);
        textFont(font_small);
        text("If you continue, please press Tab key", width/2, height/2 + 48);
        textFont(font);
        if(keyPressed==true && key==TAB){  
          setup();
        }
      } else if(Boss_HP <= 0){
        fill(255 * sin(frameCount), 255, 255 * cos(frameCount));
        text("YOU WIN!", width / 2, height / 2);
        textFont(font_small);
        text("If you continue, please press Tab key", width/2, height/2 + 48);
        textFont(font);
        if(keyPressed==true && key==TAB){  
          setup();
        }
      }
    } else {
      life_point();
      print_time();
      ship.update(mouseX, mouseY);
      if(ft>boss_time /*&& num==49*/){
        boss.fire_360();
        if (frameCount % 30 == 0) {
         boss.shoot();
        }
      }
      for(int i=0; i<=num; i++){
        enemy[i].fire();
      }
      if (frameCount % frame_num == 0) {
        enemy_judge = (int)random(2);
        for(int j=0; j<=num; j++)
          enemy[j].shoot();
        if(enemy_judge==1 && num<=49)
          num++;
      }
    }
  }
}

void print_time() {
  ft = (float)(millis()-basic_time) / 1000;
  fill(255, 255, 255);
  textAlign(RIGHT);
  text(nf(ft, 2, 1), width, 48);
}

void life_point(){
  fill(255, 255, 255);
  textAlign(LEFT);
  if(HP<=100)
      text("*", 10, 48);
  else if(HP<=200)
      text("**", 10, 48);
  else
      text("***", 10, 48);
}
