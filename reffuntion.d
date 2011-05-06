import std.stdio;

void main() {}

ref int bump(ref int x) {
	return ++x;
}

unittest {
	int x=0;
	writeln( bump(bump(x)) ); // prints 2
}