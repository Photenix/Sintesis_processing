ArrayList<VSlider> VSliders;
ArrayList<keyWhiteClass> keysWhite;

boolean initSlider = true, initKeysWhite = true;

void drawKeyboard(int oct, OscP5 oscP5, NetAddress direccion){
  
  initSliders(oscP5,direccion);
  initKeysWhite(oct);
  
  for (int i = VSliders.size()-1; i >= 0; i--){
    VSlider vsder = VSliders.get(i);
    vsder.update();
  }
  
  for (int i = oct*7; i >= 0; i--){
    keyWhiteClass kWhite = keysWhite.get(i);
    kWhite.update();
  }
  
  //whiteKeyBoard(oct);
  
  blackKeyBoard(oct);
}

void initKeysWhite(int oct){
  char keysNote[] ={
    'z','x','c','v','b','n','m',
    'q','w','e','r','t','y','u',
    'i'
  };
  
  if(initKeysWhite){
    keysWhite = new ArrayList<keyWhiteClass>();
    for(int i = 1;i <= 7*oct;i++){
      keysWhite.add(new keyWhiteClass(i,keysNote[i-1]));
    }
    keysWhite.add(new keyWhiteClass((7*oct)+1,keysNote[keysNote.length-1]));
    initKeysWhite = false;
  }
}



void initSliders(OscP5 oscP5, NetAddress direccion){
  if(initSlider){
    int nSlider = 1;
    VSliders = new ArrayList<VSlider>();
  
    for(int i = 60; i <= 75*10; i+=75){
      VSliders.add(new VSlider(i,nSlider,oscP5,direccion));
      nSlider++;
    }
    
    VSlider VolumenSlider = new VSlider(5,0,oscP5,direccion);
    
    VolumenSlider.namePort("Volumen");
    VolumenSlider.sedSliderYlong(380);
    VSliders.add(VolumenSlider);
    
    initSlider = false;
  }
}
