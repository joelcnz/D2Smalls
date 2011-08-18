import std.stdio: writeln, write;
import std.conv: to;
import std.string: toUpper, format, split;

import jeca.misc;

auto addAll( T, E )( T[] arr, E plus ) {
	static if ( is( T == string ) ) {
		alias plus append;
		if ( !is( E == string ) ) {
			foreach( ref e; arr ) {
				e ~= to!string( append );
			}
		} else {
			foreach( ref e; arr ) {
				e ~= append;
			}
		}
	}
	else
		foreach( ref e; arr ) {
			e += plus;
		}
	return arr;
}

void main() {
	mixin( test( `"cattin"[ 0 .. 3 ] ~ to!string("house".length) == "cat5"`,
		"slice a string, and get the length of another." )
	);
	mixin( test( `"catten".toUpper ~ ' ' ~ to!string( [ 1978, 5, 31 ].addAll( 1 ) ) == "CATTEN [1979, 6, 32]"`,
		"Set a string to uppercase, also at 1 to each number in an array." )
	);

	string hat = `[hat]`;
	mixin( test( `hat == "[hat]"`, "hat = '[hat]'" ) );
	assert( format( "%s%s", hat[ 0 ], hat[ $ - 1 ] ) == "[]" );
	assert( hat[ 1 .. $ - 1 ] == "hat" );
	
	auto arr = [ 7, 37 - 3, 4, 18 ];
	writeln( arr );
	writeln( addAll!(int, int)( arr, 3 ) );
	writeln( addAll!(string, int)( ["12"], 3 ) );
}
