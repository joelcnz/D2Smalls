// jec2
/**
Date: 3.08.2010
Discription: This program should be able to take command prompt arguments. And draw boxes, smaller shape smaller boxes.
Information: This program was done on my cell phone, while waiting. It didn't compile, this is a fixed up version, done since.
*/
import std.stdio; // for write and readln etc
import std.conv; // for coverting strings to integers
import std.string; // For set to char*
import jec2.all; // Allegro wrapper

string getInput() {
	return strip(readln);
}

void doWidthFromStr(string[] args, ref int w, ref int h) {
	alias args a;
	int toInt(string str) {
		return to!int(str);
	}
	int[2] nums;
	foreach (i, str; a[0..2])
		nums[i]=toInt(str);
	enum Index {width, height};
	w=nums[Index.width];
	h=nums[Index.height];
}

void main(string[] args) {
	Init(args); // Allegro setup
	args~=split("3 3"); // default
	int w,h;
	doWidthFromStr(args[1..3], w,h);
	void jrect(int x, int y) {
		rectfill(screen, x,y, x+w-1,y+h-1, Colour.amber);
	}
	foreach (y; 0..(h*(h+1))) {
		foreach (x; 0..(w*(w+1)))
			jrect(x, y), x+=w;
		y+=h;
	}
	textprintf_ex(screen, font, 0,SCREEN_H-8, Colour.green, 0, toStringz("Press any key to continue..."));
	readkey;
	rectfill(screen, 0, SCREEN_H-8, SCREEN_W, SCREEN_H, Colour.black);
	write("Enter your name: ");
	string name=getInput;
	void drawName(int x, int y) {
		 textprintf_ex(screen, font, x,SCREEN_H-8-y, Colour.green, 0, toStringz(name));
	}
	foreach (y; 0..8*h) {
		foreach (x; 0..name.length*8*w)
			drawName(x,y), x+=name.length*8-1; // gets incremented automaticaly(sp)
		y+=7;
	}
	readkey;
	write("Enter your age: ");
	int age=to!int(getInput);
	foreach (y; 0..age)
		putpixel(screen, y*2, 200, Colour.gray);
	while (! key[KEY_ESC]) {}
}
