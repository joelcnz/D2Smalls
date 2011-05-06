//note: non Start version gets a compile error, Start version does not
version = Start;

version (Start)
	const start = true;
else
	const start = false;

import std.stdio;

void main() {
	static if (start) {
		write("Start");
	}
	else {
		write("Stop");
		Elephant; // error here
	}
}
