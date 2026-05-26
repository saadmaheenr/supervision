class Player{
 ArrayList<Accessory> addons;
 int hp, atk, def;
 double grow, water, food;
 String type, name;
 PImage[] sprite;
 Player(String type, String name, int hp){
   this.type = type;
   this.name = name;
   this.hp = hp;
   atk = 1;
   def = 1;
   grow = 1;
   water = 10;
   food = 10;
 }
 int getHp(){
   return hp;
 }
  
  
  
  
}
