import std.stdio;

void main() {
	foreach (x; 0 .. 100f) {
		writeln(x);
		x+= 0.1;
	}
}
