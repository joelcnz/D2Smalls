import std.stdio;

class A {
	void bar() {
		assert(2 * 2 == 5, "maths not right" );
	}
}

void main() {
	square( 5 );

	auto foo = new A;
	foo.bar;
}

pure int square(int x)
{
	// writefln in pure function
	// without debug: debug.d(22): Error: pure function 'square' cannot call impure function 'writefln'
	debug writefln("square(%d)", x);
	return x * x;
}
