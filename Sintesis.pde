import oscP5.*;
import netP5.*;

OscP5 oscP5; 
NetAddress direccionRemota;

oscKeyMessage KeyMesage;

int puerto;
String ip;


void setup(){
  size(850,350);
  
  ip = "127.0.0.1";
  puerto = 1111;
  
  oscP5 = new OscP5(this, puerto);
  direccionRemota = new NetAddress(ip, puerto);
  
  KeyMesage = new oscKeyMessage(oscP5,direccionRemota);
}

void draw(){
  background(#FC6363);
  
  drawKeyboard(2,oscP5,direccionRemota);
  
  KeyMesage.update();
}
