import gifAnimation.*;
int gameState;
int hp;
Proj main;
PFont font;
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
Gif bullet;
int difficulty = 1;
String[] diff = {"Easy", "Normal", "Hard"};
int[] events = {0, 1, 2, 3, 4, 5, 6, 7, 8};
int parry = 5;
double mill = 0;
int time = 0; 
int startTime = 0;
int[] ends = {60, 120, 180, 300};
int endTime = 1;
int endGame;
int projCount;
PImage title;
PImage titlebg;
PImage button;
boolean run2 = true;
boolean reset = true;
boolean par = true;
boolean enabledmg = true;
String[] names = {"Shroom", "Bunny", "Allay"};
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
    hp = (int)(10/(difficulty + 1));
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
  1: Spawn homing projectiles
  2: Laser comes down on 1 of 3 columns
  3: Extra parries
  4: Wind pushes player in a random direction
  */
  if(time % 20 == 0){
    
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
  fill(0);
  textSize(75);
  text(hp, 400,120);
  text(parry, 550,120);
  text(endGame - time, 668,120);
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
  if(enabledmg == true){
  hp--;}
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
void textDisplay(){
  fill(240);
  textSize(50);
  text(currentText, 20, 970);
}


void state3(){
  
}

void state4(){
  
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
 
  text("START", 260, 900);
  
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
    if(over(220, 900, 350, 140)){
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



boolean over(float x, float y, float setw, float seth)  {
    if (mouseX >= x && mouseX <= x+setw && 
        mouseY >= y && mouseY <= y+seth) {
      return true;
  } else {
    return false;
    }
  }
  
