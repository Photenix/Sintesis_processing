class VSlider { 
  boolean locked = false; 
  boolean overBox = false;
  float yOffset = 0.0; 
  int initPosY = 9;
  int posX;
  
  float by = 80-15+initPosY;
  
  VSlider (int x) {  
    posX = x; 
  } 
  
  void update() { 
    pushStyle();
      noStroke();
      rect(posX+15,initPosY,20,80,25);
    popStyle();
    pushStyle();
      fill(#72C4C6);
      rect(posX,by,50,15,5);
    popStyle();
    
    if(
      mouseX > posX && mouseX < posX+50 &&
      mouseY > initPosY && mouseY < initPosY+80
    ) {
      overBox = true;
    }else overBox = false;
    allEventMouse();
  }
  
  void allEventMouse() {
    if(mousePressed){
      if(overBox) { 
        locked = true; 
        mouseDragged();
      } 
    }
  }
  
  void mouseDragged() {
    if(locked) {
      if(by >= initPosY && by <= initPosY+65){
        by = mouseY-yOffset;
      }
      if(by < initPosY){by = 0;}
      if(by > initPosY+65){by = initPosY+65;}
    }
    float value = map(by, 10.0,initPosY+65, 100, 0);
    println(value);
  }
}
