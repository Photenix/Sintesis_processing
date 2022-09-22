/*
  Doc JM4P1R0
  Hola me imagino que queires saber mi codigo jiji
  para esto empezare con lo siguiente.

  Para esto necesitas
    int x = posicion de X en nuestro canvas
    int numberSlider = que sera nuestro identificador del slider un paso muy importante
    OscP5 oscP5 = este viene incluido solo uno por el programa que es nuestro conector hacia PD
    NetAddress direccion = este igual que el anterior nos permitira hacer la conexion
*/
class VSlider { 
  boolean locked = false; 
  boolean overBox = false;
  float yOffset = 0.0; 
  int initPosY = 9;
  int posX;
  
  int SliderYlong = 80;
  
  
  float by = SliderYlong-15+initPosY;
  
  NetAddress direccionRemota;
  OscP5 osc;

  String port = "/Slider/Harmony/";
  
  float[] position = new float[10];
  int actualPosition =0;
  
  VSlider(int x, int numberSlider,
  OscP5 oscP5, NetAddress direccion) {  
    posX = x;
    
    direccionRemota = direccion;
    osc = oscP5;
    
    port = port+numberSlider;
    
    oscValue();
    
    for(int i=0;i<10;i++){
      position[i] = by;
    }
  } 
  
  void namePort(String nameport){
    port = "/Slider/"+nameport;
  }

  void initY(int posY){
    initPosY = posY;
    by = 80-15+initPosY;
    
    for(int i=0;i<10;i++){
      position[i] = by;
    }
  }
  
  /* 
    En processing no tenemos valor por defecto
    y por esa falta de ello manejamos es un cambio de estado por una funcion,
    y asi hackiamos processing cuando lo necesitamos ;).
    PD: la otra opcion seria hacer una clase que heredara los valores de esta, pero eso es otra historia.
  */
  void sedSliderYlong(int Yvalue){
    SliderYlong = Yvalue;
    by = SliderYlong-15+initPosY;
    
    for(int i=0;i<10;i++){
      position[i] = by;
    }
  }
  
  void button(int number){
    actualPosition = number;
  }
  
  void update() {
    //Muestra mid del slider
    pushStyle();
      fill(255);
      noStroke();
      rect(posX,initPosY+(SliderYlong/2),
        50,5);
    popStyle();
    
    //Barra Slider
    pushStyle();
      noStroke();
      rect(posX+15,initPosY,
        20,SliderYlong,25);
    popStyle();
    
    //Potenciometro Slider
    pushStyle();
      fill(#72C4C6);
      rect(posX,position[actualPosition],50,15,5);
    popStyle();
    
    by = position[actualPosition];
    
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
    
    position[actualPosition] = by;
  }
  
  // Sera nuestro mensaje osc para cada uno de nuestros slider
  void oscValue(){
    //println(by);
    OscMessage VSMessage = new OscMessage(port);
    //float value = map(by, 10.0,initPosY+65, 100, 0);
    float value = map(by, initPosY+1,initPosY+(SliderYlong-15), 1, 0);
    //println(value);
    VSMessage.add(value);
    osc.send(VSMessage, direccionRemota); // <=== Envia el mensaje
  }
}
