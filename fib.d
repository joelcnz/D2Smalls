import std.stdio;
import std.range;

void main() {
	//foreach(i,n; 5 .. 10) // can't have the index with 5 .. 10
	foreach(n; 5 .. 10)
		writeln(n);

//	foreach(i,c; ["I went for a walk"])
//		writeln(i,". ",c);

/*
	// not even work!
	writeln("Take #1");
	int i; // starts out in the cold
	foreach (f; take(50, recurrence!("a[n-1] + a[n-2]")(0, 1))) {
    writeln(i++,". ",f);
	}
*/
	writeln("Take #2");
	writeln(fib(50));
}

ulong fib(uint n) {
	writeln(n, " of them");
	uint fib_1 = 1, fib_2 = 0;
	foreach (i; 0 .. n) {
		auto t = fib_1;
		fib_1 += fib_2;
		fib_2=t;
		writeln(fib_2);
	}
	return fib_2;
}
