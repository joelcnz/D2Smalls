import std.stdio;

struct A {
	int a;
	float b;
}

A[2] as = [
    0: {0, 0.0f},
    1: {5, 5.2f}
];

void main() {
	int a=37;
	a=7;
	writefln("%s.init=%d", a.stringof, a.init);
	version (none) {
		sag;
	}	
}

