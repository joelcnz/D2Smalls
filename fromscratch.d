import std.stdio;
import std.typecons;

void main() {}

unittest {
	auto value = tuple("Top", 10, 3.7);
	writeln(value);
	value.field[0]="Bottom";
	foreach (i, v;value.expand)
		writefln("[%s]-'%s'", i, v);
}
