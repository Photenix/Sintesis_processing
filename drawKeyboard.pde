
ArrayList<VSlider> VSliders;

boolean init = true;

void drawKeyboard(int oct){
  initSliders();
  
  for (int i = VSliders.size()-1; i >= 0; i--){
    VSlider vsder = VSliders.get(i);
    vsder.update();
  }
  
  whiteKeyBoard(oct);
  blackKeyBoard(oct);
}

void initSliders(){
  if(init){
    VSliders = new ArrayList<VSlider>();
  
    for(int i = 50; i <= 75*10; i+=75){
      VSliders.add(new VSlider(i));
    }
    init = false;
  }
}
