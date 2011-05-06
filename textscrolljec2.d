/**
	Arthur: Joel Ezra Christensen
	Aim: Animation of text
	Date: 6 Sep 2010
	Orgin: http://rosettacode.org/wiki/Animation#D - key things: 'text = text[1 .. $] ~ text[0];' <- some one did, and using slice ([0..20])
	Usage: eg. 'textscroll < text.txt' at the command prompt, or shortcut propeties
*/
import std.stdio: stdin;
import std.string: lines, strip, toStringz, split;
import jec2.all;

void main(string[] args) {
	Init(split("-wxh 320 240") ~ args);
//	auto text = "I went for a walk and fell down a hole."; // Hard coded text
	/// Main string holds all the data at once
	string text;
	foreach (string line; lines(stdin)) { // Read in text line by line (to choose text put in the command prompt eg. 'textscoll < journal.txt'
		text ~= strip(line) ~ " "; // append text to text string, and remove new line characters and replace with a space
	}
	
	char[] gap;
	gap.length=(SCREEN_W/8)*(SCREEN_H/8);
	gap[] = ' ';
	text = cast(string)gap ~ text;
	// Main loop, 
	while (! key[KEY_ESC]) {
		text = text[1 .. $] ~ text[0];
		foreach (y; 0 .. SCREEN_H/8) {
			textprintf_ex(screen, font, 0, y * 8, Colour.amber, 0, toStringz(text[y * (SCREEN_W / 8) .. y * (SCREEN_W / 8) + SCREEN_W / 8]));
		}
		if (! key[KEY_LSHIFT])
			rest(100);
	}
}