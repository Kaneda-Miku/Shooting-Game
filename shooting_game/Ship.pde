public int HP;

class Ship {
  float sx; float sy;
  
  Ship() { 
  }  
  
  void update(int x, int y) {
    sx = x; 
    sy = y;
    stroke(255,255,255);
    noFill();
    triangle(x, y - 7, x - 10, y + 7, x + 10, y + 7);
    if (mousePressed) {
      line(x, y - 7, x, 0);
      if(abs(sx-boss.bx) < (boss.bw/2))
        boss.hit();
    }
  }
  
  void hit(){
    HP -= 30;
    if(HP <= 0){
      gameover=true;
    }
  }
   
}
