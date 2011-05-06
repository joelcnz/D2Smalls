import std.stdio;

class Thing {
	int _num;
	this( int num ) {
		_num = num;
	}
}

void main() {
//	dotDotDot( new Thing, "Axe" );
	dotDotDot( "Axe", new Thing( 1979 ), "Hammer", 1948 );
}

void dotDotDot( ... ) {
	writeln("\n"); // two new lines
	foreach( i, arg; _arguments ) {
		
		write( i, ") Type: ", arg );
		if ( arg == typeid( string ) ) { // immutable(char)[]
			auto txt = *cast(string*)_argptr;
			writeln( " - ", txt );
			_argptr += txt.sizeof;
		} else if ( arg == typeid( Thing ) ) {
			auto thg = *cast(Thing*)_argptr;
			writeln( " - Special number: ", thg._num );
			_argptr += thg.sizeof;
		} else if ( arg == typeid( int ) ) { // immutable(char)[]
			auto number = *cast(int*)_argptr;
			writeln( " - ", number );
			_argptr += number.sizeof;
		}
		writeln("");
	}
}
