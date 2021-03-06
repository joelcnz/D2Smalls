// jec2
/**
This program should be able to take command prompt arguments. And draw boxes, smaller shape smaller boxes.
*/
import jec2.all; // Allegro wrapper
import std.conv; // for coverting strings to integers
import std.string; // For  set to char*

void main(string[] args) {
  Init(args); // Allegro setup
  alias args a;
  alias to!int n;
  int w=n(a[1]);
  int h=n(a[2]);
  void rect(int x, int y) {
    rect(screen, x,y, x+w,y+h, Colour.amber);
  }
  foreach (y; 0..(h+1)) {
    foreach (x; 0..(w+1))
      rect(x, y), x+=w;
    y+=h;
  }
  textprintf_ex(screen, font, 0,SCREEN_H-8, Colour.green, 0, toStringz("Press any key to continue..."));
  readkey;
  write("Enter your name: ");
  string name=getInput;
  void drawName() (
     textprintf_ex(screen, font, 0,SCREEN_H-8, Colour.green, 0, toStringz(name));
  )
  foreach (y; 0..8*h) {
    foreach (x; 0..name.length*8*w)
      drawName, x+=name.length*8;
    y+=h;
  }
  readkey;
  write("Enter your age: ");
  int age=to!int(getInput);
  foreach (y; 0..age)
    putpixel(screen, y*2, 200, Colour.gray);
  readkey;
}

string getInput() {
  string str;
  readln(str);
   return strip(str);
}
 