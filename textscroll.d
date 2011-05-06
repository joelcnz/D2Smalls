/**
	Arthur: Joel Ezra Christensen
	Aim: Animation of text
	Date: 6 Sep 2010
	Orgin: http://rosettacode.org/wiki/Animation#D - key things: 'text = text[1 .. $] ~ text[0];' <- some one did, and using slice ([0..20])
	Usage: eg. 'textscroll < text.txt' at the command prompt, or shortcut propeties
*/
import std.stdio: File, write, stdin;
import std.string: lines, strip, toStringz, split, replace;

//alias write fwrite;

void main(string[] args) {
//	auto text = "I went for a walk and fell down a hole."; // Hard coded text
	/// Main string holds all the data at once
	string text;
	foreach (string line; lines(stdin)) { // Read in text line by line (to choose text put in the command prompt eg. 'textscoll < journal.txt'
		text ~= strip(line) ~ " "; // append text to text string, and remove new line characters and replace with a space
	}
	foreach (r; split("\r \n"))
		text = replaceAll(text, r);
	auto f = File("z2.d", "w");
	f.write(text);
	
	// Main loop, 
	while (true) { // while Ctrl + C not pressed
		text = text[1 .. $] ~ text[0];
		foreach (c; 0 .. 2_000)
			write(text[0 .. 79]~"\r");
	}
}

string replaceAll(string text, string from) {
	string old = text.idup;
	text = replace( text, from, " ");
	if (text != old)
		replaceAll(text, from);
	return text;
}
