class VSlider { 
  boolean locked = false; 
  boolean overBox = false;
  float yOffset = 0.0; 
  int initPosY = 9;
  int posX;
  
  int SliderYlong = 80;
  
  
  float by = 80-15+initPosY;
  
  NetAddress direccionRemota;
  OscP5 osc;

  String port = "/Slider/Harmony/";
  
  VSlider(int x, int numberSlider,
  OscP5 oscP5, NetAddress direccion) {  
    posX = x;
    
    direccionRemota = direccion;
    osc = oscP5;
    
    port = port+numberSlider;
    
    oscValue();
  } 
  
  void namePort(String nameport){
    port = "/Slider/"+nameport;
  }

  void initY(int posY){
    initPosY = posY;
    by = 80-15+initPosY;
  }
  
  void sedSliderYlong(int Yvalue){
    SliderYlong = Yvalue;
  }
  
  void update() {
    pushStyle();
      fill(255);
      noStroke();
      rect(posX,initPosY+(SliderYlong/2),
        50,5);
    popStyle();
    
    pushStyle();
      noStroke();
      rect(posX+15,initPosY,
        20,SliderYlong,25);
    popStyle();
    
    pushStyle();
      fill(#72C4C6);
      rect(posX,by,50,15,5);
    popStyle();
    
    if(
      mouseX > posX && mouseX < posX+50 &&
      mouseY > initPosY && mouseY < initPosY+SliderYlong
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
      if(by >= initPosY && by <= initPosY+(SliderYlong-15)){
        by = mouseY-yOffset;
      }
      if(by < initPosY){by = 0;}
      if(by > initPosY+(SliderYlong-15)){by = initPosY+SliderYlong-15;}
    }
    
    oscValue();
  }
  
  void oscValue(){
    println(by);
    OscMessage VSMessage = new OscMessage(port);
    //float value = map(by, 10.0,initPosY+65, 100, 0);
    
    float value = map(by, initPosY+1,initPosY+(SliderYlong-15), 1, 0);
    
    //println(value);
    VSMessage.add(value);
    osc.send(VSMessage, direccionRemota);
  }
}
