import std.stdio;
import std.typecons;

void main() {}

unittest {
	auto value = tuple("hey",1,1.2);
	writeln(value);
	value.field[2]=2.1;
	foreach (i, v; value.expand)
		writefln("[%s] - '%s'", i, v);
}
