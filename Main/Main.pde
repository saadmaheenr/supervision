// Design Document https://docs.google.com/document/d/1q6pcNHOzePtnTnFkWSbN_ncsATD2z56XCs1AGmRwTWg/edit?usp=sharing
import gifAnimation.*;
int gameState;
int hp;
Proj main;
PFont font;
int rande;
String currentText = "";
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
int c = 0;
Gif bullet;
Gif bunnyend;
Gif allayend;
int difficulty = 1;
String[] diff = {"Easy", "Normal", "Hard"};
int parry = 5;
double mill = 0;
int time = 0; 
int startTime = 0;
int[] ends = {2, 120, 180, 300};
int endTime = 1;
int endGame;
int projCount;
PImage title;
PImage titlebg;
PImage button;
boolean run2 = true;
boolean reset = true;
boolean par = true;
boolean bounce = false;
boolean setrandom;
String[] names = {"Bunny", "Allay"};
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
 bunnyend = new Gif(this, "bunnyend.gif");
 bunnyend.loop();
 allayend = new Gif(this, "allayend.gif");
 allayend.loop();
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
static int limit= 7;
static void setLimit(int i){
    limit = i;
  }
void draw(){
  if(gameState == 0){
    state0(); 
  }
  else if(gameState == 1){
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
    hp = (int)(20/(difficulty + 1));
    mill = millis();
    endGame = ends[endTime];
    run2 = false;
    }
    state2();
  }
  else if(gameState == 3){
    state3();
  }
  else if(gameState == 4){
    state4();
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
  /* Events:
  0: Projectile speed increase
  1: Laser comes down on 1 of 3 columns
  2: Extra parries
  3: Wind pushes player in a random direction
  4: Hud dissapears
  5: Lucky lucky
  */

  if(time % 20 == 0 && time != 0){
    setLimit(7);
    bounce = false;
    c = 0;
    if(rande == 0){
     setLimit(12);
     currentText = "Zooom!";
    }
    if(rande == 1){
      bounce = true;
      currentText = "Boing";
    }
    if(rande == 2){
      parry = 8; 
      currentText = "Ding ding!";
      rande = 9;
    }
    if(rande == 3){
      c = 255;
      currentText = "Where'd everything go?";
    }
    if(rande > 3 && rande < 9){
      currentText = "Keep going..";
    }
    
  }
  else{
    rande = (int)(random(5));
  }
  if(mousePressed && mouseButton == LEFT && par == true){
    if(parry <= 0){
      currentText = "* No charges!";}
      else{
    par = false;
    parry--;
    background(125);
    for (Proj p : projListA) {
    PVector force = new PVector(random(-2,2), -10);
    p.applyForce(force);
  }
  for (Proj p : projListB) {
    PVector force = new PVector(random(-2,2), 10);
    p.applyForce(force);
  }
  for (Proj p : projListC) {
    PVector force = new PVector(10, random(-2,2));
    p.applyForce(force);
  }
  for (Proj p : projListD) {
    PVector force = new PVector(-10, random(-2,2));
    p.applyForce(force);
  }
     }}
     if(!mousePressed){
       par = true;
     }
  
  game = loadImage("game.png");
  image(game, 0, 0, 800, 1000);
  fill(c);
  textSize(75);
  text(names[player], 50,75);
  text(hp, 400,120);
  text(parry, 550,120);
  text(endGame - time, 680,120);
  textDisplay();
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
  if(hp <= 0){
    gameState = 4;
  }
}
PVector getMainPos(){
  return main.getPos();
}
void reduceHp(){
  hp--;
}
void kill(){
  hp = 0;
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
  main.movenolim();
  main.bounce();
  PVector pos = main.getPos();
  PVector force = new PVector((mouseX - pos.x)/40, (mouseY - pos.y)/40);
  main.applyForce(force);
  
}
void moveProjectile(){
  for (Proj p : projListA) {
    p.move();
    if(bounce){ p.bounce();}
    p.display();
  }
 for (Proj p : projListB) {
    p.move();
    if(bounce){ p.bounce();}
    p.display();
  }
  for (Proj p : projListC) {
    p.move();
    if(bounce){ p.bounce();}
    p.display();
  }
 for (Proj p : projListD) {
    p.move();
    if(bounce){ p.bounce();}
    p.display();
  }
}
void textDisplay(){
  fill(240);
  textSize(50);
  text(currentText, 20, 970);
}


void state3(){
  image(titlebg, 0, 0, 800, 1000);
  game = loadImage("game.png");
  image(game, 0, 0, 800, 1000);
  fill(0);
  textSize(75);
  text(names[player], 50,75);
  text(hp, 400,120);
  text(parry, 550,120);
  text(0, 668,120);
  textSize(200);
  if(player == 0){
  image(bunnyend, 260, 400);}
  else{
    image(allayend, 260, 400);
  }
  text("END :)", 230,900);
}

void state4(){
  image(gamebg, 0, 0, 800, 1000);
  game = loadImage("game.png");
  image(game, 0, 0, 800, 1000);
  fill(0);
  textSize(75);
  text(names[player], 50,75);
  text(0, 400,120);
  text(parry, 550,120);
  text(endGame - time, 680,120);
  fill(255);
  textSize(200);
  text("END ):", 230,900);
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
  int pos = 100;
  title = loadImage("title.png");
  titlebg = loadImage("titlebg.png");
  textSize(75);
  image(titlebg, 0, 0);
  image(title,200, pos);//Title
  fill(0);
  button = loadImage("button.png");
  image(button, 220, 440, 350, 140);
  text(diff[difficulty], 260, 530);
  image(button, 220, 650, 350, 140);
  text(ends[endTime]/60 + " minutes", 260, 740);
 
  text("START: " + names[player], 220, 900);
  
  if(mousePressed && mouseButton == LEFT && letGo == true){
    if(over(220, 440, 350, 140)){
      if(difficulty == 2){
        difficulty = 0;
      }
      else{
      difficulty++;
      }
    }
    if(over(220, 650, 350, 140)){
      if(endTime == 3){
        endTime = 0;
      }
      else{
      endTime++;
      }
    }
    if(over(220, 800, 350, 140)){
      gameState = 2;
    }
    letGo = false;
  }
  if(mousePressed == false){
    letGo = true;
  }
  if(keyPressed && letGoKey){
    if(player == 1){
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



boolean over(float x, float y, float setw, float seth)  {
    if (mouseX >= x && mouseX <= x+setw && 
        mouseY >= y && mouseY <= y+seth) {
      return true;
  } else {
    return false;
    }
  }
  
