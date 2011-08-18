import std.stdio;
import std.string;

void main() {
	string input;
	const numbers = "4988 7210 0179 1291 - 192 - 07/13";
	auto done = false;
	do {
		writeln( "h - help" );
		input = strip(readln);
		switch (input) {
			case "q":
				done = true;
			break;
			case "h":
				writeln(
					"Memmoary(sp) program" ~ newline ~
					"h   - for this" ~ newline ~
					"v   - view the main artical" ~ newline ~
					"c   - clear" ~ newline ~
					"[x] - any thing else gets checked" ~ newline
				);
			break;
			case "v":
				writeln( numbers );
			break;
			case "c":
				for (int l; l < 300; l++)
					writeln();
			break;
			default:
				if ( input == numbers )
					writeln("Perfect!");
				else
					writeln("Woops!");
			break;
		}
	} while (! done);
	writeln("Thank you for your time.");
}
