public Enemy[] enemy;
public int[] enemy_HP;

class Enemy {
  float bx, by, bw=20, w = 0.02;  //bw is enemy length   
  int y_add=1;
  ArrayList bullet;

  Enemy(float x, float y) { 
    bx = x;
    by = y;
    bullet = new ArrayList();
  }

  void fire() {
    by += y_add;
    fill(0, 255, 0);
    rect(bx-bw/2, by-bw/2, bw, bw);
    for (int i = bullet.size()-1; i >= 0; i--) {
      Tama_enemy t_e = (Tama_enemy)bullet.get(i);  
      if (t_e.update() == false)   
        bullet.remove(i);
    }
  }

  int bullet_num = 1;
  void shoot() {
    if (num>=10&&num<20) {
      bullet_num = 2;
      frame_num = 40;
    } else if (num>=20) {
      bullet_num = 4;
      frame_num =30;
    }
    for (int i = 0; i < bullet_num; i++) {
      bullet.add(new Tama_enemy(bx, by+20*i, 10, 5));
    }
  }

  void hit(int n) {
    enemy_HP[n] -= 30;
    if (enemy_HP[n] <= 0) {
      bx = 1000; 
      by = 1000;
    }
  }
}
