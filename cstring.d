//#here we are!
import std.stdio;
import std.c.string;
import std.conv;

void main() {
	auto cstr = cast(char*)"Apartment"; // automaticly adds a null charater
	writeln( cStringToD( cstr ) );
	writeln( to!string( cstr ) ); //#here we are!
}

string cStringToD( char *cstr ) {
	return cast(string)cstr[0 .. strlen( cstr ) ];
}
