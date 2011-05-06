import std.stdio: writeln;
import std.conv: to;
import std.string: toupper;

string toUpper(string str) {
	return toupper(str);
}

int[] add(int[] nums, int plus)
{
	foreach ( ref num; nums )
	{
		num += plus;
	}
	return nums;
}

void main() {
	writeln("cattin"[0..3] ~ to!string("house".length), ' ', "catten".toUpper, ' ', [ 2, 6, -31 ].add( 1 ) );
	string hat = `[hat]`;
	writeln( hat[ 0 ], hat[ $ - 1 ] );
	writeln(hat[1 .. $ - 1]);
}
