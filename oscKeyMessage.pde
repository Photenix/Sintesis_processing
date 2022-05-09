class oscKeyMessage{
  NetAddress direccionRemota;
  OscP5 osc;

  String port = "/Key";
  
  boolean keyon = true;
  
  oscKeyMessage(OscP5 oscP5, NetAddress direccion){
    
    direccionRemota = direccion;
    osc = oscP5;
  }
  
  void update(){
    if(keyPressed){
      if(keyon){
        oscValue(1);
        keyon =false;
      }
      
    }else {
      if(!keyon){
        oscValue(0);
        keyon = true;
      }
    }
  }
  
  void oscValue(int IO){
    OscMessage KeyMessage = new OscMessage(port);
    
    //char keyNote = (char)key;
    //println(keyNote);
    
    KeyMessage.add(key);
    KeyMessage.add(IO);
    
    osc.send(KeyMessage, direccionRemota);
  }
}
