class keyWhiteClass{
  int keyw_x = 50, keyw_y = 150;
  int posX;
  char note_key;
  
  int addposition = 20;
  
  keyWhiteClass(int x, char note){
    posX = x;
    note_key = note;
    
  }
  
  void update(){
    key(posX);
    if (mousePressed && (mouseButton == LEFT)) {
      if(
        mouseX >= 50*posX+addposition && 
        mouseX <= (50*posX)+50+addposition &&
        mouseY >= 100 &&
        mouseY <= 100+keyw_y
        ){
        keyPress(posX);
      }
    }
    
    if(keyPressed){
      if(key==note_key) {
        keyPress(posX);
      }
    }
    
    textNote(note_key);
  }
  
  void key(int posX){
    pushStyle();
      fill(255);
      //rect(50*posX,100,keyw_x,keyw_y);
      rect((50*posX)+addposition,100,keyw_x,keyw_y);
    popStyle();
  }
  
  void keyPress(int posX){
    pushStyle();
      fill(#FA9F9F);
      rect(50*posX+addposition,100,keyw_x,keyw_y);
    popStyle();
  }
  
  void textNote(char note){
    pushStyle();
      fill(0, 0, 0);
      textSize(25);
      text(note,(50*posX)+20+addposition, 85+keyw_y);
    popStyle();
  }
  
  
}
