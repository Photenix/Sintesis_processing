int keyb_x = 25, keyb_y = 100;
void blackKeyBoard(int oct){
  
  boolean[] listkb ={false,true,true,false,true,true,true};
  
  char keysNote[] ={
    's','d','g','h','j',
    '2','3','5','6','7',
  };
  
  int nbucle = 1;
  int namelist = 0;
  
  
  for(int i = 1;i <= 1*oct;i++){
    for(boolean x : listkb){
      if(x){
        keyBlack(nbucle,keysNote[namelist]);
        
        if (mousePressed && (mouseButton == LEFT)) {
          if(
          mouseX >= (50*nbucle)-12.5 && 
          mouseX <= (((50*nbucle)-12.5)+25) &&
          mouseY >= 100 &&
          mouseY <= 100+keyb_y
          ){
            keyPressBlack(nbucle,keysNote[namelist]);
          }
        }
        
        if(keyPressed){
          if(key==keysNote[namelist]) {
            keyPressBlack(nbucle,keysNote[namelist]);
          }
        }
        
        namelist++;
      }
      nbucle++;
    }
  }
}

void keyBlack(int posX, char note){
  pushStyle();
    fill(0);
    rect((50*posX)-12.5,100,keyb_x,keyb_y);
  popStyle();
  
  pushStyle();
    fill(255);
    textSize(25);
    text(note,(50*posX)-7.5, 85+keyb_y);
  popStyle();
}

void keyPressBlack(int posX, char note){
  pushStyle();
    fill(#C3BBFA);
    rect((50*posX)-12.5,100,keyb_x,keyb_y);
  popStyle();
  
  pushStyle();
    fill(255);
    textSize(25);
    text(note,(50*posX)-7.5, 85+keyb_y);
  popStyle();
}
