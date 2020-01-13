public Tama_ship tama_ship;

class Tama_ship {
  float tx, ty, tr, dx, dy;
  Tama_ship(float x, float y, float r, float cos, float sin) {
    tx = x;
    ty = y;
    tr = r;
    dx = cos;
    dy = sin;
  }

  boolean update(int n) {
    tx += dx;
    ty -= dy;
    stroke(200, 0, 0);
    fill(255, 255, 255);
    ellipse(tx, ty, tr, tr);
    if (ty > height || ty <= 0 || tx > width || tx < 0 || (setting && key==ENTER && flag==1)) {
      return false;
    }
    if (num==49 &&dist(tx, ty, boss.bx, boss.by) < tr) {
      tx = 1000; 
      ty = 1000;  //delete tama
      boss.hit();
    }
    for (int i=0; i<=n; i++) {
      if (dist(tx, ty, enemy[i].bx, enemy[i].by) < tr) {
        tx = 1000; 
        ty = 1000;  //delete tama
        enemy[i].hit(i);
      }
    }
    return true;
  }
}
