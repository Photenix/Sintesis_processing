class Button{
  int keyw_x = 50, keyw_y = 50;
  int posX;
  int note_key;
  
  int posY = 280;
  
  int addposition = 20;
  
  String port = "/Button";

  DADSR controllerDADSR;
  
  Button(int x, boolean y, int note,DADSR objet){
    posX = x;
    note_key = note;
    if(y) posY+=53;
    
    port = port + note;
    
    if(note==0)oscValue();

    controllerDADSR = objet;
  }
  
  void update(){
    key(posX);
    
    
    if (mousePressed && (mouseButton == LEFT)) {
      if(
        mouseX >= 50*posX+addposition && 
        mouseX <= (50*posX)+50+addposition &&
        mouseY >= posY &&
        mouseY <= posY+keyw_y
        ){
        keyPress(posX);
      }
    }
    
    textNote(note_key);
    
  }
  
  void key(int posX){
    pushStyle();
      fill(255);
      rect((50*posX)+addposition,posY,keyw_x,keyw_y,100);
    popStyle();
  }
  
  void keyPress(int posX){
    pushStyle();
      fill(#FA9F9F);
      rect(50*posX+addposition,posY,keyw_x,keyw_y,100);
    popStyle();
    oscValue();
    
    controllerDADSR.position(note_key);
  }
  
  void textNote(int note){
    pushStyle();
      fill(0, 0, 0);
      textSize(25);
      text(note,(50*posX)+20+addposition, posY+(keyw_y/1.5));
    popStyle();
  }
  
  void oscValue(){
    OscMessage ButtonMessage = new OscMessage("/Button");
    //float value = map(by, 10.0,initPosY+65, 100, 0);
    int value = int(note_key);
    ButtonMessage.add(value);
    oscP5.send(ButtonMessage, direccionRemota);
  }
}
