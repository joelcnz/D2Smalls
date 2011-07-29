//Note - unittest
import std.stdio;

void main() {
	test;
}

unittest {
	test; // rem out when doing unittest's
}

void test() {
	string delegate ( string ) sound;
	string cat( string strsound ) { return "Cat sound " ~ strsound; }
	string dog( string strsound ) { return "Dog sound " ~ strsound; }
	
	sound = &cat;
	writeln( sound( "Meow!" ) );
	sound = &dog;
	writeln( sound( "bark!" ) );
	
	writeln(); //--------------------
	
	foreach( i, s; [ &cat, &dog ] )
		writeln( s( [ "Meow!", "Bark!" ][i] ) ); // picks ~'meow' then on the second iteration it does ~'bark'
	
	int y=2;
	auto add_y = (int x) { return x+y; };
	writeln( add_y(5) ); // 7
}
