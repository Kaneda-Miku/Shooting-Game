public Tama_enemy tama_enemy;

class Tama_enemy {
  float tx, ty, tr, dy;
  Tama_enemy(float x, float y, float r, float plus_y) {
    tx = x;
    ty = y;
    tr = r;
    dy = plus_y;
  }
  
  boolean update() {
       ty += dy;
       stroke(200, 0, 0);
       fill(0, 255, 0);
       ellipse(tx, ty, tr, tr);  
       if (ty > height || ty < 0 || tx > width || tx < 0) {
         return false;
       }
       if (dist(tx, ty, ship.sx, ship.sy) < tr/2){
         tx = 1000; ty = 1000;  //delete tama
         ship.hit(100);
       }
       return true;
  }
}
