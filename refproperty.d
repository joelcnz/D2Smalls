//(old)Why do I bother! - (still old)2.054 now it seems to work! - works in an old version of dmd1
import std.stdio;

void main() {
	auto t = new Test;
	writeln( t.x );
	t.x += 3;
	writeln( t.x );
	t.house; // no () still
	auto txt = new Txt;
	with( txt ) {
		hello = "Hay";
		writeln( hello );
		hello ~= "!";
		writeln( hello );
	}
}

class Txt {
	string _txt;
	ref string hello() { return _txt; }
}

class Test {
	private int _x;
	@property ref int x() {	if ( _x > 0 ) return _x; else { int a = 1; _x = a; return _x; } }
	//@property int x( ref int x0 ) { return _x = x0; } // redundant, I think.
	
	void house() {
		writeln( "House" );
	}
}
