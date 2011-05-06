//#auto ref not needed
import std.stdio;

void main() {}

// auto ref is for being able to change a variable while still being able to put in magic numbers etc too.

unittest {
	auto ref square(T)(auto ref T x) { return x * x; } //#auto ref not needed

	int y = 10;
	square(3); // => 9
	square(y); // => 100

	writeln("3 * 3 = ", square(3));
	writeln("y = ", y, ": y * y = ", square(y));
}
