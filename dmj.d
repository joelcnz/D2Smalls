/**
 * Uses the DMD compiler, but allows you to use wildcards
 * ---
 * dmj -c -D *.d
 * ---
 */
module dmj;

import wildcard.wildcard;

import std.stdio;
import std.string;
import std.file;
import std.process;

void main( string[] args ) {
	string line;
	line ~= "dmd";
	foreach( arg; args[ 1 .. $] ) {
		bool notSourceFile = true;
		if ( arg.indexOf( ".d" ) != -1 || ( arg[0] != '-' ) && arg.indexOf( "." ) == -1 ) {
			foreach ( string name; dirEntries( ".", SpanMode.shallow ) ) {
				if ( wildMatch( arg, name[ 2 .. $ ] ) ) {
					line ~= ' ' ~ name[ 2 .. ( arg.indexOf( "." ) ==  -1 ? $ : $ -2 ) ];
					notSourceFile = false;
				}
			}
		}
		if ( notSourceFile )
			line ~= ' ' ~ arg;
	}
	writeln( line );
	system( line );
}
