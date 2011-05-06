import std.stdio;
import std.string;
import std.regex, std.regexp;
import std.process;

alias std.string.split split;

void main() {
	writeln( "\nFind the apples:" );
	auto start = true;
	auto mstr = "kalapplesdjhappledfkashdfappleJoelksappleald";
	foreach( m; match( mstr, regex( "apple" ) ) ) {
		if ( start )
			writeln( mstr ~ "\n" ), start = false;
		write( m.pre ); write( ' ' ~ m.hit ~ ' ' ); writeln( m.post );
	}
	
	auto
		testStr = "aksljhfdalksjdhfklJoelgnedjgbvnukxzhgiuhwemb",
		regStr = "^[a-z]+$";
	void print() {
		writefln( `Test with "%s" using "%s"`, testStr, regStr);
	}
	print;
	auto myreg = new RegExp( regStr );
	if ( cast(bool)myreg.test( testStr ) == false )
		writeln( "Test failed!" ); // found a captial letter
		
	regStr = "^[a-zJ]+$";
	myreg = new RegExp( regStr );
	print;
	if ( cast(bool)myreg.test( testStr ) == true )
		writeln( "Test Passed!" ); // took into account the capital J
	
	writeln( "\nPATH = \"", environment["PATH"], "\"" );
	
	foreach( key, value; environment.toAA ) {
		//writeln( "Key: \"", key, "\"\t Value: \"", value, "\"" );
		writeln( key, "=", value );
	}
	
	writeln( '\n', `HOME = "`, environment["HOME"], `"` );
	
	environment["DSET"] = "This eviroment value was set in a D program, hmm. not sure what I'm doing.";
	
	writefln( "key=%s, value=%s", "DSET", environment["DSET"] );
	
	write( "Press [Enter] to continue.." );
}
