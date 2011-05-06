import std.stdio: write, writeln, readln;
import std.string: chomp, isNumeric, munch, inPattern;
import std.conv: to, parse;

const rubbish = `"\` ~ "` \r\n~`!@#$%^&*()_-+={[}]|:;'<,>.?/";

void main() {
	write("Enter a number: ");
	string input = chomp(readln);
	if (input != "" && ! isNumeric(input)) {
		writeln(`"`, input, `" is not a number.`);
		return;
	}
	int a;
	if (input != "") {
		a = to!int(input);
		printArray(a);
	}
	write("\nEnter some numbers: ");
	input = chomp(readln);
	while (numFind(input) == true) {
		munch(input, rubbish);
		a = parse!int(input);
		printArray(a);
	}
}

bool numFind(string text) {
	foreach (c; text)
		if (inPattern(c, "0-9") == true)
			return true;
	return false;
}

void printArray(int arrLength) {
	foreach (l; 0 .. arrLength)
		write('#');
	write('\n');
}
