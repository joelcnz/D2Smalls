// Org from bearophile ng d.D - 3 Mar 2011 2:58pm
import std.stdio;

struct Foo {
    int x;

    Foo opBinary(string op:"*")(Foo other) {
        Foo result = Foo(x * other.x);
        return result;
    }
    void opAssign(Foo other) {
        x = other.x;
    }
}

void main() {
    Foo a, b, c;
	a.x = 2,
	b.x = 3,
	c.x = -1;
	auto d = (string state) { writefln("%s: a=%s, b=%s, c=%s", state, a.x, b.x, c.x); };
	d( "Before" );
	( a * b ) = c; // what a useless expresson, can't see how to use it, what's it for?
	d( "After" );
}
