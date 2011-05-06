import std.stdio;
import std.file;

void main() {
	// Iterate a directory in breadth
	foreach (string name; dirEntries(".", SpanMode.breadth))
	{
		writeln( "implib /s ", name[ 2 .. $ - 3 ] ~ "lib ", name[ 2 .. $ ] );
	}
}
