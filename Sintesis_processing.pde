import oscP5.*;
import netP5.*;

OscP5 oscP5; 

OscP5 ListeneroscP5; 

NetAddress direccionRemota;


oscKeyMessage KeyMesage;

DADSR dadsr;

VSlider delay;

int puerto;
String ip;

ArrayList<Button> buttons;

boolean initButtons = true;

void setup(){
  size(850,400);
  
  ip = "127.0.0.1";
  puerto = 12121;
  
  oscP5 = new OscP5(this, puerto);
  
  direccionRemota = new NetAddress(ip, puerto);
  
  KeyMesage = new oscKeyMessage(oscP5,direccionRemota);
  
  dadsr = new DADSR(oscP5,direccionRemota);

  delay = new VSlider(390+400,1,oscP5,direccionRemota);
  delay.namePort("Delay");
  delay.initY(280);
  delay.sedSliderYlong(100);

}

void draw(){
  background(#FC6363);
  
  drawKeyboard(2,oscP5,direccionRemota);
  
  KeyMesage.update();
  
  initButton();
  
  for (int i = buttons.size()-1; i >= 0; i--){
    Button bAll = buttons.get(i);
    bAll.update();
  }
  //oscValue();
  
  dadsr.update();
  delay.update();
}

void initButton(){
  if(initButtons){
    
    buttons = new ArrayList<Button>();
    for(int i = 1;i <= 5;i++){
      
      buttons.add(new Button(i,false,i-1,dadsr,delay));
      
      buttons.add(new Button(i,true,i+4,dadsr,delay));
    }
    initButtons = false;
  }
}
  
