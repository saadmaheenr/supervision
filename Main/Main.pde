Player p;
int gameState;
PFont font;
String currentText;
PImage title;
PImage textbox;
// 0 = Title
// 1 = Settings
// 2 = Game
// 3 = Ending
void setup(){
 size(800, 600);
 font = createFont("ByteBounce.ttf",  50);
 textFont(font);
 
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
  int pos = 100;
  title = loadImage("title.png");
  image(title,200, pos);//Title
  if(keyPressed){
    gameState = 1;
  }
  if(pos == 100){
    pos+= 10;
  }
  if(pos == 110){
    pos -= 10;
  }
}

void state1(){
  rect(100, 100, 300, 100);
  rect(100, 250, 300, 100);
  rect(100, 400, 300, 100);
  if(mousePressed && mouseButton == LEFT){
    
  }
  
}

void state2(){
  background(0);
  textbox = loadImage("text-box.png");
  rect(150, 150, 400, 200); //Player
  image(textbox, 0, 500, 799, 100);
  fill(255);
  currentText = "Yay Yay Yay";
  fill(0);
  textDisplay(currentText);
}

void state3(){
  
}
void textDisplay(String e){
  // Iterates through the text
  text(currentText, 20, 540);
  
}

boolean over(int x, int y, int setw, int seth)  {
    if (mouseX >= x && mouseX <= x+setw && 
        mouseY >= y && mouseY <= y+seth) {
      return true;
  } else {
    return false;
    }
  }
