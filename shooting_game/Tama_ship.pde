public Tama_enemy tama_ship;

class Tama_ship {
  float tx, ty, tr, dy;
  Tama_ship(float x, float y, float r, float minus_y) {
    tx = x;
    ty = y;
    tr = r;
    dy = minus_y;
  }
  
  boolean update(int n) {
       ty -= dy;
       stroke(200, 0, 0);
       fill(255, 255, 255);
       ellipse(tx, ty, tr, tr);
       if (ty > height || ty < 0 || tx > width || tx < 0) {
         return false;
       }
       if(ft>boss_time &&dist(tx, ty, boss.bx, boss.by) < tr/2)
        boss.hit();
      for(int i=0; i<=n; i++){
        //print("%d", n);
       if (dist(tx, ty, enemy[i].bx, enemy[i].by) < tr){
         tx = 1000; ty = 1000;  //delete tama
         enemy[i].hit(i);
       }
      }
      return true;
  }
}
