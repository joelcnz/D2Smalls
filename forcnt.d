import std.stdio;

void main() {
	foreach_reverse(f; 0 .. 10)
		write(f,(f==9 ? "" : ", "));
	writeln();
	foreach(f; 0 .. 10)
		write(f,(f==9 ? "" : ", "));
}
