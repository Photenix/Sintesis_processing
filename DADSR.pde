class DADSR {
  
  int initBoxX = 350, initBoxY = 280;
  
  int zero = initBoxY+100;
  
  float yOffset = 0.0; 
  
  //Values Atack
  float endAtackX = initBoxX+100;

  //Values Decay
  float endDecayX = endAtackX+100;

  //Values Sustain
  float endSustainX = initBoxX+300;
  float SustainY = initBoxY+50;

  //min and max
  float minRelease = initBoxX+300;

  float minAtack = initBoxX+10, maxAtack = endAtackX;

  float maxDecay = endDecayX;


  //ms 
  float msDecay = 100, msAtack, msRelease;
  float volSustain;

  
  //Selection
  boolean atack = false, decay = false, 
    sustain = false, release = false;
  
  NetAddress direccionRemota;
  OscP5 osc;

  String port = "/Set/DADSR";

  float[][] harmonyesDADSR ;

  int hnumber = 0;

  DADSR(OscP5 oscP5, NetAddress direccion) {
    osc = oscP5;
    direccionRemota = direccion;
    oscValue();
    
    harmonyesDADSR = new float[10][4];

    for (int i = 0; i < 10; ++i) {

      harmonyesDADSR[i][0] = endAtackX;
      harmonyesDADSR[i][1]= endDecayX;
      harmonyesDADSR[i][2]= SustainY;
      harmonyesDADSR[i][3]= endSustainX;

    }

  }
  void update() {
    boxContainer();
    
    pushStyle();
      stroke(255);
      msAtack();
      msDecay();
      sustain();
      msRelease();
    popStyle();

    comprobantes();

    allEventMouse();
  }

  void readPosition(){
    harmonyesDADSR[hnumber][0] = endAtackX;
    harmonyesDADSR[hnumber][1]= endDecayX;
    harmonyesDADSR[hnumber][2]= SustainY;
    harmonyesDADSR[hnumber][3]= endSustainX;

    //println(harmonyesDADSR[hnumber]);
  }

  void position(int number){
    endAtackX = harmonyesDADSR[number][0];
    endDecayX = harmonyesDADSR[number][1];
    SustainY = harmonyesDADSR[number][2];
    endSustainX = harmonyesDADSR[number][3];

    hnumber = number;
  }

  void  boxContainer() {
    pushStyle();
      noFill();
      rect(initBoxX, initBoxY, 400, 100);
    popStyle();

    pushStyle();
      fill(0);
      textSize(20);
  
      text(1, 337, 281);
      text(0, 337, 281+100);
    popStyle();
  }

  void msAtack() {
    line(initBoxX, zero, endAtackX, initBoxY);

    if(
      mouseX > initBoxX && mouseX < maxAtack &&
      mouseY > initBoxY && mouseY < zero
    ) {
      atack = true;
    }else atack = false;

    msAtack = endAtackX-initBoxX;

    button(endAtackX, initBoxY,atack);
  }
  
  void msDecay() {
    line(endAtackX, initBoxY, endDecayX, SustainY);
    if(
      mouseX > endAtackX+2 && mouseX < maxDecay &&
      mouseY > initBoxY && mouseY < zero
    ) {
      decay = true;
    }else decay = false;

    msDecay = endDecayX-endAtackX;

    button(endDecayX, SustainY,decay);
  }
  
  void sustain() {
    pushStyle();
      stroke(255);
      line(endDecayX, SustainY, endSustainX, SustainY);
    popStyle();
    
    if(
      mouseX > endDecayX && mouseX < endSustainX-10 &&
      mouseY > initBoxY && mouseY < zero
    ) {
      sustain = true;
    }else sustain = false;  

  }
  
  void msRelease() {
    line(endSustainX, SustainY, initBoxX+400, zero);

    if(
      mouseX > initBoxX+300 && mouseX < initBoxX+400 &&
      mouseY > initBoxY && mouseY < zero
    ) {
      release = true;
    }else release = false;
    
    msRelease = initBoxX+400-endSustainX;

    button(endSustainX, SustainY,release);
  }
  
  
  void allEventMouse() {
    if(mousePressed){
      mouseDragged();
    }
  }
  
  void mouseDragged() {

    if(atack) {
      endAtackX = mouseX-yOffset;
      if(endAtackX > maxAtack) endAtackX = maxAtack;
      if(endAtackX < minAtack) endSustainX = minAtack;

      endDecayX = endAtackX+msDecay;
      oscValue();
    }

    if(decay) {
      endDecayX = mouseX-yOffset;
      if(endDecayX > maxAtack) endAtackX = maxAtack;
      if(endDecayX < endAtackX+10) endAtackX = endAtackX-10;
      oscValue();
    }

    if(sustain) {
      SustainY = mouseY-yOffset;
      if(SustainY < initBoxY) SustainY = initBoxY;
      if(SustainY > zero) SustainY = zero;
      oscValue();
    }

    if(release) {
      endSustainX = mouseX-yOffset;
      if(endSustainX < minRelease) endSustainX = initBoxX+300;
      if(endSustainX > initBoxX+390) endSustainX = initBoxX+390;
      oscValue();
    }
    readPosition();
  }
  
  void button(float x, float y, boolean nButton){
    boolean n = nButton;
    rect(x-2.5, y,5,5);
    if(
      mouseX > x-2.5 && mouseX < x-2.5+5 &&
      mouseY > y && mouseY < y+5
    ){
      pushStyle();
        fill(#FF7979);
        rect(x-2.5, y,5,5);
      popStyle();
      n = true;
    }else n =false;
  }

  void comprobantes(){
    if(endSustainX < minRelease)endSustainX = minRelease;
  }
  
  void oscValue(){
    OscMessage DADSRMessage = new OscMessage(port);

    //println("Atack "+ msAtack);
    //println("Decay "+ msDecay);
    //println("Release "+ msRelease);
    
    float Atack = map(msAtack, 1.0,99.0, 10, 2000);
    float Decay = map(msDecay, 10.0,99.0, 100, 1000);
    float Sustain  = map(SustainY,initBoxY+100,initBoxY,0,1);
    float Release = map(msRelease, 10.0,99.0, 100, 1000);

    //println(value);
    
    DADSRMessage.add(Atack);
    DADSRMessage.add(Decay);
    DADSRMessage.add(Sustain);
    DADSRMessage.add(Release);

    osc.send(DADSRMessage, direccionRemota);
    
  }
  
}
