import std.stdio;

void main() {
	writef("int%s, long%s, size_t%s", int.sizeof*8, long.sizeof*8, size_t.sizeof*8);
	// output: int32, long64, size_t32
	// I guess size_t will be 64 on a 64 machine with the addision of 64 bit compiler feature
}