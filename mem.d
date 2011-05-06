import std.stdio;
import std.string;

void main() {
	string input;
	const number = "4988 7210 0179 1291";
	auto done = false;
	do {
		input = strip(readln);
		switch (input) {
			case "q":
				done = true;
			break;
			case "v":
				writeln(number);
			break;
			case "c":
				for (int l; l < 300; l++)
					writeln();
			break;
			default:
				if (input == number)
					writeln("Perfect!");
				else
					writeln("Woops!");
			break;
		}
	} while (! done);
	writeln("Thank you for your time.");
}
