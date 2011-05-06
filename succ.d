import std.stdio, std.string;

void main() {
	string base = "aa";
	foreach (i; 0 .. 26 * 2)
		writeln (base), base = succ(base);
}
