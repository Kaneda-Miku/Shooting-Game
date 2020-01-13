public int HP;

class Ship {
  float sx; 
  float sy;
  ArrayList ship_bullet;
  int bw = 15;

  Ship() { 
    ship_bullet = new ArrayList();
  }  

  void update(int x, int y) {
    sx = x; 
    sy = y;
    if (sx<0) {
      sx = 0;
    } else if (sx>width) {
      sx = width;
    } else if (sy<0) {
      sy = 0;
    } else if (sy>height) {
      sy = height;
    }

    stroke(255, 255, 255);
    noFill();
    if (ship_shape) {
      triangle(x, y - 7, x - 10, y + 7, x + 10, y + 7);
      fire();
      if ((mousePressed && frameCount%5==0) || (setting && frameCount%3==0)) {
        laser.trigger();
        ship_bullet.add(new Tama_ship(sx, sy, 10, 0, 20));
      }
    } else {
      rect(x-bw/2, y-bw/2, bw, bw);
      fire();
      if ((mousePressed && frameCount%10==0) || (setting && frameCount%6==0)) {
        laser.trigger();
        for (int i = 0; i < 3; i++) {
          float rad = radians(i*90);  
          ship_bullet.add(new Tama_ship(sx, sy, 10, 5*cos(rad), 20));
        }
      }
    }
  }

  void fire() {
    for (int i = ship_bullet.size()-1; i >= 0; i--) {
      Tama_ship t_s = (Tama_ship)ship_bullet.get(i);
      if (t_s.update(num) == false)   
        ship_bullet.remove(i);
    }
  }

  void hit(int damage) {
    HP -= damage;
    if (HP <= 0) {
      gameover=true;
    }
  }
}
