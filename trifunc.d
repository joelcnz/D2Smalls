/*
bool onStack = smallEnough(length * sizeof(T));
auto a = (cast(T*) (onStack ? alloca : malloc)(length * sizeof(T)));
scope(exit) if (!onStack) free(a.ptr);
initialize(enforce(a));
scope(exit) clear(a); 
*/

//Hamish "helped"
import std.stdio;

void main() {
	bool catyu;
	catyu = true;
	( catyu ? printCat( 1 ) : printDog( 1 ) );
	auto lawn = () { writeln( "Running all around the lawn!" ); };
	writeln( lawn() );
	lawn();
	catyu = false;
	( catyu ? printCat( 1 ) : printDog( 3 ) );
	lawn();
}

void printCat( int amount ) {
	writeln( amount, " cat" ~ ( amount == 1 ? "" : "s" ) ~ '.' );
}

void printDog( int amount ) {
	writeln( amount, " dog" ~ ( amount == 1 ? "" : "s" ) ~ '.' );
}
