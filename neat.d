import std.stdio;

void main() {
	writeln(typeid(string));
	foreach( char c; "Intercity")
		write( c ~ " ");
}
