//Org: from some one else
import std.stdio;
import jtools.misc;

/// module names
template Foo( alias X )
{
	alias X.to!string Foo; // same name as header, so instead of 'bar.x( 3 )', it's just 'bar( 3 )'
}

void test()
{
    alias Foo!( std.string ) bar;
    writeln( bar( 3 ) ~ " three, you see!" ); // calls std.string.to!string(3)
}

/// Literals
template Foo2( alias X, alias Y )
{
    static int i = X;
    static string s = Y;
}

void test2()
{
    alias Foo2!( 3, "bar" ) foo;
    writeln( foo.i, foo.s );  // prints 3bar
}

/*
template Foo3( int n, string lable ) {
	
}

template Foo3Helper( alias X ) {
	alias <..> Foo3;
}

void test3() {
	
}
*/

template Foo4( alias X, alias Y ) {
	alias X.abs abs;
	alias Y.trace trace;
}

void test4() {
    alias Foo4!( std.math, jtools.misc ) aj;
    
    mixin( aj.trace( "aj.abs( -32 )" ) );
}

void main() {
	test, test2, test4;
}

