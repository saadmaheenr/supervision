int gameState;
import org.guilhermesilveira.Timers;
Player p;
PFont font;
String currentText;
int k = 1;
boolean letGo;
boolean letGoKey;

int difficulty = 1;
String[] diff = {"Easy", "Normal", "Hard", "1hit"};

int time = 0;
int startTime = 0;
int[] ends = {60, 300, 600, 1200};
int endTime = 1;
int endGame;
PImage title;

PImage[] players = new PImage[3];
String[] names = {"Shroom", "Bunny", "Frog"};
int player; //0-2
//PImage[] playerState
PImage textbox;
// 0 = Title
// 1 = Settings
// 2 = Game
// 3 = Ending
void setup(){
 size(800, 600);
 font = createFont("ByteBounce.ttf",  50);
 players[0] = loadImage("shroom.png");
 players[1] = loadImage("bunny.png");
 players[2] = loadImage("frog.png");
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
    background(49);
    p = new Player("plant", "Sand", 12/(difficulty + 1));
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
  fill(0);
  text("press any key", 260,500);
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
  text(names[player], 100,80);
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
  
  if(mousePressed && mouseButton == LEFT && letGo == true){
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
    letGo = false;
  }
  if(mousePressed == false){
    letGo = true;
  }
  if(keyPressed && letGoKey){
    if(player == 2){
        player = 0;
      }
      else{
      player++;
      }
     letGoKey = false;
     
  }
  if(keyPressed == false){
    letGoKey = true;
  }
  
}

void state2(){
  background(0);
  textbox = loadImage("text-box.png");
  image(players[player], 275, 150, 256, 256);
  image(textbox, 0, 500, 799, 100);
  fill(0);
  currentText = "One day there will be a game here..";
  textDisplay(currentText);
}

void state3(){
  
}
void textDisplay(String e){
  // Iterates through the text, WIP
  new Timers(this).add(e.length(), 100, () -> textDisplayHelper(e) );
  k = 1;
}
void textDisplayHelper(String e){
  fill(0);
  text(e.substring(0, k), 20, 540);
  k++;
}

boolean over(int x, int y, int setw, int seth)  {
    if (mouseX >= x && mouseX <= x+setw && 
        mouseY >= y && mouseY <= y+seth) {
      return true;
  } else {
    return false;
    }
  }
