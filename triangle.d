import std.stdio;
import std.string;
import std.conv;

void drawTriangle( string element, ubyte size ) {
	ubyte length = 0;
	foreach( y; 0 .. size ) {
		++length;
		foreach( x; 0 .. length )
			write( element );
		writeln();
	}
}

void main() {
	writeln( "Enter component fot text, then a numbert for the size (1-255)" );
	alias readln input;
	string getInput( in string directive ) {
		write( directive );
		return input[ 0 .. $ - 1 ]; // remove new line character and return input
	}
	drawTriangle(
		getInput( "Enter component: " ),
		to!ubyte( getInput( "Enter a size number (1 - 255): " ) )
	);
	writeln( "Press Enter to continue." );
	input;
}
