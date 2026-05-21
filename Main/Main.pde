Player p;
int gameState;
// 0 = Title
// 1 = Settings
// 2 = Game
// 3 = Ending
void setup(){
 size(800, 600);
 
}
void draw(){
  if(gameState == 0){
    state0(); 
  }
  else if(gameState == 1){
   background(49);
   state1();
  }
  else if(gameState == 2){
    state2();
  }
  else if(gameState == 3){
    state3();
  }
}

void state0(){
  rect(200, 100, 400, 200); //Title
  if(keyPressed){
    gameState = 2;
  }
  
}

void state1(){
  if(mousePressed && mouseButton == LEFT){
    
  }
  
}

void state2(){
  background(0);
  rect(150, 150, 400, 200); //Player
  rect(0, 500, 800, 100);
}

void state3(){
  
}
void textDisplay(){
  
  
}
boolean over(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
  } else {
    return false;
    }
  }
