//Not work 16 Apr 2011
import std.stdio;

version = ChrPtr;
//version = Array;

version( ChrPtr )
	inout(char)* strchr( inout(char)* input, int c ) {
		return (input + c); // input[ c ].ptr;
	}

version( Array )
	inout(char)[] strchr( inout(char)[] input, int c ) {
		return input[ 0 .. c ];
	}

void main() {
	version( ChrPtr )
		writeln( strchr( "1079".dup.ptr, 2 ) );

	version( Array )
		writeln( strchr( "1079", 2 ) );
}
