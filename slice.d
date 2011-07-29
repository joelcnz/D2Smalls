import std.stdio: writeln;
import std.conv: to;
import std.string: toupper, format;

string toUpper(string str) {
	return toupper(str);
}

int[] addAll(int[] nums, int plus)
{
	foreach ( ref num; nums )
	{
		num += plus;
	}
	return nums;
}

void main() {
	assert( "cattin"[ 0 .. 3 ] ~ to!string("house".length) ~ ' ' ~
		"catten".toUpper ~ ' ' ~ to!string( [ 2, 6, 30 ].addAll( 1 ) ) ==
		"cat5 CATTEN [3, 7, 29]" );
	string hat = `[hat]`;
	assert( format( "%s%s", hat[ 0 ], hat[ $ - 1 ] ) == "[]" );
	assert( hat[ 1 .. $ - 1 ] == "hat" );
}
