import std.stdio;
import std.string;

void main() {
	writeln( "Part One:" );
	foreach( card; "WINDOWS96 BILLGATES".split ) {
		compute( card );
	}
	while( compute( stripRight( readln ) ) ) {}

	writeln( "\nPart Two:" );
	foreach( card6; ["COMPUTER"] ) {
		compute6( card6 );
	}
	while( compute6( stripRight( readln ) ) ) {}
}

auto compute( string input ) {
	if ( input.length > 0 && input[0] == 'q' || input[0] == 'Q' )
		return false;
	int total = 0;
	foreach( c; input )
		total += c;
	writef( `This is the text: "%s" and this is the number from it %d`, input, total );
	if ( input == "BILLGATES" )
		write( " - Bill Gates /III/" );
	writeln();

	return true;
}

auto compute6( string input ) {
	if ( input.length > 0 && input[0] == 'q' || input[0] == 'Q' )
		return false;
	writeln( "Use capitals:" );
	int total = 0;
	foreach( c; input )
		total += (1 + ( c - 'A' ) ) * 6;
	writef( `This is the text: "%s" and this is the number from it %d`, input, total );
	writeln();

	return true;
}
