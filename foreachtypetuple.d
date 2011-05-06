import std.stdio, std.typetuple;

void main() {
	foreach (T; TypeTuple!(int, string, bool, int)) {
		write( typeid( T ) );
		static if ( is( T == int ) ) {
			T i = 3 + 7;
			writeln( " eg. 3 + 7 = ", i );
		} else
		static if ( is( T == bool ) ) {
			T old = false;
			writeln( " eg. old = ", old );
		} else
		static if ( is( T == string ) ) {
			T str = "Have a nice day";
			writeln( ` eg. T str = "Have a nice day"; - "`, str, `"` );
		}
	}

	foreach (V; TypeTuple!(0, false, "Hello")) {
		writeln(V);
	}
}