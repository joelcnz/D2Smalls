import std.stdio;

void main() {
	int a = 3;
	mixin( trace( "a + 1" ) );
}

//#import jeca.misc; // has trace in it
string trace( string str ) {
	return `writeln( "` ~ str ~ `: ", ` ~ str ~ `);`;
}
