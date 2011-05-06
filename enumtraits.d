import std.stdio;
import std.conv;
import std.traits;

enum Count : int {zero, ten = 10, two = 2, three};

void main() {
	foreach( c; EnumMembers!Count )
		writeln( to!string( c ) ~ ": ", c );
	writeln( "Number of members: ", EnumMembers!Count.length );
	writeln( "Index 2: " ~ to!string( EnumMembers!Count[2] )~": ", EnumMembers!Count[2] );
}
