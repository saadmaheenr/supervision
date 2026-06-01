import gifAnimation.*;
class Proj {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PImage sprite;
  color c;
  int limit= 7;
  Gif sprit;
  float mass;
  ArrayList<PVector> forces = new ArrayList<PVector>();

  Proj(float x, float y, float xVel, float yVel, Gif i) {
    location = new PVector(x, y);
    velocity = new PVector(xVel, yVel);
    acceleration = new PVector(0, 0);
    c = 200;
    mass = random(0.2, 2);
    sprit = i;
  }
  Proj(float x, float y, float xVel, float yVel, int i) {
    if(i == 0){
      sprite = loadImage("bubble.png");
    }
    if(i == 1){
      sprite = loadImage("bunny.png");
    }
    if(i == 2){
      sprite = loadImage("frog.png");
    }
    location = new PVector(x, y);
    velocity = new PVector(xVel, yVel);
    acceleration = new PVector(0, 0);
    c = 200;
    mass = 4;
  }
  PVector getPos(){
    return location;
  }
  void forcemove(float x, float y){
    location = new PVector(x, y);
  }
  void move() {
    location.add(velocity);
    velocity.add(acceleration);
    acceleration = new PVector(0, 0);
    velocity.limit(limit); 
  }
  void movenolim() {
    location.add(velocity);
    velocity.add(acceleration);
    acceleration = new PVector(0, 0);
    velocity.limit(10); 
  }
  void setLimit(int i){
    limit = i;
  }
  void bounce() {
    // Update your bounce code to use vectors
    if (location.x <= 0) {
      velocity.x = (velocity.x - 1) * -1;
      forcemove(1, location.y);
    }
    if (location.x >= 700) {
      velocity.x = (velocity.x + 1) * -1;
    }
    if (location.y >= 800) {
      velocity.y = (velocity.y + 1) * -1;
    }
    if (location.y <= 160) {
      velocity.y = (velocity.y - 1) * -1;
    }
  }

  void applyForce(PVector force) {
    acceleration.add(force.div(mass));
  }
 
  void pdisplay(){
    image(sprite, location.x, location.y, 90, 90);
  }

  void display() {
    stroke(1);
    strokeWeight(2);
    fill(c);
    sprit.loop();
    image(sprit, location.x, location.y, 60, 60);
  }
}
