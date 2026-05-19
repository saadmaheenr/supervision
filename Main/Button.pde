class Button{
 int x, y;
 int sizeX, sizeY;
 color base, highlight;
 boolean over;
 Button(int x, int y, int sizeX, int sizeY, color c){
  this.x = x;
  this.y = y;
  this.sizeX = sizeX;
  this.sizeY = sizeY;
  base = c;
  highlight = c + 20;
   
 }
 boolean over(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
  } else {
    return false;
    }
  }
  
  
}
