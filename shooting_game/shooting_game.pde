Boss boss;
//ArrayList danmaku;
void setup() {
   size(320, 320); // 9leap window size of regulation
   frameRate(30);
   noCursor();  // clear mouse cursor
   boss = new Boss(width/2, height/2);
   boss.shoot();
}

void ship(int x, int y){
  stroke(255,255,255);
  noFill();
  triangle(x, y - 7, x - 10, y + 7, x + 10, y + 7);
  if (mousePressed) {
    line(x, y - 7, x, 0);
  }
}

class Boss {
  float bx, by;        
  ArrayList danmaku; 
 
  Boss(float x, float y) {
    bx = x;
    by = y;  
    danmaku = new ArrayList();
  }
 
  void fire_360(/*float x, float y*/) {  
    for (int i = danmaku.size() -1; i >= 0; i--) {
      Tama t = (Tama)danmaku.get(i);  
      if (t.update() == false)   
        danmaku.remove(i);  
    }
  }
  
  void shoot(){
    fire_360();
    bx += 10;  //it will be change random
    for (int i = 0; i < 360; i+= 10) {
      float rad = radians(i);
      danmaku.add(new Tama(bx, by, 10, cos(rad), sin(rad)));
    }
  }
}

//tama class
class Tama {
  float tx, ty, tr, dx, dy;
  Tama(float x, float y, float r, float sin, float cos) {
    tx = x;
    ty = y;
    tr = r;
    dx = sin;
    dy = cos;
  }
  float x, y;
  boolean update() {
       tx += dx; ty += dy;
       stroke(255, 0, 0);
       ellipse(tx, ty, tr, tr);  
       if (ty > height || ty < 0 || tx > width || tx < 0) {
         y = 0;
         x = 0;
         return false;
       }
       return true;
  }
}

void draw() {
  background(0);
  ship(mouseX, mouseY);
  boss.fire_360();
  if (frameCount % 30 == 0) {
   boss.shoot();
  }
}
