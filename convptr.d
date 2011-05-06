//#this is new
import std.stdio;
import std.conv;
import std.string;

void main() {
	auto ptr = "Hello".dup.ptr; // AKA 'char*'
	auto normal = "Hi ya";
	writeln(); // to put the next out put with the ones following
	writeln( typeid( typeof ( ptr ) ) );
	writeln( to!string( ptr ) );
	
	typeof( ptr ) test; //#this is new
	test = "How are you?".dup.ptr;
	writefln(
		"test: (%s) %s",
		typeid( typeof ( ptr ) ),
		to!string( test ).dup ); // can't put to!char[]( test );
}
