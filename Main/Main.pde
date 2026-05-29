int gameState;
import org.guilhermesilveira.Timers;
Player p;
PFont font;
String currentText;
boolean letGo;
boolean letGoKey;

int difficulty = 1;
String[] diff = {"Easy", "Normal", "Hard", "1hit"};

double mill = 0;
int time = 0; 
int startTime = 0;
int[] ends = {60, 300, 600, 1200};
int endTime = 1;
int endGame;
PImage title;

boolean run2 = true;
boolean runtext = true;

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
    if(run2 == true){
    background(49);
    p = new Player("plant", "Sand", 12/(difficulty + 1));
    mill = millis();
    endGame = ends[endTime];
    run2 = false;
    }
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
  fill(255);
  time = (int)((millis() - mill)/1000);
  text("Time: " + time, 120,150);
  text("End: " + endGame, 120,300);
  textbox = loadImage("text-box.png");
  image(players[player], 275, 150, 256, 256);
  image(textbox, 0, 500, 799, 100);
  fill(0);
  currentText = "One day there will be a game here..";
  textDisplay(currentText);
  
  if(time == endGame){
    gameState = 3;
  }
}

void state3(){
  
}
void textDisplay(String e){
  int k = 1;
  int startTime = millis();
  fill(0);
  while(k < e.length()){
  if(millis() > (startTime + 100)){
  text(e.substring(0, k), 20, 540);
  startTime = millis();
  k++;
  }
  }

}

boolean over(int x, int y, int setw, int seth)  {
    if (mouseX >= x && mouseX <= x+setw && 
        mouseY >= y && mouseY <= y+seth) {
      return true;
  } else {
    return false;
    }
  }
