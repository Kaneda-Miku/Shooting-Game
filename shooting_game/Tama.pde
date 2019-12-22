Ship ship;

class Tama {
  float tx, ty, tr, dx, dy;
  Tama(float x, float y, float r, float sin, float cos) {
    tx = x;
    ty = y;
    tr = r;
    dx = sin;
    dy = cos;
  }
  
  boolean update() {
       tx += dx; ty += dy;
       stroke(200, 0, 0);
       fill(255, 0, 0);
       ellipse(tx, ty, tr, tr);  
       if (ty > height || ty < 0 || tx > width || tx < 0) {
         return false;
       }
       if (dist(tx, ty, ship.sx, ship.sy) < tr/2){
         tx = 1000; ty = 1000;  //delete tama
         ship.hit();
       }
       return true;
  }
}
