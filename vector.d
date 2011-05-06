/**
	Authors: D.learn news listing by Sebastian Schuberth and altered to work by me (with help from ng) -
	actually now I've used bearophile's randishion(sp), messed around and got strings working it it
	Date: 01 10 2010
*/
import std.stdio;
import jtools.misc;


struct Vector(size_t N, T) {
    static immutable Vector x;

	static this()
	{
		static if (N == 3)
			static if (is(T == float))
				x = Vector(1, 0, 0);
			else static if (is(T == string))
				x = Vector("One","Zero","Zero");
	}
	
    this(T[N] v...) {
        data = v;
    }
	
	void print()
	{
		foreach ( e; data )
			write ( e, " " );
		writeln();
	}
	
	void printx()
	{
		foreach ( e; x.data )
			write ( e, " " );
		writeln();
	}

    T[N] data;
}

alias Vector!(3,float) Vec3f;
alias Vector!(2,float) Vec2f;
alias Vector!(3,string) Vect3S;

void main() {
    auto v = Vec3f(1.5, 2.2, 3.8);
	mixin(test("v.data[0]","equal 1.5"));
    assert(v.data[0] == 1.5);
	
	auto v2 = Vec2f(1.2, 3.4);
	mixin(test("v2.data[1] == 3.4", "Second value is 3.4"));
	v2.print;
	v2.printx;
	mixin(trace("typeid(v2.data)"));
	mixin(trace("typeof(v2.data).stringof"));
	
	auto vs = Vect3S("One", "two", "four");
	vs.data[2] = "three";
	vs.printx;
	mixin(test(`vs.data[0] == "One"`, `first element is qual to "One"`));
	vs.print;
}
