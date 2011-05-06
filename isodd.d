import std.stdio;

void isOdd( int number )()
	if ( (number & 1) == 1 )
{
	writeln( number, " is Odd.");
}

void isEven( int number ) {
	if ( (number & 1) == 0 )
		writeln( number, " is even.");
}

void main() {
	isOdd!(1);
	isOdd!(3);
//	isOdd!(2); // error, has no effect
	foreach ( n; 0 .. 8 + 1 )
		isEven( n );
}
