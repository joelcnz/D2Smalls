//Some thing is going on here.
import std.stdio;

void main() {
	auto gun = "Gun and";
	auto bullit = " bullit.";
	writeln( gun ~ bullit ); // prints 'Gun and bullit'
	
	auto gunAndBullit = "Gun\0 and bullit";
	writeln( gunAndBullit[ 0 .. $ ] ); // prints only 'Gun'
	writeln( gunAndBullit[ 0 .. $ ], '\n', // prints 'Gun  and bullit'
		gunAndBullit[ 4 .. $ ] ); // prints ' and bullit'
	writeln( gunAndBullit[ 0 .. $ ] ); // prints only 'Gun'
}
