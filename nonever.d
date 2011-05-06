import std.stdio;

void main() {
	write("Should not print all");
	version (none) {
		writeln(" of this comment!");
	}
}
