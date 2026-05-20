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
   
  }
  else if(gameState == 2){
    
  }
  
}

void state0(){
  rect(200, 100, 400, 200); //Title
  if(keyPressed){
    gameState = 1;
  }
  
}

void state1(){
  if(mousePressed && mouseButton == LEFT){
    
  }
  
}
