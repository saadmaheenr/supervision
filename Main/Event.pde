class Event{
  String name, type, message;
  int intensity;
  String belowPar, onPar, abovePar;
  int damage;
  PImage sprite;
  Accessory add;
  Event(String n, String t, String m, Accessory add){
   name = n;
   type = t;
   message = m;
   this.add = add;
  }

  
}
