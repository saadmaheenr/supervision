Player p;
int gameState;
import org.guilhermesilveira.Timers;

PFont font;
String currentText;
int difficulty = 1;
String[] diff = {"Easy", "Normal", "Hard", "1hit"};
int time = 0;
int startTime = 0;
int[] ends = {60, 300, 600, 1200};
int endTime = 1;
int endGame;
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
    p.hp = 20 / difficulty;
    if(difficulty == 3){
      p.hp = 1;
    }
    endGame = ends[endTime];
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
  if(pos == 100 && random(1) > 0){
    pos+= 10;
  }
  if(pos == 110 && random(1) > 0){
    pos -= 10;
  }
}

void state1(){
  fill(255);
  rect(100, 100, 400, 100);
  fill(0);
  text("Select Difficulty", 120,150);
  fill(255);
  text(diff[difficulty], 600,150);
  rect(100, 250, 400, 100);
  fill(0);
  text("Select Time", 120, 300);
  fill(255);
  text(ends[endTime]/60 + " minutes", 600, 300);
  rect(100, 400, 400, 100);
  fill(0);
  text("Start", 120,450);
  fill(255);
  
  if(mousePressed && mouseButton == LEFT){
    if(over(100, 100, 400, 100)){
      if(difficulty == 3){
        difficulty = 0;
      }
      else{
      difficulty++;
      }
    }
    if(over(100, 250, 400, 100)){
      if(endTime == 3){
        endTime = 0;
      }
      else{
      endTime++;
      }
    }
    if(over(100, 400, 400, 100)){
      gameState = 2;
    }
  }
  
}

void state2(){
  background(0);
  textbox = loadImage("text-box.png");
  rect(150, 150, 400, 200); //Player
  image(textbox, 0, 500, 799, 100);
  fill(255);
  currentText = "One day there will be a game here..";
  fill(0);
  textDisplay(currentText);
  text("Time " + time, 120,150);
  
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
