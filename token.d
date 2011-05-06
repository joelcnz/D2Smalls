import std.stdio;
import std.string;

void main() {
	string[] tokens = "I went for a walk and fell down a hole!".split;
	foreach (word; tokens)
		writeln(word);
}
