public int Boss_HP;

class Boss {
  float bx, by, bw=50, w = 0.02;  //bw is boss length   
  int x_add=10;
  ArrayList danmaku; 
 
  Boss(float x, float y) {
    bx = x;
    by = y;  
    danmaku = new ArrayList();
  }
 
  void fire_360(/*float x, float y*/) {  
    rect(bx-bw/2, by-bw/4, bw, bw/2);
    for (int i = danmaku.size()-1; i >= 0; i--) {
      Tama t = (Tama)danmaku.get(i);  
      if (t.update() == false)   
        danmaku.remove(i);  
    }
  }
  
  void shoot(){
    bx += x_add;
    if(bx > width){
      bx = 320; x_add *= -1; 
      w = random(0.5);
    }else if(bx < 0){
      bx = 0; x_add *= -1;
      w = random(0.5);
    }
    by = boss_location(by);
    for (int i = 0; i < 360; i+= 10) {
      float rad = radians(i);
      danmaku.add(new Tama(bx, by, 10, cos(rad), sin(rad)));
    }
  }
  
  float boss_location(float y){ // if boss location over display, reset boss location
    y = -50*sin(w*bx+0)+50;
    return y;
  }
  
  void hit(){
    Boss_HP -= 100;
    if(Boss_HP < 0){
      gameover=true;
    }
  }
}
