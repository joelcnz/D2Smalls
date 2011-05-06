// Org: ng d.D 26 Feb 12:39am - Morlan
import std.stdio;
import std.typetuple;

struct S { TypeTuple!(int, double) field; }

void main(){
	S mys;
	mys.field[0] = 4;
	mys.field[1] = 4.4;
	
	foreach( v; mys.field ) {
		writeln( typeid( typeof( v ) ), " value: ", v );
	}
}
