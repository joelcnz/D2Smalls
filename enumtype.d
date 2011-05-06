import std.stdio;

void main() {
	enum DeadWood : char {BRICK = 'B', DARK_BRICK = 'b'};
	writefln("-%s-", DeadWood.BRICK);
}