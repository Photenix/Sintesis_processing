int keyw_x = 50, keyw_y = 150;

void whiteKeyBoard(int oct){
  char keysNote[] ={
    'z','x','c','v','b','n','m',
    'q','w','e','r','t','y','u',
    'i'
  };
  
  for(int i = 1;i <= 7*oct;i++){
    
    keyWhite(i,keysNote[i-1]);
    
    if (mousePressed && (mouseButton == LEFT)) {
      if(
        mouseX >= 50*i && 
        mouseX <= (50*i)+50 &&
        mouseY >= 100 &&
        mouseY <= 100+keyw_y
        ){
        keyPressWhite(i,keysNote[i-1]);
      }
    }
    
    if(keyPressed){
      if(key==keysNote[i-1]) {
        keyPressWhite(i,keysNote[i-1]);
      }
    }
    
  }
    keyWhite((7*oct)+1,keysNote[keysNote.length-1]);
    
    if (mousePressed && (mouseButton == LEFT)) {
      if(
        mouseX >= 50*((7*oct)+1) && 
        mouseX <= (50*((7*oct)+1))+50 &&
        mouseY >= 100 &&
        mouseY <= 100+keyw_y
        ){
        keyPressWhite((7*oct)+1,keysNote[keysNote.length-1]);
      }
    }
    
    if(keyPressed){
      if(key==keysNote[keysNote.length-1]) {
        keyPressWhite((7*oct)+1,keysNote[keysNote.length-1]);
      }
    }
    
}


void keyWhite(int posX, char note){
  rect(50*posX,100,keyw_x,keyw_y);
  pushStyle();
    fill(0, 0, 0);
    textSize(25);
    text(note,(50*posX)+20, 85+keyw_y);
  popStyle();
}


void keyPressWhite(int posX, char note){
  pushStyle();
    fill(#FA9F9F);
    rect(50*posX,100,keyw_x,keyw_y);
  popStyle();
  
  pushStyle();
    fill(0, 0, 0);
    textSize(25);
    text(note,(50*posX)+20, 85+keyw_y);
  popStyle();
}
