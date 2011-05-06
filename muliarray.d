// needs more work
import std.stdio;

void main() {
	Futs[][] arr = [[new Futs, new Futs], [new Futs]];
	arr[0][0].hello;
	arr[0][1].hello;
	arr[1][0].hello;
}

class Futs {
	void hello() {
		writeln("hello");
	}
}
