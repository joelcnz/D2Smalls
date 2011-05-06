import std.stdio;

template number(int n) {
	int times() {
		return n * n;
	}
	int plus() {
		return n + n;
	}
}

template numberSec(int x) {
	int times(int y) {
		return x * y;
	}
	int plus(int y) {
		return x + y;
	}
}

void main() {
	foreach ( int a; 0 .. 10 )
		writeln( a, " x ", a, " = ", number!a.times );

	writeln("times 2 * 2 = ",  number!(2).times,
			"\nplus 3 + 3 = ", number!(3).plus,
			"\n\ntimes 2 * 6 = ",  numberSec!(2).times(6),
			"\nplus 3 + 4 = ", numberSec!(3).plus(4));
}
