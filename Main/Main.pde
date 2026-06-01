import gifAnimation.*;
int gameState;
int hp;
Proj main;
PFont font;
String currentText;
boolean letGo;
boolean letGoKey;
ArrayList<Proj> projListA;
Proj TA;
PVector tA;
ArrayList<Proj> projListB;
Proj TB;
PVector tB;
ArrayList<Proj> projListC;
Proj TC;
PVector tC;
ArrayList<Proj> projListD;
Proj TD;
PVector tD;
Gif bullet;
int difficulty = 1;
String[] diff = {"Easy", "Normal", "Hard"};
int parry = 5;
double mill = 0;
int time = 0; 
int startTime = 0;
int[] ends = {60, 300, 600, 1200};
int endTime = 1;
int endGame;
int projCount;
PImage title;
PImage titlebg;
boolean run2 = true;
boolean takedmg = true;
boolean reset = true;

String[] names = {"Shroom", "Bunny", "Frog"};
int player; //0-2
//PImage[] playerState
PImage game;
PImage gamebg;

// 0 = Title
// 1 = Settings
// 2 = Game
// 3 = Ending
void setup(){
 size(800, 1000);
 bullet = new Gif(this, "bullet.gif");
 font = createFont("ByteBounce.ttf",  50);
 textFont(font);
 TA = new Proj(100, 400, 20, 2, 3);
 tA = TA.getPos();
 TB = new Proj(400, 300, -1, -1, 3);
 tB = TB.getPos();
 TC = new Proj(200, 500, 3, -2, 3);
 tC = TC.getPos();
 TD = new Proj(500, 600, -2, 1, 3);
 tD = TD.getPos();
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
    main = new Proj(400, 400, 0, 0, player);
    projCount = difficulty + 1;
    projListA =  new ArrayList<Proj>();
    
   for(int i = 0; i < projCount; i++){
   projListA.add(new Proj(tA.x, tA.y, random(-360,360), random(-360,360), bullet));
 }
 projListB =  new ArrayList<Proj>();
   for(int i = 0; i < projCount; i++){
   projListB.add(new Proj(tB.x, tB.y, random(-360,360), random(-360,360), bullet));
 }
 projListC =  new ArrayList<Proj>();
   for(int i = 0; i < projCount; i++){
   projListC.add(new Proj(tC.x, tC.y, random(-360,360), random(-360,360), bullet));
 }
 projListD =  new ArrayList<Proj>();
   for(int i = 0; i < projCount; i++){
   projListD.add(new Proj(tD.x, tD.y, random(-360,360), random(-360,360), bullet));
 }
    hp = (int)(6/(difficulty + 1));
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

void state2(){
  background(35);
  time = (int)((millis() - mill)/1000);
  gamebg = loadImage("gamebg.png");
  image(gamebg, 0, 0);
  main.pdisplay();
  fill(255);
  textSize(50);
  
 tA = TA.getPos();

 tB = TB.getPos();
 
 tC = TC.getPos();
 
 tD = TD.getPos();
  if(time >= 3){
  moveProjectile();}
  moveMain();
  moveTurret();
  
  game = loadImage("game.png");
  image(game, 0, 0, 800, 1000);
  fill(0);
  textSize(75);
  text(hp, 400,120);
  text(parry, 550,120);
  text(endGame - time, 668,120);
  if((time + 1) % 3 == 0){
    TA.changetB();
    TB.changetB();
    TC.changetB();
    TD.changetB();
  }
  if(time % 3 == 0 && reset == true){
    resetProjectile();
  }
  if((time - 1) % 3 == 0){
    TA.changetA();
    TB.changetA();
    TC.changetA();
    TD.changetA();
    reset = true;
  }
  
  
  if(time == endGame){
    gameState = 3;
  }
}
PVector getMainPos(){
  return main.getPos();
}
void reduceHp(){
  hp--;
}
void moveTurret(){
  TA.tdisplay();
  TA.movet();
  TA.bounce();
  
  TB.tdisplay();
  TB.movet();
  TB.bounce();
  
  TC.tdisplay();
  TC.movet();
  TC.bounce();
  
  TD.tdisplay();
  TD.movet();
  TD.bounce();
}
void resetProjectile(){
  reset = false;
  for (Proj p : projListA) {
    p.forcemove(tA.x, tA.y);
    PVector force = new PVector(random(-360,360), random(-360,360));
    p.applyForce(force);
  }
  for (Proj p : projListB) {
    p.forcemove(tB.x, tB.y);
    PVector force = new PVector(random(-360,360), random(-360,360));
    p.applyForce(force);
  }
  for (Proj p : projListC) {
    p.forcemove(tC.x, tC.y);
    PVector force = new PVector(random(-360,360), random(-360,360));
    p.applyForce(force);
  }
  for (Proj p : projListD) {
    p.forcemove(tD.x, tD.y);
    PVector force = new PVector(random(-360,360), random(-360,360));
    p.applyForce(force);
  }
  
}
void moveMain(){
  main.move();
  main.bounce();
  PVector pos = main.getPos();
  PVector force = new PVector((mouseX - pos.x)/100, (mouseY - pos.y)/100);
  main.applyForce(force);
  
}
void moveProjectile(){
  for (Proj p : projListA) {
    p.move();
    p.display();
  }
 for (Proj p : projListB) {
    p.move();
    p.display();
  }
  for (Proj p : projListC) {
    p.move();
    p.display();
  }
 for (Proj p : projListD) {
    p.move();
    p.display();
  }
}
void textDisplay(String e){

  text(e, 20, 970);

}


void state0(){
  int pos = 100;
  title = loadImage("title.png");
  titlebg = loadImage("titlebg.png");
  image(titlebg, 0, 0);
  image(title,200, pos);//Title
  fill(0);
  text("press any key", 260,500);
  if(keyPressed){
    gameState = 1;
  }
  
}

void state1(){
  fill(255);
  text(names[player], 100,80);
  rect(100, 100, 400, 100);
  fill(0);
  text("Select Difficulty", 120,150);
  fill(255);
  text(diff[difficulty], 550,150);
  rect(100, 250, 400, 100);
  fill(0);
  text("Select Time", 120, 300);
  fill(255);
  text(ends[endTime]/60 + " minutes", 550, 300);
  rect(100, 400, 400, 100);
  fill(0);
  text("Start", 120,450);
  fill(255);
  
  if(mousePressed && mouseButton == LEFT && letGo == true){
    if(over(100, 100, 400, 100)){
      if(difficulty == 2){
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


void state3(){
  
}


boolean over(float x, float y, float setw, float seth)  {
    if (mouseX >= x && mouseX <= x+setw && 
        mouseY >= y && mouseY <= y+seth) {
      return true;
  } else {
    return false;
    }
  }
  
