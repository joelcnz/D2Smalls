//Why do I bother!
import std.stdio;

void main() {
	auto t = new Test;
	writeln(t.x);
	t.x += 3;
	writeln(t.x);
}

class Test {
	private int _x;
	@property ref int x() {
		int* _x;
		return _x;
	}
}