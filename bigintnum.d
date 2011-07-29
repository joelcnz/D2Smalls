import std.stdio;
import std.conv;
import std.bigint;

struct Num {
	BigInt _num;
	
	BigInt opCall() {
		return _num;
	}
	
	void opAssign( int num ) {
		_num = num;
	}
	
	void opOpAssign( string op )( int num ) if ( op == "~" ) {
		static int[] sizes;

		foreach( i; 1 .. 7 ) {
			sizes ~= 10 ^^ i;
		}
		
		foreach( i; 0 .. sizes.length )
			if ( num < sizes[ i ] ) {
				_num = _num * sizes[ i ] + num;
				break;
			}
		/*
		_num =
			( num < 10 ? 10 :
			num < 100 ? 100 :
			num < 1000 ? 1000 : 0 )
			* _num + num; // eg Num a; a = 3;  a ~= 7; assert( a == 37 );
		*/
	}
	
	string toString() {
		return to!string( _num.toLong ); // defeats the purpose reducing to a smaller max number
	}
}

void main() {
	writeln( "int.max: ", int.max ); //, ' ', int. );
	
	Num a;

	a = 3;
	a ~= 7;
	a ~= 5;
	a ~= 0;
	a ~= 99;
	a ~= 333;
	
	writeln( a );
}
