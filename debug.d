import std.stdio;

class A {
	void bar() {
		assert(2 * 2 == 5);
	}
}

void main() {
	auto foo = new A;
	foo.bar;
}
