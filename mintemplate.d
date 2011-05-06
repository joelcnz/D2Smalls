//# only works in D2 (min!int)
import std.stdio;

void main() {
	auto min(T)(T a, T b) {
	  return b < a ? b : a;
	}
	
	auto x = min(4, 5);
	auto y = min!(int)(49, 54);
	auto z = min!int(40, 52); //# only works in D2 (min!int)

	writefln("x=%d, y=%d, z=%d", x, y, z);
}
