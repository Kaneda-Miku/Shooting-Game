public Boss boss;
PFont font;
public boolean gameover;

void setup() {
   size(320, 320); // 9leap window size of regulation
   frameRate(30);
   noCursor();  // clear mouse cursor
   boss = new Boss(random(320), 0);
   ship = new Ship();
   HP = 300; Boss_HP = 1000;
   boss.shoot();
   font = loadFont("AgencyFB-Reg-48.vlw");
   textFont(font);
}

void draw() {
  background(0);
  if (gameover) {  // game over
    textAlign(CENTER);
    if (HP <= 0) {
      fill(255, 255, 255);  // blue
      text("YOU LOSE", width / 2, height / 2);
    } else {
      fill(255 * sin(frameCount), 255, 255 * cos(frameCount));  // red
      text("YOU WIN!", width / 2, height / 2);
    }
  } else {
    print_time();
    ship.update(mouseX, mouseY);
    boss.fire_360();
    if (frameCount % 30 == 0) {
     boss.shoot();
    }
  }
}

void print_time() {
  float ft = (float)millis() / 1000;
 
  textAlign(RIGHT);
  text(nf(ft, 2, 1), width, 48);
}
